Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: barry.song@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC PATCH 0/5] Refactoring of ring buffer elements of Barry's recent RFC
Date: Wed, 30 Jun 2010 15:27:51 +0100
Message-Id: <1277908076-28592-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Barry,

This set are my follow up to my comments on your recent set.
What do you think of doing it this way round?

(the first is your code with a few minor edits, the second
makes use of it pretty much everywhere). The last 3 are the
refactored approach with the core work in patch 3 and
two example use cases (untested) in patches 4 and 5.

Jonathan

p.s. Thanks for all your ack's on the previous series, I'll
send them on to Greg KH shortly.

Barry Song (1):
  staging:iio: Add a bits per element element to ring_generic allowing 
       a general ring_sw_preenable_function.

Jonathan Cameron (4):
  staging:iio: Make extensive use of iio_sw_ring_preenable
  staging:iio: Add iio_sw_ring_helper_state and functions to cover
    common case.
  staging:iio:lis3l02dq use iio_sw_ring_helper_state and funcs
  staging:iio:adis16209 use iio_sw_ring_helper_state and funcs

 drivers/staging/iio/accel/adis16209.h         |    7 +-
 drivers/staging/iio/accel/adis16209_core.c    |   54 +++++----
 drivers/staging/iio/accel/adis16209_ring.c    |   95 +++-------------
 drivers/staging/iio/accel/adis16209_trigger.c |    8 +-
 drivers/staging/iio/accel/adis16240_ring.c    |   29 +-----
 drivers/staging/iio/accel/lis3l02dq.h         |   11 +-
 drivers/staging/iio/accel/lis3l02dq_core.c    |  116 +++++++++++--------
 drivers/staging/iio/accel/lis3l02dq_ring.c    |  152 +++++++------------------
 drivers/staging/iio/gyro/adis16260_ring.c     |   29 +-----
 drivers/staging/iio/imu/adis16300_ring.c      |   26 +----
 drivers/staging/iio/imu/adis16350_ring.c      |   29 +-----
 drivers/staging/iio/imu/adis16400_ring.c      |   26 +----
 drivers/staging/iio/ring_generic.h            |    2 +
 drivers/staging/iio/ring_sw.c                 |   68 +++++++++++
 drivers/staging/iio/ring_sw.h                 |   10 ++
 15 files changed, 257 insertions(+), 405 deletions(-)
