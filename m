Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58635 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933973AbaFCWm0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 3 Jun 2014 18:42:26 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 05/15] iio:adc:ad799x: Save some lines in ad7997_8_update_scan_mode() exit handling
Date: Wed,  4 Jun 2014 00:42:05 +0200
Message-Id: <1401835335-29969-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/adc/ad799x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index c03406e..24eca2f 100644
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

