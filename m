Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59630 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753608AbaHEVvb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Aug 2014 17:51:31 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 2/2] iio:gyro:bmg160 documentation
Date: Tue,  5 Aug 2014 14:57:34 -0700
Message-Id: <1407275854-29083-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1407275854-29083-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1407275854-29083-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added any-motion trigger documentation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-gyro-bmg160 | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-gyro-bmg160

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-gyro-bmg160 b/Documentation/ABI/testing/sysfs-bus-iio-gyro-bmg160
new file mode 100644
index 0000000..e98209c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-gyro-bmg160
@@ -0,0 +1,7 @@
+What:		/sys/bus/iio/devices/triggerX/name = "bmg160-any-motion-devX"
+KernelVersion:	3.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The BMG160 gyro kernel module provides an additional trigger,
+		which sets driver in a mode, where data is pushed to the buffer
+		only when there is any motion.
-- 
1.7.11.7

