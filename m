Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36115 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeH3TsM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 15:48:12 -0400
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
Subject: [PATCH v3 05/30] iio: adc: move SUN4I_GPADC_CHANNEL define to header file
Date: Thu, 30 Aug 2018 17:44:53 +0200
Message-Id: <20180830154518.29507-6-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We are moving the SUN4I_GPADC_CHANNEL define to the header file.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 9 ---------
 include/linux/mfd/sun4i-gpadc.h   | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index d95dd0fde2a6..666329940e1e 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -109,15 +109,6 @@ struct sun4i_gpadc_iio {
 	struct device			*sensor_device;
 };
 
-#define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
-	.type = IIO_VOLTAGE,					\
-	.indexed = 1,						\
-	.channel = _channel,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
-	.datasheet_name = _name,				\
-}
-
 static struct iio_map sun4i_gpadc_hwmon_maps[] = {
 	{
 		.adc_channel_label = "temp_adc",
diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index 139872c2e0fe..54c7c9375c1b 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -90,6 +90,15 @@
 /* 10s delay before suspending the IP */
 #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
 
+#define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = _channel,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.datasheet_name = _name,				\
+}
+
 struct sun4i_gpadc_dev {
 	struct device			*dev;
 	struct regmap			*regmap;
-- 
2.11.0
