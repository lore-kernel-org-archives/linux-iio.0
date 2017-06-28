Return-Path: <SRS0=o7HV=6B=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][iio-next] iio: adc: stm32: make array stm32h7_adc_ckmodes_spec static
Date: Wed, 28 Jun 2017 14:06:50 +0100
Message-Id: <20170628130650.21872-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

The array stm32h7_adc_ckmodes_spec does not need to be in global scope, so
make it static.

Cleans up sparse warning:
"symbol 'stm32h7_adc_ckmodes_spec' was not declared. Should it be static?"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/adc/stm32-adc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index e09233b03c05..9d083c2338f9 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -172,7 +172,7 @@ struct stm32h7_adc_ck_spec {
 	int div;
 };
 
-const struct stm32h7_adc_ck_spec stm32h7_adc_ckmodes_spec[] = {
+static const struct stm32h7_adc_ck_spec stm32h7_adc_ckmodes_spec[] = {
 	/* 00: CK_ADC[1..3]: Asynchronous clock modes */
 	{ 0, 0, 1 },
 	{ 0, 1, 2 },
-- 
2.11.0
