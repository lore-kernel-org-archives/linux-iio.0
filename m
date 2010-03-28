Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/13] Staging: IIO: ABI changes round 1, V1
Date: Sun, 28 Mar 2010 21:41:06 +0100
Message-Id: <1269808879-28838-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Dear All,

This is the first set of patches related to the new abi as discussed on
lkml http://lkml.org/lkml/2010/2/5/205  I will post them more generally
(i.e. lkml) in a week ammended as appropriate.  Note these will cause
extensive breakage in any drivers not currently in the mainline tree
(so most of them :) but hopefully the changes required are fairly minimal.

Practical issues lead to a few minor changes.  Firstly the 'scan_elements'
directory still exists in the main device directory. This is mainly
because moving it into the buffer0 directory will add complexity
to handling the addition of multiple choices of buffer type.

One other question that came up during this, was how to name triggers
that are associated closely with a device.  Those trigger not associated
with a device should be named trigger0 etc with their own idr to handle
numbering.  But for those cases where there is a device, should they
be device[n]:trigger0 or device[n]:trigger[m] where m is based on the
the trigger idr?  At the moment they are still all as trigger[m]
in /sys/bus/iio/devices but this obviously doesn't give quite as much
info as is available for all the other elements associated with a given
physical device?

I'm afraid the ordering of these patches is a little random but as they
are here they shouldn't cause any breakage and I'd rather not waste time
putting them in a more sensible order.

Note the changes to max1363 are large. This is mainly because the driver
previously used a completely different means of controlling scan elements
to all others and hence that code needed a thorough rewrite.  This probably
still needs more work, but is informative to others in its current
state.

Note these patches are against 2.6.34-rc2 and as such do not include a
number of fixes that people have set out and which are in Greg's
and Andrew's trees at the moment.

Thanks,

Jonathan

Jonathan Cameron (13):
  staging:iio: Add new in_raw definitions for adc channels.
  staging:iio: Add new attrs for sampling frequency available and
    temp_raw
  iio:staging:accelerometers move towards the new abi
  staging:iio: Support functions for scan mask matching
  staging: iio: Move from class to bus
  staging:iio: Move event attributes into the event[n] device in sysfs
  staging:iio: Clean out unused IIO_SCAN_EL and add IIO_SCAN_NAMED_EL_C
  staging:iio:max1363 move to new abi.
  staging:iio: Documentation, update iio_utils.h for the move to a bus
  staging:iio: ABI documentation (partial)
  staging:iio: Directory name changes to match new ABI.
  staging:iio:tsl2563: change lux to illuminanc0_input to match new abi
  staging:iio: Remove naming via IDR's where no longer necessary under
    new abi.

 drivers/staging/iio/Documentation/iio_utils.h     |   31 +-
 drivers/staging/iio/Documentation/sysfs-class-iio |  265 +++++++
 drivers/staging/iio/accel/accel.h                 |    8 +-
 drivers/staging/iio/accel/kxsd9.c                 |   88 ++-
 drivers/staging/iio/accel/lis3l02dq.h             |    4 -
 drivers/staging/iio/accel/lis3l02dq_core.c        |  175 +++---
 drivers/staging/iio/accel/lis3l02dq_ring.c        |   10 +-
 drivers/staging/iio/accel/sca3000.h               |    2 +
 drivers/staging/iio/accel/sca3000_core.c          |  174 +++---
 drivers/staging/iio/accel/sca3000_ring.c          |   33 +-
 drivers/staging/iio/adc/Kconfig                   |    1 +
 drivers/staging/iio/adc/Makefile                  |    2 +-
 drivers/staging/iio/adc/adc.h                     |   12 +
 drivers/staging/iio/adc/max1363.h                 |  122 ++--
 drivers/staging/iio/adc/max1363_core.c            |  762 ++++++++++++---------
 drivers/staging/iio/adc/max1363_ring.c            |   67 ++-
 drivers/staging/iio/chrdev.h                      |    2 +-
 drivers/staging/iio/iio.h                         |   46 ++-
 drivers/staging/iio/industrialio-core.c           |   58 +-
 drivers/staging/iio/industrialio-ring.c           |   63 +--
 drivers/staging/iio/industrialio-trigger.c        |    2 +-
 drivers/staging/iio/light/tsl2563.c               |    4 +-
 drivers/staging/iio/ring_generic.h                |   42 +-
 drivers/staging/iio/ring_sw.c                     |    2 +-
 drivers/staging/iio/sysfs.h                       |   15 +-
 25 files changed, 1244 insertions(+), 746 deletions(-)
 create mode 100644 drivers/staging/iio/Documentation/sysfs-class-iio
