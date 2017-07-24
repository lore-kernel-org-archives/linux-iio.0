Return-Path: <SRS0=bqw6=63=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] iio: adc: stm32: fix common clock rate
Date: Mon, 24 Jul 2017 18:10:38 +0200
Message-ID: <1500912640-23927-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1500912640-23927-1-git-send-email-fabrice.gasnier@st.com>
References: <1500912640-23927-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Fixes: 95e339b6e85d ("iio: adc: stm32: add support for STM32H7")

ADC clock input is provided to internal prescaler (that decreases its
frequency). It's then used as reference clock for conversions.

- Fix common clock rate used then by stm32-adc sub-devices. Take common
  prescaler into account. Currently, rate is used to set "boost" mode.
  It may unnecessarily be set. This impacts power consumption.
- Fix ADC max clock rate on STM32H7 (fADC from datasheet). Currently,
  prescaler may be set too low. This can result in ADC reference
  clock used for conversion to exceed max allowed clock frequency.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- Better description of wrong things being fixed.
---
 drivers/iio/adc/stm32-adc-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index e09233b..6096763 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -64,7 +64,7 @@
 #define STM32H7_CKMODE_MASK		GENMASK(17, 16)
 
 /* STM32 H7 maximum analog clock rate (from datasheet) */
-#define STM32H7_ADC_MAX_CLK_RATE	72000000
+#define STM32H7_ADC_MAX_CLK_RATE	36000000
 
 /**
  * stm32_adc_common_regs - stm32 common registers, compatible dependent data
@@ -148,14 +148,14 @@ static int stm32f4_adc_clk_sel(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	priv->common.rate = rate;
+	priv->common.rate = rate / stm32f4_pclk_div[i];
 	val = readl_relaxed(priv->common.base + STM32F4_ADC_CCR);
 	val &= ~STM32F4_ADC_ADCPRE_MASK;
 	val |= i << STM32F4_ADC_ADCPRE_SHIFT;
 	writel_relaxed(val, priv->common.base + STM32F4_ADC_CCR);
 
 	dev_dbg(&pdev->dev, "Using analog clock source at %ld kHz\n",
-		rate / (stm32f4_pclk_div[i] * 1000));
+		priv->common.rate / 1000);
 
 	return 0;
 }
@@ -250,7 +250,7 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
 
 out:
 	/* rate used later by each ADC instance to control BOOST mode */
-	priv->common.rate = rate;
+	priv->common.rate = rate / div;
 
 	/* Set common clock mode and prescaler */
 	val = readl_relaxed(priv->common.base + STM32H7_ADC_CCR);
@@ -260,7 +260,7 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
 	writel_relaxed(val, priv->common.base + STM32H7_ADC_CCR);
 
 	dev_dbg(&pdev->dev, "Using %s clock/%d source at %ld kHz\n",
-		ckmode ? "bus" : "adc", div, rate / (div * 1000));
+		ckmode ? "bus" : "adc", div, priv->common.rate / 1000);
 
 	return 0;
 }
-- 
1.9.1
