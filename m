Return-Path: <mfuzzey@parkeon.com>
Subject: [PATCH 5/9] iio: doc: Describe scale attributes for event thresholds
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Date: Thu, 19 Feb 2015 15:16:04 +0100
Message-ID: <20150219141604.27001.24235.stgit@localhost>
In-Reply-To: <20150219141553.27001.18825.stgit@localhost>
References: <20150219141553.27001.18825.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 Documentation/ABI/testing/sysfs-bus-iio |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ab592dd..d15a61d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -613,6 +613,24 @@ Description:
 		value is in raw device units or in processed units (as _raw
 		and _input do on sysfs direct channel read attributes).
 
+What:		/sys/.../events/in_accel_scale
+What:		/sys/.../events/in_accel_peak_scale
+What:		/sys/.../events/in_anglvel_scale
+What:		/sys/.../events/in_magn_scale
+What:		/sys/.../events/in_rot_from_north_magnetic_scale
+What:		/sys/.../events/in_rot_from_north_true_scale
+What:		/sys/.../events/in_voltage_scale
+What:		/sys/.../events/in_voltage_supply_scale
+What:		/sys/.../events/in_temp_scale
+What:		/sys/.../events/in_illuminance_scale
+What:		/sys/.../events/in_proximity_scale
+KernelVersion:	3.21
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Specifies the conversion factor from the standard units
+                to device specific units used to set the event trigger
+                threshold.
+
 What:		/sys/.../events/in_accel_x_thresh_rising_hysteresis
 What:		/sys/.../events/in_accel_x_thresh_falling_hysteresis
 What:		/sys/.../events/in_accel_x_thresh_either_hysteresis
