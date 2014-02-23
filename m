Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25356 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508AbaBWTug (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 23 Feb 2014 14:50:36 -0500
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 5/5] iio: Added ABI description for quaternion
Date: Sun, 23 Feb 2014 11:50:48 -0800
Message-Id: <1393185048-4004-5-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1393185048-4004-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1393185048-4004-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added documentation for reading quaternion components for 3D rotations.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 6e02c50..8daa91a 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -891,3 +891,12 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		This attribute is used to get/set the integration time in
 		seconds.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_rotquaternion_raw
+KernelVersion:	3.15
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw value of quaternion components using a format
+		x:y:z:w. Here x, y, and z component represents the axis about
+		which a rotation will occur and w component represents the
+		amount of rotation.
-- 
1.8.3.2

