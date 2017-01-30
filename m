Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:53102 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbdA3Er3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2017 23:47:29 -0500
From: Shailendra Verma <shailendra.v@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.shailesh@samsung.com, ashish.kalra@samsung.com,
        Shailendra Verma <shailendra.v@samsung.com>,
        Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] iio: adc - Fix possible NULL derefrence.
Date: Mon, 30 Jan 2017 10:17:14 +0530
Message-id: <1485751634-28963-1-git-send-email-shailendra.v@samsung.com>
References: <CGME20170130044724epcas3p444b23d43fed213511e6994ecb4ed0ef3@epcas3p4.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

of_match_device could return NULL, and so can cause a NULL
pointer dereference later.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 drivers/iio/adc/mxs-lradc.c       |   14 ++++++++++----
 drivers/iio/adc/rockchip_saradc.c |    4 ++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
index b84d37c..4308a59 100644
--- a/drivers/iio/adc/mxs-lradc.c
+++ b/drivers/iio/adc/mxs-lradc.c
@@ -1570,10 +1570,8 @@ static int mxs_lradc_probe_touchscreen(struct mxs_lradc *lradc,
 
 static int mxs_lradc_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-		of_match_device(mxs_lradc_dt_ids, &pdev->dev);
-	const struct mxs_lradc_of_config *of_cfg =
-		&mxs_lradc_of_config[(enum mxs_lradc_id)of_id->data];
+	const struct of_device_id *of_id;
+	const struct mxs_lradc_of_config *of_cfg;
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct mxs_lradc *lradc;
@@ -1583,6 +1581,14 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	int i, s;
 	u64 scale_uv;
 
+	of_id = of_match_device(mxs_lradc_dt_ids, &pdev->dev);
+	if (!of_id) {
+		dev_err(&pdev->dev, "Error: No device match found\n");
+		return -ENODEV;
+	}
+
+	of_cfg = &mxs_lradc_of_config[(enum mxs_lradc_id)of_id->data];
+
 	/* Allocate the IIO device. */
 	iio = devm_iio_device_alloc(dev, sizeof(*lradc));
 	if (!iio) {
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 85d7012..08dfb43 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -224,6 +224,10 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	info = iio_priv(indio_dev);
 
 	match = of_match_device(rockchip_saradc_match, &pdev->dev);
+	if (!match) {
+		dev_err(&pdev->dev, "Error: No device match found\n");
+		return -ENODEV;
+	}
 	info->data = match->data;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.7.9.5

