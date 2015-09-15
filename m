Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [RESEND PATCH 1/4] iio: st_accel: set up available scan masks
Date: Tue, 15 Sep 2015 09:49:16 +0200
Message-Id: <1442303356-11764-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

In order to enable triggered buffered input, IIO needs to
know what channels can be enabled for buffered input.
Set up a scan mask for X/Y/Z.

Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/st_accel_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index ff30f8806880..b9a7b5c7c5e7 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -630,6 +630,12 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
 #define ST_ACCEL_TRIGGER_OPS NULL
 #endif
 
+/* Bits 0,1,2, = channels 0,1,2 = x,y,z */
+static const unsigned long st_sensors_scan_masks[] = {
+	ST_SENSORS_ENABLE_ALL_AXIS,
+	0, /* Sentinel */
+};
+
 int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
@@ -652,6 +658,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 	adata->multiread_bit = adata->sensor_settings->multi_read_bit;
 	indio_dev->channels = adata->sensor_settings->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
+	indio_dev->available_scan_masks = st_sensors_scan_masks;
 
 	adata->current_fullscale = (struct st_sensor_fullscale_avl *)
 					&adata->sensor_settings->fs.fs_avl[0];
-- 
2.4.3
