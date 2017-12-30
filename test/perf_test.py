import json
import os

from pytest import raises
import pytest


def _log_messages_from_file(fpath):
    list_dict = []
    with open(fpath) as ingester_log:
        ingest_log = ingester_log.readlines()

    for line in ingest_log:
        l = line[line.find('{"'):]
        l = l.rstrip()
        if len(l) > 0:
            list_dict.append(json.loads(l))

    return list_dict


@pytest.fixture
def ingester_log():
    return _log_messages_from_file('%s/xqa-ingester.log' % os.getenv('LOGFOLDER'))


@pytest.fixture
def ingest_balancer_log():
    return _log_messages_from_file('%s/%s-xqa-ingest-balancer.log' % (os.getenv('LOGFOLDER'), os.getenv('SHARDINSTANCES')))


@pytest.fixture
def shards_log():
    list_dict = []
    for shard_instance in range(1, 1 + int(os.getenv('SHARDINSTANCES'))):
        log_messages_from_file = _log_messages_from_file('%s/%s-xqa-shard-%s.log' % (os.getenv('LOGFOLDER'), os.getenv('SHARDINSTANCES'), shard_instance))
        for log_line in log_messages_from_file:
            list_dict.append(log_line)
    return list_dict


def _correlation_id_dict(correlation_id, log_list):
    for line in log_list:
        if line['correlation_id'] == correlation_id:
            return line


def test_check_sha256_consistency(ingester_log, ingest_balancer_log, shards_log):
    assert len(ingester_log) == len(ingest_balancer_log) / 2
    assert len(ingest_balancer_log) / 2 == len(shards_log)

    for ingest in ingester_log:
        ingest_correlation_id = ingest['correlation_id']

        ingest_balancer = _correlation_id_dict(ingest_correlation_id, ingest_balancer_log)
        shard = _correlation_id_dict(ingest_correlation_id, shards_log)

        try:
            assert ingest['sha256'] == ingest_balancer['sha256']
            assert ingest['sha256'] == shard['sha256']
        except AssertionError as e:
            print('%s: %s v. %s v. %s' % (ingest['file'], ingest['sha256'], ingest_balancer['sha256'], shard['sha256']))
            raise e
