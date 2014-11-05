Return-Path: <darshanapadmadas@gmail.com>
From: Darshana Padmadas <darshanapadmadas@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Darshana Padmadas <darshanapadmadas@gmail.com>
Subject: [PATCH] iio: Add ABI documentation for scaled voltage
Date: Wed,  5 Nov 2014 21:48:11 +0530
Message-Id: <1415204291-25376-1-git-send-email-darshanapadmadas@gmail.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

This patch adds an entry in ABI documentation for in_voltage-voltage_scale.
It has at least one user driver, adis16220, in accel driver.

Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d760b02..0640118 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -251,6 +251,7 @@ Description:
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_scale
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale
-- 
1.9.1
