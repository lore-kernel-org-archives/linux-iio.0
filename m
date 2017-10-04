Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:54754 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbdJDMIc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Oct 2017 08:08:32 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jonathan Cameron <jic23@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] iio: adc: rcar-gyroadc: Use of_device_get_match_data() helper
Date: Wed,  4 Oct 2017 14:08:26 +0200
Message-Id: <1507118906-8946-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1507118906-8946-1-git-send-email-geert+renesas@glider.be>
References: <1507118906-8946-1-git-send-email-geert+renesas@glider.be>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the of_device_get_match_data() helper instead of open coding.
Note that the rcar-gyroadc driver is used with DT only, so there's
always a valid match.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iio/adc/rcar-gyroadc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 0098c66a19572400..dcb50172186f49ab 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -487,8 +487,6 @@ static int rcar_gyroadc_init_supplies(struct iio_dev *indio_dev)
 
 static int rcar_gyroadc_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-		of_match_device(rcar_gyroadc_match, &pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct rcar_gyroadc *priv;
 	struct iio_dev *indio_dev;
@@ -525,7 +523,8 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->model = (enum rcar_gyroadc_model)of_id->data;
+	priv->model = (enum rcar_gyroadc_model)
+		of_device_get_match_data(&pdev->dev);
 
 	platform_set_drvdata(pdev, indio_dev);
 
-- 
2.7.4

