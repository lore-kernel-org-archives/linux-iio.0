Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:30820 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754957AbbHLOc5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 12 Aug 2015 10:32:57 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Wolfram Sang <wsa@the-dreams.de>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v5 3/8] iio: accel: bmc150: use available_scan_masks
Date: Wed, 12 Aug 2015 17:31:35 +0300
Message-Id: <1439389900-10108-4-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1439389900-10108-1-git-send-email-irina.tirdea@intel.com>
References: <1439389900-10108-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use available_scan_masks to allow the iio core to select
the data to send to userspace depending on which axes are
enabled, instead of doing this in the driver's interrupt
handler.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index cc5a357..40da2d0 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -136,6 +136,7 @@ enum bmc150_accel_axis {
 	AXIS_X,
 	AXIS_Y,
 	AXIS_Z,
+	AXIS_MAX,
 };
 
 enum bmc150_power_modes {
@@ -1200,6 +1201,8 @@ static const struct iio_info bmc150_accel_info_fifo = {
 	.driver_module		= THIS_MODULE,
 };
 
+static const unsigned long bmc150_accel_scan_masks[] = {0x7, 0};
+
 static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -1208,8 +1211,7 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 	int bit, ret, i = 0;
 
 	mutex_lock(&data->mutex);
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	for (bit = 0; bit < AXIS_MAX; bit++) {
 		ret = i2c_smbus_read_word_data(data->client,
 					       BMC150_ACCEL_AXIS_TO_REG(bit));
 		if (ret < 0) {
@@ -1647,6 +1649,7 @@ static int bmc150_accel_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->num_channels;
+	indio_dev->available_scan_masks = bmc150_accel_scan_masks;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmc150_accel_info;
-- 
1.9.1

