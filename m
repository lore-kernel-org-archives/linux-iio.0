Return-Path: <SRS0=KnI2=5D=linaro.org=benjamin.gaignard@kernel.org>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: 
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] iio: adc: stm32: use devm_of_platform_populate()
Date: Mon, 29 May 2017 17:45:49 +0200
Message-Id: <1496072763-31209-2-git-send-email-benjamin.gaignard@linaro.org>
In-Reply-To: <1496072763-31209-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1496072763-31209-1-git-send-email-benjamin.gaignard@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Use devm_of_platform_populate() instead of of_platform_populate and
of_platform_depopulate to simplify driver code

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

CC: Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>
CC: Lars-Peter Clausen <lars@metafoo.de>
CC: Alexandre Torgue <alexandre.torgue@st.com>
CC: Fabrice Gasnier <fabrice.gasnier@st.com>
CC: linux-iio@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 drivers/iio/adc/stm32-adc-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 22b7c93..46e41dc5 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -186,7 +186,6 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
 static int stm32_adc_probe(struct platform_device *pdev)
 {
 	struct stm32_adc_priv *priv;
-	struct device_node *np = pdev->dev.of_node;
 	struct resource *res;
 	int ret;
 
@@ -249,7 +248,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, &priv->common);
 
-	ret = of_platform_populate(np, NULL, NULL, &pdev->dev);
+	ret = devm_of_platform_populate(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to populate DT children\n");
 		goto err_irq_remove;
@@ -274,7 +273,6 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	struct stm32_adc_common *common = platform_get_drvdata(pdev);
 	struct stm32_adc_priv *priv = to_stm32_adc_priv(common);
 
-	of_platform_depopulate(&pdev->dev);
 	stm32_adc_irq_remove(pdev, priv);
 	clk_disable_unprepare(priv->aclk);
 	regulator_disable(priv->vref);
-- 
1.9.1
