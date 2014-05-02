Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/4] iio: Add ABI documentation for proximity
Date: Fri,  2 May 2014 17:54:48 +0200
Message-Id: <1399046089-6616-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399046089-6616-1-git-send-email-pmeerw@pmeerw.net>
References: <1399046089-6616-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

has been in use for a long time, but never documented
proximity is unit-less, except otherwise stated, see e.g.
the as3935 driver where it is meter

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index a9757dc..ed202b3 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -895,6 +895,16 @@ Description:
 		on-chip EEPROM. After power-up or chip reset the device will
 		automatically load the saved configuration.
 
+What:		/sys/.../iio:deviceX/in_proximity_raw
+What:		/sys/.../iio:deviceX/in_proximity_input
+What:		/sys/.../iio:deviceX/in_proximityY_raw
+KernelVersion:	3.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Unit-less proximity measurement indicating that some
+		object is near the sensor, usually be observing
+		reflectivity of infrared or ultrasound emitted.
+
 What:		/sys/.../iio:deviceX/in_illuminanceY_input
 What:		/sys/.../iio:deviceX/in_illuminanceY_raw
 What:		/sys/.../iio:deviceX/in_illuminanceY_mean_raw
-- 
1.9.1
