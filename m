Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43688 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeKHEVX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Nov 2018 23:21:23 -0500
From: Giuliano Belinassi <giuliano.belinassi@gmail.com>
Date: Wed, 7 Nov 2018 16:49:39 -0200
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        renatogeh@gmail.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 1/3] staging: iio: ad7780: Add is_ad778x flag chip info
Message-ID: <e7f1b071157abbb92d5cb42f310fb471ea43ff01.1541615978.git.giuliano.belinassi@usp.br>
References: <cover.1541615978.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1541615978.git.giuliano.belinassi@usp.br>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch allows further checking of whatever the chip is (ad778x or
ad717x).

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
 drivers/staging/iio/adc/ad7780.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 91e016d534ed..6e51bfdb076a 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -35,6 +35,7 @@ struct ad7780_chip_info {
 	struct iio_chan_spec	channel;
 	unsigned int		pattern_mask;
 	unsigned int		pattern;
+	u8			is_ad778x;
 };
 
 struct ad7780_state {
@@ -135,21 +136,25 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
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
