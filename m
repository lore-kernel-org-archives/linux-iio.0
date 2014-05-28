Return-Path: <reyad.attiyat@gmail.com>
From: Reyad Attiyat <reyad.attiyat@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	linux-input@vger.kernel.org,
	jkosina@suse.cz
Cc: Reyad Attiyat <reyad.attiyat@gmail.com>
Subject: [PATCH 0/3] IIO: hid-sensor-magn-3d: Add support for compass north usage attribute
Date: Wed, 28 May 2014 16:06:12 -0500
Message-Id: <1401311175-12784-1-git-send-email-reyad.attiyat@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Update hid-sensor-magn-3d to dynamically create IIO channels
Update IIO to include modifiers for true/magnetic north and
tilt compensation compass usages

Signed-off-by: Reyad Attiyat <reyad.attiyat@gmail.com>


Reyad Attiyat (3):
  IIO: Added iio magn_north ABI documentation
  IIO: Add iio_chan modifier for True/Magnetic North HID usages
  IO: hid-sensor-magn-3d: Add in support for True/Magnetic North HID
    usages

 Documentation/ABI/testing/sysfs-bus-iio       |  76 +++++++
 drivers/iio/industrialio-core.c               |   4 +
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 278 +++++++++++++++++---------
 include/linux/iio/types.h                     |   4 +
 4 files changed, 267 insertions(+), 95 deletions(-)

-- 
1.9.3
