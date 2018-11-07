Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33762 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbeKHEV5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Nov 2018 23:21:57 -0500
From: Giuliano Belinassi <giuliano.belinassi@gmail.com>
Date: Wed, 7 Nov 2018 16:50:10 -0200
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        renatogeh@gmail.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 2/3] staging: iio: ad7780: check if ad778x before gain update
Message-ID: <2a521e5f036eb74b684f368a6227509cac93fe0d.1541615978.git.giuliano.belinassi@usp.br>
References: <cover.1541615978.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1541615978.git.giuliano.belinassi@usp.br>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Only the ad778x have the 'gain' status bit. Check it before updating.

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
 drivers/staging/iio/adc/ad7780.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 6e51bfdb076a..0a473aae52f2 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -114,10 +114,12 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
 	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
 		return -EIO;
 
-	if (raw_sample & AD7780_GAIN)
-		st->gain = 1;
-	else
-		st->gain = 128;
+	if (chip_info->is_ad778x) {
+		if (raw_sample & AD7780_GAIN)
+			st->gain = 1;
+		else
+			st->gain = 128;
+	}
 
 	return 0;
 }
-- 
2.19.1
