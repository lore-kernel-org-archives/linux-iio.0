Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: opw-kernel@googlegroups.com
Cc: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH] iio: Add ABI documentation for offset and scaled humidity
Date: Thu, 23 Oct 2014 14:44:21 +0300
Message-Id: <1414064661-4645-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds ABI documentation entries for in_humidityrelative_offset
and in_humidityrelative_scale, since there is at least one user for these,
Si7005 humidity and temperature sensor driver.

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d760b02..ffcadca 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -231,6 +231,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_offset
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -266,6 +267,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_rot_from_north_magnetic_tilt_comp_sca
 What:		/sys/bus/iio/devices/iio:deviceX/in_rot_from_north_true_tilt_comp_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_scale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
1.9.1
