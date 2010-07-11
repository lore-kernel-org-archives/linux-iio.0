Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: gregkh@suse.de
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/12] IIO cleanups and fixes (for staging-next)
Date: Sun, 11 Jul 2010 16:39:07 +0100
Message-Id: <1278862759-19028-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

All of these have been on the iio mailing list for at least
a week and the majority reviewed.  The others are uncontroversial.

The two fixes are:
  staging:iio:imu allow adis16300 and adis16400 to build without ring
    buffer support.
  staging:iio: Fix scan_element naming issue

The first overly restricts building those IMU drivers (I introduced
this when doing the origial merge of these two... oops). The second
bug caused incorrect naming of scan_element attributes.  This
heavily restricts ring buffer usage (you can't really change
what is in it).

The other patches are all directed towards reducing code either
by removing locally created equivalents of standard kernel
constructs or by adding some 'helper' functions that cover
standard cases when dealing with particular ring types.

For the last two, only a single driver has yet been tested
but the same approach should give a similar saving in code
for the majority of device drivers.

Barry Song (1):
  staging:iio: Add a bits per element element to ring_generic allowing 
       a general ring_sw_preenable_function.

Jonathan Cameron (11):
  staging:iio: Use kasprintf to allocate and fill trig->name
  staging:iio: Add and convert drivers to use iio_alloc_pollfunc
  staging:iio: Add iio_triggered_ring postenable and predisable + use
    in drivers
  staging:iio: remove timestamp field from trigger and pass instead
    through pollfuncs
  staging:iio: replace combine_8_to_16 with be16_to_cpup where
    possible.
  staging:iio:imu allow adis16300 and adis16400 to build without ring
    buffer support.
  staging:iio: Add stubs for iio_ring_buffer_[un]register and
    equivalent driver stubs
  staging:iio: Fix scan_element naming issue
  staging:iio: Make extensive use of iio_sw_ring_preenable
  staging:iio: Add iio_sw_ring_helper_state and functions to cover
    common case.
  staging:iio:lis3l02dq use iio_sw_ring_helper_state and funcs

 drivers/staging/iio/accel/adis16209.h              |   30 +--
 drivers/staging/iio/accel/adis16209_core.c         |    7 +-
 drivers/staging/iio/accel/adis16209_ring.c         |   93 ++--------
 drivers/staging/iio/accel/adis16209_trigger.c      |   10 +-
 drivers/staging/iio/accel/adis16240.h              |   25 +--
 drivers/staging/iio/accel/adis16240_core.c         |    7 +-
 drivers/staging/iio/accel/adis16240_ring.c         |   90 ++--------
 drivers/staging/iio/accel/adis16240_trigger.c      |   10 +-
 drivers/staging/iio/accel/lis3l02dq.h              |   20 +--
 drivers/staging/iio/accel/lis3l02dq_core.c         |  119 +++++++-----
 drivers/staging/iio/accel/lis3l02dq_ring.c         |  202 ++++++--------------
 drivers/staging/iio/adc/max1363.h                  |   13 --
 drivers/staging/iio/adc/max1363_core.c             |    6 +-
 drivers/staging/iio/adc/max1363_ring.c             |   54 +-----
 drivers/staging/iio/gyro/adis16260.h               |   23 +--
 drivers/staging/iio/gyro/adis16260_core.c          |   10 +-
 drivers/staging/iio/gyro/adis16260_ring.c          |   91 ++--------
 drivers/staging/iio/gyro/adis16260_trigger.c       |   10 +-
 drivers/staging/iio/imu/Kconfig                    |   10 +-
 drivers/staging/iio/imu/adis16300.h                |   20 +-
 drivers/staging/iio/imu/adis16300_core.c           |    7 +-
 drivers/staging/iio/imu/adis16300_ring.c           |   87 ++-------
 drivers/staging/iio/imu/adis16300_trigger.c        |   10 +-
 drivers/staging/iio/imu/adis16350.h                |   44 +----
 drivers/staging/iio/imu/adis16350_core.c           |    7 +-
 drivers/staging/iio/imu/adis16350_ring.c           |   90 ++--------
 drivers/staging/iio/imu/adis16350_trigger.c        |   10 +-
 drivers/staging/iio/imu/adis16400.h                |   37 ++---
 drivers/staging/iio/imu/adis16400_core.c           |    7 +-
 drivers/staging/iio/imu/adis16400_ring.c           |   88 ++-------
 drivers/staging/iio/imu/adis16400_trigger.c        |   10 +-
 drivers/staging/iio/industrialio-trigger.c         |   48 ++++-
 drivers/staging/iio/ring_generic.h                 |   23 ++-
 drivers/staging/iio/ring_sw.c                      |   69 +++++++
 drivers/staging/iio/ring_sw.h                      |   10 +
 drivers/staging/iio/trigger.h                      |   24 ++-
 drivers/staging/iio/trigger/iio-trig-gpio.c        |   12 +-
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |   15 +-
 38 files changed, 485 insertions(+), 963 deletions(-)
