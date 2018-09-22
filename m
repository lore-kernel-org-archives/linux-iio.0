Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33935 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbeIWEQV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Sep 2018 00:16:21 -0400
Received: by mail-wr1-f66.google.com with SMTP id t15so8188975wrx.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Sep 2018 15:21:13 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/3] iio: adc: meson-saradc: use of_device_get_match_data
Date: Sun, 23 Sep 2018 00:21:01 +0200
Message-Id: <20180922222102.12023-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20180922222102.12023-1-martin.blumenstingl@googlemail.com>
References: <20180922222102.12023-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This simplifies our _probe function by using of_device_get_match_data
instead of open-coding it. No functional changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index b97b06bf7713..9d8f2139debc 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -978,11 +978,11 @@ MODULE_DEVICE_TABLE(of, meson_sar_adc_of_match);
 
 static int meson_sar_adc_probe(struct platform_device *pdev)
 {
+	const struct meson_sar_adc_data *match_data;
 	struct meson_sar_adc_priv *priv;
 	struct iio_dev *indio_dev;
 	struct resource *res;
 	void __iomem *base;
-	const struct of_device_id *match;
 	int irq, ret;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
@@ -994,13 +994,13 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	priv = iio_priv(indio_dev);
 	init_completion(&priv->done);
 
-	match = of_match_device(meson_sar_adc_of_match, &pdev->dev);
-	if (!match) {
-		dev_err(&pdev->dev, "failed to match device\n");
+	match_data = of_device_get_match_data(&pdev->dev);
+	if (!match_data) {
+		dev_err(&pdev->dev, "failed to get match data\n");
 		return -ENODEV;
 	}
 
-	priv->data = match->data;
+	priv->data = match_data;
 
 	indio_dev->name = priv->data->name;
 	indio_dev->dev.parent = &pdev->dev;
-- 
2.19.0
