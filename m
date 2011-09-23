Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/16] staging:iio:adc:ad7606 make gpio request failures more consistent
Date: Fri, 23 Sep 2011 13:01:38 +0100
Message-Id: <1316779302-12357-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

To my mind, if a gpio is specified in the board file, yet fails
to be successfully requested, that is an error condidtion and
the driver should not muddle on regardless.

This does mean unwinding the gpios on error. Also the free_gpios
function is reordered so that it is consistent with the request one
(reverse order obviously).

This patch is the category of not technically fixing anything, just
making the driver be more in line with what a reviewer will expect.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7606.h      |    5 -
 drivers/staging/iio/adc/ad7606_core.c |  135 +++++++++++++++++++++------------
 drivers/staging/iio/adc/ad7606_ring.c |    2 +-
 3 files changed, 86 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index b8b3d8e..8fc259f 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -75,11 +75,6 @@ struct ad7606_state {
 	unsigned			range;
 	unsigned			oversampling;
 	bool				done;
-	bool				have_frstdata;
-	bool				have_os;
-	bool				have_stby;
-	bool				have_reset;
-	bool				have_range;
 	void __iomem			*base_address;
 
 	/*
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 02b0a5b..e762acb 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -26,7 +26,7 @@
 
 int ad7606_reset(struct ad7606_state *st)
 {
-	if (st->have_reset) {
+	if (gpio_is_valid(st->pdata->gpio_reset)) {
 		gpio_set_value(st->pdata->gpio_reset, 1);
 		ndelay(100); /* t_reset >= 100ns */
 		gpio_set_value(st->pdata->gpio_reset, 0);
@@ -48,7 +48,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned ch)
 	if (ret)
 		goto error_ret;
 
-	if (st->have_frstdata) {
+	if (gpio_is_valid(st->pdata->gpio_frstdata)) {
 		ret = st->bops->read_block(st->dev, 1, st->data);
 		if (ret)
 			goto error_ret;
@@ -214,12 +214,14 @@ static mode_t ad7606_attr_is_visible(struct kobject *kobj,
 
 	mode_t mode = attr->mode;
 
-	if (!st->have_os &&
-		(attr == &iio_dev_attr_oversampling_ratio.dev_attr.attr ||
-		attr ==
-		&iio_const_attr_oversampling_ratio_available.dev_attr.attr))
+	if (!(gpio_is_valid(st->pdata->gpio_os0) &&
+	      gpio_is_valid(st->pdata->gpio_os1) &&
+	      gpio_is_valid(st->pdata->gpio_os2)) &&
+	    (attr == &iio_dev_attr_oversampling_ratio.dev_attr.attr ||
+	     attr ==
+	     &iio_const_attr_oversampling_ratio_available.dev_attr.attr))
 		mode = 0;
-	else if (!st->have_range &&
+	else if (!gpio_is_valid(st->pdata->gpio_range) &&
 		 (attr == &iio_dev_attr_in_voltage_range.dev_attr.attr ||
 		  attr ==
 		  &iio_const_attr_in_voltage_range_available.dev_attr.attr))
@@ -321,63 +323,96 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 	};
 	int ret;
 
-	ret = gpio_request_one(st->pdata->gpio_convst, GPIOF_OUT_INIT_LOW,
-			       "AD7606_CONVST");
-	if (ret) {
-		dev_err(st->dev, "failed to request GPIO CONVST\n");
-		return ret;
+	if (gpio_is_valid(st->pdata->gpio_convst)) {
+		ret = gpio_request_one(st->pdata->gpio_convst,
+				       GPIOF_OUT_INIT_LOW,
+				       "AD7606_CONVST");
+		if (ret) {
+			dev_err(st->dev, "failed to request GPIO CONVST\n");
+			goto error_ret;
+		}
+	} else {
+		ret = -EIO;
+		goto error_ret;
 	}
 
-	ret = gpio_request_array(gpio_array, ARRAY_SIZE(gpio_array));
-	if (!ret)
-		st->have_os = true;
-
-	ret = gpio_request_one(st->pdata->gpio_reset, GPIOF_OUT_INIT_LOW,
-			       "AD7606_RESET");
-	if (!ret)
-		st->have_reset = true;
+	if (gpio_is_valid(st->pdata->gpio_os0) &&
+	    gpio_is_valid(st->pdata->gpio_os1) &&
+	    gpio_is_valid(st->pdata->gpio_os2)) {
+		ret = gpio_request_array(gpio_array, ARRAY_SIZE(gpio_array));
+		if (ret < 0)
+			goto error_free_convst;
+	}
 
-	ret = gpio_request_one(st->pdata->gpio_range, GPIOF_DIR_OUT |
-				((st->range == 10000) ? GPIOF_INIT_HIGH :
-				GPIOF_INIT_LOW), "AD7606_RANGE");
-	if (!ret)
-		st->have_range = true;
+	if (gpio_is_valid(st->pdata->gpio_reset)) {
+		ret = gpio_request_one(st->pdata->gpio_reset,
+				       GPIOF_OUT_INIT_LOW,
+				       "AD7606_RESET");
+		if (ret < 0)
+			goto error_free_os;
+	}
 
-	ret = gpio_request_one(st->pdata->gpio_stby, GPIOF_OUT_INIT_HIGH,
-			       "AD7606_STBY");
-	if (!ret)
-		st->have_stby = true;
+	if (gpio_is_valid(st->pdata->gpio_range)) {
+		ret = gpio_request_one(st->pdata->gpio_range, GPIOF_DIR_OUT |
+				       ((st->range == 10000) ? GPIOF_INIT_HIGH :
+					GPIOF_INIT_LOW), "AD7606_RANGE");
+		if (ret < 0)
+			goto error_free_reset;
+	}
+	if (gpio_is_valid(st->pdata->gpio_stby)) {
+		ret = gpio_request_one(st->pdata->gpio_stby,
+				       GPIOF_OUT_INIT_HIGH,
+				       "AD7606_STBY");
+		if (ret < 0)
+			goto error_free_range;
+	}
 
 	if (gpio_is_valid(st->pdata->gpio_frstdata)) {
 		ret = gpio_request_one(st->pdata->gpio_frstdata, GPIOF_IN,
 				       "AD7606_FRSTDATA");
-		if (!ret)
-			st->have_frstdata = true;
+		if (ret < 0)
+			goto error_free_stby;
 	}
 
 	return 0;
+
+error_free_stby:
+	if (gpio_is_valid(st->pdata->gpio_stby))
+		gpio_free(st->pdata->gpio_stby);
+error_free_range:
+	if (gpio_is_valid(st->pdata->gpio_range))
+		gpio_free(st->pdata->gpio_range);
+error_free_reset:
+	if (gpio_is_valid(st->pdata->gpio_reset))
+		gpio_free(st->pdata->gpio_reset);
+error_free_os:
+	if (gpio_is_valid(st->pdata->gpio_os0) &&
+	    gpio_is_valid(st->pdata->gpio_os1) &&
+	    gpio_is_valid(st->pdata->gpio_os2))
+		gpio_free_array(gpio_array, ARRAY_SIZE(gpio_array));
+error_free_convst:
+	gpio_free(st->pdata->gpio_convst);
+error_ret:
+	return ret;
 }
 
 static void ad7606_free_gpios(struct ad7606_state *st)
 {
-	if (st->have_range)
-		gpio_free(st->pdata->gpio_range);
-
-	if (st->have_stby)
+	if (gpio_is_valid(st->pdata->gpio_frstdata))
+		gpio_free(st->pdata->gpio_frstdata);
+	if (gpio_is_valid(st->pdata->gpio_stby))
 		gpio_free(st->pdata->gpio_stby);
-
-	if (st->have_os) {
-		gpio_free(st->pdata->gpio_os0);
-		gpio_free(st->pdata->gpio_os1);
+	if (gpio_is_valid(st->pdata->gpio_range))
+		gpio_free(st->pdata->gpio_range);
+	if (gpio_is_valid(st->pdata->gpio_reset))
+		gpio_free(st->pdata->gpio_reset);
+	if (gpio_is_valid(st->pdata->gpio_os0) &&
+	    gpio_is_valid(st->pdata->gpio_os1) &&
+	    gpio_is_valid(st->pdata->gpio_os2)) {
 		gpio_free(st->pdata->gpio_os2);
+		gpio_free(st->pdata->gpio_os1);
+		gpio_free(st->pdata->gpio_os0);
 	}
-
-	if (st->have_reset)
-		gpio_free(st->pdata->gpio_reset);
-
-	if (st->have_frstdata)
-		gpio_free(st->pdata->gpio_frstdata);
-
 	gpio_free(st->pdata->gpio_convst);
 }
 
@@ -531,8 +566,8 @@ void ad7606_suspend(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	if (st->have_stby) {
-		if (st->have_range)
+	if (gpio_is_valid(st->pdata->gpio_stby)) {
+		if (gpio_is_valid(st->pdata->gpio_range))
 			gpio_set_value(st->pdata->gpio_range, 1);
 		gpio_set_value(st->pdata->gpio_stby, 0);
 	}
@@ -542,8 +577,8 @@ void ad7606_resume(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	if (st->have_stby) {
-		if (st->have_range)
+	if (gpio_is_valid(st->pdata->gpio_stby)) {
+		if (gpio_is_valid(st->pdata->gpio_range))
 			gpio_set_value(st->pdata->gpio_range,
 					st->range == 10000);
 
diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
index 0b60a6e..f0742d6 100644
--- a/drivers/staging/iio/adc/ad7606_ring.c
+++ b/drivers/staging/iio/adc/ad7606_ring.c
@@ -110,7 +110,7 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
 	if (buf == NULL)
 		return;
 
-	if (st->have_frstdata) {
+	if (gpio_is_valid(st->pdata->gpio_frstdata)) {
 		ret = st->bops->read_block(st->dev, 1, buf);
 		if (ret)
 			goto done;
-- 
1.7.3.4
