Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:58734 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751854Ab3IRJAj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2013 05:00:39 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: lee.jones@linaro.org, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 2/4] iio:gyro: Register buffer also without specific trigger
Date: Wed, 18 Sep 2013 11:00:20 +0200
Message-Id: <1379494822-9985-3-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1379494822-9985-1-git-send-email-denis.ciocca@st.com>
References: <1379494822-9985-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fix buffer registration that allows to use generic IIO trigger.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/gyro/st_gyro_core.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index e13c2b0..8a45d43 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -329,13 +329,13 @@ int st_gyro_common_probe(struct iio_dev *indio_dev,
 	if (err < 0)
 		goto st_gyro_common_probe_error;
 
-	if (gdata->get_irq_data_ready(indio_dev) > 0) {
-		err = st_gyro_allocate_ring(indio_dev);
-		if (err < 0)
-			goto st_gyro_common_probe_error;
+	err = st_gyro_allocate_ring(indio_dev);
+	if (err < 0)
+		goto st_gyro_common_probe_error;
 
+	if (gdata->get_irq_data_ready(indio_dev) > 0) {
 		err = st_sensors_allocate_trigger(indio_dev,
-						  ST_GYRO_TRIGGER_OPS);
+							ST_GYRO_TRIGGER_OPS);
 		if (err < 0)
 			goto st_gyro_probe_trigger_error;
 	}
@@ -350,8 +350,7 @@ st_gyro_device_register_error:
 	if (gdata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
 st_gyro_probe_trigger_error:
-	if (gdata->get_irq_data_ready(indio_dev) > 0)
-		st_gyro_deallocate_ring(indio_dev);
+	st_gyro_deallocate_ring(indio_dev);
 st_gyro_common_probe_error:
 	return err;
 }
@@ -362,10 +361,10 @@ void st_gyro_common_remove(struct iio_dev *indio_dev)
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (gdata->get_irq_data_ready(indio_dev) > 0) {
+	if (gdata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
-		st_gyro_deallocate_ring(indio_dev);
-	}
+
+	st_gyro_deallocate_ring(indio_dev);
 }
 EXPORT_SYMBOL(st_gyro_common_remove);
 
-- 
1.7.9.5

