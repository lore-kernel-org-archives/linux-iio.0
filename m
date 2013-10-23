Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25536 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839Ab3JWTL1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 23 Oct 2013 15:11:27 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/9] iio: hid_Sensors: fix crash during trigger unregister
Date: Wed, 23 Oct 2013 12:11:08 -0700
Message-Id: <1382555476-15826-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We can't store the trigger instance created by iio_trigger_alloc, in
trig field of iio_device structure. This needs to be stored in the
driver private data. Othewise it can result in crash during module
unload. Hence created a trig_ptr in the common data structure
for each HID sensor IIO driver and storing here.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c             | 5 +++--
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 9 ++++-----
 drivers/iio/common/hid-sensors/hid-sensor-trigger.h | 2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c               | 5 +++--
 drivers/iio/light/hid-sensor-als.c                  | 5 +++--
 drivers/iio/magnetometer/hid-sensor-magn-3d.c       | 5 +++--
 include/linux/hid-sensor-hub.h                      | 1 +
 7 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 46d22f3..7fbe136 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -349,7 +349,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev);
+	hid_sensor_remove_trigger(&accel_state->common_attributes);
 error_unreg_buffer_funcs:
 	iio_triggered_buffer_cleanup(indio_dev);
 error_free_dev_mem:
@@ -362,10 +362,11 @@ static int hid_accel_3d_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct accel_3d_state *accel_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ACCEL_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev);
+	hid_sensor_remove_trigger(&accel_state->common_attributes);
 	iio_triggered_buffer_cleanup(indio_dev);
 	kfree(indio_dev->channels);
 
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index dbc9141..759582d 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -71,11 +71,10 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return 0;
 }
 
-void hid_sensor_remove_trigger(struct iio_dev *indio_dev)
+void hid_sensor_remove_trigger(struct hid_sensor_common *attrb)
 {
-	iio_trigger_unregister(indio_dev->trig);
-	iio_trigger_free(indio_dev->trig);
-	indio_dev->trig = NULL;
+	iio_trigger_unregister(attrb->trig_ptr);
+	iio_trigger_free(attrb->trig_ptr);
 }
 EXPORT_SYMBOL(hid_sensor_remove_trigger);
 
@@ -106,7 +105,7 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 		dev_err(&indio_dev->dev, "Trigger Register Failed\n");
 		goto error_free_trig;
 	}
-	indio_dev->trig = trig;
+	indio_dev->trig = attrb->trig_ptr = trig;
 
 	return ret;
 
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
index 9a87314..ca02f78 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
@@ -21,6 +21,6 @@
 
 int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 				struct hid_sensor_common *attrb);
-void hid_sensor_remove_trigger(struct iio_dev *indio_dev);
+void hid_sensor_remove_trigger(struct hid_sensor_common *attrb);
 
 #endif
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index c688d97..74bbed7 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -347,7 +347,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev);
+	hid_sensor_remove_trigger(&gyro_state->common_attributes);
 error_unreg_buffer_funcs:
 	iio_triggered_buffer_cleanup(indio_dev);
 error_free_dev_mem:
@@ -360,10 +360,11 @@ static int hid_gyro_3d_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev);
+	hid_sensor_remove_trigger(&gyro_state->common_attributes);
 	iio_triggered_buffer_cleanup(indio_dev);
 	kfree(indio_dev->channels);
 
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index e59d00c..771c919 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -313,7 +313,7 @@ static int hid_als_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev);
+	hid_sensor_remove_trigger(&als_state->common_attributes);
 error_unreg_buffer_funcs:
 	iio_triggered_buffer_cleanup(indio_dev);
 error_free_dev_mem:
@@ -326,10 +326,11 @@ static int hid_als_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct als_state *als_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ALS);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev);
+	hid_sensor_remove_trigger(&als_state->common_attribute);
 	iio_triggered_buffer_cleanup(indio_dev);
 	kfree(indio_dev->channels);
 
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index a98460b..ff7b9da 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -350,7 +350,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev);
+	hid_sensor_remove_trigger(&magn_state->common_attributes);
 error_unreg_buffer_funcs:
 	iio_triggered_buffer_cleanup(indio_dev);
 error_free_dev_mem:
@@ -363,10 +363,11 @@ static int hid_magn_3d_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct magn_3d_state *magn_state = iio_priv(indio_dev);
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev);
+	hid_sensor_remove_trigger(&magn_state->common_attributes);
 	iio_triggered_buffer_cleanup(indio_dev);
 	kfree(indio_dev->channels);
 
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index a265af2..107baec4 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -184,6 +184,7 @@ struct hid_sensor_common {
 	struct platform_device *pdev;
 	unsigned usage_id;
 	bool data_ready;
+	void *trig_ptr;
 	struct hid_sensor_hub_attribute_info poll;
 	struct hid_sensor_hub_attribute_info report_state;
 	struct hid_sensor_hub_attribute_info power_state;
-- 
1.8.3.2

