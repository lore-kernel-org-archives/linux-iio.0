Return-Path: <SRS0=POww=4Z=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH 4/5] iio: adc: stm32: make per instance bus clock optional
Date: Fri, 19 May 2017 14:45:27 +0200
Message-ID: <1495197928-1439-5-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1495197928-1439-1-git-send-email-fabrice.gasnier@st.com>
References: <1495197928-1439-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

STM32F4 requires one clock per ADC instance for register access. But,
newer version of ADC hardware block have common bus clock for all
instances (per instance driver isn't responsible for getting it).
So, make it optional by default. Still, enforce it's required on STM32F4.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 065189a..ad8fdb9 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -160,6 +160,7 @@ struct stm32_adc_regspec {
  * @regs:		registers descriptions
  * @adc_info:		per instance input channels definitions
  * @trigs:		external trigger sources
+ * @clk_required:	clock is required
  * @start_conv:		routine to start conversions
  * @stop_conv:		routine to stop conversions
  */
@@ -167,6 +168,7 @@ struct stm32_adc_cfg {
 	const struct stm32_adc_regspec	*regs;
 	const struct stm32_adc_info	*adc_info;
 	struct stm32_adc_trig_info	*trigs;
+	bool clk_required;
 	void (*start_conv)(struct stm32_adc *, bool dma);
 	void (*stop_conv)(struct stm32_adc *);
 };
@@ -1142,14 +1144,21 @@ static int stm32_adc_probe(struct platform_device *pdev)
 
 	adc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(adc->clk)) {
-		dev_err(&pdev->dev, "Can't get clock\n");
-		return PTR_ERR(adc->clk);
+		ret = PTR_ERR(adc->clk);
+		if (ret == -ENOENT && !adc->cfg->clk_required) {
+			adc->clk = NULL;
+		} else {
+			dev_err(&pdev->dev, "Can't get clock\n");
+			return ret;
+		}
 	}
 
-	ret = clk_prepare_enable(adc->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "clk enable failed\n");
-		return ret;
+	if (adc->clk) {
+		ret = clk_prepare_enable(adc->clk);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "clk enable failed\n");
+			return ret;
+		}
 	}
 
 	ret = stm32_adc_of_get_resolution(indio_dev);
@@ -1193,7 +1202,8 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		dma_release_channel(adc->dma_chan);
 	}
 err_clk_disable:
-	clk_disable_unprepare(adc->clk);
+	if (adc->clk)
+		clk_disable_unprepare(adc->clk);
 
 	return ret;
 }
@@ -1211,7 +1221,8 @@ static int stm32_adc_remove(struct platform_device *pdev)
 				  adc->rx_buf, adc->rx_dma_buf);
 		dma_release_channel(adc->dma_chan);
 	}
-	clk_disable_unprepare(adc->clk);
+	if (adc->clk)
+		clk_disable_unprepare(adc->clk);
 
 	return 0;
 }
@@ -1220,6 +1231,7 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	.regs = &stm32f4_adc_regspec,
 	.adc_info = &stm32f4_adc_info,
 	.trigs = stm32f4_adc_trigs,
+	.clk_required = true,
 	.start_conv = stm32f4_adc_start_conv,
 	.stop_conv = stm32f4_adc_stop_conv,
 };
-- 
1.9.1
