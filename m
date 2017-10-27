Return-Path: <SRS0=wbiz=B2=pmeerw.net=pmeerw@kernel.org>
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald-Stalder <pmeerw@pmeerw.net>,
	Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 07/13] iio: health: max30102: Introduce intensity channel macro
Date: Fri, 27 Oct 2017 21:45:37 +0200
Message-Id: <1509133543-4597-8-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald-Stalder <pmeerw@pmeerw.net>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/health/max30102.c | 44 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index c43957e..968b54b 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -106,35 +106,23 @@ static const struct regmap_config max30102_regmap_config = {
 
 static const unsigned long max30102_scan_masks[] = {0x3, 0};
 
+#define MAX30102_INTENSITY_CHANNEL(_si, _mod) { \
+		.type = IIO_INTENSITY, \
+		.channel2 = _mod, \
+		.modified = 1, \
+		.scan_index = _si, \
+		.scan_type = { \
+			.sign = 'u', \
+			.shift = 8, \
+			.realbits = 18, \
+			.storagebits = 32, \
+			.endianness = IIO_BE, \
+		}, \
+	}
+
 static const struct iio_chan_spec max30102_channels[] = {
-	{
-		.type = IIO_INTENSITY,
-		.channel2 = IIO_MOD_LIGHT_RED,
-		.modified = 1,
-
-		.scan_index = 0,
-		.scan_type = {
-			.sign = 'u',
-			.shift = 8,
-			.realbits = 18,
-			.storagebits = 32,
-			.endianness = IIO_BE,
-		},
-	},
-	{
-		.type = IIO_INTENSITY,
-		.channel2 = IIO_MOD_LIGHT_IR,
-		.modified = 1,
-
-		.scan_index = 1,
-		.scan_type = {
-			.sign = 'u',
-			.shift = 8,
-			.realbits = 18,
-			.storagebits = 32,
-			.endianness = IIO_BE,
-		},
-	},
+	MAX30102_INTENSITY_CHANNEL(0, IIO_MOD_LIGHT_RED),
+	MAX30102_INTENSITY_CHANNEL(1, IIO_MOD_LIGHT_IR),
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate =
-- 
2.7.4
