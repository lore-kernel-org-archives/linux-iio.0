Return-Path: <slm9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: greg@kroah.com
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org
Subject: [PATCH 0/6] staging:iio Update drivers and docu
Date: Tue, 31 Aug 2010 11:32:49 +0200
Message-Id: <1283247175-12835-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
List-ID: <linux-iio@vger.kernel.org>

Hello Greg,

this patch series updates the iio drivers and docu to the latest
discussion in the linux-iio mailing list. Mainly some cleanup of
userspace ABI and streamlining the drivers.

The last patch fixes some unit scaling, but Jonathan Cameron and I
could not agree on how strictly we want to resamble the hwmon ABI.

To sum up the discussion:
Hwmon has files with the postfix _input to read values scaled to
reasonable units for fixed point representation. So the units are
sometimes scaled down to 'millis' e.g. millivolt, millidegree Celsius.
We agreed that we want to keep this, whenever we use the _input postfix.
For IIO there is also the postfix triple _raw, _scale and _offset,
where the final value is calculated by (_raw + _offset) * _scale.
Floating point values are allowed for any of these files.

The question in place was:
Do we want to resamble the 'milli' units or should we stick to
standard SI units (radians, kelvin, etc.) as floating point math is
necessary anyway.

Regards,
Manuel

[PATCH 1/6] staging:iio rename ring attributes
[PATCH 2/6] staging:iio:lis3l02dq adjust lis3l02dq_configure_ring
[PATCH 3/6] staging:iio move scan_elements into ring buffer
[PATCH 4/6] staging:iio partial documentation update
[PATCH 5/6] staging:iio sync drivers with current ABI
[PATCH 6/6] staging:iio sync scale units

 drivers/staging/iio/Documentation/ring.txt        |    6 +-
 drivers/staging/iio/Documentation/sysfs-class-iio |   72 ++++++------
 drivers/staging/iio/Documentation/userspace.txt   |   36 +++---
 drivers/staging/iio/accel/accel.h                 |   42 ++++++-
 drivers/staging/iio/accel/adis16209_core.c        |   30 ++----
 drivers/staging/iio/accel/adis16209_ring.c        |   49 ++++----
 drivers/staging/iio/accel/adis16220_core.c        |   14 ++-
 drivers/staging/iio/accel/adis16240_core.c        |   27 +++--
 drivers/staging/iio/accel/adis16240_ring.c        |   41 ++++----
 drivers/staging/iio/accel/inclinometer.h          |    2 +
 drivers/staging/iio/accel/lis3l02dq_core.c        |    2 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c        |   62 ++++++-----
 drivers/staging/iio/accel/sca3000_core.c          |    4 +-
 drivers/staging/iio/accel/sca3000_ring.c          |   12 +-
 drivers/staging/iio/adc/adc.h                     |    7 +
 drivers/staging/iio/adc/max1363_core.c            |    1 -
 drivers/staging/iio/adc/max1363_ring.c            |   18 ++--
 drivers/staging/iio/gyro/adis16260_core.c         |   22 ++--
 drivers/staging/iio/gyro/adis16260_ring.c         |   39 +++----
 drivers/staging/iio/gyro/gyro.h                   |   46 +++++++--
 drivers/staging/iio/iio.h                         |   98 -----------------
 drivers/staging/iio/imu/adis16300_core.c          |   36 ++++---
 drivers/staging/iio/imu/adis16300_ring.c          |   51 ++++-----
 drivers/staging/iio/imu/adis16350_core.c          |   45 ++++++--
 drivers/staging/iio/imu/adis16350_ring.c          |   55 +++++-----
 drivers/staging/iio/imu/adis16400_core.c          |   51 +++++----
 drivers/staging/iio/imu/adis16400_ring.c          |   57 +++++-----
 drivers/staging/iio/industrialio-core.c           |   12 --
 drivers/staging/iio/industrialio-ring.c           |   46 +++++---
 drivers/staging/iio/ring_generic.h                |  122 +++++++++++++++++++--
 drivers/staging/iio/ring_sw.c                     |   79 +++++++-------
 drivers/staging/iio/ring_sw.h                     |   12 +-
 drivers/staging/iio/sysfs.h                       |   17 ++-
 33 files changed, 661 insertions(+), 552 deletions(-)
