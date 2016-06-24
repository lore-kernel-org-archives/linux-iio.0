Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
Cc: vlad.dogaru@intel.com,
	andrey_utkin@fastmail.com
Subject: [RFC PATCH] iio: imu: add driver for Bosch Sensortec BNO055
Date: Fri, 24 Jun 2016 14:15:35 +0300
Message-Id: <1466766936-20561-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Hi everyone,

This is a minimal implementation of a driver for the Bosch Sensortec
BNO055, a very interesting accel-gyro-magneto combo.  The datasheet is
available at https://www.bosch-sensortec.com/bst/products/all_products/bno055

The driver in its present state works, but this is a RFC for a few
reasons detailed below:

(1) The device has a few possible operating modes.  The most simple
ones employ a single sensor and power down the other two; the most
complex use all 3 for sensor fusion.  Changing the mode at runtime would
require changing the channels and I'm not sure IIO allows that.  So I've
opted to choose the mode at probe time, based on a DeviceTree property.
Hope that's ok.

(2) Fusion modes provide orientation data.  This is either relative to
the initial position of the sensor, or to magnetic North.  There is a
modifier, IIO_MOD_NORTH_MAGN, but it occupies the same field as
IIO_MOD_QUATERNION and IIO_MOD_{X,Y,Z}, so we can't use both.  Therefore
there is currently no means of telling from user space whether the
orientation is relative to North or to the initial position;  one could
look at the DeviceTree description to deduce the operating mode, but
that's hardly ideal.

(3) In fusion modes, the device also exposes linear and gravitational
accelerations, but IIO doesn't seem to support this.  I can add these
channel types if you believe they are useful.


Vlad Dogaru (1):
  iio: imu: add driver for Bosch Sensortec BNO055

 drivers/iio/imu/Kconfig  |  11 +
 drivers/iio/imu/Makefile |   1 +
 drivers/iio/imu/bno055.c | 569 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 581 insertions(+)
 create mode 100644 drivers/iio/imu/bno055.c

-- 
1.9.1
