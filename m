Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18599 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754993AbaGQAhE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Jul 2014 20:37:04 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/6] iio: accel: kxcjk-1013: Use try_reenable to ack intr
Date: Wed, 16 Jul 2014 17:42:30 -0700
Message-Id: <1405557754-19601-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1405557754-19601-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1405557754-19601-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This chip needs explicit interrupt ack, introducing try_reenable
callback. Also removed separate function to ack interrupt as this
doesn't add any value.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 4702aeb..bff5161 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -138,19 +138,6 @@ static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
 	return 0;
 }
 
-static int kxcjk1013_chip_ack_intr(struct kxcjk1013_data *data)
-{
-	int ret;
-
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_REL);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_int_rel\n");
-		return ret;
-	}
-
-	return ret;
-}
-
 static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 {
 	int ret;
@@ -498,15 +485,11 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
 			 indio_dev->masklength) {
 		ret = kxcjk1013_get_acc_reg(data, bit);
 		if (ret < 0) {
-			kxcjk1013_chip_ack_intr(data);
 			mutex_unlock(&data->mutex);
 			goto err;
 		}
 		data->buffer[i++] = ret;
 	}
-
-	kxcjk1013_chip_ack_intr(data);
-
 	mutex_unlock(&data->mutex);
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
@@ -517,6 +500,21 @@ err:
 	return IRQ_HANDLED;
 }
 
+static int kxcjk1013_trig_try_reen(struct iio_trigger *trig)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_REL);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error reading reg_int_rel\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
@@ -543,6 +541,7 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 static const struct iio_trigger_ops kxcjk1013_trigger_ops = {
 	.set_trigger_state = kxcjk1013_data_rdy_trigger_set_state,
+	.try_reenable = kxcjk1013_trig_try_reen,
 	.owner = THIS_MODULE,
 };
 
-- 
1.7.11.7

