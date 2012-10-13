Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:54692 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab2JMJe4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Oct 2012 05:34:56 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/7] staging:iio:adc:max1363 drop references to 'ring' given now using a fifo
Date: Sat, 13 Oct 2012 10:34:47 +0100
Message-Id: <1350120891-28593-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1350120891-28593-1-git-send-email-jic23@kernel.org>
References: <1350120891-28593-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Seems worth clearing the old naming out to avoid any confusion in the future.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/max1363.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363.c b/drivers/staging/iio/adc/max1363.c
index 72715a4..dbfdc39 100644
--- a/drivers/staging/iio/adc/max1363.c
+++ b/drivers/staging/iio/adc/max1363.c
@@ -788,7 +788,7 @@ static int max1363_monitor_mode_update(struct max1363_state *st, int enabled)
 	const long *modemask;
 
 	if (!enabled) {
-		/* transition to ring capture is not currently supported */
+		/* transition to buffered capture is not currently supported */
 		st->setupbyte &= ~MAX1363_SETUP_MONITOR_SETUP;
 		st->configbyte &= ~MAX1363_SCAN_MASK;
 		st->monitor_on = false;
@@ -1482,13 +1482,13 @@ done:
 	return IRQ_HANDLED;
 }
 
-static const struct iio_buffer_setup_ops max1363_ring_setup_ops = {
+static const struct iio_buffer_setup_ops max1363_buffered_setup_ops = {
 	.postenable = &iio_triggered_buffer_postenable,
 	.preenable = &iio_sw_buffer_preenable,
 	.predisable = &iio_triggered_buffer_predisable,
 };
 
-static int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
+static int max1363_register_buffered_funcs_and_init(struct iio_dev *indio_dev)
 {
 	struct max1363_state *st = iio_priv(indio_dev);
 	int ret = 0;
@@ -1509,10 +1509,10 @@ static int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_deallocate_sw_rb;
 	}
-	/* Ring buffer functions - here trigger setup related */
-	indio_dev->setup_ops = &max1363_ring_setup_ops;
+	/* Buffer functions - here trigger setup related */
+	indio_dev->setup_ops = &max1363_buffered_setup_ops;
 
-	/* Flag that polled ring buffering is possible */
+	/* Flag that polled buffering is possible */
 	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
 
 	return 0;
@@ -1523,7 +1523,7 @@ error_ret:
 	return ret;
 }
 
-static void max1363_ring_cleanup(struct iio_dev *indio_dev)
+static void max1363_buffer_cleanup(struct iio_dev *indio_dev)
 {
 	/* ensure that the trigger has been detached */
 	iio_dealloc_pollfunc(indio_dev->pollfunc);
@@ -1581,7 +1581,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	if (ret < 0)
 		goto error_free_available_scan_masks;
 
-	ret = max1363_register_ring_funcs_and_init(indio_dev);
+	ret = max1363_register_buffered_funcs_and_init(indio_dev);
 	if (ret)
 		goto error_free_available_scan_masks;
 
@@ -1589,7 +1589,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 				  st->chip_info->channels,
 				  st->chip_info->num_channels);
 	if (ret)
-		goto error_cleanup_ring;
+		goto error_cleanup_buffer;
 
 	if (client->irq) {
 		ret = request_threaded_irq(st->client->irq,
@@ -1600,7 +1600,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 					   indio_dev);
 
 		if (ret)
-			goto error_uninit_ring;
+			goto error_uninit_buffer;
 	}
 
 	ret = iio_device_register(indio_dev);
@@ -1610,10 +1610,10 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	return 0;
 error_free_irq:
 	free_irq(st->client->irq, indio_dev);
-error_uninit_ring:
+error_uninit_buffer:
 	iio_buffer_unregister(indio_dev);
-error_cleanup_ring:
-	max1363_ring_cleanup(indio_dev);
+error_cleanup_buffer:
+	max1363_buffer_cleanup(indio_dev);
 error_free_available_scan_masks:
 	kfree(indio_dev->available_scan_masks);
 error_unregister_map:
@@ -1638,7 +1638,7 @@ static int __devexit max1363_remove(struct i2c_client *client)
 	if (client->irq)
 		free_irq(st->client->irq, indio_dev);
 	iio_buffer_unregister(indio_dev);
-	max1363_ring_cleanup(indio_dev);
+	max1363_buffer_cleanup(indio_dev);
 	kfree(indio_dev->available_scan_masks);
 	if (!IS_ERR(reg)) {
 		regulator_disable(reg);
-- 
1.7.12.2

