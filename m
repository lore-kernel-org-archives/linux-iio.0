Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/9 v2] iio: pressure: bmp280: support supply regulators
Date: Wed, 22 Jun 2016 22:53:34 +0200
Message-Id: <1466628819-29784-5-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
References: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

The BMP058/BMP180/BMP280 is supplied with two power sources:
VDDA (analog power) and VDDD (digital power). As these may come
from regulators (as on the APQ8060 Dragonboard) we need the driver
to attempt to fetch and enable these regulators.

We FAIL if we cannot: boards should either define:
- Proper regulators if present
- Define fixed regulators if power is hardwired to the component
- Rely on dummy regulators (will be present on all DT systems and
  any boardfile system that calls regulator_has_full_constraints().

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Make the regulators non-optional: an optional supply is one you
  can choose not to supply ELECTRICALLY as in an internal charge
  pump taking its place or so.
- Bail out if not present and add some notices to the commit that
  boards need to think about their regulator usage.
---
 drivers/iio/pressure/bmp280.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
index f7fd98e93850..3051e7c444d2 100644
--- a/drivers/iio/pressure/bmp280.c
+++ b/drivers/iio/pressure/bmp280.c
@@ -24,6 +24,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
 
 /* BMP280 specific registers */
 #define BMP280_REG_HUMIDITY_LSB		0xFE
@@ -124,6 +125,8 @@ struct bmp280_data {
 	struct mutex lock;
 	struct regmap *regmap;
 	const struct bmp280_chip_info *chip_info;
+	struct regulator *vddd;
+	struct regulator *vdda;
 
 	/* log of base 2 of oversampling rate */
 	u8 oversampling_press;
@@ -1065,6 +1068,28 @@ static int bmp280_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
+	/* Bring up regulators */
+	data->vddd = devm_regulator_get(&client->dev, "vddd");
+	if (IS_ERR(data->vddd)) {
+		dev_err(&client->dev, "failed to get VDDD regulator\n");
+		return PTR_ERR(data->vddd);
+	}
+	ret = regulator_enable(data->vddd);
+	if (ret) {
+		dev_err(&client->dev, "failed to enable VDDD regulator\n");
+		return ret;
+	}
+	data->vdda = devm_regulator_get(&client->dev, "vdda");
+	if (IS_ERR(data->vdda)) {
+		dev_err(&client->dev, "failed to get VDDA regulator\n");
+		return PTR_ERR(data->vddd);
+	}
+	ret = regulator_enable(data->vdda);
+	if (ret) {
+		dev_err(&client->dev, "failed to enable VDDA\n");
+		return ret;
+	}
+
 	/* Bring chip out of reset if there is an assigned GPIO line */
 	gpiod = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
 	/* Deassert the signal */
-- 
2.4.11
