Return-Path: <SRS0=axc1=6N=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio:adc:at91-sama5d2: make array startup_lookup static
Date: Mon, 10 Jul 2017 17:56:16 +0100
Message-Id: <20170710165616.16734-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Don't populate array startup_lookup on the stack but instead make
it static.  Makes the object code smaller.  Also add in missing 'int' type
specifier to clean up a checkpatch warning.

Before:
   text	   data	    bss	    dec	    hex	filename
  10297	   2800	    128	  13225	   33a9	drivers/iio/adc/at91-sama5d2_adc.o

After:
   text	   data	    bss	    dec	    hex	filename
  10140	   2888	    128	  13156	   3364	drivers/iio/adc/at91-sama5d2_adc.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index e10dca3ed74b..509988a6817a 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -231,7 +231,7 @@ static const struct iio_chan_spec at91_adc_channels[] = {
 static unsigned at91_adc_startup_time(unsigned startup_time_min,
 				      unsigned adc_clk_khz)
 {
-	const unsigned startup_lookup[] = {
+	static const unsigned int startup_lookup[] = {
 		  0,   8,  16,  24,
 		 64,  80,  96, 112,
 		512, 576, 640, 704,
-- 
2.11.0
