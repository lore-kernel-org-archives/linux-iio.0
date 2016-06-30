Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 10/10 v4] iio: pressure: bmp280: read calibration data once
Date: Thu, 30 Jun 2016 03:48:54 +0200
Message-Id: <1467251334-30594-11-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1467251334-30594-1-git-send-email-linus.walleij@linaro.org>
References: <1467251334-30594-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

The calibration data is described as coming from an E2PROM and that
means it does not change. Just read it once at probe time and store
it in the device state container. Also toss the calibration data
into the entropy pool since it is device unique.

Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Fix bmp058/bmp085 typo
- Move patch last so the controversial stuff is at the end of the series
ChangeLog v2->v3:
- Rebase on other changes
- Drop unrelated whitespace fix
ChangeLog v1->v2:
- Remove unused dangling "ret" variable.
---
 drivers/iio/pressure/bmp280-core.c | 94 +++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index e8f534240f2d..eef4ef0097ce 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -31,9 +31,30 @@
 #include <linux/irq.h> /* For irq_get_irq_data() */
 #include <linux/completion.h>
 #include <linux/pm_runtime.h>
+#include <linux/random.h>
 
 #include "bmp280.h"
 
+/*
+ * These enums are used for indexing into the array of calibration
+ * coefficients for BMP180.
+ */
+enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
+
+struct bmp180_calib {
+	s16 AC1;
+	s16 AC2;
+	s16 AC3;
+	u16 AC4;
+	u16 AC5;
+	u16 AC6;
+	s16 B1;
+	s16 B2;
+	s16 MB;
+	s16 MC;
+	s16 MD;
+};
+
 struct bmp280_data {
 	struct device *dev;
 	struct mutex lock;
@@ -41,6 +62,7 @@ struct bmp280_data {
 	struct completion done;
 	bool use_eoc;
 	const struct bmp280_chip_info *chip_info;
+	struct bmp180_calib calib;
 	struct regulator *vddd;
 	struct regulator *vdda;
 	unsigned int start_up_time; /* in milliseconds */
@@ -663,26 +685,6 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 	return 0;
 }
 
-/*
- * These enums are used for indexing into the array of calibration
- * coefficients for BMP180.
- */
-enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
-
-struct bmp180_calib {
-	s16 AC1;
-	s16 AC2;
-	s16 AC3;
-	u16 AC4;
-	u16 AC5;
-	u16 AC6;
-	s16 B1;
-	s16 B2;
-	s16 MB;
-	s16 MC;
-	s16 MD;
-};
-
 static int bmp180_read_calib(struct bmp280_data *data,
 			     struct bmp180_calib *calib)
 {
@@ -702,6 +704,9 @@ static int bmp180_read_calib(struct bmp280_data *data,
 			return -EIO;
 	}
 
+	/* Toss the calibration data into the entropy pool */
+	add_device_randomness(buf, sizeof(buf));
+
 	calib->AC1 = be16_to_cpu(buf[AC1]);
 	calib->AC2 = be16_to_cpu(buf[AC2]);
 	calib->AC3 = be16_to_cpu(buf[AC3]);
@@ -725,19 +730,11 @@ static int bmp180_read_calib(struct bmp280_data *data,
  */
 static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
 {
-	int ret;
 	s32 x1, x2;
-	struct bmp180_calib calib;
+	struct bmp180_calib *calib = &data->calib;
 
-	ret = bmp180_read_calib(data, &calib);
-	if (ret < 0) {
-		dev_err(data->dev,
-			"failed to read calibration coefficients\n");
-		return ret;
-	}
-
-	x1 = ((adc_temp - calib.AC6) * calib.AC5) >> 15;
-	x2 = (calib.MC << 11) / (x1 + calib.MD);
+	x1 = ((adc_temp - calib->AC6) * calib->AC5) >> 15;
+	x2 = (calib->MC << 11) / (x1 + calib->MD);
 	data->t_fine = x1 + x2;
 
 	return (data->t_fine + 8) >> 4;
@@ -792,29 +789,21 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
  */
 static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
 {
-	int ret;
 	s32 x1, x2, x3, p;
 	s32 b3, b6;
 	u32 b4, b7;
 	s32 oss = data->oversampling_press;
-	struct bmp180_calib calib;
-
-	ret = bmp180_read_calib(data, &calib);
-	if (ret < 0) {
-		dev_err(data->dev,
-			"failed to read calibration coefficients\n");
-		return ret;
-	}
+	struct bmp180_calib *calib = &data->calib;
 
 	b6 = data->t_fine - 4000;
-	x1 = (calib.B2 * (b6 * b6 >> 12)) >> 11;
-	x2 = calib.AC2 * b6 >> 11;
+	x1 = (calib->B2 * (b6 * b6 >> 12)) >> 11;
+	x2 = calib->AC2 * b6 >> 11;
 	x3 = x1 + x2;
-	b3 = ((((s32)calib.AC1 * 4 + x3) << oss) + 2) / 4;
-	x1 = calib.AC3 * b6 >> 13;
-	x2 = (calib.B1 * ((b6 * b6) >> 12)) >> 16;
+	b3 = ((((s32)calib->AC1 * 4 + x3) << oss) + 2) / 4;
+	x1 = calib->AC3 * b6 >> 13;
+	x2 = (calib->B1 * ((b6 * b6) >> 12)) >> 16;
 	x3 = (x1 + x2 + 2) >> 2;
-	b4 = calib.AC4 * (u32)(x3 + 32768) >> 15;
+	b4 = calib->AC4 * (u32)(x3 + 32768) >> 15;
 	b7 = ((u32)adc_press - b3) * (50000 >> oss);
 	if (b7 < 0x80000000)
 		p = (b7 * 2) / b4;
@@ -1018,6 +1007,19 @@ int bmp280_common_probe(struct device *dev,
 	dev_set_drvdata(dev, data);
 
 	/*
+	 * The BMP085 and BMP180 has calibration in an E2PROM, read it out
+	 * at probe time. It will not change.
+	 */
+	if (chip_id  == BMP180_CHIP_ID) {
+		ret = bmp180_read_calib(data, &data->calib);
+		if (ret < 0) {
+			dev_err(data->dev,
+				"failed to read calibration coefficients\n");
+			goto out_disable_vdda;
+		}
+	}
+
+	/*
 	 * Attempt to grab an optional EOC IRQ - only the BMP085 has this
 	 * however as it happens, the BMP085 shares the chip ID of BMP180
 	 * so we look for an IRQ if we have that.
-- 
2.4.11
