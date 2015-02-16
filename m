Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Adriana Reus <adriana.reus@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 1/2] iio: accel: bmc150: use available_scan_masks
Date: Mon, 16 Feb 2015 20:17:00 +0200
Message-Id: <1424110621-16571-2-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1424110621-16571-1-git-send-email-irina.tirdea@intel.com>
References: <1424110621-16571-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Use available_scan_masks to allow the iio core to select
the data to send to userspace depending on which axes are
enabled, instead of doing this in the driver's interrupt
handler.

This also fixes the issue of accessing the buffer scan_mask
instead of active_scan_mask, since these might not be the
same due to client devices.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index f040f40..2eb0102 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -126,6 +126,7 @@ enum bmc150_accel_axis {
 	AXIS_X,
 	AXIS_Y,
 	AXIS_Z,
+	AXIS_MAX,
 };
 
 enum bmc150_power_modes {
@@ -921,6 +922,8 @@ static const struct iio_info bmc150_accel_info = {
 	.driver_module		= THIS_MODULE,
 };
 
+static const unsigned long bmc150_accel_scan_masks[] = {0x7, 0};
+
 static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -929,8 +932,7 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 	int bit, ret, i = 0;
 
 	mutex_lock(&data->mutex);
-	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
-			 indio_dev->masklength) {
+	for (bit = 0; bit < AXIS_MAX; bit++) {
 		ret = i2c_smbus_read_word_data(data->client,
 					       BMC150_ACCEL_AXIS_TO_REG(bit));
 		if (ret < 0) {
@@ -1178,6 +1180,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->num_channels;
+	indio_dev->available_scan_masks = bmc150_accel_scan_masks;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmc150_accel_info;
-- 
1.9.1
