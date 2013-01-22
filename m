Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:42630 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab3AVQQq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Jan 2013 11:16:46 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, denis.ciocca@st.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 05/10] iio:accel:st_accel drop unwanted EXPORT_SYMBOLS
Date: Tue, 22 Jan 2013 16:16:34 +0000
Message-Id: <1358871399-11216-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1358871399-11216-1-git-send-email-jic23@kernel.org>
References: <50FEBB20.7070407@kernel.org>
 <1358871399-11216-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These no longer need exporting..
---
 drivers/iio/accel/st_accel_buffer.c | 3 ---
 drivers/iio/accel/st_accel_core.c   | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
index 4c76787..f35f374 100644
--- a/drivers/iio/accel/st_accel_buffer.c
+++ b/drivers/iio/accel/st_accel_buffer.c
@@ -29,7 +29,6 @@ int st_accel_trig_set_state(struct iio_trigger *trig, bool state)
 	struct iio_dev *indio_dev = trig->private_data;
 	return st_accel_set_dataready_irq(indio_dev, state);
 }
-EXPORT_SYMBOL(st_accel_trig_set_state);
 
 static int st_accel_buffer_preenable(struct iio_dev *indio_dev)
 {
@@ -105,13 +104,11 @@ int st_accel_allocate_ring(struct iio_dev *indio_dev)
 	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
 		&st_sensors_trigger_handler, &st_accel_buffer_setup_ops);
 }
-EXPORT_SYMBOL(st_accel_allocate_ring);
 
 void st_accel_deallocate_ring(struct iio_dev *indio_dev)
 {
 	iio_triggered_buffer_cleanup(indio_dev);
 }
-EXPORT_SYMBOL(st_accel_deallocate_ring);
 
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics accelerometers buffer");
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 7af2f8e..88f94b7 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -407,7 +407,6 @@ int st_accel_set_dataready_irq(struct iio_dev *indio_dev, bool state)
 	return st_sensors_set_dataready_irq(indio_dev,
 					&st_accel_sensors[adata->index], state);
 }
-EXPORT_SYMBOL(st_accel_set_dataready_irq);
 
 int st_accel_set_axis_enable(struct iio_dev *indio_dev, u8 active_bit)
 {
@@ -416,7 +415,6 @@ int st_accel_set_axis_enable(struct iio_dev *indio_dev, u8 active_bit)
 	return st_sensors_set_axis_enable(indio_dev,
 				&st_accel_sensors[adata->index], active_bit);
 }
-EXPORT_SYMBOL(st_accel_set_axis_enable);
 
 int st_accel_set_enable(struct iio_dev *indio_dev, bool enable)
 {
@@ -425,7 +423,6 @@ int st_accel_set_enable(struct iio_dev *indio_dev, bool enable)
 	return st_sensors_set_enable(indio_dev,
 				&st_accel_sensors[adata->index], enable);
 }
-EXPORT_SYMBOL(st_accel_set_enable);
 
 static ssize_t st_accel_sysfs_set_sampling_frequency(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
-- 
1.8.1.1

