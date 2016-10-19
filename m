Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:60018 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757154AbcJSRHV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 13:07:21 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/13] staging:iio:ad7606: Factor out common code between periodic and one-shot capture
Date: Wed, 19 Oct 2016 19:07:02 +0200
Message-Id: <1476896828-10544-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1476896828-10544-1-git-send-email-lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Both the periodic buffer based and one-shot sysfs based capture methods
share a large portion of their code. Factor this out into a common helper
function.

Also provide a comment that better explains in more detail what is going on
in the capture function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7606.h      |  1 +
 drivers/staging/iio/adc/ad7606_core.c | 58 ++++++++++++++++++++++-------------
 drivers/staging/iio/adc/ad7606_ring.c | 30 +++---------------
 3 files changed, 41 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index 129f94e..2257bdb 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -84,6 +84,7 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 			      const struct ad7606_bus_ops *bops);
 int ad7606_remove(struct iio_dev *indio_dev, int irq);
 int ad7606_reset(struct ad7606_state *st);
+int ad7606_read_samples(struct ad7606_state *st);
 
 enum ad7606_supported_device_ids {
 	ID_AD7606_8,
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 7c093e2..4ce103a 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -36,6 +36,39 @@ int ad7606_reset(struct ad7606_state *st)
 	return -ENODEV;
 }
 
+int ad7606_read_samples(struct ad7606_state *st)
+{
+	unsigned int num = st->chip_info->num_channels;
+	u16 *data = st->data;
+	int ret;
+
+	/*
+	 * The frstdata signal is set to high while and after reading the sample
+	 * of the first channel and low for all other channels. This can be used
+	 * to check that the incoming data is correctly aligned. During normal
+	 * operation the data should never become unaligned, but some glitch or
+	 * electrostatic discharge might cause an extra read or clock cycle.
+	 * Monitoring the frstdata signal allows to recover from such failure
+	 * situations.
+	 */
+
+	if (gpio_is_valid(st->pdata->gpio_frstdata)) {
+		ret = st->bops->read_block(st->dev, 1, data);
+		if (ret)
+			return ret;
+
+		if (!gpio_get_value(st->pdata->gpio_frstdata)) {
+			ad7606_reset(st);
+			return -EIO;
+		}
+
+		data++;
+		num--;
+	}
+
+	return st->bops->read_block(st->dev, num, data);
+}
+
 static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
@@ -48,28 +81,9 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 	if (ret)
 		goto error_ret;
 
-	if (gpio_is_valid(st->pdata->gpio_frstdata)) {
-		ret = st->bops->read_block(st->dev, 1, st->data);
-		if (ret)
-			goto error_ret;
-		if (!gpio_get_value(st->pdata->gpio_frstdata)) {
-			/* This should never happen */
-			ad7606_reset(st);
-			ret = -EIO;
-			goto error_ret;
-		}
-		ret = st->bops->read_block(st->dev,
-			st->chip_info->num_channels - 1, &st->data[1]);
-		if (ret)
-			goto error_ret;
-	} else {
-		ret = st->bops->read_block(st->dev,
-			st->chip_info->num_channels, st->data);
-		if (ret)
-			goto error_ret;
-	}
-
-	ret = st->data[ch];
+	ret = ad7606_read_samples(st);
+	if (ret == 0)
+		ret = st->data[ch];
 
 error_ret:
 	gpio_set_value(st->pdata->gpio_convst, 0);
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 7fa4ccc..b7bf0cf 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -48,33 +48,11 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	struct iio_dev *indio_dev = iio_priv_to_dev(st);
 	int ret;
 
-	if (gpio_is_valid(st->pdata->gpio_frstdata)) {
-		ret = st->bops->read_block(st->dev, 1, st->data);
-		if (ret)
-			goto done;
-		if (!gpio_get_value(st->pdata->gpio_frstdata)) {
-			/* This should never happen. However
-			 * some signal glitch caused by bad PCB desgin or
-			 * electrostatic discharge, could cause an extra read
-			 * or clock. This allows recovery.
-			 */
-			ad7606_reset(st);
-			goto done;
-		}
-		ret = st->bops->read_block(st->dev,
-			st->chip_info->num_channels - 1, st->data + 1);
-		if (ret)
-			goto done;
-	} else {
-		ret = st->bops->read_block(st->dev,
-			st->chip_info->num_channels, st->data);
-		if (ret)
-			goto done;
-	}
+	ret = ad7606_read_samples(st);
+	if (ret == 0)
+		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
+						   iio_get_time_ns(indio_dev));
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
-					   iio_get_time_ns(indio_dev));
-done:
 	gpio_set_value(st->pdata->gpio_convst, 0);
 	iio_trigger_notify_done(indio_dev->trig);
 }
-- 
2.1.4

