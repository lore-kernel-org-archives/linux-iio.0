Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43347 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeH3TsP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 15:48:15 -0400
From: Philipp Rossak <embed3d@gmail.com>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 09/30] iio: adc: Threat A33 as thermal sensor and remove non thermal sun4i channel
Date: Thu, 30 Aug 2018 17:44:57 +0200
Message-Id: <20180830154518.29507-10-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We want to use this driver mostly as thermal sensor, that still supports
the adc for the older chips, thus we threat the A33 as thermal sensor.
We also remove the adc channel without thermal support.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index ab474ce86fb6..658a7e3e3370 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -123,23 +123,6 @@ static const struct iio_chan_spec sun4i_gpadc_channels[] = {
 	},
 };
 
-static const struct iio_chan_spec sun4i_gpadc_channels_no_temp[] = {
-	SUN4I_GPADC_ADC_CHANNEL(0, "adc_chan0"),
-	SUN4I_GPADC_ADC_CHANNEL(1, "adc_chan1"),
-	SUN4I_GPADC_ADC_CHANNEL(2, "adc_chan2"),
-	SUN4I_GPADC_ADC_CHANNEL(3, "adc_chan3"),
-};
-
-static const struct iio_chan_spec sun8i_a33_gpadc_channels[] = {
-	{
-		.type = IIO_TEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SCALE) |
-				      BIT(IIO_CHAN_INFO_OFFSET),
-		.datasheet_name = "temp_adc",
-	},
-};
-
 static const struct regmap_config sun4i_gpadc_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
@@ -444,8 +427,6 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 		return -ENODEV;
 
 	info->no_irq = true;
-	indio_dev->num_channels = ARRAY_SIZE(sun8i_a33_gpadc_channels);
-	indio_dev->channels = sun8i_a33_gpadc_channels;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, mem);
-- 
2.11.0
