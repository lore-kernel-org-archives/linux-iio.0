Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/8 V2] staging:iio chrdev merge series.
Date: Wed, 24 Aug 2011 17:34:06 +0100
Message-Id: <1314203654-22377-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi All,

I thought I'd best give this series one last airing before sending on
to Greg.  Note I'll be dropping the ioctl region patch for now as
there may be issues with reserving that for a staging driver?

Anyhow does what it says on the tin.

Michael, can you give me a tested by on this stuff (guessing you have
been given your iio-blue.git fixes etc).

Thanks,

Jonathan

Jonathan Cameron (8):
  staging:iio:kfifo buffer - push structure definition down into
    implementation.
  staging:iio:chrdev.h rationalization.
  staging:iio: remove specific chrdev for event reading. Get fd from
    ioctl on buffer.
  ioctl region for IIO.
  staging:iio: squash chrdev handler remains into users.
  staging:iio: push the main buffer chrdev down to the top level.
  staging:iio: remove now defunct header definitions and add some
    statics
  staging:iio:Documentation sysfs-bus-iio update for chrdev merge.

 Documentation/ioctl/ioctl-number.txt               |    1 +
 drivers/staging/iio/Documentation/generic_buffer.c |   12 +-
 drivers/staging/iio/Documentation/iio_utils.h      |    2 +-
 drivers/staging/iio/Documentation/sysfs-bus-iio    |  573 ++++++++++----------
 drivers/staging/iio/accel/adis16201_core.c         |    6 +-
 drivers/staging/iio/accel/adis16203_core.c         |    6 +-
 drivers/staging/iio/accel/adis16204_core.c         |    6 +-
 drivers/staging/iio/accel/adis16209_core.c         |    6 +-
 drivers/staging/iio/accel/adis16240_core.c         |    6 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |    6 +-
 drivers/staging/iio/accel/sca3000_core.c           |    7 +-
 drivers/staging/iio/accel/sca3000_ring.c           |   23 +-
 drivers/staging/iio/adc/ad7150.c                   |    1 +
 drivers/staging/iio/adc/ad7192.c                   |    6 +-
 drivers/staging/iio/adc/ad7298_core.c              |    4 +-
 drivers/staging/iio/adc/ad7476_core.c              |    4 +-
 drivers/staging/iio/adc/ad7606_core.c              |    4 +-
 drivers/staging/iio/adc/ad7745.c                   |    1 +
 drivers/staging/iio/adc/ad7793.c                   |    6 +-
 drivers/staging/iio/adc/ad7816.c                   |    1 +
 drivers/staging/iio/adc/ad7887_core.c              |    4 +-
 drivers/staging/iio/adc/ad799x_core.c              |    6 +-
 drivers/staging/iio/adc/adt7310.c                  |    2 +
 drivers/staging/iio/adc/adt7410.c                  |    2 +
 drivers/staging/iio/adc/adt75.c                    |    1 +
 drivers/staging/iio/adc/max1363_core.c             |   10 +-
 drivers/staging/iio/addac/adt7316.c                |    2 +
 drivers/staging/iio/chrdev.h                       |   52 +--
 drivers/staging/iio/dac/ad5504.c                   |    1 +
 drivers/staging/iio/gyro/adis16260_core.c          |    6 +-
 drivers/staging/iio/iio.h                          |    3 +-
 drivers/staging/iio/iio_core.h                     |   39 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    8 +-
 drivers/staging/iio/imu/adis16400_core.c           |    6 +-
 drivers/staging/iio/industrialio-core.c            |  279 ++++++-----
 drivers/staging/iio/industrialio-ring.c            |  220 +++-----
 drivers/staging/iio/kfifo_buf.c                    |   34 +-
 drivers/staging/iio/kfifo_buf.h                    |    8 -
 drivers/staging/iio/meter/ade7758.h                |    5 +-
 drivers/staging/iio/meter/ade7758_core.c           |    6 +-
 drivers/staging/iio/meter/ade7758_ring.c           |    4 +-
 drivers/staging/iio/ring_generic.h                 |   28 +-
 drivers/staging/iio/ring_sw.c                      |   25 +-
 43 files changed, 645 insertions(+), 787 deletions(-)

-- 
1.7.3.4
