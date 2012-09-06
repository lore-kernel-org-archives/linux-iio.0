Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47762 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932124Ab2IFRIy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 6 Sep 2012 13:08:54 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	"J. August Brenner" <jbrenner@taosinc.com>
Subject: [PATCH] iio staging: cleanup documentation for tsl2583
Date: Thu,  6 Sep 2012 19:08:48 +0200
Message-Id: <1346951329-20693-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

drop Documentation/sysfs-bus-iio-light-tsl2583 and merge content with
Documentation/light/sysfs-bus-iio-light-tsl2583 together with some obvious
fixes:
in_illuminance0_calibrate -> illuminance0_calibrate
lux_table -> illuminance0_lux_table

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: J. August Brenner <jbrenner@taosinc.com>
---
 .../light/sysfs-bus-iio-light-tsl2583              |   16 +++++++++++++++-
 .../iio/Documentation/sysfs-bus-iio-light-tsl2583  |   20 --------------------
 2 files changed, 15 insertions(+), 21 deletions(-)
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-light-tsl2583

diff --git a/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583 b/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
index 470f7ad..e9716b9 100644
--- a/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
+++ b/drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
@@ -1,6 +1,20 @@
-What:		/sys/bus/iio/devices/device[n]/in_illuminance0_calibrate
+What:		/sys/bus/iio/devices/device[n]/illuminance0_lux_table
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This property gets/sets the table of coefficients
+		used in calculating illuminance in lux.
+
+What:		/sys/bus/iio/devices/device[n]/illuminance0_calibrate
 KernelVersion:	2.6.37
 Contact:	linux-iio@vger.kernel.org
 Description:
 		This property causes an internal calibration of the als gain trim
 		value which is later used in calculating illuminance in lux.
+
+What:		/sys/bus/iio/devices/device[n]/illuminance0_input_target
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This property is the known externally illuminance (in lux).
+		It is used in the process of calibrating the device accuracy.
diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-light-tsl2583 b/drivers/staging/iio/Documentation/sysfs-bus-iio-light-tsl2583
deleted file mode 100644
index 660781d..0000000
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio-light-tsl2583
+++ /dev/null
@@ -1,20 +0,0 @@
-What:		/sys/bus/iio/devices/device[n]/lux_table
-KernelVersion:	2.6.37
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This property gets/sets the table of coefficients
-		used in calculating illuminance in lux.
-
-What:		/sys/bus/iio/devices/device[n]/illuminance0_calibrate
-KernelVersion:	2.6.37
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This property causes an internal calibration of the als gain trim
-		value which is later used in calculating illuminance in lux.
-
-What:		/sys/bus/iio/devices/device[n]/illuminance0_input_target
-KernelVersion:	2.6.37
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This property is the known externally illuminance (in lux).
-		It is used in the process of calibrating the device accuracy.
-- 
1.7.9.5

