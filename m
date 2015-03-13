Return-Path: <darshanapadmadas@gmail.com>
From: Darshana Padmadas <darshanapadmadas@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	Darshana Padmadas <darshanapadmadas@gmail.com>
Subject: [PATCH v2] iio: Add ABI documentation for in_magn offset value
Date: Fri, 13 Mar 2015 21:06:58 +0530
Message-Id: <1426261018-6025-1-git-send-email-darshanapadmadas@gmail.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

This patch adds ABI documentation entries for in_magn_offset.
There is one user, hid-sensor-magn-3d in drivers/iio/magnetometer.

Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
---
Changes in v2:
    - Removed attribute in_magn_raw as no driver in drivers/iio/magnetometer
      or staging/iio/magnetometer has info_mask_separate set to
      IIO_CHAN_INFO_RAW without any modifiers.
    - Changed subject and commit message accordingly.

 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 9a70c31..4fd3976 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -253,6 +253,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_temp_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_offset
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
1.9.1
