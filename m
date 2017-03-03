Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34217 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdCCVOP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Mar 2017 16:14:15 -0500
Received: by mail-wm0-f68.google.com with SMTP id m70so4921774wma.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Mar 2017 13:14:14 -0800 (PST)
To: Jonathan Cameron <jic23@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-iio@vger.kernel.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] iio: adc: meson-saradc: add calibration for meson gxbb
Message-ID: <84a7d692-53a8-91ad-b347-9be936924f8f@gmail.com>
Date: Fri, 3 Mar 2017 22:13:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The calibration on Meson GXBB is different from the one on GXM/GXL.
This patch only supports GXBB as I don't have other spec and test hw.
Points 25% vref and 75% vref are used for calibration.

Adding a calibration scale resulted in no improvement, therefore
only a simple calibration bias is supported.

Successfully tested on a Odroid C2.  Calibbias is 8 on my system.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/iio/adc/meson_saradc.c | 56 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 23710088..276375c7 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -173,7 +173,8 @@
 	.channel = _chan,						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
 				BIT(IIO_CHAN_INFO_AVERAGE_RAW),		\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+				BIT(IIO_CHAN_INFO_CALIBBIAS),		\
 	.datasheet_name = "SAR_ADC_CH"#_chan,				\
 }
 
@@ -233,6 +234,7 @@ struct meson_sar_adc_priv {
 	struct clk				*adc_div_clk;
 	struct clk_divider			clk_div;
 	struct completion			done;
+	int					calibbias;
 };
 
 static const struct regmap_config meson_sar_adc_regmap_config = {
@@ -252,6 +254,14 @@ static unsigned int meson_sar_adc_get_fifo_count(struct iio_dev *indio_dev)
 	return FIELD_GET(MESON_SAR_ADC_REG0_FIFO_COUNT_MASK, regval);
 }
 
+static int meson_sar_adc_calib_val(struct iio_dev *indio_dev, int val)
+{
+	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+
+	return clamp(val + priv->calibbias, 0,
+		     (1 << priv->data->resolution) - 1);
+}
+
 static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
@@ -303,7 +313,7 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 	fifo_val = FIELD_GET(MESON_SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK,
 			     regval);
 	fifo_val &= GENMASK(priv->data->resolution - 1, 0);
-	*val = fifo_val;
+	*val = meson_sar_adc_calib_val(indio_dev, fifo_val);
 
 	return 0;
 }
@@ -529,6 +539,10 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
 		*val2 = priv->data->resolution;
 		return IIO_VAL_FRACTIONAL_LOG2;
 
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*val = priv->calibbias;
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
@@ -754,6 +768,38 @@ static irqreturn_t meson_sar_adc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int meson_sar_adc_calib_gxbb(struct iio_dev *indio_dev)
+{
+	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+	int ret, act0, act1, set0, set1;
+
+	/* use points 25% and 75% for calibration */
+	set0 = (1 << priv->data->resolution) / 4;
+	set1 = (1 << priv->data->resolution) * 3 / 4;
+
+	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_DIV4);
+	ret = meson_sar_adc_get_sample(indio_dev,
+				       &meson_sar_adc_iio_channels[7],
+				       MEAN_AVERAGING, EIGHT_SAMPLES, &act0);
+	if (ret < 0)
+		goto out;
+
+	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_MUL3_DIV4);
+	ret = meson_sar_adc_get_sample(indio_dev,
+				       &meson_sar_adc_iio_channels[7],
+				       MEAN_AVERAGING, EIGHT_SAMPLES, &act1);
+	if (ret < 0)
+		goto out;
+
+	priv->calibbias = (set0 + set1 - act0 - act1) / 2;
+
+	ret = 0;
+out:
+	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_CH7_INPUT);
+
+	return ret;
+}
+
 static const struct iio_info meson_sar_adc_iio_info = {
 	.read_raw = meson_sar_adc_iio_info_read_raw,
 	.driver_module = THIS_MODULE,
@@ -901,6 +952,12 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
+	if (priv->data == &meson_sar_adc_gxbb_data) {
+		ret = meson_sar_adc_calib_gxbb(indio_dev);
+		if (ret)
+			goto err_hw;
+	}
+
 	platform_set_drvdata(pdev, indio_dev);
 
 	ret = iio_device_register(indio_dev);
-- 
2.12.0

