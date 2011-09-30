Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 11/11] staging:iio:resolver:ad2s1210 cleanup gpio handling.
Date: Fri, 30 Sep 2011 11:14:54 +0100
Message-Id: <1317377694-9001-12-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
References: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Basically make use of the gpio array functions.
Technically the free doesn't need as much info
as given here, but this keeps it clean and easy
to follow.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/resolver/ad2s1210.c |   51 +++++++++++--------------------
 1 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 4f248de..8a6fcb6 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -653,45 +653,30 @@ static const struct iio_info ad2s1210_info = {
 
 static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 {
-	int ret;
 	unsigned long flags = st->pdata->gpioin ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
+	struct gpio ad2s1210_gpios[] = {
+		{ st->pdata->sample, GPIOF_DIR_IN, "sample" },
+		{ st->pdata->a[0], flags, "a0" },
+		{ st->pdata->a[1], flags, "a1" },
+		{ st->pdata->res[0], flags, "res0" },
+		{ st->pdata->res[0], flags, "res1" },
+	};
 
-	ret = gpio_request_one(st->pdata->sample, GPIOF_DIR_IN, "sample");
-	if (ret < 0)
-		goto error_ret;
-	ret = gpio_request_one(st->pdata->a[0], flags, "a0");
-	if (ret < 0)
-		goto error_free_sample;
-	ret = gpio_request_one(st->pdata->a[1], flags, "a1");
-	if (ret < 0)
-		goto error_free_a0;
-	ret = gpio_request_one(st->pdata->res[1], flags, "res0");
-	if (ret < 0)
-		goto error_free_a1;
-	ret = gpio_request_one(st->pdata->res[1], flags, "res1");
-	if (ret < 0)
-		goto error_free_res0;
-
-	return 0;
-error_free_res0:
-	gpio_free(st->pdata->res[0]);
-error_free_a1:
-	gpio_free(st->pdata->a[1]);
-error_free_a0:
-	gpio_free(st->pdata->a[0]);
-error_free_sample:
-	gpio_free(st->pdata->sample);
-error_ret:
-	return ret;
+	return gpio_request_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
 }
 
 static void ad2s1210_free_gpios(struct ad2s1210_state *st)
 {
-	gpio_free(st->pdata->res[1]);
-	gpio_free(st->pdata->res[0]);
-	gpio_free(st->pdata->a[1]);
-	gpio_free(st->pdata->a[0]);
-	gpio_free(st->pdata->sample);
+	unsigned long flags = st->pdata->gpioin ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
+	struct gpio ad2s1210_gpios[] = {
+		{ st->pdata->sample, GPIOF_DIR_IN, "sample" },
+		{ st->pdata->a[0], flags, "a0" },
+		{ st->pdata->a[1], flags, "a1" },
+		{ st->pdata->res[0], flags, "res0" },
+		{ st->pdata->res[0], flags, "res1" },
+	};
+
+	gpio_free_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
 }
 
 static int __devinit ad2s1210_probe(struct spi_device *spi)
-- 
1.7.3.4
