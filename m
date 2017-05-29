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
Subject: [PATCH 02/15] iio: dac: stm32: use devm_of_platform_populate()
Date: Mon, 29 May 2017 17:45:50 +0200
Message-Id: <1496072763-31209-3-git-send-email-benjamin.gaignard@linaro.org>
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
 drivers/iio/dac/stm32-dac-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
index 75e4878..9c42537 100644
--- a/drivers/iio/dac/stm32-dac-core.c
+++ b/drivers/iio/dac/stm32-dac-core.c
@@ -130,7 +130,7 @@ static int stm32_dac_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, &priv->common);
 
-	ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, dev);
+	ret = devm_of_platform_populate(&pdev->dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to populate DT children\n");
 		goto err_pclk;
@@ -151,7 +151,6 @@ static int stm32_dac_remove(struct platform_device *pdev)
 	struct stm32_dac_common *common = platform_get_drvdata(pdev);
 	struct stm32_dac_priv *priv = to_stm32_dac_priv(common);
 
-	of_platform_depopulate(&pdev->dev);
 	clk_disable_unprepare(priv->pclk);
 	regulator_disable(priv->vref);
 
-- 
1.9.1
