Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/5] staging:iio: New stuff (No rush!)
Date: Wed, 26 Oct 2011 17:41:31 +0100
Message-Id: <1319647296-4374-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

This lot are not even vaguely urgent. I am just sending them
to you to keep on top of my own patch queue.

The header reorganization was proposed by Lars-Peter and
adapted to fit in with the in kernel interface work.
Anyhow they'd become a mess so this cleanup makes life
somwhat nicer.

The userspace types fo iio_event data makes sense, but
obviously doesn't matter enough to push out in this cycle.

Not using bitmasks is a cleanup that should have been done
a long time ago.  The code evolved to the point where they
didn't make any sense at all (I'm not entirely sure they
did when we first introduced them either.) Dan Carpenter
raised this point as well as Lars-Peter.

The treewided only use shared to decide in interfaces patch
takes this futher.  Drivers very rarely (and arguably never
should) care whether the requested value is shared across
multiple channels or not.  Hence we push that logic up
the chain so that it controls only the userspace (sysfs)
interface naming (allowing in_accel_scale to apply to
in_accel_x_raw etc channels). It stops us having to
carry two versions of the enum entries and a lot
of silly workarounds for that.

Anyhow, all nice cleanups, mostly coming from Lars-Peter
poking around in stuff we had left alone for far too long!
Always good to get new eyes on the code.

Jonathan

Jonathan Cameron (2):
  staging:iio: header reorganization
  staging:iio:treewide only use shared to decide on interfaces

Lars-Peter Clausen (3):
  staging:iio: Use userspace types for iio_event_data
  iio:staging: Add documentation for IIO_EVENT_CODE
  staging:iio: Do not use bitmasks for channel info addresses

 drivers/staging/iio/accel/adis16201_core.c      |   35 ++--
 drivers/staging/iio/accel/adis16203_core.c      |   23 +--
 drivers/staging/iio/accel/adis16204_core.c      |   34 ++--
 drivers/staging/iio/accel/adis16209_core.c      |   31 ++--
 drivers/staging/iio/accel/adis16220_core.c      |   22 +-
 drivers/staging/iio/accel/adis16240_core.c      |   31 ++--
 drivers/staging/iio/accel/kxsd9.c               |    6 +-
 drivers/staging/iio/accel/lis3l02dq_core.c      |   19 +-
 drivers/staging/iio/accel/sca3000_core.c        |    7 +-
 drivers/staging/iio/accel/sca3000_ring.c        |    2 +-
 drivers/staging/iio/adc/ad7192.c                |   36 ++--
 drivers/staging/iio/adc/ad7280a.c               |    7 +-
 drivers/staging/iio/adc/ad7291.c                |   39 +++--
 drivers/staging/iio/adc/ad7298_core.c           |   43 +++--
 drivers/staging/iio/adc/ad7298_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7476_core.c           |   20 +-
 drivers/staging/iio/adc/ad7476_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7606_core.c           |    4 +-
 drivers/staging/iio/adc/ad7606_ring.c           |    2 +-
 drivers/staging/iio/adc/ad7780.c                |    6 +-
 drivers/staging/iio/adc/ad7793.c                |   52 +++---
 drivers/staging/iio/adc/ad7816.c                |    1 +
 drivers/staging/iio/adc/ad7887_core.c           |    8 +-
 drivers/staging/iio/adc/ad7887_ring.c           |    2 +-
 drivers/staging/iio/adc/ad799x_core.c           |    5 +-
 drivers/staging/iio/adc/ad799x_ring.c           |    2 +-
 drivers/staging/iio/adc/adt7310.c               |    2 +-
 drivers/staging/iio/adc/adt7410.c               |    1 +
 drivers/staging/iio/adc/max1363_core.c          |    7 +-
 drivers/staging/iio/adc/max1363_ring.c          |    2 +-
 drivers/staging/iio/addac/adt7316.c             |    1 +
 drivers/staging/iio/buffer.h                    |  227 ++++++++++++++++++++++
 drivers/staging/iio/buffer_generic.h            |  228 -----------------------
 drivers/staging/iio/cdc/ad7150.c                |    8 +-
 drivers/staging/iio/cdc/ad7152.c                |   38 ++--
 drivers/staging/iio/cdc/ad7746.c                |   50 +++---
 drivers/staging/iio/chrdev.h                    |   25 ---
 drivers/staging/iio/dac/ad5064.c                |    4 +-
 drivers/staging/iio/dac/ad5360.c                |   22 +-
 drivers/staging/iio/dac/ad5504.c                |    1 +
 drivers/staging/iio/dac/ad5686.c                |    4 +-
 drivers/staging/iio/dac/ad5791.c                |    8 +-
 drivers/staging/iio/events.h                    |  102 ++++++++++
 drivers/staging/iio/gyro/adis16060_core.c       |    8 +-
 drivers/staging/iio/gyro/adis16260_core.c       |   29 ++--
 drivers/staging/iio/gyro/adxrs450_core.c        |    8 +-
 drivers/staging/iio/iio.h                       |  102 +++++------
 drivers/staging/iio/iio_simple_dummy.c          |   46 +++--
 drivers/staging/iio/iio_simple_dummy_events.c   |    1 +
 drivers/staging/iio/impedance-analyzer/ad5933.c |    6 +-
 drivers/staging/iio/imu/adis16400_core.c        |  145 +++++++-------
 drivers/staging/iio/industrialio-buffer.c       |    2 +-
 drivers/staging/iio/industrialio-core.c         |   21 +-
 drivers/staging/iio/kfifo_buf.h                 |    2 +-
 drivers/staging/iio/light/isl29018.c            |    7 +-
 drivers/staging/iio/light/tsl2563.c             |    7 +-
 drivers/staging/iio/magnetometer/ak8975.c       |    4 +-
 drivers/staging/iio/magnetometer/hmc5843.c      |    4 +-
 drivers/staging/iio/meter/ade7758_core.c        |   32 ++--
 drivers/staging/iio/ring_sw.h                   |    2 +-
 drivers/staging/iio/sysfs.h                     |   43 -----
 drivers/staging/iio/types.h                     |   49 +++++
 62 files changed, 894 insertions(+), 795 deletions(-)
 create mode 100644 drivers/staging/iio/buffer.h
 delete mode 100644 drivers/staging/iio/buffer_generic.h
 delete mode 100644 drivers/staging/iio/chrdev.h
 create mode 100644 drivers/staging/iio/events.h
 create mode 100644 drivers/staging/iio/types.h

-- 
1.7.7
