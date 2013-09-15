Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-015.synserver.de ([212.40.185.15]:1031 "EHLO
	smtp-out-015.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757091Ab3IOQtx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 12:49:53 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/27] iio: Remove unnecessary casts for iio_push_to_buffers()
Date: Sun, 15 Sep 2013 18:50:55 +0200
Message-Id: <1379263880-18405-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-1-git-send-email-lars@metafoo.de>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Now that iio_push_to_buffers() takes a void pointer for the data parameter we
can remove those casts to u8*.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/accel/bma180.c                    | 2 +-
 drivers/iio/accel/hid-sensor-accel-3d.c       | 7 ++++---
 drivers/iio/adc/ad7266.c                      | 2 +-
 drivers/iio/adc/ad7298.c                      | 2 +-
 drivers/iio/adc/ad7923.c                      | 2 +-
 drivers/iio/adc/ad_sigma_delta.c              | 2 +-
 drivers/iio/adc/at91_adc.c                    | 2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 7 ++++---
 drivers/iio/gyro/itg3200_buffer.c             | 2 +-
 drivers/iio/light/adjd_s311.c                 | 2 +-
 drivers/iio/light/hid-sensor-als.c            | 7 ++++---
 drivers/iio/light/tcs3472.c                   | 2 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 7 ++++---
 13 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 12e32e6..3eff246 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -490,7 +490,7 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
 	}
 	mutex_unlock(&data->mutex);
 
-	iio_push_to_buffers(indio_dev, (u8 *)data->buff);
+	iio_push_to_buffers(indio_dev, data->buff);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 46d22f3..dcda173 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -182,10 +182,11 @@ static const struct iio_info accel_3d_info = {
 };
 
 /* Function to push data to buffer */
-static void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
+static void hid_sensor_push_data(struct iio_dev *indio_dev, const void *data,
+	int len)
 {
 	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
-	iio_push_to_buffers(indio_dev, (u8 *)data);
+	iio_push_to_buffers(indio_dev, data);
 }
 
 /* Callback handler to send event after all samples are received and captured */
@@ -200,7 +201,7 @@ static int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 				accel_state->common_attributes.data_ready);
 	if (accel_state->common_attributes.data_ready)
 		hid_sensor_push_data(indio_dev,
-				(u8 *)accel_state->accel_val,
+				accel_state->accel_val,
 				sizeof(accel_state->accel_val));
 
 	return 0;
diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 371731d..5bfed23 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -98,7 +98,7 @@ static irqreturn_t ad7266_trigger_handler(int irq, void *p)
 	if (ret == 0) {
 		if (indio_dev->scan_timestamp)
 			((s64 *)st->data)[1] = pf->timestamp;
-		iio_push_to_buffers(indio_dev, (u8 *)st->data);
+		iio_push_to_buffers(indio_dev, st->data);
 	}
 
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 85d1481..0812556 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -172,7 +172,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 			&time_ns, sizeof(time_ns));
 	}
 
-	iio_push_to_buffers(indio_dev, (u8 *)st->rx_buf);
+	iio_push_to_buffers(indio_dev, st->rx_buf);
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 4108dbb..7eb4cb5 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -187,7 +187,7 @@ static irqreturn_t ad7923_trigger_handler(int irq, void *p)
 			&time_ns, sizeof(time_ns));
 	}
 
-	iio_push_to_buffers(indio_dev, (u8 *)st->rx_buf);
+	iio_push_to_buffers(indio_dev, st->rx_buf);
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index f0d6335..78d276f 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -391,7 +391,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 		break;
 	}
 
-	iio_push_to_buffers(indio_dev, (uint8_t *)data);
+	iio_push_to_buffers(indio_dev, data);
 
 	iio_trigger_notify_done(indio_dev->trig);
 	sigma_delta->irq_dis = false;
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 84be63b..6da5ebb 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -89,7 +89,7 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 		*timestamp = pf->timestamp;
 	}
 
-	iio_push_to_buffers(idev, (u8 *)st->buffer);
+	iio_push_to_buffers(idev, st->buffer);
 
 	iio_trigger_notify_done(idev->trig);
 
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index c688d97..ea01c6bc 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -182,10 +182,11 @@ static const struct iio_info gyro_3d_info = {
 };
 
 /* Function to push data to buffer */
-static void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
+static void hid_sensor_push_data(struct iio_dev *indio_dev, const void *data,
+	int len)
 {
 	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
-	iio_push_to_buffers(indio_dev, (u8 *)data);
+	iio_push_to_buffers(indio_dev, data);
 }
 
 /* Callback handler to send event after all samples are received and captured */
@@ -200,7 +201,7 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 				gyro_state->common_attributes.data_ready);
 	if (gyro_state->common_attributes.data_ready)
 		hid_sensor_push_data(indio_dev,
-				(u8 *)gyro_state->gyro_val,
+				gyro_state->gyro_val,
 				sizeof(gyro_state->gyro_val));
 
 	return 0;
diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index 6c43af9..6b3c301 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -59,7 +59,7 @@ static irqreturn_t itg3200_trigger_handler(int irq, void *p)
 		memcpy(buf + indio_dev->scan_bytes - sizeof(s64),
 				&pf->timestamp, sizeof(pf->timestamp));
 
-	iio_push_to_buffers(indio_dev, (u8 *)buf);
+	iio_push_to_buffers(indio_dev, buf);
 	iio_trigger_notify_done(indio_dev->trig);
 
 error_ret:
diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index c0da351..c9c8b00 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -141,7 +141,7 @@ static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*(s64 *)((u8 *)data->buffer + ALIGN(len, sizeof(s64)))
 			= time_ns;
-	iio_push_to_buffers(indio_dev, (u8 *)data->buffer);
+	iio_push_to_buffers(indio_dev, data->buffer);
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index e59d00c..fa6ae8c 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -161,10 +161,11 @@ static const struct iio_info als_info = {
 };
 
 /* Function to push data to buffer */
-static void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
+static void hid_sensor_push_data(struct iio_dev *indio_dev, const void *data,
+					int len)
 {
 	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
-	iio_push_to_buffers(indio_dev, (u8 *)data);
+	iio_push_to_buffers(indio_dev, data);
 }
 
 /* Callback handler to send event after all samples are received and captured */
@@ -179,7 +180,7 @@ static int als_proc_event(struct hid_sensor_hub_device *hsdev,
 				als_state->common_attributes.data_ready);
 	if (als_state->common_attributes.data_ready)
 		hid_sensor_push_data(indio_dev,
-				(u8 *)&als_state->illum,
+				&als_state->illum,
 				sizeof(als_state->illum));
 
 	return 0;
diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index dc7d823..7bf2969 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -195,7 +195,7 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
 	if (indio_dev->scan_timestamp)
 		*(s64 *)((u8 *)data->buffer + ALIGN(len, sizeof(s64)))
 			= iio_get_time_ns();
-	iio_push_to_buffers(indio_dev, (u8 *)data->buffer);
+	iio_push_to_buffers(indio_dev, data->buffer);
 
 done:
 	iio_trigger_notify_done(indio_dev->trig);
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index a98460b..2634920 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -183,10 +183,11 @@ static const struct iio_info magn_3d_info = {
 };
 
 /* Function to push data to buffer */
-static void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
+static void hid_sensor_push_data(struct iio_dev *indio_dev, const void *data,
+	int len)
 {
 	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
-	iio_push_to_buffers(indio_dev, (u8 *)data);
+	iio_push_to_buffers(indio_dev, data);
 }
 
 /* Callback handler to send event after all samples are received and captured */
@@ -201,7 +202,7 @@ static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 				magn_state->common_attributes.data_ready);
 	if (magn_state->common_attributes.data_ready)
 		hid_sensor_push_data(indio_dev,
-				(u8 *)magn_state->magn_val,
+				magn_state->magn_val,
 				sizeof(magn_state->magn_val));
 
 	return 0;
-- 
1.8.0

