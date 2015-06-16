Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: ABI: Fix typo in in_proximity_raw description
Date: Tue, 16 Jun 2015 22:36:43 +0200
Message-Id: <1434487003-7248-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 Documentation/ABI/testing/sysfs-bus-iio | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3befcb1..7d909a4 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1162,7 +1162,7 @@ KernelVersion:	3.4
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Proximity measurement indicating that some
-		object is near the sensor, usually be observing
+		object is near the sensor, usually by observing
 		reflectivity of infrared or ultrasound emitted.
 		Often these sensors are unit less and as such conversion
 		to SI units is not possible.  Where it is, the units should
-- 
1.9.1
