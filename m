Return-Path: <SRS0=KfHW=NT=gmail.com=giuliano.belinassi@kernel.org>
From: Giuliano Belinassi <giuliano.belinassi@gmail.com>
Date: Thu, 8 Nov 2018 11:03:40 -0200
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	renatogeh@gmail.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 2/2] staging: iio: ad7780: generates pattern_mask from PAT
 bits
Message-ID: <ce8ebadd1638810eaaa3b0b30a961a7b3f88ae34.1541681371.git.giuliano.belinassi@usp.br>
References: <cover.1541681371.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1541681371.git.giuliano.belinassi@usp.br>
List-ID: <linux-iio@vger.kernel.org>

Previously, all pattern_masks and patterns in the chip_info table were
hardcoded. Now they are generated using the PAT macros, as described in
the datasheets.

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
Changes in v2:
	- Added the PATTERN and PATTERN_MASK macros
	- Update BIT macros alignment to match with PATTERN
	- Generate pattern mask with PATTERN_MASK macros.

drivers/staging/iio/adc/ad7780.c | 40 +++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 9ec2b002539e..ff8e3b2d0efc 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -22,14 +22,22 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/adc/ad_sigma_delta.h>
 
-#define AD7780_RDY	BIT(7)
-#define AD7780_FILTER	BIT(6)
-#define AD7780_ERR	BIT(5)
-#define AD7780_ID1	BIT(4)
-#define AD7780_ID0	BIT(3)
-#define AD7780_GAIN	BIT(2)
-#define AD7780_PAT1	BIT(1)
-#define AD7780_PAT0	BIT(0)
+#define AD7780_RDY		BIT(7)
+#define AD7780_FILTER		BIT(6)
+#define AD7780_ERR		BIT(5)
+#define AD7780_ID1		BIT(4)
+#define AD7780_ID0		BIT(3)
+#define AD7780_GAIN		BIT(2)
+#define AD7780_PAT1		BIT(1)
+#define AD7780_PAT0		BIT(0)
+
+#define AD7780_PATTERN		(AD7780_PAT0)
+#define AD7780_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1)
+
+#define AD7170_PAT2		BIT(2)
+
+#define AD7170_PATTERN		(AD7780_PAT0 | AD7170_PAT2)
+#define AD7170_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
 
 struct ad7780_chip_info {
 	struct iio_chan_spec	channel;
@@ -136,26 +144,26 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7170] = {
 		.channel = AD7780_CHANNEL(12, 24),
-		.pattern = 0x5,
-		.pattern_mask = 0x7,
+		.pattern = AD7170_PATTERN,
+		.pattern_mask = AD7170_PATTERN_MASK,
 		.is_ad778x = false,
 	},
 	[ID_AD7171] = {
 		.channel = AD7780_CHANNEL(16, 24),
-		.pattern = 0x5,
-		.pattern_mask = 0x7,
+		.pattern = AD7170_PATTERN,
+		.pattern_mask = AD7170_PATTERN_MASK,
 		.is_ad778x = false,
 	},
 	[ID_AD7780] = {
 		.channel = AD7780_CHANNEL(24, 32),
-		.pattern = 0x1,
-		.pattern_mask = 0x3,
+		.pattern = AD7780_PATTERN,
+		.pattern_mask = AD7780_PATTERN_MASK,
 		.is_ad778x = true,
 	},
 	[ID_AD7781] = {
 		.channel = AD7780_CHANNEL(20, 32),
-		.pattern = 0x1,
-		.pattern_mask = 0x3,
+		.pattern = AD7780_PATTERN,
+		.pattern_mask = AD7780_PATTERN_MASK,
 		.is_ad778x = true,
 	},
 };
-- 
2.19.1
