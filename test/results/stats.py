import datetime


def _stats(start, end, format):
    ingester_start = datetime.datetime.strptime(start, format)
    ingester_end = datetime.datetime.strptime(end, format)
    ingester_timedelta = ingester_end - ingester_start
    return ingester_timedelta.seconds, int(ingester_timedelta.microseconds / 1000)


def xqa_ingester():
    print('ingest took: %s.%s' % _stats('2018-01-01 11:07:19,001', '2018-01-01 11:07:20,214', '%Y-%m-%d %H:%M:%S,%f'))
    print('40 items @ 81667249 bytes, with 3 ingest-balancer threads')


def one_shard():
    print('1: ingest_balanacer took: %s.%s' % _stats('2018-01-01 11:07:21.407', '2018-01-01 11:08:32.045',
                                                     '%Y-%m-%d %H:%M:%S.%f'))
    print('1: shard took: %s.%s' % _stats('2018-01-01 11:07:27,180', '2018-01-01 11:08:32,228', '%Y-%m-%d %H:%M:%S,%f'))


def two_shards():
    print('2: ingest_balanacer took: %s.%s' % _stats('2018-01-01 11:16:15.667', '2018-01-01 11:16:54.259',
                                                     '%Y-%m-%d %H:%M:%S.%f'))
    print('2: shard took: %s.%s' % _stats('2018-01-01 11:16:19,109', '2018-01-01 11:17:11,837', '%Y-%m-%d %H:%M:%S,%f'))


def four_shards():
    print('4: ingest_balanacer took: %s.%s' % _stats('2018-01-01 11:19:06.933', '2018-01-01 11:19:35.778',
                                                     '%Y-%m-%d %H:%M:%S.%f'))
    print('4: shard took: %s.%s' % _stats('2018-01-01 11:19:10,256', '2018-01-01 11:19:55,770', '%Y-%m-%d %H:%M:%S,%f'))


xqa_ingester()
one_shard()
two_shards()
four_shards()
