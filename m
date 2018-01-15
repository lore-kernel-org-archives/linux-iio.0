Return-Path: <SRS0=Rdkf=EK=st.com=arnaud.pouliquen@kernel.org>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
To: Jonathan Cameron <jic23@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        "Lars-Peter
 Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Hartmut Knaack
	<knaack.h@gmx.de>,
        Alexandre Torgue <alexandre.torgue@st.com>, <arnaud.pouliquen@st.com>
Subject: [PATCH] IIO: ADC: stm32-dfsdm: fix static check warning
Date: Mon, 15 Jan 2018 10:00:26 +0100
Message-ID: <1516006826-16230-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

iio_priv does not return an error pointer, so check is not valid.
Patch suppresses it.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index f79a90f..5c67236 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1099,10 +1099,6 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	}
 
 	adc = iio_priv(iio);
-	if (IS_ERR(adc)) {
-		dev_err(dev, "%s: Failed to allocate ADC\n", __func__);
-		return PTR_ERR(adc);
-	}
 	adc->dfsdm = dev_get_drvdata(dev->parent);
 
 	iio->dev.parent = dev;
-- 
2.7.4
