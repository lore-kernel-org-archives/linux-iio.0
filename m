Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	michael.hennerich@analog.com,
	device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] IIO: Why maintain separate and shared knowledge internally?
Date: Fri, 21 Oct 2011 16:39:38 +0100
Message-Id: <1319211579-14367-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

We don't use it anywhere.  Post Lars-Peter's cleanup to
use the enum values directly, it seems sensible to get rid
of the constraint that each should be listed in two variants,
shared and separate.  Lars-Peter suggested some macros to
simplify the whole (1 << INFO ELEMENT) | ( 1 <<...
mess we have in drivers.  If we are going to have these,
might as well use this oportunity to make the pairs in
the mask explicit by having only one enum entry and adding
the logic to these macros.

Will break all out of tree drivers (more or less).
Sorry, but the fix is simple.

Note - dependent on patch 1 but not 2 of Lars-Peters series.
2 is replaced as part of this.

Jonathan

Jonathan Cameron (1):
  staging:iio:treewide only use shared to decide on interfaces

 drivers/staging/iio/accel/adis16201_core.c      |   33 +++---
 drivers/staging/iio/accel/adis16203_core.c      |   21 ++--
 drivers/staging/iio/accel/adis16204_core.c      |   32 +++---
 drivers/staging/iio/accel/adis16209_core.c      |   29 +++---
 drivers/staging/iio/accel/adis16220_core.c      |   22 ++--
 drivers/staging/iio/accel/adis16240_core.c      |   29 +++---
 drivers/staging/iio/accel/kxsd9.c               |    6 +-
 drivers/staging/iio/accel/lis3l02dq_core.c      |   16 ++--
 drivers/staging/iio/accel/sca3000_core.c        |    4 +-
 drivers/staging/iio/adc/ad7192.c                |   34 +++---
 drivers/staging/iio/adc/ad7280a.c               |    6 +-
 drivers/staging/iio/adc/ad7291.c                |   38 ++++---
 drivers/staging/iio/adc/ad7298_core.c           |   41 ++++---
 drivers/staging/iio/adc/ad7476_core.c           |   18 ++--
 drivers/staging/iio/adc/ad7606_core.c           |    2 +-
 drivers/staging/iio/adc/ad7780.c                |    6 +-
 drivers/staging/iio/adc/ad7793.c                |   50 ++++----
 drivers/staging/iio/adc/ad7887_core.c           |    6 +-
 drivers/staging/iio/adc/ad799x_core.c           |    2 +-
 drivers/staging/iio/adc/max1363_core.c          |    4 +-
 drivers/staging/iio/cdc/ad7150.c                |    6 +-
 drivers/staging/iio/cdc/ad7152.c                |   38 +++---
 drivers/staging/iio/cdc/ad7746.c                |   50 ++++----
 drivers/staging/iio/dac/ad5064.c                |    4 +-
 drivers/staging/iio/dac/ad5360.c                |   22 ++--
 drivers/staging/iio/dac/ad5686.c                |    4 +-
 drivers/staging/iio/dac/ad5791.c                |    8 +-
 drivers/staging/iio/gyro/adis16060_core.c       |    8 +-
 drivers/staging/iio/gyro/adis16260_core.c       |   27 ++---
 drivers/staging/iio/gyro/adxrs450_core.c        |    8 +-
 drivers/staging/iio/iio.h                       |   62 +++++++---
 drivers/staging/iio/iio_simple_dummy.c          |   43 ++++---
 drivers/staging/iio/impedance-analyzer/ad5933.c |    4 +-
 drivers/staging/iio/imu/adis16400_core.c        |  143 +++++++++++------------
 drivers/staging/iio/industrialio-core.c         |   19 ++--
 drivers/staging/iio/light/isl29018.c            |    7 +-
 drivers/staging/iio/light/tsl2563.c             |    6 +-
 drivers/staging/iio/magnetometer/ak8975.c       |    4 +-
 drivers/staging/iio/magnetometer/hmc5843.c      |    4 +-
 drivers/staging/iio/meter/ade7758_core.c        |   30 +++---
 40 files changed, 468 insertions(+), 428 deletions(-)

-- 
1.7.7
