Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47794 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909AbaFLEy1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 12 Jun 2014 00:54:27 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v3 04/12] iio:adc:ad799x: Save some lines in ad7997_8_update_scan_mode() exit handling
Date: Thu, 12 Jun 2014 06:54:08 +0200
Message-Id: <1402548856-3564-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net>
References: <1402548856-3564-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad799x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 34d93a5..878400c 100644
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

