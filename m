Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34940 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944909AbcJaRIH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2016 13:08:07 -0400
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 2/6] staging: iio: rework regulator handling
Date: Tue,  1 Nov 2016 01:04:31 +0800
Message-Id: <1477933475-21914-3-git-send-email-eraretuya@gmail.com>
In-Reply-To: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
References: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently, the affected drivers ignore all errors from regulator_get().
The way it is now, it also breaks probe deferral (EPROBE_DEFER). The
correct behavior is to propagate the error to the upper layers so they
can handle it accordingly.

Rework the regulator handling so that it matches the standard behavior.
If the specific design uses a static always-on regulator and does not
explicitly specify it, regulator_get() will return the dummy regulator.

The following semantic patch was used to apply the change:
@r1@
expression reg, dev, en, volt;
@@

reg = \(devm_regulator_get\|regulator_get\)(dev, ...);
if (
- !
   IS_ERR(reg))
+	return PTR_ERR(reg);
(
- {	en = regulator_enable(reg);
-	if (en) return en; }
+
+	en = regulator_enable(reg);
+	if (en) {
+		dev_err(dev, "Failed to enable specified supply\n");
+		return en; }
|
+
- {	en = regulator_enable(reg);
-	if (en)	return en;
-	volt = regulator_get_voltage(reg); }
+	en = regulator_enable(reg);
+	if (en) {
+		dev_err(dev, "Failed to enable specified supply\n");
+		return en;
+	}
+	volt = regulator_get_voltage(reg);
)

@r2@
expression arg;
@@

-	if (!IS_ERR(arg)) regulator_disable(arg);
+	regulator_disable(arg);

Hand-edit the debugging prints with the supply name to become more
specific.

Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c                | 18 +++++++++---------
 drivers/staging/iio/adc/ad7780.c                | 18 +++++++++---------
 drivers/staging/iio/frequency/ad9832.c          | 17 +++++++++--------
 drivers/staging/iio/frequency/ad9834.c          | 17 +++++++++--------
 drivers/staging/iio/impedance-analyzer/ad5933.c | 19 ++++++++++---------
 5 files changed, 46 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 41fb32d..29e32b7 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -634,13 +634,15 @@ static int ad7192_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 
 	st->reg = devm_regulator_get(&spi->dev, "avdd");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
+	if (IS_ERR(st->reg))
+		return PTR_ERR(st->reg);
 
-		voltage_uv = regulator_get_voltage(st->reg);
+	ret = regulator_enable(st->reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
+		return ret;
 	}
+	voltage_uv = regulator_get_voltage(st->reg);
 
 	if (pdata->vref_mv)
 		st->int_vref_mv = pdata->vref_mv;
@@ -689,8 +691,7 @@ static int ad7192_probe(struct spi_device *spi)
 error_remove_trigger:
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 error_disable_reg:
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
+	regulator_disable(st->reg);
 
 	return ret;
 }
@@ -703,8 +704,7 @@ static int ad7192_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
+	regulator_disable(st->reg);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index a88236e..e149600 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -174,13 +174,15 @@ static int ad7780_probe(struct spi_device *spi)
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
 
 	st->reg = devm_regulator_get(&spi->dev, "avdd");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
+	if (IS_ERR(st->reg))
+		return PTR_ERR(st->reg);
 
-		voltage_uv = regulator_get_voltage(st->reg);
+	ret = regulator_enable(st->reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
+		return ret;
 	}
+	voltage_uv = regulator_get_voltage(st->reg);
 
 	st->chip_info =
 		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
@@ -222,8 +224,7 @@ static int ad7780_probe(struct spi_device *spi)
 error_cleanup_buffer_and_trigger:
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 error_disable_reg:
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
+	regulator_disable(st->reg);
 
 	return ret;
 }
@@ -236,8 +237,7 @@ static int ad7780_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
+	regulator_disable(st->reg);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 744c8ee..7d8dc6c 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -213,10 +213,13 @@ static int ad9832_probe(struct spi_device *spi)
 	}
 
 	reg = devm_regulator_get(&spi->dev, "avdd");
-	if (!IS_ERR(reg)) {
-		ret = regulator_enable(reg);
-		if (ret)
-			return ret;
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	ret = regulator_enable(reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
+		return ret;
 	}
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -311,8 +314,7 @@ static int ad9832_probe(struct spi_device *spi)
 	return 0;
 
 error_disable_reg:
-	if (!IS_ERR(reg))
-		regulator_disable(reg);
+	regulator_disable(reg);
 
 	return ret;
 }
@@ -323,8 +325,7 @@ static int ad9832_remove(struct spi_device *spi)
 	struct ad9832_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
+	regulator_disable(st->reg);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index ca3cea6..19216af 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -330,10 +330,13 @@ static int ad9834_probe(struct spi_device *spi)
 	}
 
 	reg = devm_regulator_get(&spi->dev, "avdd");
-	if (!IS_ERR(reg)) {
-		ret = regulator_enable(reg);
-		if (ret)
-			return ret;
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	ret = regulator_enable(reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
+		return ret;
 	}
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -416,8 +419,7 @@ static int ad9834_probe(struct spi_device *spi)
 	return 0;
 
 error_disable_reg:
-	if (!IS_ERR(reg))
-		regulator_disable(reg);
+	regulator_disable(reg);
 
 	return ret;
 }
@@ -428,8 +430,7 @@ static int ad9834_remove(struct spi_device *spi)
 	struct ad9834_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
+	regulator_disable(st->reg);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 62f61bc..8f2736a 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -724,12 +724,15 @@ static int ad5933_probe(struct i2c_client *client,
 		pdata = &ad5933_default_pdata;
 
 	st->reg = devm_regulator_get(&client->dev, "vdd");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-		voltage_uv = regulator_get_voltage(st->reg);
+	if (IS_ERR(st->reg))
+		return PTR_ERR(st->reg);
+
+	ret = regulator_enable(st->reg);
+	if (ret) {
+		dev_err(&client->dev, "Failed to enable specified VDD supply\n");
+		return ret;
 	}
+	voltage_uv = regulator_get_voltage(st->reg);
 
 	if (voltage_uv)
 		st->vref_mv = voltage_uv / 1000;
@@ -772,8 +775,7 @@ static int ad5933_probe(struct i2c_client *client,
 error_unreg_ring:
 	iio_kfifo_free(indio_dev->buffer);
 error_disable_reg:
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
+	regulator_disable(st->reg);
 
 	return ret;
 }
@@ -785,8 +787,7 @@ static int ad5933_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 	iio_kfifo_free(indio_dev->buffer);
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
+	regulator_disable(st->reg);
 
 	return 0;
 }
-- 
2.7.4

