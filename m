Return-Path: <SRS0=wbiz=B2=pmeerw.net=pmeerw@kernel.org>
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 09/13] iio: health: max30102: Introduce indices for LED channels
Date: Fri, 27 Oct 2017 21:45:39 +0200
Message-Id: <1509133543-4597-10-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/health/max30102.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 520d905..37176c2 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -34,6 +34,11 @@
 #define MAX30102_DRV_NAME	"max30102"
 #define MAX30102_PART_NUMBER	0x15
 
+enum max3012_led_idx {
+	MAX30102_LED_RED,
+	MAX30102_LED_IR,
+};
+
 #define MAX30102_REG_INT_STATUS			0x00
 #define MAX30102_REG_INT_STATUS_PWR_RDY		BIT(0)
 #define MAX30102_REG_INT_STATUS_PROX_INT	BIT(4)
@@ -104,7 +109,10 @@ static const struct regmap_config max30102_regmap_config = {
 	.val_bits = 8,
 };
 
-static const unsigned long max30102_scan_masks[] = {0x3, 0};
+static const unsigned long max30102_scan_masks[] = {
+	BIT(MAX30102_LED_RED) | BIT(MAX30102_LED_IR),
+	0
+};
 
 #define MAX30102_INTENSITY_CHANNEL(_si, _mod) { \
 		.type = IIO_INTENSITY, \
@@ -121,8 +129,8 @@ static const unsigned long max30102_scan_masks[] = {0x3, 0};
 	}
 
 static const struct iio_chan_spec max30102_channels[] = {
-	MAX30102_INTENSITY_CHANNEL(0, IIO_MOD_LIGHT_RED),
-	MAX30102_INTENSITY_CHANNEL(1, IIO_MOD_LIGHT_IR),
+	MAX30102_INTENSITY_CHANNEL(MAX30102_LED_RED, IIO_MOD_LIGHT_RED),
+	MAX30102_INTENSITY_CHANNEL(MAX30102_LED_IR, IIO_MOD_LIGHT_IR),
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate =
-- 
2.7.4
