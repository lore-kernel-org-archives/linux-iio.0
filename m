Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/4] iio: Add ABI documentation for illuminance
Date: Fri,  2 May 2014 17:54:47 +0200
Message-Id: <1399046089-6616-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399046089-6616-1-git-send-email-pmeerw@pmeerw.net>
References: <1399046089-6616-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

has been in use for a long time, but never documented;
state that this measurement should be in lux (drivers may feel
different about this)

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 9669c1f..a9757dc 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -895,6 +895,15 @@ Description:
 		on-chip EEPROM. After power-up or chip reset the device will
 		automatically load the saved configuration.
 
+What:		/sys/.../iio:deviceX/in_illuminanceY_input
+What:		/sys/.../iio:deviceX/in_illuminanceY_raw
+What:		/sys/.../iio:deviceX/in_illuminanceY_mean_raw
+KernelVersion:	3.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Illuminance measurement, units after application of scale
+		and offset are lux.
+
 What:		/sys/.../iio:deviceX/in_intensityY_raw
 What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
 What:		/sys/.../iio:deviceX/in_intensityY_both_raw
-- 
1.9.1
