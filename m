Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: ABI: Fix typo in in_proximity_raw description
Date: Sun, 13 Mar 2016 16:02:22 +0100
Message-Id: <1457881342-15418-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 Documentation/ABI/testing/sysfs-bus-iio |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3c66248..17a9210 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1233,7 +1233,7 @@ KernelVersion:	3.4
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Proximity measurement indicating that some
-		object is near the sensor, usually be observing
+		object is near the sensor, usually by observing
 		reflectivity of infrared or ultrasound emitted.
 		Often these sensors are unit less and as such conversion
 		to SI units is not possible. Higher proximity measurements
-- 
1.7.10.4
