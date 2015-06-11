Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net,
	vlad.dogaru@intel.com,
	tiberiu.a.breana@intel.com
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: ABI: Clarify proximity output value
Date: Thu, 11 Jun 2015 18:49:33 +0300
Message-Id: <1434037774-22081-2-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1434037774-22081-1-git-send-email-daniel.baluta@intel.com>
References: <1434037774-22081-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Current description for proximity measurement is ambiguous. While
the first part says that proximity is measured by observing
reflectivity, the second part incorrectly infers that reported values
should behave like a distance.

This is because of AS3935 lightning sensor which uses the proximity
API, while not being a true proximity sensor.

Fixes:  614e8842ddf ("iio: ABI: add clarification for proximity")
Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index bbed111..70c9b1a 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1234,10 +1234,8 @@ Description:
 		object is near the sensor, usually be observing
 		reflectivity of infrared or ultrasound emitted.
 		Often these sensors are unit less and as such conversion
-		to SI units is not possible.  Where it is, the units should
-		be meters.  If such a conversion is not possible, the reported
-		values should behave in the same way as a distance, i.e. lower
-		values indicate something is closer to the sensor.
+		to SI units is not possible. Higher proximity measurements
+		indicate closer objects, and vice versa.
 
 What:		/sys/.../iio:deviceX/in_illuminance_input
 What:		/sys/.../iio:deviceX/in_illuminance_raw
-- 
1.9.1
