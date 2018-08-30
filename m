Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38741 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbeH3TsK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 15:48:10 -0400
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
Subject: [PATCH v3 03/30] iio: adc: Remove ID table
Date: Thu, 30 Aug 2018 17:44:51 +0200
Message-Id: <20180830154518.29507-4-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

To disable the driver we are removing the compatibles.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 04d7147e0110..d95dd0fde2a6 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -698,21 +698,12 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct platform_device_id sun4i_gpadc_id[] = {
-	{ "sun4i-a10-gpadc-iio", (kernel_ulong_t)&sun4i_gpadc_data },
-	{ "sun5i-a13-gpadc-iio", (kernel_ulong_t)&sun5i_gpadc_data },
-	{ "sun6i-a31-gpadc-iio", (kernel_ulong_t)&sun6i_gpadc_data },
-	{ /* sentinel */ },
-};
-MODULE_DEVICE_TABLE(platform, sun4i_gpadc_id);
-
 static struct platform_driver sun4i_gpadc_driver = {
 	.driver = {
 		.name = "sun4i-gpadc-iio",
 		.of_match_table = sun4i_gpadc_of_id,
 		.pm = &sun4i_gpadc_pm_ops,
 	},
-	.id_table = sun4i_gpadc_id,
 	.probe = sun4i_gpadc_probe,
 	.remove = sun4i_gpadc_remove,
 };
-- 
2.11.0
