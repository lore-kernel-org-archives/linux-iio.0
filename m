Return-Path: <SRS0=Xqts=FL=konsulko.com=matt.ranostay@kernel.org>
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: sysfs-bus-iio-*: update email contact
Date: Fri, 16 Feb 2018 18:36:21 -0800
Message-Id: <20180217023621.14482-1-matt.ranostay@konsulko.com>
List-ID: <linux-iio@vger.kernel.org>

Change email contact for ABI documention to author's current employer
on the following files:

* sysfs-bus-iio-chemical-vz89x
* sysfs-bus-iio-proximity-as3935

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x   | 2 +-
 Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935 | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x b/Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
index c0c1ea924535..d512f865600e 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
+++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-vz89x
@@ -1,7 +1,7 @@
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_VOC_short_raw
 Date:		September 2015
 KernelVersion:	4.3
-Contact:	Matt Ranostay <mranostay@gmail.com>
+Contact:	Matt Ranostay <matt.ranostay@konsulko.com>
 Description:
 		Get the raw calibration VOC value from the sensor.
 		This value has little application outside of calibration.
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935 b/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
index 147d4e8a1403..9a17ab5036a4 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
+++ b/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
@@ -1,7 +1,7 @@
 What		/sys/bus/iio/devices/iio:deviceX/in_proximity_input
 Date:		March 2014
 KernelVersion:	3.15
-Contact:	Matt Ranostay <mranostay@gmail.com>
+Contact:	Matt Ranostay <matt.ranostay@konsulko.com>
 Description:
 		Get the current distance in meters of storm (1km steps)
 		1000-40000 = distance in meters
@@ -9,7 +9,7 @@ Description:
 What		/sys/bus/iio/devices/iio:deviceX/sensor_sensitivity
 Date:		March 2014
 KernelVersion:	3.15
-Contact:	Matt Ranostay <mranostay@gmail.com>
+Contact:	Matt Ranostay <matt.ranostay@konsulko.com>
 Description:
 		Show or set the gain boost of the amp, from 0-31 range.
 		18 = indoors (default)
-- 
2.14.1
