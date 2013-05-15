Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de,
	j.anaszewski@samsung.com
Cc: Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 2/3] iio:common: Added get_buffer_element function pointer
Date: Wed, 15 May 2013 10:44:52 +0200
Message-Id: <1368607493-4843-3-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1368607493-4843-1-git-send-email-denis.ciocca@st.com>
References: <1368607493-4843-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/accel/st_accel_core.c                 |    1 +
 drivers/iio/common/st_sensors/st_sensors_buffer.c |    2 +-
 drivers/iio/gyro/st_gyro_core.c                   |    1 +
 drivers/iio/magnetometer/st_magn_core.c           |    1 +
 include/linux/iio/common/st_sensors.h             |    2 ++
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 40236d5..2b8a7bd 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -454,6 +454,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 	if (err < 0)
 		goto st_accel_common_probe_error;
 
+	adata->get_buffer_element = &st_sensors_get_buffer_element;
 	adata->multiread_bit = adata->sensor->multi_read_bit;
 	indio_dev->channels = adata->sensor->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index 09b236d..430039d 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -94,7 +94,7 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	len = st_sensors_get_buffer_element(indio_dev, sdata->buffer_data);
+	len = sdata->get_buffer_element(indio_dev, sdata->buffer_data);
 	if (len < 0)
 		goto st_sensors_get_buffer_element_error;
 
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 9bae46b..56e9253 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -313,6 +313,7 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 	if (err < 0)
 		goto st_gyro_common_probe_error;
 
+	gdata->get_buffer_element = &st_sensors_get_buffer_element;
 	gdata->multiread_bit = gdata->sensor->multi_read_bit;
 	indio_dev->channels = gdata->sensor->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 715d616..3208ba8 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -356,6 +356,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	if (err < 0)
 		goto st_magn_common_probe_error;
 
+	mdata->get_buffer_element = &st_sensors_get_buffer_element;
 	mdata->multiread_bit = mdata->sensor->multi_read_bit;
 	indio_dev->channels = mdata->sensor->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 5ffd763..fd81707 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -203,6 +203,7 @@ struct st_sensors {
  * @buffer_data: Data used by buffer part.
  * @odr: Output data rate of the sensor [Hz].
  * @get_irq_data_ready: Function to get the IRQ used for data ready signal.
+ * @get_buffer_element: Function to get data from sensor and push on buffer.
  * @tf: Transfer function structure used by I/O operations.
  * @tb: Transfer buffers and mutex used by I/O operations.
  */
@@ -220,6 +221,7 @@ struct st_sensor_data {
 	unsigned int odr;
 
 	unsigned int (*get_irq_data_ready) (struct iio_dev *indio_dev);
+	int (*get_buffer_element) (struct iio_dev *indio_dev, u8 *buf);
 
 	const struct st_sensor_transfer_function *tf;
 	struct st_sensor_transfer_buffer tb;
-- 
1.7.9.5
