Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: lee.jones@linaro.org, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 3/4] iio:magn: Register buffer also without specific trigger
Date: Wed, 18 Sep 2013 11:00:21 +0200
Message-Id: <1379494822-9985-4-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1379494822-9985-1-git-send-email-denis.ciocca@st.com>
References: <1379494822-9985-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fix buffer registration that allows to use generic IIO trigger.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/magnetometer/st_magn_core.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index e8d2849..0de49f8 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -372,10 +372,11 @@ int st_magn_common_probe(struct iio_dev *indio_dev,
 	if (err < 0)
 		goto st_magn_common_probe_error;
 
+	err = st_magn_allocate_ring(indio_dev);
+	if (err < 0)
+		goto st_magn_common_probe_error;
+
 	if (mdata->get_irq_data_ready(indio_dev) > 0) {
-		err = st_magn_allocate_ring(indio_dev);
-		if (err < 0)
-			goto st_magn_common_probe_error;
 		err = st_sensors_allocate_trigger(indio_dev, NULL);
 		if (err < 0)
 			goto st_magn_probe_trigger_error;
@@ -391,8 +392,7 @@ st_magn_device_register_error:
 	if (mdata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
 st_magn_probe_trigger_error:
-	if (mdata->get_irq_data_ready(indio_dev) > 0)
-		st_magn_deallocate_ring(indio_dev);
+	st_magn_deallocate_ring(indio_dev);
 st_magn_common_probe_error:
 	return err;
 }
@@ -403,10 +403,10 @@ void st_magn_common_remove(struct iio_dev *indio_dev)
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (mdata->get_irq_data_ready(indio_dev) > 0) {
+	if (mdata->get_irq_data_ready(indio_dev) > 0)
 		st_sensors_deallocate_trigger(indio_dev);
-		st_magn_deallocate_ring(indio_dev);
-	}
+
+	st_magn_deallocate_ring(indio_dev);
 }
 EXPORT_SYMBOL(st_magn_common_remove);
 
-- 
1.7.9.5
