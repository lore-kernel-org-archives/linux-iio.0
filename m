Return-Path: <SRS0=tI7e=MA=embeddedor.com=gustavo@kernel.org>
Date: Tue, 18 Sep 2018 07:53:14 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] iio: adc: Fix potential integer overflow
Message-ID: <20180918125314.GA12752@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Cast factor to s64 in order to give the compiler complete information
about the proper arithmetic to use and avoid a potential integer
overflow. Notice that such variable is being used in a context
that expects an expression of type s64 (64 bits, signed).

Addresses-Coverity-ID: 1324146 ("Unintentional integer overflow")
Fixes: e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/iio/adc/qcom-vadc-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index dcd7fb5..e360e27 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -282,7 +282,7 @@ static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
 	voltage = div64_s64(voltage, data->full_scale_code_volt);
 	if (voltage > 0) {
 		voltage *= prescale->den;
-		temp = prescale->num * factor;
+		temp = prescale->num * (s64)factor;
 		voltage = div64_s64(voltage, temp);
 	} else {
 		voltage = 0;
-- 
2.7.4
