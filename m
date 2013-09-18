Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: lee.jones@linaro.org, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 1/4] iio:accel: Register buffer also without specific trigger
Date: Wed, 18 Sep 2013 11:00:19 +0200
Message-Id: <1379494822-9985-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1379494822-9985-1-git-send-email-denis.ciocca@st.com>
References: <1379494822-9985-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fix buffer registration that allows to use generic IIO trigger.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/accel/st_accel_core.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 1458343..1bbdc8f 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -480,13 +480,13 @@ int st_accel_common_probe(struct iio_dev *indio_dev,
 	if (err < 0)
 		goto st_accel_common_probe_error;
 
-	if (adata->get_irq_data_ready(indio_dev) > 0) {
-		err = st_accel_allocate_ring(indio_dev);
-		if (err < 0)
-			goto st_accel_common_probe_error;
+	err = st_accel_allocate_ring(indio_dev);
+	if (err < 0)
+		goto st_accel_common_probe_error;
 
+	if (adata->get_irq_data_ready(indio_dev) > 0) {
 		err = st_sensors_allocate_trigger(indio_dev,
-						 ST_ACCEL_TRIGGER_OPS);
+							ST_ACCEL_TRIGGER_OPS);
 		if (err < 0)
 			goto st_accel_probe_trigger_error;
 	}
@@ -501,8 +501,7 @@ st_accel_device_register_error:
 	if (adata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
 st_accel_probe_trigger_error:
-	if (adata->get_irq_data_ready(indio_dev) > 0)
-		st_accel_deallocate_ring(indio_dev);
+	st_accel_deallocate_ring(indio_dev);
 st_accel_common_probe_error:
 	return err;
 }
@@ -513,10 +512,10 @@ void st_accel_common_remove(struct iio_dev *indio_dev)
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (adata->get_irq_data_ready(indio_dev) > 0) {
+	if (adata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
-		st_accel_deallocate_ring(indio_dev);
-	}
+
+	st_accel_deallocate_ring(indio_dev);
 }
 EXPORT_SYMBOL(st_accel_common_remove);
 
-- 
1.7.9.5
