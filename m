Return-Path: <SRS0=yzOE=NS=gmail.com=giuliano.belinassi@kernel.org>
From: Giuliano Belinassi <giuliano.belinassi@gmail.com>
Date: Wed, 7 Nov 2018 16:50:53 -0200
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	renatogeh@gmail.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 3/3] staging: iio: ad7780: generates pattern_mask from PAT
 bits
Message-ID: <f7925df556f37f48ae0b1707239aff5a108fea1d.1541615978.git.giuliano.belinassi@usp.br>
References: <cover.1541615978.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1541615978.git.giuliano.belinassi@usp.br>
List-ID: <linux-iio@vger.kernel.org>

Previously, all pattern_masks in the chip_info table were hardcoded. Now they
are generated using the PAT macros, as described in the datasheets.

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
 drivers/staging/iio/adc/ad7780.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 0a473aae52f2..fa9e047b5191 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -31,6 +31,8 @@
 #define AD7780_PAT1	BIT(1)
 #define AD7780_PAT0	BIT(0)
 
+#define AD7170_PAT2	BIT(2)
+
 struct ad7780_chip_info {
 	struct iio_chan_spec	channel;
 	unsigned int		pattern_mask;
@@ -137,25 +139,25 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7170] = {
 		.channel = AD7780_CHANNEL(12, 24),
 		.pattern = 0x5,
-		.pattern_mask = 0x7,
+		.pattern_mask = AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2,
 		.is_ad778x = false,
 	},
 	[ID_AD7171] = {
 		.channel = AD7780_CHANNEL(16, 24),
 		.pattern = 0x5,
-		.pattern_mask = 0x7,
+		.pattern_mask = AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2,
 		.is_ad778x = false,
 	},
 	[ID_AD7780] = {
 		.channel = AD7780_CHANNEL(24, 32),
 		.pattern = 0x1,
-		.pattern_mask = 0x3,
+		.pattern_mask = AD7780_PAT0 | AD7780_PAT1,
 		.is_ad778x = true,
 	},
 	[ID_AD7781] = {
 		.channel = AD7780_CHANNEL(20, 32),
 		.pattern = 0x1,
-		.pattern_mask = 0x3,
+		.pattern_mask = AD7780_PAT0 | AD7780_PAT1,
 		.is_ad778x = true,
 	},
 };
-- 
2.19.1
