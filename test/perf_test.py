import json
import os

from pytest import raises
import pytest


def _populate_list_from_file(fpath):
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
    return _populate_list_from_file('%s/xqa-ingester.log' % os.getenv('LOGFOLDER'))


@pytest.fixture
def ingest_balancer_log():
    return _populate_list_from_file('%s/%s-xqa-ingest-balancer.log' % (os.getenv('LOGFOLDER'), os.getenv('SHARDINSTANCES')))


@pytest.fixture
def shard_log():
    return _populate_list_from_file('%s/%s-xqa-shard-1.log' % (os.getenv('LOGFOLDER'), os.getenv('SHARDINSTANCES')))


def _correlation_id_dict(correlation_id, log_list):
    for line in log_list:
        if line['correlation_id'] == correlation_id:
            return line


def test_check_sha256_consistency(ingester_log, ingest_balancer_log, shard_log):
    for ingest in ingester_log:
        ingest_correlation_id = ingest['correlation_id']

        ingest_balancer = _correlation_id_dict(ingest_correlation_id, ingest_balancer_log)
        shard = _correlation_id_dict(ingest_correlation_id, shard_log)

        try:
            assert ingest['sha256'] == ingest_balancer['sha256']
            assert ingest['sha256'] == shard['sha256']
        except AssertionError as e:
            print('%s: %s v. %s v. %s' % (ingest['file'], ingest['sha256'], ingest_balancer['sha256'], shard['sha256']))
            raise e
