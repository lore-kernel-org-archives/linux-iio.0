Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:56927 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755156AbbGYWnl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 25 Jul 2015 18:43:41 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH 8/8] iio:adc:berlin2-adc: coding style cleanup
Date: Sun, 26 Jul 2015 00:43:26 +0200
Message-Id: <35296c32a78d86aa36f71c3e03fa39a1d9ca9e6d.1437862404.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437862404.git.knaack.h@gmx.de>
References: <cover.1437862404.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437862404.git.knaack.h@gmx.de>
References: <cover.1437862404.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some adjustment of indentation to make checkpatch.pl happy in strict mode.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/adc/berlin2-adc.c | 64 +++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index 3621ee9f5032..73d625313388 100644
--- a/drivers/iio/adc/berlin2-adc.c
+++ b/drivers/iio/adc/berlin2-adc.c
@@ -78,13 +78,13 @@ struct berlin2_adc_priv {
 };
 
 #define BERLIN2_ADC_CHANNEL(n, t)					\
-		{							\
-			.channel	= n,				\
-			.datasheet_name	= "channel"#n,			\
-			.type		= t,				\
-			.indexed	= 1,				\
-			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-		}
+	{								\
+		.channel		= n,				\
+		.datasheet_name		= "channel"#n,			\
+		.type			= t,				\
+		.indexed		= 1,				\
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW),	\
+	}
 
 static const struct iio_chan_spec berlin2_adc_channels[] = {
 	BERLIN2_ADC_CHANNEL(0, IIO_VOLTAGE),	/* external input */
@@ -117,16 +117,18 @@ static int berlin2_adc_read(struct iio_dev *indio_dev, int channel)
 
 	/* Configure the ADC */
 	regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
-			BERLIN2_SM_CTRL_ADC_RESET | BERLIN2_SM_CTRL_ADC_SEL_MASK
-			| BERLIN2_SM_CTRL_ADC_START,
-			BERLIN2_SM_CTRL_ADC_SEL(channel) | BERLIN2_SM_CTRL_ADC_START);
+			   BERLIN2_SM_CTRL_ADC_RESET |
+			   BERLIN2_SM_CTRL_ADC_SEL_MASK |
+			   BERLIN2_SM_CTRL_ADC_START,
+			   BERLIN2_SM_CTRL_ADC_SEL(channel) |
+			   BERLIN2_SM_CTRL_ADC_START);
 
 	ret = wait_event_interruptible_timeout(priv->wq, priv->data_available,
-			msecs_to_jiffies(1000));
+					       msecs_to_jiffies(1000));
 
 	/* Disable the interrupts */
 	regmap_update_bits(priv->regmap, BERLIN2_SM_ADC_STATUS,
-			BERLIN2_SM_ADC_STATUS_INT_EN(channel), 0);
+			   BERLIN2_SM_ADC_STATUS_INT_EN(channel), 0);
 
 	if (ret == 0)
 		ret = -ETIMEDOUT;
@@ -136,7 +138,7 @@ static int berlin2_adc_read(struct iio_dev *indio_dev, int channel)
 	}
 
 	regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
-			BERLIN2_SM_CTRL_ADC_START, 0);
+			   BERLIN2_SM_CTRL_ADC_START, 0);
 
 	data = priv->data;
 	priv->data_available = false;
@@ -159,22 +161,25 @@ static int berlin2_adc_tsen_read(struct iio_dev *indio_dev)
 
 	/* Configure the ADC */
 	regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
-			BERLIN2_SM_CTRL_TSEN_RESET | BERLIN2_SM_CTRL_ADC_ROTATE,
-			BERLIN2_SM_CTRL_ADC_ROTATE);
+			   BERLIN2_SM_CTRL_TSEN_RESET |
+			   BERLIN2_SM_CTRL_ADC_ROTATE,
+			   BERLIN2_SM_CTRL_ADC_ROTATE);
 
 	/* Configure the temperature sensor */
 	regmap_update_bits(priv->regmap, BERLIN2_SM_TSEN_CTRL,
-			BERLIN2_SM_TSEN_CTRL_TRIM_MASK | BERLIN2_SM_TSEN_CTRL_SETTLING_MASK
-			| BERLIN2_SM_TSEN_CTRL_START,
-			BERLIN2_SM_TSEN_CTRL_TRIM(3) | BERLIN2_SM_TSEN_CTRL_SETTLING_12
-			| BERLIN2_SM_TSEN_CTRL_START);
+			   BERLIN2_SM_TSEN_CTRL_TRIM_MASK |
+			   BERLIN2_SM_TSEN_CTRL_SETTLING_MASK |
+			   BERLIN2_SM_TSEN_CTRL_START,
+			   BERLIN2_SM_TSEN_CTRL_TRIM(3) |
+			   BERLIN2_SM_TSEN_CTRL_SETTLING_12 |
+			   BERLIN2_SM_TSEN_CTRL_START);
 
 	ret = wait_event_interruptible_timeout(priv->wq, priv->data_available,
-			msecs_to_jiffies(1000));
+					       msecs_to_jiffies(1000));
 
 	/* Disable interrupts */
 	regmap_update_bits(priv->regmap, BERLIN2_SM_TSEN_STATUS,
-			BERLIN2_SM_TSEN_STATUS_INT_EN, 0);
+			   BERLIN2_SM_TSEN_STATUS_INT_EN, 0);
 
 	if (ret == 0)
 		ret = -ETIMEDOUT;
@@ -184,7 +189,7 @@ static int berlin2_adc_tsen_read(struct iio_dev *indio_dev)
 	}
 
 	regmap_update_bits(priv->regmap, BERLIN2_SM_TSEN_CTRL,
-			BERLIN2_SM_TSEN_CTRL_START, 0);
+			   BERLIN2_SM_TSEN_CTRL_START, 0);
 
 	data = priv->data;
 	priv->data_available = false;
@@ -195,8 +200,8 @@ static int berlin2_adc_tsen_read(struct iio_dev *indio_dev)
 }
 
 static int berlin2_adc_read_raw(struct iio_dev *indio_dev,
-		struct iio_chan_spec const *chan, int *val, int *val2,
-		long mask)
+				struct iio_chan_spec const *chan, int *val,
+				int *val2, long mask)
 {
 	int temp;
 
@@ -305,12 +310,12 @@ static int berlin2_adc_probe(struct platform_device *pdev)
 		return tsen_irq;
 
 	ret = devm_request_irq(&pdev->dev, irq, berlin2_adc_irq, 0,
-			pdev->dev.driver->name, indio_dev);
+			       pdev->dev.driver->name, indio_dev);
 	if (ret)
 		return ret;
 
 	ret = devm_request_irq(&pdev->dev, tsen_irq, berlin2_adc_tsen_irq,
-			0, pdev->dev.driver->name, indio_dev);
+			       0, pdev->dev.driver->name, indio_dev);
 	if (ret)
 		return ret;
 
@@ -327,13 +332,14 @@ static int berlin2_adc_probe(struct platform_device *pdev)
 
 	/* Power up the ADC */
 	regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
-			BERLIN2_SM_CTRL_ADC_POWER, BERLIN2_SM_CTRL_ADC_POWER);
+			   BERLIN2_SM_CTRL_ADC_POWER,
+			   BERLIN2_SM_CTRL_ADC_POWER);
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		/* Power down the ADC */
 		regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
-				BERLIN2_SM_CTRL_ADC_POWER, 0);
+				   BERLIN2_SM_CTRL_ADC_POWER, 0);
 		return ret;
 	}
 
@@ -349,7 +355,7 @@ static int berlin2_adc_remove(struct platform_device *pdev)
 
 	/* Power down the ADC */
 	regmap_update_bits(priv->regmap, BERLIN2_SM_CTRL,
-			BERLIN2_SM_CTRL_ADC_POWER, 0);
+			   BERLIN2_SM_CTRL_ADC_POWER, 0);
 
 	return 0;
 }
-- 
2.4.3

