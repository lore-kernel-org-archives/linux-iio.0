Return-Path: <SRS0=9t7F=5D=gmail.com=arvind.yadav.cs@kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: Aspeed ADC - Handle return value of clk_prepare_enable
Date: Mon, 29 May 2017 13:12:12 +0530
Message-Id: <4d7cbfdca6b7e89a312a08dad6c49b3289299bd8.1496041572.git.arvind.yadav.cs@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/iio/adc/aspeed_adc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 62670cb..e0ea411 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -212,7 +212,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	}
 
 	/* Start all channels in normal mode. */
-	clk_prepare_enable(data->clk_scaler->clk);
+	ret = clk_prepare_enable(data->clk_scaler->clk);
+	if (ret)
+		goto clk_enable_error;
+
 	adc_engine_control_reg_val = GENMASK(31, 16) |
 		ASPEED_OPERATION_MODE_NORMAL | ASPEED_ENGINE_ENABLE;
 	writel(adc_engine_control_reg_val,
@@ -236,6 +239,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	writel(ASPEED_OPERATION_MODE_POWER_DOWN,
 		data->base + ASPEED_REG_ENGINE_CONTROL);
 	clk_disable_unprepare(data->clk_scaler->clk);
+clk_enable_error:
 	clk_hw_unregister_divider(data->clk_scaler);
 
 scaler_error:
-- 
1.9.1
