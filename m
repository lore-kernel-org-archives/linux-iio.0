Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55437 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeH3TsO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 15:48:14 -0400
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
Subject: [PATCH v3 08/30] iio: adc: remove hwmon structure
Date: Thu, 30 Aug 2018 17:44:56 +0200
Message-Id: <20180830154518.29507-9-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We remove the hwmon structure that was requiered for the mfd driver.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index f787442a9e5f..ab474ce86fb6 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -109,14 +109,6 @@ struct sun4i_gpadc_iio {
 	struct device			*sensor_device;
 };
 
-static struct iio_map sun4i_gpadc_hwmon_maps[] = {
-	{
-		.adc_channel_label = "temp_adc",
-		.consumer_dev_name = "iio_hwmon.0",
-	},
-	{ /* sentinel */ },
-};
-
 static const struct iio_chan_spec sun4i_gpadc_channels[] = {
 	SUN4I_GPADC_ADC_CHANNEL(0, "adc_chan0"),
 	SUN4I_GPADC_ADC_CHANNEL(1, "adc_chan1"),
-- 
2.11.0
