Return-Path: <SRS0=Nowh=34=gmail.com=marek.vasut@kernel.org>
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: adc: Derive interface clock speed from fck clock
Date: Thu, 20 Apr 2017 17:43:10 +0200
Message-Id: <20170420154310.32759-1-marek.vasut+renesas@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The "if" interface clock speed is actually derived from the "fck"
block clock, as in the hardware they are the same clock. Drop the
incorrect second "if" clock and get the clock speed from "fck".

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/iio/adc/rcar-gyroadc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 018ed360e717..27a318164619 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -73,7 +73,7 @@ enum rcar_gyroadc_model {
 struct rcar_gyroadc {
 	struct device			*dev;
 	void __iomem			*regs;
-	struct clk			*iclk;
+	struct clk			*clk;
 	struct regulator		*vref[8];
 	unsigned int			num_channels;
 	enum rcar_gyroadc_model		model;
@@ -83,7 +83,7 @@ struct rcar_gyroadc {
 
 static void rcar_gyroadc_hw_init(struct rcar_gyroadc *priv)
 {
-	const unsigned long clk_mhz = clk_get_rate(priv->iclk) / 1000000;
+	const unsigned long clk_mhz = clk_get_rate(priv->clk) / 1000000;
 	const unsigned long clk_mul =
 		(priv->mode == RCAR_GYROADC_MODE_SELECT_1_MB88101A) ? 10 : 5;
 	unsigned long clk_len = clk_mhz * clk_mul;
@@ -510,9 +510,9 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->regs))
 		return PTR_ERR(priv->regs);
 
-	priv->iclk = devm_clk_get(dev, "if");
-	if (IS_ERR(priv->iclk)) {
-		ret = PTR_ERR(priv->iclk);
+	priv->clk = devm_clk_get(dev, "fck");
+	if (IS_ERR(priv->clk)) {
+		ret = PTR_ERR(priv->clk);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Failed to get IF clock (ret=%i)\n", ret);
 		return ret;
@@ -536,7 +536,7 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
 	indio_dev->info = &rcar_gyroadc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = clk_prepare_enable(priv->iclk);
+	ret = clk_prepare_enable(priv->clk);
 	if (ret) {
 		dev_err(dev, "Could not prepare or enable the IF clock.\n");
 		goto err_clk_if_enable;
@@ -565,7 +565,7 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-	clk_disable_unprepare(priv->iclk);
+	clk_disable_unprepare(priv->clk);
 err_clk_if_enable:
 	rcar_gyroadc_deinit_supplies(indio_dev);
 
@@ -584,7 +584,7 @@ static int rcar_gyroadc_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-	clk_disable_unprepare(priv->iclk);
+	clk_disable_unprepare(priv->clk);
 	rcar_gyroadc_deinit_supplies(indio_dev);
 
 	return 0;
-- 
2.11.0
