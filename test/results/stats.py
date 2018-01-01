import datetime


def _stats(start, end, format):
    ingester_start = datetime.datetime.strptime(start, format)
    ingester_end = datetime.datetime.strptime(end, format)
    ingester_timedelta = ingester_end - ingester_start
    return ingester_timedelta.seconds, int(ingester_timedelta.microseconds / 1000)


def xqa_ingester():
    print('ingest took: %s.%s' % _stats('2018-01-01 11:52:24,684', '2018-01-01 11:52:29,909', '%Y-%m-%d %H:%M:%S,%f'))
    print('40 items @ 81667249 bytes')


def one_shard():
    print('1: ingest_balanacer took: %s.%s' % _stats('2018-01-01 11:52:26.385', '2018-01-01 11:53:32.946',
                                                     '%Y-%m-%d %H:%M:%S.%f'))
    print('1: shard took: %s.%s' % _stats('2018-01-01 11:52:30,938', '2018-01-01 11:53:33,419', '%Y-%m-%d %H:%M:%S,%f'))


def two_shards():
    print('2: ingest_balanacer took: %s.%s' % _stats('2018-01-01 11:55:08.406', '2018-01-01 11:55:30.724',
                                                     '%Y-%m-%d %H:%M:%S.%f'))
    print('2: shard took: %s.%s' % _stats('2018-01-01 11:55:12,898', '2018-01-01 11:56:11,586', '%Y-%m-%d %H:%M:%S,%f'))


def four_shards():
    print('4: ingest_balanacer took: %s.%s' % _stats('2018-01-01 11:59:09.910', '2018-01-01 11:59:31.536',
                                                     '%Y-%m-%d %H:%M:%S.%f'))
    print('4: shard took: %s.%s' % _stats('2018-01-01 11:59:13,677', '2018-01-01 12:00:11,348', '%Y-%m-%d %H:%M:%S,%f'))


def eight_shards():
    print('8: ingest_balanacer took: %s.%s' % _stats('2018-01-01 12:07:33.618', '2018-01-01 12:07:56.522',
                                                     '%Y-%m-%d %H:%M:%S.%f'))
    print('8: shard took: %s.%s' % _stats('2018-01-01 12:07:38,064', '2018-01-01 12:08:27,635', '%Y-%m-%d %H:%M:%S,%f'))


xqa_ingester()
one_shard()
two_shards()
four_shards()
eight_shards()
