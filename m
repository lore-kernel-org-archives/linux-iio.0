Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Adriana Reus <adriana.reus@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 1/2] iio: accel: kxcjk-1013: use available_scan_masks
Date: Mon, 16 Feb 2015 20:21:48 +0200
Message-Id: <1424110909-16878-2-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1424110909-16878-1-git-send-email-irina.tirdea@intel.com>
References: <1424110909-16878-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

From: Adriana Reus <adriana.reus@intel.com>

Use available_scan_masks to allow the iio core to select
the data to send to userspace depending on which axes are
enabled, instead of doing this in the driver's interrupt
handler.

This also fixes the issue of accessing the buffer scan_mask
instead of active_scan_mask, since these might not be the
same due to client devices.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 567de26..5f27787 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -115,6 +115,7 @@ enum kxcjk1013_axis {
 	AXIS_X,
 	AXIS_Y,
 	AXIS_Z,
+	AXIS_MAX,
 };
 
 enum kxcjk1013_mode {
@@ -947,6 +948,8 @@ static const struct iio_info kxcjk1013_info = {
 	.driver_module		= THIS_MODULE,
 };
 
+static const unsigned long kxcjk1013_scan_masks[] = {0x7, 0};
+
 static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -955,9 +958,7 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
 	int bit, ret, i = 0;
 
 	mutex_lock(&data->mutex);
-
-	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
-			 indio_dev->masklength) {
+	for (bit = 0; bit < AXIS_MAX; bit++) {
 		ret = kxcjk1013_get_acc_reg(data, bit);
 		if (ret < 0) {
 			mutex_unlock(&data->mutex);
@@ -1228,6 +1229,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->channels = kxcjk1013_channels;
 	indio_dev->num_channels = ARRAY_SIZE(kxcjk1013_channels);
+	indio_dev->available_scan_masks = kxcjk1013_scan_masks;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &kxcjk1013_info;
-- 
1.9.1
