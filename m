Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 04/13] iio:adc:ad799x: Save some lines in ad7997_8_update_scan_mode() exit handling
Date: Sat,  7 Jun 2014 17:31:28 +0200
Message-Id: <1402155097-435-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155097-435-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad799x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index d1ba99b..320e3a3 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -193,10 +193,8 @@ static int ad7997_8_update_scan_mode(struct iio_dev *indio_dev,
 		return i2c_smbus_write_word_swapped(st->client, AD7998_CONF_REG,
 			st->config | (*scan_mask << AD799X_CHANNEL_SHIFT));
 	default:
-		break;
+		return 0;
 	}
-
-	return 0;
 }
 
 static int ad799x_scan_direct(struct ad799x_state *st, unsigned ch)
-- 
1.9.1
