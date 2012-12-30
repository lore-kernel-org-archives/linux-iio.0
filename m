Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/2] iio: cleanup buffer setup code in max1363 driver
Date: Mon, 31 Dec 2012 00:26:57 +0100
Message-Id: <1356910018-14422-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

use iio_triggered_buffer_setup(), iio_triggered_buffer_cleanup()

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/max1363.c |   59 ++++-----------------------------------------
 1 file changed, 5 insertions(+), 54 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 1e84b5b..46d8365 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -39,6 +39,7 @@
 #include <linux/iio/driver.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define MAX1363_SETUP_BYTE(a) ((a) | 0x80)
 
@@ -1483,48 +1484,6 @@ static const struct iio_buffer_setup_ops max1363_buffered_setup_ops = {
 	.predisable = &iio_triggered_buffer_predisable,
 };
 
-static int max1363_register_buffered_funcs_and_init(struct iio_dev *indio_dev)
-{
-	struct max1363_state *st = iio_priv(indio_dev);
-	int ret = 0;
-
-	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
-	if (!indio_dev->buffer) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
-						 &max1363_trigger_handler,
-						 IRQF_ONESHOT,
-						 indio_dev,
-						 "%s_consumer%d",
-						 st->client->name,
-						 indio_dev->id);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_deallocate_sw_rb;
-	}
-	/* Buffer functions - here trigger setup related */
-	indio_dev->setup_ops = &max1363_buffered_setup_ops;
-
-	/* Flag that polled buffering is possible */
-	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
-
-	return 0;
-
-error_deallocate_sw_rb:
-	iio_kfifo_free(indio_dev->buffer);
-error_ret:
-	return ret;
-}
-
-static void max1363_buffer_cleanup(struct iio_dev *indio_dev)
-{
-	/* ensure that the trigger has been detached */
-	iio_dealloc_pollfunc(indio_dev->pollfunc);
-	iio_kfifo_free(indio_dev->buffer);
-}
-
 static int __devinit max1363_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
@@ -1577,16 +1536,11 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	if (ret < 0)
 		goto error_free_available_scan_masks;
 
-	ret = max1363_register_buffered_funcs_and_init(indio_dev);
+	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+		&max1363_trigger_handler, &max1363_buffered_setup_ops);
 	if (ret)
 		goto error_free_available_scan_masks;
 
-	ret = iio_buffer_register(indio_dev,
-				  st->chip_info->channels,
-				  st->chip_info->num_channels);
-	if (ret)
-		goto error_cleanup_buffer;
-
 	if (client->irq) {
 		ret = request_threaded_irq(st->client->irq,
 					   NULL,
@@ -1607,9 +1561,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 error_free_irq:
 	free_irq(st->client->irq, indio_dev);
 error_uninit_buffer:
-	iio_buffer_unregister(indio_dev);
-error_cleanup_buffer:
-	max1363_buffer_cleanup(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 error_free_available_scan_masks:
 	kfree(indio_dev->available_scan_masks);
 error_unregister_map:
@@ -1632,8 +1584,7 @@ static int __devexit max1363_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 	if (client->irq)
 		free_irq(st->client->irq, indio_dev);
-	iio_buffer_unregister(indio_dev);
-	max1363_buffer_cleanup(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 	kfree(indio_dev->available_scan_masks);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
-- 
1.7.9.5
