Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:max1361: Use default triggered buffer setup ops
Date: Mon, 16 Sep 2013 10:34:49 +0200
Message-Id: <1379320489-27334-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The max1361 driver uses the same callbacks as the triggered buffer default
buffer setup ops, so just remove the max1361 specific ops and let it use the
default ops.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/max1363.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 4fb35d1..1e7160d 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1484,12 +1484,6 @@ done:
 	return IRQ_HANDLED;
 }
 
-static const struct iio_buffer_setup_ops max1363_buffered_setup_ops = {
-	.postenable = &iio_triggered_buffer_postenable,
-	.preenable = &iio_sw_buffer_preenable,
-	.predisable = &iio_triggered_buffer_predisable,
-};
-
 static int max1363_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -1559,7 +1553,7 @@ static int max1363_probe(struct i2c_client *client,
 		goto error_disable_reg;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-		&max1363_trigger_handler, &max1363_buffered_setup_ops);
+		&max1363_trigger_handler, NULL);
 	if (ret)
 		goto error_disable_reg;
 
-- 
1.8.0
