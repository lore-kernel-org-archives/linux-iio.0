Return-Path: <SRS0=y4pC=FR=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH 6/7] iio: adc: stm32-dfsdm: add check on max filter id
Date: Fri, 23 Feb 2018 13:51:00 +0100
Message-ID: <1519390261-25453-7-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

reg property should be checked against number of available filters.
BTW, dfsdm->num_fls wasn't used. But it can be used for this purpose.
This prevents using data out of allocated dfsdm->fl_list array.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 57bcb45..1b78bec 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1111,8 +1111,8 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, adc);
 
 	ret = of_property_read_u32(dev->of_node, "reg", &adc->fl_id);
-	if (ret != 0) {
-		dev_err(dev, "Missing reg property\n");
+	if (ret != 0 || adc->fl_id >= adc->dfsdm->num_fls) {
+		dev_err(dev, "Missing or bad reg property\n");
 		return -EINVAL;
 	}
 
-- 
1.9.1
