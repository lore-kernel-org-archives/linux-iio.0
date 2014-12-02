Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
To: jic23@kernel.org
Cc: harald@ccbib.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	sanjeev_sharma@mentor.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/4] iio: dht11: Fix out-of-bounds read
Date: Wed,  3 Dec 2014 00:32:56 +0100
Message-Id: <1417563176-31972-5-git-send-email-richard@nod.at>
In-Reply-To: <1417563176-31972-1-git-send-email-richard@nod.at>
References: <1417563176-31972-1-git-send-email-richard@nod.at>
List-ID: <linux-iio@vger.kernel.org>

As we access i-1 we must not start with i=0.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/iio/humidity/dht11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index fbcd7cb..5dfe71b 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -90,7 +90,7 @@ static int dht11_decode(struct dht11 *dht11, int offset)
 	unsigned char temp_int, temp_dec, hum_int, hum_dec, checksum;
 
 	/* Calculate timestamp resolution */
-	for (i = 0; i < dht11->num_edges; ++i) {
+	for (i = 1; i < dht11->num_edges; ++i) {
 		t = dht11->edges[i].ts - dht11->edges[i-1].ts;
 		if (t > 0 && t < timeres)
 			timeres = t;
-- 
1.8.4.5
