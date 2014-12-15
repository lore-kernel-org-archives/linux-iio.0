Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:30120 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbaLOPNy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 15 Dec 2014 10:13:54 -0500
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH] iio: ABI: add clarification for proximity
Date: Mon, 15 Dec 2014 17:14:49 +0200
Message-Id: <1418656489-13190-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index df5e69e..831db86 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1068,7 +1068,9 @@ Description:
 		reflectivity of infrared or ultrasound emitted.
 		Often these sensors are unit less and as such conversion
 		to SI units is not possible.  Where it is, the units should
-		be meters.
+		be meters.  If such a conversion is not possible, the reported
+		values should behave in the same way as a distance, i.e. lower
+		values indicate something is closer to the sensor.
 
 What:		/sys/.../iio:deviceX/in_illuminanceY_input
 What:		/sys/.../iio:deviceX/in_illuminanceY_raw
-- 
1.9.1

