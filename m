Return-Path: <SRS0=Ggth=ES=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: [PATCH] iio: adc: stm32: fix stm32h7_adc_enable error handling
Date: Tue, 23 Jan 2018 17:04:56 +0100
Message-ID: <1516723497-9018-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Error handling in stm32h7_adc_enable routine doesn't unwind enable
sequence correctly. ADEN can only be cleared by hardware (e.g. by
writing one to ADDIS).
It's also better to clear ADRDY just after it's been set by hardware.

Fixes: 95e339b6e85d ("iio: adc: stm32: add support for STM32H7")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index ca3b865..8177a92 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -735,8 +735,6 @@ static int stm32h7_adc_enable(struct stm32_adc *adc)
 	int ret;
 	u32 val;
 
-	/* Clear ADRDY by writing one, then enable ADC */
-	stm32_adc_set_bits(adc, STM32H7_ADC_ISR, STM32H7_ADRDY);
 	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADEN);
 
 	/* Poll for ADRDY to be set (after adc startup time) */
@@ -744,8 +742,11 @@ static int stm32h7_adc_enable(struct stm32_adc *adc)
 					   val & STM32H7_ADRDY,
 					   100, STM32_ADC_TIMEOUT_US);
 	if (ret) {
-		stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADEN);
+		stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADDIS);
 		dev_err(&indio_dev->dev, "Failed to enable ADC\n");
+	} else {
+		/* Clear ADRDY by writing one */
+		stm32_adc_set_bits(adc, STM32H7_ADC_ISR, STM32H7_ADRDY);
 	}
 
 	return ret;
-- 
1.9.1
