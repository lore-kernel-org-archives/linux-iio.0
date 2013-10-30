Return-Path: <weiyj.lk@gmail.com>
MIME-Version: 1.0
Date: Wed, 30 Oct 2013 13:20:51 +0800
Message-ID: <CAPgLHd_whWvPuHTCGdQkZa2fbra=U1nRBvBCyd9azUzS8_XLNg@mail.gmail.com>
Subject: [PATCH -next] iio: at91: fix error return code in at91_adc_probe()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: jic23@kernel.org, grant.likely@linaro.org, rob.herring@calxeda.com,
	maxime.ripard@free-electrons.com, josh.wu@atmel.com, lars@metafoo.de,
	ludovic.desroches@atmel.com
Cc: yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -ENODEV instead of 0 if non-TSMR adc don't
support, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/iio/adc/at91_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 17df749..5b1aa02 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1047,6 +1047,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	} else {
 		if (!st->caps->has_tsmr) {
 			dev_err(&pdev->dev, "We don't support non-TSMR adc\n");
+			ret = -ENODEV;
 			goto error_disable_adc_clk;
 		}
 
