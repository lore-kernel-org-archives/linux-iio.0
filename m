Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8265 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755378AbbHLOd3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 12 Aug 2015 10:33:29 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Wolfram Sang <wsa@the-dreams.de>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Adriana Reus <adriana.reus@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v5 7/8] iio: accel: kxcjk-1013: use available_scan_masks
Date: Wed, 12 Aug 2015 17:31:39 +0300
Message-Id: <1439389900-10108-8-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1439389900-10108-1-git-send-email-irina.tirdea@intel.com>
References: <1439389900-10108-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Adriana Reus <adriana.reus@intel.com>

Use available_scan_masks to allow the iio core to select
the data to send to userspace depending on which axes are
enabled, instead of doing this in the driver's interrupt
handler.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 0d9bd35..d4b80e7 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -115,6 +115,7 @@ enum kxcjk1013_axis {
 	AXIS_X,
 	AXIS_Y,
 	AXIS_Z,
+	AXIS_MAX,
 };
 
 enum kxcjk1013_mode {
@@ -956,6 +957,8 @@ static const struct iio_info kxcjk1013_info = {
 	.driver_module		= THIS_MODULE,
 };
 
+static const unsigned long kxcjk1013_scan_masks[] = {0x7, 0};
+
 static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -965,8 +968,7 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
 
 	mutex_lock(&data->mutex);
 
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	for (bit = 0; bit < AXIS_MAX; bit++) {
 		ret = kxcjk1013_get_acc_reg(data, bit);
 		if (ret < 0) {
 			mutex_unlock(&data->mutex);
@@ -1236,6 +1238,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->channels = kxcjk1013_channels;
 	indio_dev->num_channels = ARRAY_SIZE(kxcjk1013_channels);
+	indio_dev->available_scan_masks = kxcjk1013_scan_masks;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &kxcjk1013_info;
-- 
1.9.1

