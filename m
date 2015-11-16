Return-Path: <nizamhaider786@gmail.com>
From: Nizam Haider <nizamhaider786@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	leupold@rsi-elektrotechnik.de,
	nicolas.ferre@atmel.com,
	alexandre.belloni@free-electrons.com,
	octavian.purdila@intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nizam Haider <nizamhaider786@gmail.com>
Subject: [PATCH] IIO: adc: at91_adc.c Prefer kmalloc_array over kmalloc with multiply
Date: Mon, 16 Nov 2015 05:35:57 +0530
Message-Id: <1447632357-8222-1-git-send-email-nizamhaider786@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

So this patch swaps that use out for kmalloc_array instead.

Signed-off-by Nizam Haider <nijamh@cdac.in>
---
 drivers/iio/adc/at91_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 7b40925..f284cd6 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -742,7 +742,7 @@ static int at91_adc_of_get_resolution(struct at91_adc_state *st,
 		return count;
 	}
 
-	resolutions = kmalloc(count * sizeof(*resolutions), GFP_KERNEL);
+	resolutions = kmalloc_array(count, sizeof(*resolutions), GFP_KERNEL);
 	if (!resolutions)
 		return -ENOMEM;
 
-- 
1.8.1.4
