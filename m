Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34346 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944934AbcJaRI0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2016 13:08:26 -0400
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 6/6] staging: iio: ad9832: clean-up regulator 'reg'
Date: Tue,  1 Nov 2016 01:04:35 +0800
Message-Id: <1477933475-21914-7-git-send-email-eraretuya@gmail.com>
In-Reply-To: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
References: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Rename regulator 'reg' to 'avdd' so as to be clear what regulator it
stands for specifically. Additionally, get rid of local variable 'reg'
and use direct assignment instead. Update also the goto label pertaining
to the avdd regulator during disable.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 20 +++++++++-----------
 drivers/staging/iio/frequency/ad9832.h |  4 ++--
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 6a5ab02..639047f 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -204,7 +204,6 @@ static int ad9832_probe(struct spi_device *spi)
 	struct ad9832_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct iio_dev *indio_dev;
 	struct ad9832_state *st;
-	struct regulator *reg;
 	int ret;
 
 	if (!pdata) {
@@ -212,11 +211,11 @@ static int ad9832_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	reg = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(reg))
-		return PTR_ERR(reg);
+	st->avdd = devm_regulator_get(&spi->dev, "avdd");
+	if (IS_ERR(st->avdd))
+		return PTR_ERR(st->avdd);
 
-	ret = regulator_enable(reg);
+	ret = regulator_enable(st->avdd);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
 		return ret;
@@ -225,13 +224,13 @@ static int ad9832_probe(struct spi_device *spi)
 	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
 	if (IS_ERR(st->dvdd)) {
 		ret = PTR_ERR(st->dvdd);
-		goto error_disable_reg;
+		goto error_disable_avdd;
 	}
 
 	ret = regulator_enable(st->dvdd);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to enable specified DVDD supply\n");
-		goto error_disable_reg;
+		goto error_disable_avdd;
 	}
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -241,7 +240,6 @@ static int ad9832_probe(struct spi_device *spi)
 	}
 	spi_set_drvdata(spi, indio_dev);
 	st = iio_priv(indio_dev);
-	st->reg = reg;
 	st->mclk = pdata->mclk;
 	st->spi = spi;
 
@@ -327,8 +325,8 @@ static int ad9832_probe(struct spi_device *spi)
 
 error_disable_dvdd:
 	regulator_disable(st->dvdd);
-error_disable_reg:
-	regulator_disable(reg);
+error_disable_avdd:
+	regulator_disable(st->avdd);
 
 	return ret;
 }
@@ -340,7 +338,7 @@ static int ad9832_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	regulator_disable(st->dvdd);
-	regulator_disable(st->reg);
+	regulator_disable(st->avdd);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
index eb0e7f2..1b08b04 100644
--- a/drivers/staging/iio/frequency/ad9832.h
+++ b/drivers/staging/iio/frequency/ad9832.h
@@ -58,7 +58,7 @@
 /**
  * struct ad9832_state - driver instance specific data
  * @spi:		spi_device
- * @reg:		supply regulator
+ * @avdd:		supply regulator for the analog section
  * @dvdd:		supply regulator for the digital section
  * @mclk:		external master clock
  * @ctrl_fp:		cached frequency/phase control word
@@ -77,7 +77,7 @@
 
 struct ad9832_state {
 	struct spi_device		*spi;
-	struct regulator		*reg;
+	struct regulator		*avdd;
 	struct regulator		*dvdd;
 	unsigned long			mclk;
 	unsigned short			ctrl_fp;
-- 
2.7.4

