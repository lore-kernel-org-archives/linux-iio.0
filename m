Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34564 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbdBNV7E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Feb 2017 16:59:04 -0500
Received: by mail-wr0-f196.google.com with SMTP id c4so3633999wrd.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Feb 2017 13:59:03 -0800 (PST)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/2] iio: adc: meson-saradc: improve
 meson_sar_adc_read_raw_sample
To: Jonathan Cameron <jic23@kernel.org>
References: <eae2ac11-867f-d471-7430-963906746d29@gmail.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Message-ID: <3419d25d-cecc-0e00-9c60-578553221784@gmail.com>
Date: Tue, 14 Feb 2017 22:58:52 +0100
MIME-Version: 1.0
In-Reply-To: <eae2ac11-867f-d471-7430-963906746d29@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

After sampling there should always be only one value in the FIFO.
This also applies to averaging mode as the averaging is done
chip-internally. So we don't have to loop and let the driver
complain if there's not exactly one value in the FIFO.

If the value belongs to a different channel then don't silently
swallow the value but complain.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/iio/adc/meson_saradc.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index dbd56bcc..d39711c0 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -278,33 +278,31 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 					 int *val)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
-	int regval, fifo_chan, fifo_val, sum = 0, count = 0;
+	int regval, fifo_chan, fifo_val, count;
 
 	if(!wait_for_completion_timeout(&priv->done,
 				msecs_to_jiffies(MESON_SAR_ADC_TIMEOUT)))
 		return -ETIMEDOUT;
 
-	while (meson_sar_adc_get_fifo_count(indio_dev) > 0 &&
-	       count < MESON_SAR_ADC_MAX_FIFO_SIZE) {
-		regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
-
-		fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK,
-				      regval);
-		if (fifo_chan != chan->channel)
-			continue;
-
-		fifo_val = FIELD_GET(MESON_SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK,
-				     regval);
-		fifo_val &= (BIT(priv->data->resolution) - 1);
-
-		sum += fifo_val;
-		count++;
+	count = meson_sar_adc_get_fifo_count(indio_dev);
+	if (count != 1) {
+		dev_err(&indio_dev->dev,
+			"ADC FIFO has %d elements instead of one\n", count);
+		return -EINVAL;
 	}
 
-	if (!count)
-		return -ENOENT;
+	regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
+	fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK, regval);
+	if (fifo_chan != chan->channel) {
+		dev_err(&indio_dev->dev,
+			"ADC FIFO entry belongs to channel %d instead of %d\n",
+			fifo_chan, chan->channel);
+		return -EINVAL;
+	}
 
-	*val = sum / count;
+	fifo_val = FIELD_GET(MESON_SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK, regval);
+	fifo_val &= GENMASK(priv->data->resolution - 1, 0);
+	*val = fifo_val;
 
 	return 0;
 }
-- 
2.11.1


