Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37044 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeH3TsM (ORCPT
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
Subject: [PATCH v3 06/30] iio: adc: remove ofnode options
Date: Thu, 30 Aug 2018 17:44:54 +0200
Message-Id: <20180830154518.29507-7-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since we are merging the mfd dirver into the adc driver we don't need
two different probing functions. Thus we remove the ofnode options

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 666329940e1e..d6f00d3b802d 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -622,10 +622,7 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	indio_dev->info = &sun4i_gpadc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (pdev->dev.of_node)
-		ret = sun4i_gpadc_probe_dt(pdev, indio_dev);
-	else
-		ret = sun4i_gpadc_probe_mfd(pdev, indio_dev);
+	ret = sun4i_gpadc_probe_dt(pdev, indio_dev);
 
 	if (ret)
 		return ret;
-- 
2.11.0
