Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/4] iio: Add intensity including ir and both modifiers to ABI documentation ex-post
Date: Fri,  2 May 2014 17:54:46 +0200
Message-Id: <1399046089-6616-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399046089-6616-1-git-send-email-pmeerw@pmeerw.net>
References: <1399046089-6616-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

intensity has been in use for a long time but never documented
it is beneficial to document what this is supposed to be

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ca3d3b7..9669c1f 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -895,6 +895,16 @@ Description:
 		on-chip EEPROM. After power-up or chip reset the device will
 		automatically load the saved configuration.
 
+What:		/sys/.../iio:deviceX/in_intensityY_raw
+What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
+What:		/sys/.../iio:deviceX/in_intensityY_both_raw
+KernelVersion:	3.4
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Unit-less light intensity. Modifiers both and ir indicate
+		that measurements contains visible and infrared light
+		components or just infrared light, respectively.
+
 What:		/sys/.../iio:deviceX/in_intensity_red_integration_time
 What:		/sys/.../iio:deviceX/in_intensity_green_integration_time
 What:		/sys/.../iio:deviceX/in_intensity_blue_integration_time
-- 
1.9.1
