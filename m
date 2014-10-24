Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: opw-kernel@googlegroups.com
Cc: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH] iio: Add ABI documentation for RGBC intensity hardware gain factor
Date: Sat, 25 Oct 2014 00:41:55 +0300
Message-Id: <1414186915-4035-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds documentation for RGBC in_intensity_*_hardwaregain.
There is at least one user for these, ADJD-S311-CR999 digital color sensor
driver.

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ffcadca..661a672 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -330,6 +330,10 @@ Description:
 		are listed in this attribute.
 
 What		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_hardwaregain
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_hardwaregain
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_hardwaregain
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_clear_hardwaregain
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
1.9.1
