Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56169 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbaHEVvI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Aug 2014 17:51:08 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 2/2] iio: accel: BMC150 accel documentation
Date: Tue,  5 Aug 2014 14:57:05 -0700
Message-Id: <1407275825-29035-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1407275825-29035-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1407275825-29035-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added any-motion trigger documentation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-accel-bmc150 | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-accel-bmc150

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-accel-bmc150 b/Documentation/ABI/testing/sysfs-bus-iio-accel-bmc150
new file mode 100644
index 0000000..99847a9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-accel-bmc150
@@ -0,0 +1,7 @@
+What:		/sys/bus/iio/devices/triggerX/name = "bmc150_accel-any-motion-devX"
+KernelVersion:	3.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The BMC150 accelerometer kernel module provides an additional trigger,
+		which sets driver in a mode, where data is pushed to the buffer
+		only when there is any motion.
-- 
1.7.11.7

