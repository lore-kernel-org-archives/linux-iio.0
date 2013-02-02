Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43924 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755471Ab3BBKrP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2013 05:47:15 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio:max1363 remove some functions left after merge
Date: Sat,  2 Feb 2013 10:47:08 +0000
Message-Id: <1359802028-31812-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

merge commit 17cb3be61b45d716f6b21a9380925493413ce0ed
seems to have resulted in two functions that were removed in
4389fbec5b8fd0577c1e854ff5d7139329558c20 reappearing.

Spotted due to a build kicking out

drivers/iio/adc/max1363.c:1486:12: warning: 'max1363_register_buffered_funcs_and_init' defined but not used
drivers/iio/adc/max1363.c:1521:13: warning: 'max1363_buffer_cleanup' defined but not used

This patch just removes them again.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/max1363.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index ef868c9..08e4feb 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1484,48 +1484,6 @@ static const struct iio_buffer_setup_ops max1363_buffered_setup_ops = {
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
 static int max1363_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
-- 
1.8.1.1

