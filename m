Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/6] IIO cleanups
Date: Wed,  5 May 2010 23:25:40 +0100
Message-Id: <1273098346-4184-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Dear all these are mostly the promised incremental patches to move
the adis16400 and adis16300 drivers to the new abi.  Also in here
are some dead code removal.  Usual principal that code that isn't
used should not be there until it is needed.  Both the drivers
were in very good condition, so I've only touched them in superficial
ways.  Thanks Barry.

I do not think there is anything controversial in these so if I
don't hear any shouts I'll send them to Greg tomorrow.

Note I know there are plenty of other bit not meeting the abi
(and probably some more typos in the abi itself) but these were
the low hanging fruit today.

Jonathan

---

Jonathan Cameron (6):
  staging:iio:Documentation fixes
  staging:iio  Break up gyro.h and move to new abi
  staging:iio:adis16300 clean out some unused code
  staging:iio:Documentation update to add incli and switch to magn
  staging:iio:adis16400 clean out some unused code
  staging:iio:imu remove unecessary empty defs for event attributes.

 drivers/staging/iio/Documentation/sysfs-class-iio |   17 +++-
 drivers/staging/iio/accel/inclinometer.h          |   23 +++++
 drivers/staging/iio/gyro/gyro.h                   |   43 +---------
 drivers/staging/iio/imu/adis16300.h               |    9 --
 drivers/staging/iio/imu/adis16300_core.c          |   91 ++-------------------
 drivers/staging/iio/imu/adis16400.h               |    9 --
 drivers/staging/iio/imu/adis16400_core.c          |   75 ++---------------
 drivers/staging/iio/magnetometer/magnet.h         |   12 ++--
 8 files changed, 62 insertions(+), 217 deletions(-)
 create mode 100644 drivers/staging/iio/accel/inclinometer.h
