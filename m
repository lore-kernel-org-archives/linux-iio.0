Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: lee.jones@linaro.org, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 4/4] iio:press: Register buffer also without specific trigger
Date: Wed, 18 Sep 2013 11:00:22 +0200
Message-Id: <1379494822-9985-5-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1379494822-9985-1-git-send-email-denis.ciocca@st.com>
References: <1379494822-9985-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fix buffer registration that allows to use generic IIO trigger.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/pressure/st_pressure_core.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 93bff9b..312a093 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -262,11 +262,11 @@ int st_press_common_probe(struct iio_dev *indio_dev,
 	if (err < 0)
 		goto st_press_common_probe_error;
 
-	if (pdata->get_irq_data_ready(indio_dev) > 0) {
-		err = st_press_allocate_ring(indio_dev);
-		if (err < 0)
-			goto st_press_common_probe_error;
+	err = st_press_allocate_ring(indio_dev);
+	if (err < 0)
+		goto st_press_common_probe_error;
 
+	if (pdata->get_irq_data_ready(indio_dev) > 0) {
 		err = st_sensors_allocate_trigger(indio_dev,
 							ST_PRESS_TRIGGER_OPS);
 		if (err < 0)
@@ -283,8 +283,7 @@ st_press_device_register_error:
 	if (pdata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
 st_press_probe_trigger_error:
-	if (pdata->get_irq_data_ready(indio_dev) > 0)
-		st_press_deallocate_ring(indio_dev);
+	st_press_deallocate_ring(indio_dev);
 st_press_common_probe_error:
 	return err;
 }
@@ -295,10 +294,10 @@ void st_press_common_remove(struct iio_dev *indio_dev)
 	struct st_sensor_data *pdata = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (pdata->get_irq_data_ready(indio_dev) > 0) {
+	if (pdata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
-		st_press_deallocate_ring(indio_dev);
-	}
+
+	st_press_deallocate_ring(indio_dev);
 }
 EXPORT_SYMBOL(st_press_common_remove);
 
-- 
1.7.9.5
