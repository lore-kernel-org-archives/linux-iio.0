Return-Path: <SRS0=axc1=6N=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Wenyou Yang <wenyou.yang@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>,
	Anders Darander <anders@chargestorm.se>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: at91: make array startup_lookup static
Date: Mon, 10 Jul 2017 18:46:54 +0100
Message-Id: <20170710174654.17271-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Don't populate array startup_lookup on the stack but instead make
it static.  Makes the object code smaller.

Before:
   text	   data	    bss	    dec	    hex	filename
  21754	   5440	    128	  27322	   6aba	drivers/iio/adc/at91_adc.o

After:
   text	   data	    bss	    dec	    hex	filename
  21613	   5496	    128	  27237	   6a65	drivers/iio/adc/at91_adc.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/adc/at91_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 34b928cefeed..15109728cae7 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -799,7 +799,7 @@ static u32 calc_startup_ticks_9x5(u32 startup_time, u32 adc_clk_khz)
 	 * For sama5d3x and at91sam9x5, the formula changes to:
 	 * Startup Time = <lookup_table_value> / ADC Clock
 	 */
-	const int startup_lookup[] = {
+	static const int startup_lookup[] = {
 		0,   8,   16,  24,
 		64,  80,  96,  112,
 		512, 576, 640, 704,
-- 
2.11.0
