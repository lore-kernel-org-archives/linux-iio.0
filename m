Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/9] Trigger locking rework and splitting up trigger.h 
Date: Wed, 24 Aug 2011 17:28:32 +0100
Message-Id: <1314203321-21926-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

This series has been floating around for a while and fixes some nasty
issues with reference counting on triggers + gets rid of some work
arounds people were using in drivers for the above issue.  Series
has had a few little reorganization patches added since first posting,
but nothing controversial.

Whilst some of this is technically stable material it's probably better
to wait an see if anyone cares then do a backport as and when.

Thanks as ever for your hard work.

Jonathan

Original text was:

This is the result of actually checking the locking code for
triggers and ensuring saferemoval.

One kicker in here.  Any driver that can do dynamic creation / removal
of triggers (currently only sysfs trigger), must be very very careful.
It's possible post this series for two devices to apparently be connected
to a trigger with the same name, but only one be connected to the current
instance of that trigger.  To my mind, if you've got into this mess, your
userspace is borked anyway and it doesn't actually cause a crash (unlike
before this set), it just doesn't work as expected.

If anyone can see a case I've missed, please do point it out.

Note this also includes the trigger.h split and the semantic change
discussed in 'Splitting trigger header in two and barriers'.

That is, if your driver is currently using a trigger (other than one
it provides), you will not be able to remove the module.  The previous
approach of just disconnected on removal would double release some stuff
anyway causing lots of unpleasant messages.

Whilst this stuff is definitely broken in current mainline, I'm not
proposing to rush this set out.


Jonathan Cameron (9):
  staging:iio:triggers. Add a reference get to the core for triggers.
  staging:iio:triggers reorder module put and device put to ensure that
    the ops are still there if put results in device deletion.
  staging:iio:trigger:sysfs trigger: Add a release function to avoid
    warning on module removal.
  staging:iio:pollfunc: Make explicit that private data is always
    pointer to a struct iio_dev.
  staging:iio: prevent removal of module connected to trigger.
  staging:iio:rename trigger_consumer.h to indicate it is core only.
  staging:iio: spit trigger.h into provider and consumer parts.
  staging:iio:trigger core. Trivial code cleanups.
  staging:iio:trigger push functions that don't need to be generaly
    available down into the core.

 drivers/staging/iio/accel/adis16201_ring.c   |    4 +-
 drivers/staging/iio/accel/adis16203_ring.c   |    4 +-
 drivers/staging/iio/accel/adis16204_ring.c   |    4 +-
 drivers/staging/iio/accel/adis16209_ring.c   |    4 +-
 drivers/staging/iio/accel/adis16240_ring.c   |    4 +-
 drivers/staging/iio/accel/lis3l02dq_ring.c   |    3 +-
 drivers/staging/iio/adc/ad7192.c             |    9 +--
 drivers/staging/iio/adc/ad7298_ring.c        |    9 +--
 drivers/staging/iio/adc/ad7476_ring.c        |   10 +---
 drivers/staging/iio/adc/ad7606_ring.c        |   10 +---
 drivers/staging/iio/adc/ad7793.c             |    9 +--
 drivers/staging/iio/adc/ad7887_ring.c        |   10 +---
 drivers/staging/iio/adc/ad799x_ring.c        |   10 +---
 drivers/staging/iio/adc/max1363_ring.c       |    9 +--
 drivers/staging/iio/gyro/adis16260_ring.c    |    4 +-
 drivers/staging/iio/iio_core_trigger.h       |   46 ++++++++++++++
 drivers/staging/iio/imu/adis16400_ring.c     |    4 +-
 drivers/staging/iio/industrialio-core.c      |    2 +-
 drivers/staging/iio/industrialio-trigger.c   |   65 +++++++++++++--------
 drivers/staging/iio/meter/ade7758_ring.c     |   10 +---
 drivers/staging/iio/trigger.h                |   83 +-------------------------
 drivers/staging/iio/trigger/iio-trig-sysfs.c |    7 ++
 drivers/staging/iio/trigger_consumer.h       |   71 ++++++++++++----------
 23 files changed, 169 insertions(+), 222 deletions(-)
 create mode 100644 drivers/staging/iio/iio_core_trigger.h

-- 
1.7.3.4
