Return-Path: <darshanapadmadas@gmail.com>
From: Darshana Padmadas <darshanapadmadas@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	Darshana Padmadas <darshanapadmadas@gmail.com>
Subject: [PATCH] iio: Add ABI documentation for in_magn offset and raw values
Date: Fri, 13 Mar 2015 19:16:06 +0530
Message-Id: <1426254366-27021-1-git-send-email-darshanapadmadas@gmail.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

This patch adds ABI documentation entries for in_magn_offset
and in_magn_raw. At least one user exists, mag3110 and
hid-sensor-magn-3d in drivers/iio/magnetometer.

Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 9a70c31..37564cb 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -177,6 +177,7 @@ Description:
 		arbitrarily assigned). Data converted by application of offset
 		and scale to degrees.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_magn_z_raw
@@ -253,6 +254,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_temp_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_offset
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
1.9.1
