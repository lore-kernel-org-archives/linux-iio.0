Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46065 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab1I3KGf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2011 06:06:35 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 05/11] staging:iio:Documentation gyro -> anglvel updates in attribute names
Date: Fri, 30 Sep 2011 11:14:48 +0100
Message-Id: <1317377694-9001-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
References: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Follows directly from change made in previous patch.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/sysfs-bus-iio |  108 +++++++++++-----------
 1 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
index fb6c381..0d6823d 100644
--- a/drivers/staging/iio/Documentation/sysfs-bus-iio
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
@@ -141,9 +141,9 @@ Description:
 		Has all of the equivalent parameters as per voltageY. Units
 		after application of scale and offset are m/s^2.
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_x_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_y_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_z_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -221,7 +221,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_scale
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_peak_scale
-What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_scale
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_magn_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_scale
@@ -240,9 +240,9 @@ Description:
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias
-What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_x_calibbias
-What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_y_calibbias
-What:		/sys/bus/iio/devices/iio:deviceX/in_gyro_z_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -255,9 +255,9 @@ What		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
 What		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
 What		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
 What		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_gyro_x_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_gyro_y_calibscale
-What		/sys/bus/iio/devices/iio:deviceX/in_gyro_z_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibscale
+What		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibscale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -338,12 +338,12 @@ What:		/sys/.../iio:deviceX/events/in_accel_y_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_accel_y_thresh_falling_en
 What:		/sys/.../iio:deviceX/events/in_accel_z_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_accel_z_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/in_gyro_x_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/in_gyro_x_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/in_gyro_y_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/in_gyro_y_thresh_falling_en
-What:		/sys/.../iio:deviceX/events/in_gyro_z_thresh_rising_en
-What:		/sys/.../iio:deviceX/events/in_gyro_z_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_anglvel_x_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_anglvel_x_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_anglvel_y_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_anglvel_y_thresh_falling_en
+What:		/sys/.../iio:deviceX/events/in_anglvel_z_thresh_rising_en
+What:		/sys/.../iio:deviceX/events/in_anglvel_z_thresh_falling_en
 What:		/sys/.../iio:deviceX/events/in_magn_x_thresh_rising_en
 What:		/sys/.../iio:deviceX/events/in_magn_x_thresh_falling_en
 What:		/sys/.../iio:deviceX/events/in_magn_y_thresh_rising_en
@@ -383,12 +383,12 @@ What:		/sys/.../iio:deviceX/events/in_accel_y_roc_rising_en
 What:		/sys/.../iio:deviceX/events/in_accel_y_roc_falling_en
 What:		/sys/.../iio:deviceX/events/in_accel_z_roc_rising_en
 What:		/sys/.../iio:deviceX/events/in_accel_z_roc_falling_en
-What:		/sys/.../iio:deviceX/events/in_gyro_x_roc_rising_en
-What:		/sys/.../iio:deviceX/events/in_gyro_x_roc_falling_en
-What:		/sys/.../iio:deviceX/events/in_gyro_y_roc_rising_en
-What:		/sys/.../iio:deviceX/events/in_gyro_y_roc_falling_en
-What:		/sys/.../iio:deviceX/events/in_gyro_z_roc_rising_en
-What:		/sys/.../iio:deviceX/events/in_gyro_z_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_anglvel_x_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_anglvel_x_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_anglvel_y_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_anglvel_y_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_anglvel_z_roc_rising_en
+What:		/sys/.../iio:deviceX/events/in_anglvel_z_roc_falling_en
 What:		/sys/.../iio:deviceX/events/in_magn_x_roc_rising_en
 What:		/sys/.../iio:deviceX/events/in_magn_x_roc_falling_en
 What:		/sys/.../iio:deviceX/events/in_magn_y_roc_rising_en
@@ -429,12 +429,12 @@ What:		/sys/.../events/in_accel_y_raw_thresh_rising_value
 What:		/sys/.../events/in_accel_y_raw_thresh_falling_value
 What:		/sys/.../events/in_accel_z_raw_thresh_rising_value
 What:		/sys/.../events/in_accel_z_raw_thresh_falling_value
-What:		/sys/.../events/in_gyro_x_raw_thresh_rising_value
-What:		/sys/.../events/in_gyro_x_raw_thresh_falling_value
-What:		/sys/.../events/in_gyro_y_raw_thresh_rising_value
-What:		/sys/.../events/in_gyro_y_raw_thresh_falling_value
-What:		/sys/.../events/in_gyro_z_raw_thresh_rising_value
-What:		/sys/.../events/in_gyro_z_raw_thresh_falling_value
+What:		/sys/.../events/in_anglvel_x_raw_thresh_rising_value
+What:		/sys/.../events/in_anglvel_x_raw_thresh_falling_value
+What:		/sys/.../events/in_anglvel_y_raw_thresh_rising_value
+What:		/sys/.../events/in_anglvel_y_raw_thresh_falling_value
+What:		/sys/.../events/in_anglvel_z_raw_thresh_rising_value
+What:		/sys/.../events/in_anglvel_z_raw_thresh_falling_value
 What:		/sys/.../events/in_magn_x_raw_thresh_rising_value
 What:		/sys/.../events/in_magn_x_raw_thresh_falling_value
 What:		/sys/.../events/in_magn_y_raw_thresh_rising_value
@@ -466,12 +466,12 @@ What:		/sys/.../events/in_accel_y_raw_roc_rising_value
 What:		/sys/.../events/in_accel_y_raw_roc_falling_value
 What:		/sys/.../events/in_accel_z_raw_roc_rising_value
 What:		/sys/.../events/in_accel_z_raw_roc_falling_value
-What:		/sys/.../events/in_gyro_x_raw_roc_rising_value
-What:		/sys/.../events/in_gyro_x_raw_roc_falling_value
-What:		/sys/.../events/in_gyro_y_raw_roc_rising_value
-What:		/sys/.../events/in_gyro_y_raw_roc_falling_value
-What:		/sys/.../events/in_gyro_z_raw_roc_rising_value
-What:		/sys/.../events/in_gyro_z_raw_roc_falling_value
+What:		/sys/.../events/in_anglvel_x_raw_roc_rising_value
+What:		/sys/.../events/in_anglvel_x_raw_roc_falling_value
+What:		/sys/.../events/in_anglvel_y_raw_roc_rising_value
+What:		/sys/.../events/in_anglvel_y_raw_roc_falling_value
+What:		/sys/.../events/in_anglvel_z_raw_roc_rising_value
+What:		/sys/.../events/in_anglvel_z_raw_roc_falling_value
 What:		/sys/.../events/in_magn_x_raw_roc_rising_value
 What:		/sys/.../events/in_magn_x_raw_roc_falling_value
 What:		/sys/.../events/in_magn_y_raw_roc_rising_value
@@ -509,18 +509,18 @@ What:		/sys/.../events/in_accel_z_thresh_rising_period
 What:		/sys/.../events/in_accel_z_thresh_falling_period
 What:		/sys/.../events/in_accel_z_roc_rising_period
 What:		/sys/.../events/in_accel_z_roc_falling_period
-What:		/sys/.../events/in_gyro_x_thresh_rising_period
-What:		/sys/.../events/in_gyro_x_thresh_falling_period
-What:		/sys/.../events/in_gyro_x_roc_rising_period
-What:		/sys/.../events/in_gyro_x_roc_falling_period
-What:		/sys/.../events/in_gyro_y_thresh_rising_period
-What:		/sys/.../events/in_gyro_y_thresh_falling_period
-What:		/sys/.../events/in_gyro_y_roc_rising_period
-What:		/sys/.../events/in_gyro_y_roc_falling_period
-What:		/sys/.../events/in_gyro_z_thresh_rising_period
-What:		/sys/.../events/in_gyro_z_thresh_falling_period
-What:		/sys/.../events/in_gyro_z_roc_rising_period
-What:		/sys/.../events/in_gyro_z_roc_falling_period
+What:		/sys/.../events/in_anglvel_x_thresh_rising_period
+What:		/sys/.../events/in_anglvel_x_thresh_falling_period
+What:		/sys/.../events/in_anglvel_x_roc_rising_period
+What:		/sys/.../events/in_anglvel_x_roc_falling_period
+What:		/sys/.../events/in_anglvel_y_thresh_rising_period
+What:		/sys/.../events/in_anglvel_y_thresh_falling_period
+What:		/sys/.../events/in_anglvel_y_roc_rising_period
+What:		/sys/.../events/in_anglvel_y_roc_falling_period
+What:		/sys/.../events/in_anglvel_z_thresh_rising_period
+What:		/sys/.../events/in_anglvel_z_thresh_falling_period
+What:		/sys/.../events/in_anglvel_z_roc_rising_period
+What:		/sys/.../events/in_anglvel_z_roc_falling_period
 What:		/sys/.../events/in_magn_x_thresh_rising_period
 What:		/sys/.../events/in_magn_x_thresh_falling_period
 What:		/sys/.../events/in_magn_x_roc_rising_period
@@ -622,9 +622,9 @@ Description:
 What:		/sys/.../buffer/scan_elements/in_accel_x_en
 What:		/sys/.../buffer/scan_elements/in_accel_y_en
 What:		/sys/.../buffer/scan_elements/in_accel_z_en
-What:		/sys/.../buffer/scan_elements/in_gyro_x_en
-What:		/sys/.../buffer/scan_elements/in_gyro_y_en
-What:		/sys/.../buffer/scan_elements/in_gyro_z_en
+What:		/sys/.../buffer/scan_elements/in_anglvel_x_en
+What:		/sys/.../buffer/scan_elements/in_anglvel_y_en
+What:		/sys/.../buffer/scan_elements/in_anglvel_z_en
 What:		/sys/.../buffer/scan_elements/in_magn_x_en
 What:		/sys/.../buffer/scan_elements/in_magn_y_en
 What:		/sys/.../buffer/scan_elements/in_magn_z_en
@@ -640,7 +640,7 @@ Description:
 		Scan element control for triggered data capture.
 
 What:		/sys/.../buffer/scan_elements/in_accel_type
-What:		/sys/.../buffer/scan_elements/in_gyro_type
+What:		/sys/.../buffer/scan_elements/in_anglvel_type
 What:		/sys/.../buffer/scan_elements/in_magn_type
 What:		/sys/.../buffer/scan_elements/in_incli_type
 What:		/sys/.../buffer/scan_elements/in_voltageY_type
@@ -682,9 +682,9 @@ What:		/sys/.../buffer/scan_elements/in_voltageY_supply_index
 What:		/sys/.../buffer/scan_elements/in_accel_x_index
 What:		/sys/.../buffer/scan_elements/in_accel_y_index
 What:		/sys/.../buffer/scan_elements/in_accel_z_index
-What:		/sys/.../buffer/scan_elements/in_gyro_x_index
-What:		/sys/.../buffer/scan_elements/in_gyro_y_index
-What:		/sys/.../buffer/scan_elements/in_gyro_z_index
+What:		/sys/.../buffer/scan_elements/in_anglvel_x_index
+What:		/sys/.../buffer/scan_elements/in_anglvel_y_index
+What:		/sys/.../buffer/scan_elements/in_anglvel_z_index
 What:		/sys/.../buffer/scan_elements/in_magn_x_index
 What:		/sys/.../buffer/scan_elements/in_magn_y_index
 What:		/sys/.../buffer/scan_elements/in_magn_z_index
@@ -702,7 +702,7 @@ Description:
 		and the relevant _type attributes to establish the data storage
 		format.
 
-What:		/sys/.../iio:deviceX/in_gyro_z_quadrature_correction_raw
+What:		/sys/.../iio:deviceX/in_anglvel_z_quadrature_correction_raw
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:
-- 
1.7.3.4

