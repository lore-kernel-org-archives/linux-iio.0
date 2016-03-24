Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:11670 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757081AbcCXJ34 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 24 Mar 2016 05:29:56 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Markus Pargmann <mpa@pengutronix.de>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Adriana Reus <adriana.reus@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 5/6] iio: accel: kxcjk-1013: use available_scan_masks
Date: Thu, 24 Mar 2016 11:29:30 +0200
Message-Id: <1458811771-25217-6-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1458811771-25217-1-git-send-email-irina.tirdea@intel.com>
References: <1458811771-25217-1-git-send-email-irina.tirdea@intel.com>
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
index edec1d0..3861fe9 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -115,6 +115,7 @@ enum kxcjk1013_axis {
 	AXIS_X,
 	AXIS_Y,
 	AXIS_Z,
+	AXIS_MAX,
 };
 
 enum kxcjk1013_mode {
@@ -953,6 +954,8 @@ static const struct iio_info kxcjk1013_info = {
 	.driver_module		= THIS_MODULE,
 };
 
+static const unsigned long kxcjk1013_scan_masks[] = {0x7, 0};
+
 static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -962,8 +965,7 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
 
 	mutex_lock(&data->mutex);
 
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	for (bit = 0; bit < AXIS_MAX; bit++) {
 		ret = kxcjk1013_get_acc_reg(data, bit);
 		if (ret < 0) {
 			mutex_unlock(&data->mutex);
@@ -1204,6 +1206,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->channels = kxcjk1013_channels;
 	indio_dev->num_channels = ARRAY_SIZE(kxcjk1013_channels);
+	indio_dev->available_scan_masks = kxcjk1013_scan_masks;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &kxcjk1013_info;
-- 
1.9.1

