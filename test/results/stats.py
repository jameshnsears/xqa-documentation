import datetime


def _stats(start, end, format):
    ingester_start = datetime.datetime.strptime(start, format)
    ingester_end = datetime.datetime.strptime(end, format)
    ingester_timedelta = ingester_end - ingester_start
    return ingester_timedelta.seconds, int(ingester_timedelta.microseconds / 1000)


def xqa_ingester():
    print('ingest took: %s.%s' % _stats('2017-12-30 13:09:17,104', '2017-12-30 13:09:18,344', '%Y-%m-%d %H:%M:%S,%f'))
    print('40 items @ 81667249 bytes, with 6 ingest-balancer threads')


def one_shard():
    print('1: ingest_balanacer took: %s.%s' % _stats('2017-12-30 12:06:34.063', '2017-12-30 12:07:42.645',
                                                     '%Y-%m-%d %H:%M:%S.%f'))
    print('1: shard took: %s.%s' % _stats('2017-12-30 12:06:36,608', '2017-12-30 12:07:43,797', '%Y-%m-%d %H:%M:%S,%f'))


def two_shards():
    print('2: ingest_balanacer took: %s.%s' % _stats('2017-12-30 12:34:15.252', '2017-12-30 12:34:36.331',
                                                     '%Y-%m-%d %H:%M:%S.%f'))
    print('2: shard took: %s.%s' % _stats('2017-12-30 12:34:18,051', '2017-12-30 12:35:20,915', '%Y-%m-%d %H:%M:%S,%f'))


def four_shards():
    print('4: ingest_balanacer took: %s.%s' % _stats('2017-12-30 13:09:18.918', '2017-12-30 13:09:35.898',
                                                     '%Y-%m-%d %H:%M:%S.%f'))
    print('4: shard took: %s.%s' % _stats('2017-12-30 13:09:21,255', '2017-12-30 13:10:16,585', '%Y-%m-%d %H:%M:%S,%f'))


xqa_ingester()
one_shard()
two_shards()
four_shards()
