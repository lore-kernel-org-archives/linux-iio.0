Return-Path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>
cc: Richard Weinberger <richard@nod.at>, knaack.h@gmx.de,
    lars@metafoo.de, pmeerw@pmeerw.net, sanjeev_sharma@mentor.com,
    linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 1/3,RESEND] iio: dht11: Fix out-of-bounds read
In-reply-to: <54AA97B9.7040703@nod.at>
References: <1417563176-31972-1-git-send-email-richard@nod.at> <54A53FBF.5000003@kernel.org> <7e4f6a70e48afe96457ebbcf07572224@imap.cosmopool.net> <54A680F8.30209@nod.at> <54A91DA1.6080107@kernel.org> <E1Y881p-0001Fp-NX@stardust.g4.wien.funkfeuer.at> <54AA97B9.7040703@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 07 Jan 2015 13:15:22 +0100
Message-Id: <E1Y8pWE-00012g-Ec@stardust.g4.wien.funkfeuer.at>
List-ID: <linux-iio@vger.kernel.org>

As we access i-1 we must not start with i=0.

From: Richard Weinberger <richard@nod.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Acked-by: Harald Geyer <harald@ccbib.org>
Reviewed-by: Sanjeev Sharma <sanjeev_sharma@mentor.com>
---
Resending again to get the metadata right.
No Signed-off-by from me, because I didn't contribute anything.
No changes since v1 except reordering.

 drivers/iio/humidity/dht11.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 623c145..f546eca 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -88,7 +88,7 @@ static int dht11_decode(struct dht11 *dht11, int offset)
 	unsigned char temp_int, temp_dec, hum_int, hum_dec, checksum;
 
 	/* Calculate timestamp resolution */
-	for (i = 0; i < dht11->num_edges; ++i) {
+	for (i = 1; i < dht11->num_edges; ++i) {
 		t = dht11->edges[i].ts - dht11->edges[i-1].ts;
 		if (t > 0 && t < timeres)
 			timeres = t;
-- 
1.7.2.5
