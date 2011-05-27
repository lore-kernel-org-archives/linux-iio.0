Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/50] staging:iio: dev_data removal from iio_dev
Date: Fri, 27 May 2011 19:35:40 +0100
Message-Id: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Dear All,

The principle aim of this set is to move all drivers over to using
iio_device_allocate to reserve the space they need for their chip
state information.  There are also some more general cleanups
such as extensive use of ____cacheline_aligned to allow spi
buffers to be embedded within the relevant chip structures without
dma issues occuring.  A few of these could probably be done
more neatly but I have tried to keep the code flow as close as
possible to what is already there.
Note the resolver series of the other day is also in the middle
of this, because part of it deals with the same issue in that
set of drivers.

I'm not proposing to push these to Greg for at least a week or so
and will be only on intermittent email contact for the next week.

Jonathan

Jonathan Cameron (50):
  staging:iio:accel:adis16201 general cleanup, move to iio_priv and
    buffers in adis16201_state
  staging:iio:accel:adis16203 move buffers into state and use iio_priv
    to avoid allocating state separately.
  staging:iio:accel:adis16204 allocate tx and rx in state plus state
    via iio_priv
  staging:iio:accel:adis16209 allocate tx and rx in state plus state
    via iio_priv
  staging:iio:accel:adis16240 allocate tx and rx in state plus state
    via iio_priv
  staging:iio:accel:adis16220 allocate tx and rx in state plus state
    via iio_priv
  staging:iio:accel:sca3000: allocate state in iio_dev and use iio_priv
    to access.
  staging:iio:accel:kxsd9: allocate state with iio_dev and use iio_priv
    to access.
  staging:iio:adc:ad7476 allocate state with iio_dev and use iio_priv
    to access.
  staging:iio:adc:ad7887 clear out last few uses of iio_dev->dev_data.
  staging:iio:adc:ad799x clear out last few uses of iio_dev->dev_data.
  staging:iio:adc:ad7150: allocate chip state with iio_dev and use
    iio_priv to access.
  staging:iio:adc:ad7152: allocate chip state with iio_dev and use
    iio_priv for access.
  staging:iio:adc:ad7291: allocate chip state with iio_dev and use
    iio_priv for access.
  staging:iio:adc:ad7314 allocate chip state with iio_dev and use
    iio_priv to access.
  staging:iio:adc:ad7745 allocate chip state with iio_dev and use
    iio_priv to access.
  staging:iio:adc:ad7816: allocate chip state with iio_dev and use
    iio_priv to access.
  staging:iio:adc:adt75: allocate chip state with iio_dev and cleanup
    some function calls.
  staging:iio:adc:adt7310: allocate chip state with iio_dev and use
    iio_priv for access.
  staging:iio:adc:adt7410 allocate chip state with iio_dev and use
    iio_priv to access.
  staging:iio:addac:adt7316: allocate chip state with iio_dev and use
    iio_priv to access.
  staging:iio:dac:ad5624r: allocate chip state with iio_dev and use
    iio_priv for access.
  staging:iio:dac:ad5504: allocate chip state with iio_dev and use
    iio_priv for access.
  staging:iio:dac:ad5446: allocate chip state with iio_dev and use
    iio_priv for access.
  staging:iio:dac:ad5791: allocate chip state with iio_dev and use
    iio_priv for access.
  staging:iio:dac:max517: allocate chip state with iio_dev and use
    iio_priv to access it.
  staging:iio:dds: Fix attr group location + allocate state with
    iio_dev
  staging:iio:dds:ad9832: allocate chip state with iio_dev and use
    iio_priv to access.
  staging:iio:ad9834: allocate chip state with iio_dev and use iio_priv
    to access.
  staging:iio:dds:ad9850 allocate chip state with iio_dev + fix name of
    attr group.
  staging:iio:dds:ad9810: allocate chip state with iio_dev and use
    iio_priv for access.
  staging:iio:dds:ad9910: allocate chip state with iio_dev
  staging:iio:dds:ad9951: allocate chip state with iio_dev
  staging:iio:gyro:adis16060 allocate chip state with iio_dev.
  staging:iio:gyro:adis16080: allocate chip state with iio_dev
  staging:iio:gyro:adis16130: allocate chip state with iio_dev and use
    iio_priv to access it.
  staging:iio:gyro:adis16260: allocate chip state with iio_dev and use
    iio_priv to access.
  staging:iio:gyro:adxrs450: allocate chip state with iio_dev
  staging:iio:meter:ade7753 allocate chip state with iio_dev; allocate
    buffers within state
  staging:iio:meter:ade7754: allocate state with iio_dev and buffers in
    state.
  staging:iio:meter:ade7854: Allocate buffers in state and state with
    iio_dev.
  staging:iio:resolver:ad2s1210 general driver cleanup.
  staging:iio:resolver:ad2s120x cleanup.
  staging:iio:resolver:ad2s90 general cleanup
  staging:iio:magnetometer:ak8975: allocate chip state with iio_dev.
  staging:iio:meter:ade7759: allocate state with iio_dev
  staging:iio:magnetometer:hmc5843: allocate device state with iio_dev.
  staging:iio:light:isl29018: allocate device state with iio_dev
  staging:iio:light:tsl2583 allocate chip state with iio_dev
  staging:iio: Remove deprecated dev_data from iio_dev.

 drivers/staging/iio/accel/adis16201.h         |   12 +-
 drivers/staging/iio/accel/adis16201_core.c    |  125 ++---
 drivers/staging/iio/accel/adis16201_ring.c    |    8 +-
 drivers/staging/iio/accel/adis16201_trigger.c |   11 +-
 drivers/staging/iio/accel/adis16203.h         |   12 +-
 drivers/staging/iio/accel/adis16203_core.c    |   85 +--
 drivers/staging/iio/accel/adis16203_ring.c    |    8 +-
 drivers/staging/iio/accel/adis16203_trigger.c |   17 +-
 drivers/staging/iio/accel/adis16204.h         |   12 +-
 drivers/staging/iio/accel/adis16204_core.c    |   84 +--
 drivers/staging/iio/accel/adis16204_ring.c    |    8 +-
 drivers/staging/iio/accel/adis16204_trigger.c |   11 +-
 drivers/staging/iio/accel/adis16209.h         |   12 +-
 drivers/staging/iio/accel/adis16209_core.c    |   82 +--
 drivers/staging/iio/accel/adis16209_ring.c    |    8 +-
 drivers/staging/iio/accel/adis16209_trigger.c |   17 +-
 drivers/staging/iio/accel/adis16220.h         |   14 +-
 drivers/staging/iio/accel/adis16220_core.c    |  105 ++--
 drivers/staging/iio/accel/adis16240.h         |   12 +-
 drivers/staging/iio/accel/adis16240_core.c    |   82 +--
 drivers/staging/iio/accel/adis16240_ring.c    |    8 +-
 drivers/staging/iio/accel/adis16240_trigger.c |   17 +-
 drivers/staging/iio/accel/kxsd9.c             |   64 +--
 drivers/staging/iio/accel/sca3000.h           |    1 -
 drivers/staging/iio/accel/sca3000_core.c      |   99 ++--
 drivers/staging/iio/accel/sca3000_ring.c      |   14 +-
 drivers/staging/iio/adc/ad7150.c              |   91 ++--
 drivers/staging/iio/adc/ad7152.c              |   73 +--
 drivers/staging/iio/adc/ad7291.c              |   85 ++--
 drivers/staging/iio/adc/ad7314.c              |   48 +-
 drivers/staging/iio/adc/ad7476.h              |    5 +-
 drivers/staging/iio/adc/ad7476_core.c         |   82 ++--
 drivers/staging/iio/adc/ad7476_ring.c         |   10 +-
 drivers/staging/iio/adc/ad7745.c              |   79 +--
 drivers/staging/iio/adc/ad7816.c              |   74 +--
 drivers/staging/iio/adc/ad7887_core.c         |    3 +-
 drivers/staging/iio/adc/ad7887_ring.c         |    6 +-
 drivers/staging/iio/adc/ad799x_core.c         |   13 +-
 drivers/staging/iio/adc/ad799x_ring.c         |    4 +-
 drivers/staging/iio/adc/adt7310.c             |   94 ++--
 drivers/staging/iio/adc/adt7410.c             |   86 ++--
 drivers/staging/iio/adc/adt75.c               |  123 ++--
 drivers/staging/iio/addac/adt7316.c           |  224 +++----
 drivers/staging/iio/dac/ad5446.c              |   84 ++--
 drivers/staging/iio/dac/ad5446.h              |    2 -
 drivers/staging/iio/dac/ad5504.c              |   89 ++--
 drivers/staging/iio/dac/ad5504.h              |    2 -
 drivers/staging/iio/dac/ad5624r.h             |    1 -
 drivers/staging/iio/dac/ad5624r_spi.c         |   82 ++--
 drivers/staging/iio/dac/ad5791.c              |  112 ++--
 drivers/staging/iio/dac/ad5791.h              |    2 -
 drivers/staging/iio/dac/max517.c              |   42 +-
 drivers/staging/iio/dds/ad5930.c              |   37 +-
 drivers/staging/iio/dds/ad9832.c              |   69 +--
 drivers/staging/iio/dds/ad9832.h              |    2 -
 drivers/staging/iio/dds/ad9834.c              |   81 ++--
 drivers/staging/iio/dds/ad9834.h              |    2 -
 drivers/staging/iio/dds/ad9850.c              |   37 +-
 drivers/staging/iio/dds/ad9852.c              |   38 +-
 drivers/staging/iio/dds/ad9910.c              |   36 +-
 drivers/staging/iio/dds/ad9951.c              |   36 +-
 drivers/staging/iio/gyro/adis16060_core.c     |   59 +-
 drivers/staging/iio/gyro/adis16080_core.c     |   50 +-
 drivers/staging/iio/gyro/adis16130_core.c     |   50 +-
 drivers/staging/iio/gyro/adis16260.h          |   18 +-
 drivers/staging/iio/gyro/adis16260_core.c     |   98 ++--
 drivers/staging/iio/gyro/adis16260_ring.c     |    9 +-
 drivers/staging/iio/gyro/adis16260_trigger.c  |   15 +-
 drivers/staging/iio/gyro/adxrs450.h           |   13 +-
 drivers/staging/iio/gyro/adxrs450_core.c      |   71 +--
 drivers/staging/iio/iio.h                     |   13 +-
 drivers/staging/iio/light/isl29018.c          |   52 +-
 drivers/staging/iio/light/tsl2583.c           |   82 +--
 drivers/staging/iio/magnetometer/ak8975.c     |   91 ++--
 drivers/staging/iio/magnetometer/hmc5843.c    |   50 +-
 drivers/staging/iio/meter/ade7753.c           |   79 +--
 drivers/staging/iio/meter/ade7753.h           |   10 +-
 drivers/staging/iio/meter/ade7754.c           |   80 +--
 drivers/staging/iio/meter/ade7754.h           |   12 +-
 drivers/staging/iio/meter/ade7759.c           |   80 +--
 drivers/staging/iio/meter/ade7759.h           |   12 +-
 drivers/staging/iio/meter/ade7854-i2c.c       |   41 +-
 drivers/staging/iio/meter/ade7854-spi.c       |   40 +-
 drivers/staging/iio/meter/ade7854.c           |   76 +--
 drivers/staging/iio/meter/ade7854.h           |   36 +-
 drivers/staging/iio/resolver/Kconfig          |   27 -
 drivers/staging/iio/resolver/ad2s120x.c       |  196 +-----
 drivers/staging/iio/resolver/ad2s1210.c       |  856 ++++++++++++-------------
 drivers/staging/iio/resolver/ad2s90.c         |   50 +--
 89 files changed, 2073 insertions(+), 2975 deletions(-)

-- 
1.7.3.4
