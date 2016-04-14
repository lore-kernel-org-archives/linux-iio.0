Return-Path: <sst@poczta.fm>
From: Slawomir Stepien <sst@poczta.fm>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 05/10] iio: adc: at91_adc: fix errors reported by checkpatch.pl
Date: Thu, 14 Apr 2016 21:36:37 +0200
Message-Id: <1460662602-2951-6-git-send-email-sst@poczta.fm>
In-Reply-To: <1460662602-2951-1-git-send-email-sst@poczta.fm>
References: <1460662602-2951-1-git-send-email-sst@poczta.fm>
List-ID: <linux-iio@vger.kernel.org>

This fixes the errors reported by checkpatch.pl:

ERROR: space prohibited before that ',' (ctx:WxW)
ERROR: code indent should use tabs where possible

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/iio/adc/at91_adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index f284cd6..52430ba 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -797,8 +797,8 @@ static u32 calc_startup_ticks_9x5(u32 startup_time, u32 adc_clk_khz)
 	 * Startup Time = <lookup_table_value> / ADC Clock
 	 */
 	const int startup_lookup[] = {
-		0  , 8  , 16 , 24 ,
-		64 , 80 , 96 , 112,
+		0,   8,   16,  24,
+		64,  80,  96,  112,
 		512, 576, 640, 704,
 		768, 832, 896, 960
 		};
@@ -924,14 +924,14 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
 			ret = -EINVAL;
 			goto error_ret;
 		}
-	        trig->name = name;
+		trig->name = name;
 
 		if (of_property_read_u32(trig_node, "trigger-value", &prop)) {
 			dev_err(&idev->dev, "Missing trigger-value property in the DT.\n");
 			ret = -EINVAL;
 			goto error_ret;
 		}
-	        trig->value = prop;
+		trig->value = prop;
 		trig->is_external = of_property_read_bool(trig_node, "trigger-external");
 		i++;
 	}
-- 
2.8.0
