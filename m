Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:3775 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932285AbeAKLGi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 11 Jan 2018 06:06:38 -0500
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Mark Brown <broonie@kernel.org>,
        "Arnaud Pouliquen" <arnaud.pouliquen@st.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] IIO: ADC: fix return value check in stm32_dfsdm_adc_probe()
Date: Thu, 11 Jan 2018 11:12:41 +0000
Message-ID: <1515669161-125426-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In case of error, the function devm_iio_device_alloc() returns NULL
pointer not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index e628d04..5e87140 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1100,9 +1100,9 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	dev_data = (const struct stm32_dfsdm_dev_data *)of_id->data;
 
 	iio = devm_iio_device_alloc(dev, sizeof(*adc));
-	if (IS_ERR(iio)) {
+	if (!iio) {
 		dev_err(dev, "%s: Failed to allocate IIO\n", __func__);
-		return PTR_ERR(iio);
+		return -ENOMEM;
 	}
 
 	adc = iio_priv(iio);

