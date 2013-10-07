Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-020.synserver.de ([212.40.185.20]:1070 "EHLO
	smtp-out-017.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755303Ab3JGOJx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 10:09:53 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 16/20] iio: Add a hysteresis event info attribute
Date: Mon,  7 Oct 2013 16:11:30 +0200
Message-Id: <1381155094-20166-16-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-1-git-send-email-lars@metafoo.de>
References: <1381155094-20166-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

For some devices it is possible to configure a hysteresis for threshold (or
similar) events. This patch adds a new hysteresis event info type which allows
for easy creation and read/write handling of the sysfs attribute.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 Documentation/ABI/testing/sysfs-bus-iio | 56 +++++++++++++++++++++++++++++++++
 drivers/iio/industrialio-event.c        |  1 +
 include/linux/iio/types.h               |  1 +
 3 files changed, 58 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2d736208..b20e829 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -537,6 +537,62 @@ Description:
 		value is in raw device units or in processed units (as _raw
 		and _input do on sysfs direct channel read attributes).
 
+What:		/sys/.../events/in_accel_x_thresh_rising_hysteresis
+What:		/sys/.../events/in_accel_x_thresh_falling_hysteresis
+What:		/sys/.../events/in_accel_x_thresh_either_hysteresis
+What:		/sys/.../events/in_accel_y_thresh_rising_hysteresis
+What:		/sys/.../events/in_accel_y_thresh_falling_hysteresis
+What:		/sys/.../events/in_accel_y_thresh_either_hysteresis
+What:		/sys/.../events/in_accel_z_thresh_rising_hysteresis
+What:		/sys/.../events/in_accel_z_thresh_falling_hysteresis
+What:		/sys/.../events/in_accel_z_thresh_either_hysteresis
+What:		/sys/.../events/in_anglvel_x_thresh_rising_hysteresis
+What:		/sys/.../events/in_anglvel_x_thresh_falling_hysteresis
+What:		/sys/.../events/in_anglvel_x_thresh_either_hysteresis
+What:		/sys/.../events/in_anglvel_y_thresh_rising_hysteresis
+What:		/sys/.../events/in_anglvel_y_thresh_falling_hysteresis
+What:		/sys/.../events/in_anglvel_y_thresh_either_hysteresis
+What:		/sys/.../events/in_anglvel_z_thresh_rising_hysteresis
+What:		/sys/.../events/in_anglvel_z_thresh_falling_hysteresis
+What:		/sys/.../events/in_anglvel_z_thresh_either_hysteresis
+What:		/sys/.../events/in_magn_x_thresh_rising_hysteresis
+What:		/sys/.../events/in_magn_x_thresh_falling_hysteresis
+What:		/sys/.../events/in_magn_x_thresh_either_hysteresis
+What:		/sys/.../events/in_magn_y_thresh_rising_hysteresis
+What:		/sys/.../events/in_magn_y_thresh_falling_hysteresis
+What:		/sys/.../events/in_magn_y_thresh_either_hysteresis
+What:		/sys/.../events/in_magn_z_thresh_rising_hysteresis
+What:		/sys/.../events/in_magn_z_thresh_falling_hysteresis
+What:		/sys/.../events/in_magn_z_thresh_either_hysteresis
+What:		/sys/.../events/in_voltageY_thresh_rising_hysteresis
+What:		/sys/.../events/in_voltageY_thresh_falling_hysteresis
+What:		/sys/.../events/in_voltageY_thresh_either_hysteresis
+What:		/sys/.../events/in_tempY_thresh_rising_hysteresis
+What:		/sys/.../events/in_tempY_thresh_falling_hysteresis
+What:		/sys/.../events/in_tempY_thresh_either_hysteresis
+What:		/sys/.../events/in_illuminance0_thresh_falling_hysteresis
+what:		/sys/.../events/in_illuminance0_thresh_rising_hysteresis
+what:		/sys/.../events/in_illuminance0_thresh_either_hysteresis
+what:		/sys/.../events/in_proximity0_thresh_falling_hysteresis
+what:		/sys/.../events/in_proximity0_thresh_rising_hysteresis
+what:		/sys/.../events/in_proximity0_thresh_either_hysteresis
+KernelVersion:	3.13
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Specifies the hysteresis of threshold that the device is comparing
+		against for the events enabled by
+		<type>Y[_name]_thresh[_(rising|falling)]_hysteresis.
+		If separate attributes exist for the two directions, but
+		direction is not specified for this attribute, then a single
+		hysteresis value applies to both directions.
+		For falling events the hysteresis is added to the _value attribute for
+		this event to get the upper threshold for when the event goes back to
+		normal, for rising events the hysteresis is subtracted from the _value
+		attribute. E.g. if in_voltage0_raw_thresh_rising_value is set to 1200
+		and in_voltage0_raw_thresh_rising_hysteresis is set to 50. The event
+		will get activated once in_voltage0_raw goes above 1200 and will become
+		deactived again once the value falls below 1150.
+
 What:		/sys/.../events/in_accel_x_raw_roc_rising_value
 What:		/sys/.../events/in_accel_x_raw_roc_falling_value
 What:		/sys/.../events/in_accel_y_raw_roc_rising_value
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 8c81e18..16746b9 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -193,6 +193,7 @@ static const char * const iio_ev_dir_text[] = {
 static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_ENABLE] = "en",
 	[IIO_EV_INFO_VALUE] = "value",
+	[IIO_EV_INFO_HYSTERESIS] = "hysteresis",
 };
 
 static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 18339ef..4ac928e 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -65,6 +65,7 @@ enum iio_event_type {
 enum iio_event_info {
 	IIO_EV_INFO_ENABLE,
 	IIO_EV_INFO_VALUE,
+	IIO_EV_INFO_HYSTERESIS,
 };
 
 enum iio_event_direction {
-- 
1.8.0

