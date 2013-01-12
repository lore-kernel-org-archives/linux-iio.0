Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: jbrenner@taosinc.com,
	amit.kucheria@verdurent.com,
	pmeerw@pmeerw.net,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/5] staging:iio:light:tsl2563 drop unnecessary brackets around constants.
Date: Sat, 12 Jan 2013 10:35:20 +0000
Message-Id: <1357986924-11471-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1357986924-11471-1-git-send-email-jic23@kernel.org>
References: <1357986924-11471-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Not sure why these were ever there.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/light/tsl2563.c | 66 ++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 1a9adc0..1ee0a6f 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -41,49 +41,49 @@
 #include "tsl2563.h"
 
 /* Use this many bits for fraction part. */
-#define ADC_FRAC_BITS		(14)
+#define ADC_FRAC_BITS		14
 
 /* Given number of 1/10000's in ADC_FRAC_BITS precision. */
 #define FRAC10K(f)		(((f) * (1L << (ADC_FRAC_BITS))) / (10000))
 
 /* Bits used for fraction in calibration coefficients.*/
-#define CALIB_FRAC_BITS		(10)
+#define CALIB_FRAC_BITS		10
 /* 0.5 in CALIB_FRAC_BITS precision */
 #define CALIB_FRAC_HALF		(1 << (CALIB_FRAC_BITS - 1))
 /* Make a fraction from a number n that was multiplied with b. */
 #define CALIB_FRAC(n, b)	(((n) << CALIB_FRAC_BITS) / (b))
 /* Decimal 10^(digits in sysfs presentation) */
-#define CALIB_BASE_SYSFS	(1000)
-
-#define TSL2563_CMD		(0x80)
-#define TSL2563_CLEARINT	(0x40)
-
-#define TSL2563_REG_CTRL	(0x00)
-#define TSL2563_REG_TIMING	(0x01)
-#define TSL2563_REG_LOWLOW	(0x02) /* data0 low threshold, 2 bytes */
-#define TSL2563_REG_LOWHIGH	(0x03)
-#define TSL2563_REG_HIGHLOW	(0x04) /* data0 high threshold, 2 bytes */
-#define TSL2563_REG_HIGHHIGH	(0x05)
-#define TSL2563_REG_INT		(0x06)
-#define TSL2563_REG_ID		(0x0a)
-#define TSL2563_REG_DATA0LOW	(0x0c) /* broadband sensor value, 2 bytes */
-#define TSL2563_REG_DATA0HIGH	(0x0d)
-#define TSL2563_REG_DATA1LOW	(0x0e) /* infrared sensor value, 2 bytes */
-#define TSL2563_REG_DATA1HIGH	(0x0f)
-
-#define TSL2563_CMD_POWER_ON	(0x03)
-#define TSL2563_CMD_POWER_OFF	(0x00)
-#define TSL2563_CTRL_POWER_MASK	(0x03)
-
-#define TSL2563_TIMING_13MS	(0x00)
-#define TSL2563_TIMING_100MS	(0x01)
-#define TSL2563_TIMING_400MS	(0x02)
-#define TSL2563_TIMING_MASK	(0x03)
-#define TSL2563_TIMING_GAIN16	(0x10)
-#define TSL2563_TIMING_GAIN1	(0x00)
-
-#define TSL2563_INT_DISBLED	(0x00)
-#define TSL2563_INT_LEVEL	(0x10)
+#define CALIB_BASE_SYSFS	1000
+
+#define TSL2563_CMD		0x80
+#define TSL2563_CLEARINT	0x40
+
+#define TSL2563_REG_CTRL	0x00
+#define TSL2563_REG_TIMING	0x01
+#define TSL2563_REG_LOWLOW	0x02 /* data0 low threshold, 2 bytes */
+#define TSL2563_REG_LOWHIGH	0x03
+#define TSL2563_REG_HIGHLOW	0x04 /* data0 high threshold, 2 bytes */
+#define TSL2563_REG_HIGHHIGH	0x05
+#define TSL2563_REG_INT		0x06
+#define TSL2563_REG_ID		0x0a
+#define TSL2563_REG_DATA0LOW	0x0c /* broadband sensor value, 2 bytes */
+#define TSL2563_REG_DATA0HIGH	0x0d
+#define TSL2563_REG_DATA1LOW	0x0e /* infrared sensor value, 2 bytes */
+#define TSL2563_REG_DATA1HIGH	0x0f
+
+#define TSL2563_CMD_POWER_ON	0x03
+#define TSL2563_CMD_POWER_OFF	0x00
+#define TSL2563_CTRL_POWER_MASK	0x03
+
+#define TSL2563_TIMING_13MS	0x00
+#define TSL2563_TIMING_100MS	0x01
+#define TSL2563_TIMING_400MS	0x02
+#define TSL2563_TIMING_MASK	0x03
+#define TSL2563_TIMING_GAIN16	0x10
+#define TSL2563_TIMING_GAIN1	0x00
+
+#define TSL2563_INT_DISBLED	0x00
+#define TSL2563_INT_LEVEL	0x10
 #define TSL2563_INT_PERSIST(n)	((n) & 0x0F)
 
 struct tsl2563_gainlevel_coeff {
-- 
1.8.1
