Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33490 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944928AbcJaRIX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2016 13:08:23 -0400
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 5/6] staging: iio: ad9832: add DVDD regulator
Date: Tue,  1 Nov 2016 01:04:34 +0800
Message-Id: <1477933475-21914-6-git-send-email-eraretuya@gmail.com>
In-Reply-To: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
References: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The AD9832/AD9835 is supplied with two power sources: AVDD as analog
supply voltage and DVDD as digital supply voltage.

Attempt to fetch and enable the regulator 'dvdd'. Bail out if any error
occurs.

Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 33 ++++++++++++++++++++++++---------
 drivers/staging/iio/frequency/ad9832.h |  2 ++
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 7d8dc6c..6a5ab02 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -222,10 +222,22 @@ static int ad9832_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
+	if (IS_ERR(st->dvdd)) {
+		ret = PTR_ERR(st->dvdd);
+		goto error_disable_reg;
+	}
+
+	ret = regulator_enable(st->dvdd);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable specified DVDD supply\n");
+		goto error_disable_reg;
+	}
+
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev) {
 		ret = -ENOMEM;
-		goto error_disable_reg;
+		goto error_disable_dvdd;
 	}
 	spi_set_drvdata(spi, indio_dev);
 	st = iio_priv(indio_dev);
@@ -280,39 +292,41 @@ static int ad9832_probe(struct spi_device *spi)
 	ret = spi_sync(st->spi, &st->msg);
 	if (ret) {
 		dev_err(&spi->dev, "device init failed\n");
-		goto error_disable_reg;
+		goto error_disable_dvdd;
 	}
 
 	ret = ad9832_write_frequency(st, AD9832_FREQ0HM, pdata->freq0);
 	if (ret)
-		goto error_disable_reg;
+		goto error_disable_dvdd;
 
 	ret = ad9832_write_frequency(st, AD9832_FREQ1HM, pdata->freq1);
 	if (ret)
-		goto error_disable_reg;
+		goto error_disable_dvdd;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE0H, pdata->phase0);
 	if (ret)
-		goto error_disable_reg;
+		goto error_disable_dvdd;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE1H, pdata->phase1);
 	if (ret)
-		goto error_disable_reg;
+		goto error_disable_dvdd;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE2H, pdata->phase2);
 	if (ret)
-		goto error_disable_reg;
+		goto error_disable_dvdd;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE3H, pdata->phase3);
 	if (ret)
-		goto error_disable_reg;
+		goto error_disable_dvdd;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_disable_reg;
+		goto error_disable_dvdd;
 
 	return 0;
 
+error_disable_dvdd:
+	regulator_disable(st->dvdd);
 error_disable_reg:
 	regulator_disable(reg);
 
@@ -325,6 +339,7 @@ static int ad9832_remove(struct spi_device *spi)
 	struct ad9832_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
+	regulator_disable(st->dvdd);
 	regulator_disable(st->reg);
 
 	return 0;
diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
index d32323b..eb0e7f2 100644
--- a/drivers/staging/iio/frequency/ad9832.h
+++ b/drivers/staging/iio/frequency/ad9832.h
@@ -59,6 +59,7 @@
  * struct ad9832_state - driver instance specific data
  * @spi:		spi_device
  * @reg:		supply regulator
+ * @dvdd:		supply regulator for the digital section
  * @mclk:		external master clock
  * @ctrl_fp:		cached frequency/phase control word
  * @ctrl_ss:		cached sync/selsrc control word
@@ -77,6 +78,7 @@
 struct ad9832_state {
 	struct spi_device		*spi;
 	struct regulator		*reg;
+	struct regulator		*dvdd;
 	unsigned long			mclk;
 	unsigned short			ctrl_fp;
 	unsigned short			ctrl_ss;
-- 
2.7.4

