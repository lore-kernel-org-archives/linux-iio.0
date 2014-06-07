Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43408 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753025AbaFGPnC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:43:02 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 06/12] iio: Move documentation of iio-trig-sysfs to ABI
Date: Sat,  7 Jun 2014 17:42:46 +0200
Message-Id: <1402155772-1373-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

iio-trig-sysfs has left staging with commit e64e7d5c

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 Documentation/ABI/testing/sysfs-bus-iio                      | 12 ++++++++++++
 .../staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs    | 11 -----------
 2 files changed, 12 insertions(+), 11 deletions(-)
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ed202b3..5e86ee9 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -19,6 +19,18 @@ Description:
 		generalize well and hence are not documented in this file.
 		X is the IIO index of the trigger.
 
+What:		/sys/bus/iio/devices/triggerX/trigger_now
+KernelVersion:	2.6.38
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This file is provided by the iio-trig-sysfs stand-alone trigger
+		driver. Writing this file with any value triggers an event
+		driven driver, associated with this trigger, to capture data
+		into an in kernel buffer. This approach can be valuable during
+		automated testing or in situations, where other trigger methods
+		are not applicable. For example no RTC or spare GPIOs.
+		X is the IIO index of the trigger.
+
 What:		/sys/bus/iio/devices/iio:deviceX/buffer
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs b/drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs
deleted file mode 100644
index 5235e6c..0000000
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs
+++ /dev/null
@@ -1,11 +0,0 @@
-What:		/sys/bus/iio/devices/triggerX/trigger_now
-KernelVersion:	2.6.38
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This file is provided by the iio-trig-sysfs stand-alone trigger
-		driver. Writing this file with any value triggers an event
-		driven driver, associated with this trigger, to capture data
-		into an in kernel buffer. This approach can be valuable during
-		automated testing or in situations, where other trigger methods
-		are not applicable. For example no RTC or spare GPIOs.
-		X is the IIO index of the trigger.
-- 
1.9.1

