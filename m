Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47890 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbaFLFAk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 12 Jun 2014 01:00:40 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 06/12] iio: Move documentation of iio-trig-sysfs to ABI/testing
Date: Thu, 12 Jun 2014 07:00:23 +0200
Message-Id: <1402549229-4449-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402549229-4449-1-git-send-email-pmeerw@pmeerw.net>
References: <1402549229-4449-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

iio-trig-sysfs has left staging with commit e64e7d5c

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs         | 11 +++++++++++
 drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
new file mode 100644
index 0000000..5235e6c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-trigger-sysfs
@@ -0,0 +1,11 @@
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

