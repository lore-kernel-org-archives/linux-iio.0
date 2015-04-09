Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v3 2/6] iio: documentation: Add ABI info for iio event persistence filter
Date: Wed,  8 Apr 2015 17:06:06 -0700
Message-Id: <d6ed572de5978b1ab44f0bd72432b8eeeac0b321.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Add ABI info for iio event persistence filter.

Setting <n> to persistence filter would need atleast
<n> data values outside the upper/lower threshold
limits before generating an interrupt.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 82 +++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 9a70c31..590b1d4 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -856,6 +856,88 @@ Description:
 		met before an event is generated. If direction is not
 		specified then this period applies to both directions.
 
+What:		/sys/.../events/in_accel_x_thresh_rising_persistence
+What:		/sys/.../events/in_accel_x_thresh_falling_persistence
+hat:		/sys/.../events/in_accel_x_roc_rising_persistence
+What:		/sys/.../events/in_accel_x_roc_falling_persistence
+What:		/sys/.../events/in_accel_y_thresh_rising_persistence
+What:		/sys/.../events/in_accel_y_thresh_falling_persistence
+What:		/sys/.../events/in_accel_y_roc_rising_persistence
+What:		/sys/.../events/in_accel_y_roc_falling_persistence
+What:		/sys/.../events/in_accel_z_thresh_rising_persistence
+What:		/sys/.../events/in_accel_z_thresh_falling_persistence
+What:		/sys/.../events/in_accel_z_roc_rising_persistence
+What:		/sys/.../events/in_accel_z_roc_falling_persistence
+What:		/sys/.../events/in_anglvel_x_thresh_rising_persistence
+What:		/sys/.../events/in_anglvel_x_thresh_falling_persistence
+What:		/sys/.../events/in_anglvel_x_roc_rising_persistence
+What:		/sys/.../events/in_anglvel_x_roc_falling_persistence
+What:		/sys/.../events/in_anglvel_y_thresh_rising_persistence
+What:		/sys/.../events/in_anglvel_y_thresh_falling_persistence
+What:		/sys/.../events/in_anglvel_y_roc_rising_persistence
+What:		/sys/.../events/in_anglvel_y_roc_falling_persistence
+What:		/sys/.../events/in_anglvel_z_thresh_rising_persistence
+What:		/sys/.../events/in_anglvel_z_thresh_falling_persistence
+What:		/sys/.../events/in_anglvel_z_roc_rising_persistence
+What:		/sys/.../events/in_anglvel_z_roc_falling_persistence
+What:		/sys/.../events/in_magn_x_thresh_rising_persistence
+What:		/sys/.../events/in_magn_x_thresh_falling_persistence
+What:		/sys/.../events/in_magn_x_roc_rising_persistence
+What:		/sys/.../events/in_magn_x_roc_falling_persistence
+What:		/sys/.../events/in_magn_y_thresh_rising_persistence
+What:		/sys/.../events/in_magn_y_thresh_falling_persistence
+What:		/sys/.../events/in_magn_y_roc_rising_persistence
+What:		/sys/.../events/in_magn_y_roc_falling_persistence
+What:		/sys/.../events/in_magn_z_thresh_rising_persistence
+What:		/sys/.../events/in_magn_z_thresh_falling_persistence
+What:		/sys/.../events/in_magn_z_roc_rising_persistence
+What:		/sys/.../events/in_magn_z_roc_falling_persistence
+What:		/sys/.../events/in_rot_from_north_magnetic_thresh_rising_persistence
+What:		/sys/.../events/in_rot_from_north_magnetic_thresh_falling_persistence
+What:		/sys/.../events/in_rot_from_north_magnetic_roc_rising_persistence
+What:		/sys/.../events/in_rot_from_north_magnetic_roc_falling_persistence
+What:		/sys/.../events/in_rot_from_north_true_thresh_rising_persistence
+What:		/sys/.../events/in_rot_from_north_true_thresh_falling_persistence
+What:		/sys/.../events/in_rot_from_north_true_roc_rising_persistence
+What:		/sys/.../events/in_rot_from_north_true_roc_falling_persistence
+What:		/sys/.../events/in_rot_from_north_magnetic_tilt_comp_thresh_rising_persistence
+What:		/sys/.../events/in_rot_from_north_magnetic_tilt_comp_thresh_falling_persistence
+What:		/sys/.../events/in_rot_from_north_magnetic_tilt_comp_roc_rising_persistence
+What:		/sys/.../events/in_rot_from_north_magnetic_tilt_comp_roc_falling_persistence
+What:		/sys/.../events/in_rot_from_north_true_tilt_comp_thresh_rising_persistence
+What:		/sys/.../events/in_rot_from_north_true_tilt_comp_thresh_falling_persistence
+What:		/sys/.../events/in_rot_from_north_true_tilt_comp_roc_rising_persistence
+What:		/sys/.../events/in_rot_from_north_true_tilt_comp_roc_falling_persistence
+What:		/sys/.../events/in_voltageY_supply_thresh_rising_persistence
+What:		/sys/.../events/in_voltageY_supply_thresh_falling_persistence
+What:		/sys/.../events/in_voltageY_supply_roc_rising_persistence
+What:		/sys/.../events/in_voltageY_supply_roc_falling_persistence
+What:		/sys/.../events/in_voltageY_thresh_rising_persistence
+What:		/sys/.../events/in_voltageY_thresh_falling_persistence
+What:		/sys/.../events/in_voltageY_roc_rising_persistence
+What:		/sys/.../events/in_voltageY_roc_falling_persistence
+What:		/sys/.../events/in_tempY_thresh_rising_persistence
+What:		/sys/.../events/in_tempY_thresh_falling_persistence
+What:		/sys/.../events/in_tempY_roc_rising_persistence
+What:		/sys/.../events/in_tempY_roc_falling_persistence
+What:		/sys/.../events/in_accel_x&y&z_mag_falling_persistence
+What:		/sys/.../events/in_intensity0_thresh_persistence
+What:		/sys/.../events/in_proximity0_thresh_persistence
+What:		/sys/.../events/in_activity_still_thresh_rising_persistence
+What:		/sys/.../events/in_activity_still_thresh_falling_persistence
+What:		/sys/.../events/in_activity_walking_thresh_rising_persistence
+What:		/sys/.../events/in_activity_walking_thresh_falling_persistence
+What:		/sys/.../events/in_activity_jogging_thresh_rising_persistence
+What:		/sys/.../events/in_activity_jogging_thresh_falling_persistence
+What:		/sys/.../events/in_activity_running_thresh_rising_persistence
+What:		/sys/.../events/in_activity_running_thresh_falling_persistence
+KernelVersion:	4.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Number of times an event should occur before generating an
+		interrupt. Persistence filter value can be applied for both
+		rising/falling threshold based interrupts.
+
 What:		/sys/.../events/in_activity_still_thresh_rising_en
 What:		/sys/.../events/in_activity_still_thresh_falling_en
 What:		/sys/.../events/in_activity_walking_thresh_rising_en
-- 
1.9.1
