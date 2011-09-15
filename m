Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/8] staging:iio: Documentation updates + ring -> buffer renaming in core
Date: Thu, 15 Sep 2011 14:45:29 +0100
Message-Id: <1316094337-12542-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

I might well split this into two sets, but for now here it is
as one big one.

Actually very little going on here.

1) Bring some docs up to date plus clarify some corners.
2) Get rid of references to 'ring' when it should be a generic
   buffer in the core code.  This is large, invasive and utterly
   mechanical. I've been meaning to sort this out once and for
   all for a long time and definitely wanted it done before
   proposing a move out of staging.


Still, please take a look at the rest even if no one can quite
be bothered to check the mass patch (in case you haven't guessed
I got bored of doing it one function at a time!)

Jonathan

Jonathan Cameron (8):
  staging:iio:documentation general refresh of abi docs.
  staging:iio:documentation Add abi docs for capacitance adcs.
  staging:iio: treewide rename iio_triggered_ring_* to
    iio_triggered_buffer_*
  staging:iio: tree wide IIO_RING_TRIGGERED -> IIO_BUFFER_TRIGGERED
  staging:iio: tree wide IIO_RING_BUFFER config symbol to IIO_BUFFER
  staging:iio: rename ring_generic.h -> buffer_generic.h
  staging:iio: replacing term ring with buffer in the IIO core.
  staging:iio:accel:lis3l02dq ring->buffer renames.

 drivers/staging/iio/Documentation/sysfs-bus-iio |  202 ++++----
 drivers/staging/iio/Kconfig                     |    6 +-
 drivers/staging/iio/Makefile                    |    2 +-
 drivers/staging/iio/accel/Kconfig               |   28 +-
 drivers/staging/iio/accel/Makefile              |   12 +-
 drivers/staging/iio/accel/adis16201.h           |    6 +-
 drivers/staging/iio/accel/adis16201_core.c      |   12 +-
 drivers/staging/iio/accel/adis16201_ring.c      |   20 +-
 drivers/staging/iio/accel/adis16203.h           |    6 +-
 drivers/staging/iio/accel/adis16203_core.c      |   12 +-
 drivers/staging/iio/accel/adis16203_ring.c      |   20 +-
 drivers/staging/iio/accel/adis16204.h           |    6 +-
 drivers/staging/iio/accel/adis16204_core.c      |   12 +-
 drivers/staging/iio/accel/adis16204_ring.c      |   20 +-
 drivers/staging/iio/accel/adis16209.h           |    6 +-
 drivers/staging/iio/accel/adis16209_core.c      |   12 +-
 drivers/staging/iio/accel/adis16209_ring.c      |   20 +-
 drivers/staging/iio/accel/adis16240.h           |    6 +-
 drivers/staging/iio/accel/adis16240_core.c      |   12 +-
 drivers/staging/iio/accel/adis16240_ring.c      |   20 +-
 drivers/staging/iio/accel/lis3l02dq.h           |   26 +-
 drivers/staging/iio/accel/lis3l02dq_core.c      |   43 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c      |  100 ++--
 drivers/staging/iio/accel/sca3000.h             |    4 +-
 drivers/staging/iio/accel/sca3000_core.c        |   22 +-
 drivers/staging/iio/accel/sca3000_ring.c        |   52 +-
 drivers/staging/iio/adc/Kconfig                 |   18 +-
 drivers/staging/iio/adc/Makefile                |    8 +-
 drivers/staging/iio/adc/ad7192.c                |   52 +-
 drivers/staging/iio/adc/ad7298.h                |    6 +-
 drivers/staging/iio/adc/ad7298_core.c           |   14 +-
 drivers/staging/iio/adc/ad7298_ring.c           |   32 +-
 drivers/staging/iio/adc/ad7476.h                |    6 +-
 drivers/staging/iio/adc/ad7476_core.c           |   14 +-
 drivers/staging/iio/adc/ad7476_ring.c           |   38 +-
 drivers/staging/iio/adc/ad7606_core.c           |   16 +-
 drivers/staging/iio/adc/ad7606_ring.c           |   32 +-
 drivers/staging/iio/adc/ad7780.c                |    1 -
 drivers/staging/iio/adc/ad7793.c                |   50 +-
 drivers/staging/iio/adc/ad7887.h                |    6 +-
 drivers/staging/iio/adc/ad7887_core.c           |   14 +-
 drivers/staging/iio/adc/ad7887_ring.c           |   36 +-
 drivers/staging/iio/adc/ad799x_core.c           |   12 +-
 drivers/staging/iio/adc/ad799x_ring.c           |   38 +-
 drivers/staging/iio/adc/max1363_core.c          |   14 +-
 drivers/staging/iio/adc/max1363_ring.c          |   28 +-
 drivers/staging/iio/buffer_generic.h            |  228 ++++++++
 drivers/staging/iio/gyro/Kconfig                |    4 +-
 drivers/staging/iio/gyro/Makefile               |    2 +-
 drivers/staging/iio/gyro/adis16260.h            |    6 +-
 drivers/staging/iio/gyro/adis16260_core.c       |   24 +-
 drivers/staging/iio/gyro/adis16260_ring.c       |   20 +-
 drivers/staging/iio/iio.h                       |   20 +-
 drivers/staging/iio/iio_core.h                  |   26 +-
 drivers/staging/iio/impedance-analyzer/Kconfig  |    2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |   40 +-
 drivers/staging/iio/imu/Kconfig                 |    4 +-
 drivers/staging/iio/imu/Makefile                |    2 +-
 drivers/staging/iio/imu/adis16400.h             |    6 +-
 drivers/staging/iio/imu/adis16400_core.c        |   14 +-
 drivers/staging/iio/imu/adis16400_ring.c        |   31 +-
 drivers/staging/iio/industrialio-buffer.c       |  632 +++++++++++++++++++++++
 drivers/staging/iio/industrialio-core.c         |   20 +-
 drivers/staging/iio/industrialio-ring.c         |  631 ----------------------
 drivers/staging/iio/industrialio-trigger.c      |   10 +-
 drivers/staging/iio/kfifo_buf.c                 |   48 +-
 drivers/staging/iio/kfifo_buf.h                 |    8 +-
 drivers/staging/iio/meter/Kconfig               |    4 +-
 drivers/staging/iio/meter/Makefile              |    2 +-
 drivers/staging/iio/meter/ade7758.h             |    6 +-
 drivers/staging/iio/meter/ade7758_core.c        |   10 +-
 drivers/staging/iio/meter/ade7758_ring.c        |   34 +-
 drivers/staging/iio/ring_generic.h              |  226 --------
 drivers/staging/iio/ring_hw.h                   |    6 +-
 drivers/staging/iio/ring_sw.c                   |   44 +-
 drivers/staging/iio/ring_sw.h                   |    8 +-
 drivers/staging/iio/trigger_consumer.h          |    4 +-
 77 files changed, 1632 insertions(+), 1612 deletions(-)
 create mode 100644 drivers/staging/iio/buffer_generic.h
 create mode 100644 drivers/staging/iio/industrialio-buffer.c
 delete mode 100644 drivers/staging/iio/industrialio-ring.c
 delete mode 100644 drivers/staging/iio/ring_generic.h

-- 
1.7.3.4
