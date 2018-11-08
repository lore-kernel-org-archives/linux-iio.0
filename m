Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38063 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHWiv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Nov 2018 17:38:51 -0500
From: Giuliano Belinassi <giuliano.belinassi@gmail.com>
Date: Thu, 8 Nov 2018 11:03:20 -0200
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        renatogeh@gmail.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 1/2] staging: iio: ad7780: check if ad778x before gain
 update
Message-ID: <762e851dd819f27e3955cb695cd8422d84a19438.1541681371.git.giuliano.belinassi@usp.br>
References: <cover.1541681371.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1541681371.git.giuliano.belinassi@usp.br>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Only the ad778x have the 'gain' status bit. Check it before updating
through a new variable is_ad778x in chip_info.

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
Changes in v2:
	- Squashed is_ad778x declaration commit with the ad778x checkage
	- Changed is_ad778x type to bool
 
 drivers/staging/iio/adc/ad7780.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 91e016d534ed..9ec2b002539e 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -35,6 +35,7 @@ struct ad7780_chip_info {
 	struct iio_chan_spec	channel;
 	unsigned int		pattern_mask;
 	unsigned int		pattern;
+	bool			is_ad778x;
 };
 
 struct ad7780_state {
@@ -113,10 +114,12 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
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
@@ -135,21 +138,25 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 		.channel = AD7780_CHANNEL(12, 24),
 		.pattern = 0x5,
 		.pattern_mask = 0x7,
+		.is_ad778x = false,
 	},
 	[ID_AD7171] = {
 		.channel = AD7780_CHANNEL(16, 24),
 		.pattern = 0x5,
 		.pattern_mask = 0x7,
+		.is_ad778x = false,
 	},
 	[ID_AD7780] = {
 		.channel = AD7780_CHANNEL(24, 32),
 		.pattern = 0x1,
 		.pattern_mask = 0x3,
+		.is_ad778x = true,
 	},
 	[ID_AD7781] = {
 		.channel = AD7780_CHANNEL(20, 32),
 		.pattern = 0x1,
 		.pattern_mask = 0x3,
+		.is_ad778x = true,
 	},
 };
 
-- 
2.19.1
