Return-Path: <alexandre.belloni@free-electrons.com>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] iio: Documentation: fix in_*_scale  kernel version
Date: Sun, 22 May 2016 15:30:48 +0200
Message-Id: <1463923848-13157-1-git-send-email-alexandre.belloni@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

v3.21 doesn't exist, the first apparition of a in_.*_scale file was in v3.2

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3c6624881375..ca2d1a6135f1 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -724,7 +724,7 @@ What:		/sys/.../events/in_voltage_supply_scale
 What:		/sys/.../events/in_temp_scale
 What:		/sys/.../events/in_illuminance_scale
 What:		/sys/.../events/in_proximity_scale
-KernelVersion:	3.21
+KernelVersion:	3.2
 Contact:	linux-iio@vger.kernel.org
 Description:
                 Specifies the conversion factor from the standard units
-- 
2.8.1
