Return-Path: <SRS0=bFjq=GD=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH 1/2] iio: adc: stm32-dfsdm: fix successive oversampling settings
Date: Tue, 13 Mar 2018 15:23:05 +0100
Message-ID: <1520950986-23116-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1520950986-23116-1-git-send-email-fabrice.gasnier@st.com>
References: <1520950986-23116-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

When doing successive oversampling settings, it may fail to update filter
parameters silently:
- First time oversampling is being set, it will be successful, as fl->res
is 0 initially.
- Next attempts with various oversamp value may return 0 (success), but
keep previous filter parameters, due to 'res' never reaches above or
equal current 'fl->res'.

This is particularly true when setting sampling frequency (that relies on
oversamp). Typical failure without error:
- run 1st test @16kHz samp freq will succeed
- run new test @8kHz will succeed as well
- run new test @16kHz (again): sample rate will remain 8kHz without error

Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 01422d1..dc911b6 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -144,6 +144,7 @@ static int stm32_dfsdm_set_osrs(struct stm32_dfsdm_filter *fl,
 	 * Leave as soon as if exact resolution if reached.
 	 * Otherwise the higher resolution below 32 bits is kept.
 	 */
+	fl->res = 0;
 	for (fosr = 1; fosr <= DFSDM_MAX_FL_OVERSAMPLING; fosr++) {
 		for (iosr = 1; iosr <= DFSDM_MAX_INT_OVERSAMPLING; iosr++) {
 			if (fast)
@@ -193,7 +194,7 @@ static int stm32_dfsdm_set_osrs(struct stm32_dfsdm_filter *fl,
 		}
 	}
 
-	if (!fl->fosr)
+	if (!fl->res)
 		return -EINVAL;
 
 	return 0;
-- 
1.9.1
