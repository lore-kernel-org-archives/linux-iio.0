Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/14 V2] staging:iio: mixed bag
Date: Wed, 21 Sep 2011 11:15:48 +0100
Message-Id: <1316600162-15581-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

Same as previous lot but with the changes to iio_core.h actually
present. Sorry again!

Pervious message:

Hi Greg,

Various updates that would normally have gone directly
to you from Michael, Stephen and Manuel.  All have
been on linux-iio for a while.

* Effectively new driver from Michael - he went with rewrite
  rather than fix the old one.

* Kconfig reorganization from Manuel that makes finding
  drivers somewhat easier.

* Some documenation updates from me.

* Clearing missleading naming of all buffers as ring buffers
  out. I had been leaving that one for a rainy day, but was
  a badly needed cleanup.

* Stephen has put a temporary workaround in place to allow
  the ak8975 to build / work until someone has time / hardware
  to fix properly.

Anyhow, pretty straight forward stuff all in all. (touch wood)

Thanks,

Jonathan


Jonathan Cameron (10):
  staging:iio:documentation general refresh of abi docs.
  staging:iio:documentation Add abi docs for capacitance adcs.
  staging:iio: treewide rename iio_triggered_ring_* to
    iio_triggered_buffer_*
  staging:iio: tree wide IIO_RING_TRIGGERED -> IIO_BUFFER_TRIGGERED
  staging:iio: tree wide IIO_RING_BUFFER config symbol to IIO_BUFFER
  staging:iio: rename ring_generic.h -> buffer_generic.h
  staging:iio: replacing term ring with buffer in the IIO core.
  staging:iio:accel:lis3l02dq ring->buffer renames.
  staging:iio:magnetometer:ak8975 use platform_data to pass the gpio
    number.
  staging:iio: Prevent reading from buffer chrdev when device has no
    buffer.

Manuel Stahl (1):
  staging: iio: Move sensor drivers to sub menus

Michael Hennerich (1):
  iio: adc: Replace, rewrite ad7745 from scratch.

Stephen Warren (2):
  staging:iio:magnetometer:ak8975: Don't assume 0 is an invalid GPIO
  staging:iio:magnetometer:ak8975: Fix probe() error-handling

 drivers/staging/iio/Documentation/sysfs-bus-iio |  202 +++---
 drivers/staging/iio/Kconfig                     |    6 +-
 drivers/staging/iio/Makefile                    |    2 +-
 drivers/staging/iio/accel/Kconfig               |   32 +-
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
 drivers/staging/iio/adc/Kconfig                 |   24 +-
 drivers/staging/iio/adc/Makefile                |   10 +-
 drivers/staging/iio/adc/ad7192.c                |   52 +-
 drivers/staging/iio/adc/ad7298.h                |    6 +-
 drivers/staging/iio/adc/ad7298_core.c           |   14 +-
 drivers/staging/iio/adc/ad7298_ring.c           |   32 +-
 drivers/staging/iio/adc/ad7476.h                |    6 +-
 drivers/staging/iio/adc/ad7476_core.c           |   14 +-
 drivers/staging/iio/adc/ad7476_ring.c           |   38 +-
 drivers/staging/iio/adc/ad7606_core.c           |   16 +-
 drivers/staging/iio/adc/ad7606_ring.c           |   32 +-
 drivers/staging/iio/adc/ad7745.c                |  673 -------------------
 drivers/staging/iio/adc/ad7746.c                |  804 +++++++++++++++++++++++
 drivers/staging/iio/adc/ad7746.h                |   29 +
 drivers/staging/iio/adc/ad7780.c                |    1 -
 drivers/staging/iio/adc/ad7793.c                |   50 +-
 drivers/staging/iio/adc/ad7887.h                |    6 +-
 drivers/staging/iio/adc/ad7887_core.c           |   14 +-
 drivers/staging/iio/adc/ad7887_ring.c           |   36 +-
 drivers/staging/iio/adc/ad799x_core.c           |   12 +-
 drivers/staging/iio/adc/ad799x_ring.c           |   38 +-
 drivers/staging/iio/adc/max1363_core.c          |   14 +-
 drivers/staging/iio/adc/max1363_ring.c          |   28 +-
 drivers/staging/iio/addac/Kconfig               |    4 +-
 drivers/staging/iio/buffer_generic.h            |  228 +++++++
 drivers/staging/iio/dac/Kconfig                 |    4 +-
 drivers/staging/iio/dds/Kconfig                 |    4 +-
 drivers/staging/iio/gyro/Kconfig                |    8 +-
 drivers/staging/iio/gyro/Makefile               |    2 +-
 drivers/staging/iio/gyro/adis16260.h            |    6 +-
 drivers/staging/iio/gyro/adis16260_core.c       |   24 +-
 drivers/staging/iio/gyro/adis16260_ring.c       |   20 +-
 drivers/staging/iio/iio.h                       |   20 +-
 drivers/staging/iio/iio_core.h                  |   31 +-
 drivers/staging/iio/impedance-analyzer/Kconfig  |    6 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |   40 +-
 drivers/staging/iio/imu/Kconfig                 |    8 +-
 drivers/staging/iio/imu/Makefile                |    2 +-
 drivers/staging/iio/imu/adis16400.h             |    6 +-
 drivers/staging/iio/imu/adis16400_core.c        |   14 +-
 drivers/staging/iio/imu/adis16400_ring.c        |   31 +-
 drivers/staging/iio/industrialio-buffer.c       |  634 ++++++++++++++++++
 drivers/staging/iio/industrialio-core.c         |   22 +-
 drivers/staging/iio/industrialio-ring.c         |  631 ------------------
 drivers/staging/iio/industrialio-trigger.c      |   10 +-
 drivers/staging/iio/kfifo_buf.c                 |   48 +-
 drivers/staging/iio/kfifo_buf.h                 |    8 +-
 drivers/staging/iio/light/Kconfig               |    4 +-
 drivers/staging/iio/magnetometer/Kconfig        |    3 +-
 drivers/staging/iio/magnetometer/ak8975.c       |   18 +-
 drivers/staging/iio/meter/Kconfig               |    8 +-
 drivers/staging/iio/meter/Makefile              |    2 +-
 drivers/staging/iio/meter/ade7758.h             |    6 +-
 drivers/staging/iio/meter/ade7758_core.c        |   10 +-
 drivers/staging/iio/meter/ade7758_ring.c        |   34 +-
 drivers/staging/iio/resolver/Kconfig            |    3 +-
 drivers/staging/iio/ring_generic.h              |  226 -------
 drivers/staging/iio/ring_hw.h                   |    6 +-
 drivers/staging/iio/ring_sw.c                   |   44 +-
 drivers/staging/iio/ring_sw.h                   |    8 +-
 drivers/staging/iio/trigger_consumer.h          |    4 +-
 87 files changed, 2518 insertions(+), 2309 deletions(-)
 delete mode 100644 drivers/staging/iio/adc/ad7745.c
 create mode 100644 drivers/staging/iio/adc/ad7746.c
 create mode 100644 drivers/staging/iio/adc/ad7746.h
 create mode 100644 drivers/staging/iio/buffer_generic.h
 create mode 100644 drivers/staging/iio/industrialio-buffer.c
 delete mode 100644 drivers/staging/iio/industrialio-ring.c
 delete mode 100644 drivers/staging/iio/ring_generic.h

-- 
1.7.3.4
