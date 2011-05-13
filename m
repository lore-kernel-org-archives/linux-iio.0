Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/5] IIO: Another mixed bag, including iio_info structure and doc updates.
Date: Fri, 13 May 2011 17:08:58 +0100
Message-Id: <1305302943-16475-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi all,

Only one significant patch here.  The first adds the iio_info structure,
pulling those elements that are typically shared by a large group of
parts and constant out of iio_dev structures. It touches every driver,
but as a simple parameter move patch 'should' be relatively safe.

I haven't put the iio_chan_spec pointer in there. To see why, just consider
the number of instances of iio_info that would be needed in max1363 if we
did do so.

The doc updates aren't great, but the get it nearer to where it should be.

Other stuff is in the category of things I'd either noted down to fix, or
happened to come across whilst doing something else.

Thanks all, and as ever comments / review welcome.



Jonathan Cameron (5):
  staging:iio: implement an iio_info structure to take some of the
    constant elements out of iio_dev.
  staging:iio:max1363 misc cleanups and use of for_each_bit_set to    
    simplify event code spitting out.
  staging:iio: use pollfunc allocation helpers in remaining drivers.
  staging:iio:documenation partial update.
  staging:iio: Trivial kconfig reorganization and uniformity
    improvements.

 drivers/staging/iio/Documentation/device.txt    |   78 ++-
 drivers/staging/iio/Documentation/overview.txt  |   19 +-
 drivers/staging/iio/Documentation/ring.txt      |   44 +-
 drivers/staging/iio/Documentation/trigger.txt   |   16 +-
 drivers/staging/iio/Documentation/userspace.txt |   12 -
 drivers/staging/iio/Kconfig                     |    8 +-
 drivers/staging/iio/accel/adis16201_core.c      |   13 +-
 drivers/staging/iio/accel/adis16203_core.c      |   12 +-
 drivers/staging/iio/accel/adis16204_core.c      |   12 +-
 drivers/staging/iio/accel/adis16209_core.c      |   12 +-
 drivers/staging/iio/accel/adis16220_core.c      |    7 +-
 drivers/staging/iio/accel/adis16240_core.c      |   12 +-
 drivers/staging/iio/accel/kxsd9.c               |   12 +-
 drivers/staging/iio/accel/lis3l02dq_core.c      |   23 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |   16 +-
 drivers/staging/iio/accel/sca3000_core.c        |   33 +-
 drivers/staging/iio/adc/Kconfig                 |   48 +-
 drivers/staging/iio/adc/ad7150.c                |   15 +-
 drivers/staging/iio/adc/ad7152.c                |    7 +-
 drivers/staging/iio/adc/ad7291.c                |   11 +-
 drivers/staging/iio/adc/ad7298_core.c           |    8 +-
 drivers/staging/iio/adc/ad7298_ring.c           |   24 +-
 drivers/staging/iio/adc/ad7314.c                |    7 +-
 drivers/staging/iio/adc/ad7476_core.c           |    8 +-
 drivers/staging/iio/adc/ad7476_ring.c           |   26 +-
 drivers/staging/iio/adc/ad7606_core.c           |   10 +-
 drivers/staging/iio/adc/ad7606_ring.c           |   24 +-
 drivers/staging/iio/adc/ad7745.c                |   11 +-
 drivers/staging/iio/adc/ad7780.c                |    8 +-
 drivers/staging/iio/adc/ad7816.c                |   12 +-
 drivers/staging/iio/adc/ad7887_core.c           |    8 +-
 drivers/staging/iio/adc/ad7887_ring.c           |   24 +-
 drivers/staging/iio/adc/ad799x.h                |    3 +-
 drivers/staging/iio/adc/ad799x_core.c           |   47 +-
 drivers/staging/iio/adc/ad799x_ring.c           |   25 +-
 drivers/staging/iio/adc/adt7310.c               |   12 +-
 drivers/staging/iio/adc/adt7410.c               |   12 +-
 drivers/staging/iio/adc/adt75.c                 |   12 +-
 drivers/staging/iio/adc/max1363.h               |   78 +--
 drivers/staging/iio/adc/max1363_core.c          |  890 ++++++++++++-----------
 drivers/staging/iio/adc/max1363_ring.c          |   25 +-
 drivers/staging/iio/addac/adt7316.c             |   27 +-
 drivers/staging/iio/dac/ad5446.c                |    8 +-
 drivers/staging/iio/dac/ad5504.c                |   24 +-
 drivers/staging/iio/dac/ad5624r_spi.c           |    8 +-
 drivers/staging/iio/dac/ad5791.c                |    8 +-
 drivers/staging/iio/dac/max517.c                |   15 +-
 drivers/staging/iio/dds/ad5930.c                |   12 +-
 drivers/staging/iio/dds/ad9832.c                |    8 +-
 drivers/staging/iio/dds/ad9834.c                |    8 +-
 drivers/staging/iio/dds/ad9850.c                |   10 +-
 drivers/staging/iio/dds/ad9852.c                |   10 +-
 drivers/staging/iio/dds/ad9910.c                |   10 +-
 drivers/staging/iio/dds/ad9951.c                |   10 +-
 drivers/staging/iio/gyro/adis16060_core.c       |    8 +-
 drivers/staging/iio/gyro/adis16080_core.c       |    8 +-
 drivers/staging/iio/gyro/adis16130_core.c       |    8 +-
 drivers/staging/iio/gyro/adis16260_core.c       |   12 +-
 drivers/staging/iio/gyro/adis16260_ring.c       |   23 +-
 drivers/staging/iio/gyro/adxrs450_core.c        |    8 +-
 drivers/staging/iio/iio.h                       |  105 ++--
 drivers/staging/iio/imu/adis16400_core.c        |   12 +-
 drivers/staging/iio/industrialio-core.c         |   73 +-
 drivers/staging/iio/light/Kconfig               |   26 +-
 drivers/staging/iio/light/isl29018.c            |    8 +-
 drivers/staging/iio/light/tsl2563.c             |   26 +-
 drivers/staging/iio/light/tsl2583.c             |    8 +-
 drivers/staging/iio/magnetometer/ak8975.c       |    8 +-
 drivers/staging/iio/magnetometer/hmc5843.c      |    8 +-
 drivers/staging/iio/meter/ade7753.c             |    8 +-
 drivers/staging/iio/meter/ade7754.c             |    8 +-
 drivers/staging/iio/meter/ade7758_core.c        |    8 +-
 drivers/staging/iio/meter/ade7758_ring.c        |   22 +-
 drivers/staging/iio/meter/ade7759.c             |    9 +-
 drivers/staging/iio/meter/ade7854.c             |    8 +-
 drivers/staging/iio/resolver/ad2s120x.c         |   11 +-
 drivers/staging/iio/resolver/ad2s1210.c         |   10 +-
 drivers/staging/iio/resolver/ad2s90.c           |   10 +-
 78 files changed, 1241 insertions(+), 1036 deletions(-)
 delete mode 100644 drivers/staging/iio/Documentation/userspace.txt

-- 
1.7.3.4
