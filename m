Return-Path: <pgrudzinski@openmailbox.org>
From: =?UTF-8?q?Pawe=C5=82=20Grudzi=C5=84ski?= <pgrudzinski@openmailbox.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pawel Grudzinski <pgrudzinski@openmailbox.org>
Subject: [PATCH v2] iio: dac: ad5380: Fix probe failure when no external reference is supplied
Date: Tue, 19 Jul 2016 08:12:45 +0200
Message-Id: <20160719061302.8360-1-pgrudzinski@openmailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

From: Pawel Grudzinski <pgrudzinski@openmailbox.org>

Driver fails to load when there is no external Vref regulator defined,
leaving no way to use internal reference. ad5380_probe function tries to
obtain regulator with demv_regulator_get and checks for error, in which
case it would use internal reference. Even without "Vref" regulator defined
devm_regulator_get returns dummy regulator which makes function omit use of
internal reference and causes failure on regulator_get_voltage.

Replace demv_regulator_get with demv_regulator_get_optional, which returns
error instead of dummy regulator if it does not find one which is specified
by the caller to make ad5380_probe configure internal reference when no
"Vref" regulator is supplied.

Initialize internal regulator only if returned error is ENODEV, otherwise
propagate the error to the caller of probe.

Signed-off-by: Paweł Grudziński <pgrudzinski@openmailbox.org>
---
Changes in v2:
- Add error type checking to enable internal reference only on ENODEV and
return any other error to the caller.

 drivers/iio/dac/ad5380.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 97d2c51..144cfdc 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -401,7 +401,7 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
 	if (st->chip_info->int_vref == 2500)
 		ctrl |= AD5380_CTRL_INT_VREF_2V5;
 
-	st->vref_reg = devm_regulator_get(dev, "vref");
+	st->vref_reg = devm_regulator_get_optional(dev, "vref");
 	if (!IS_ERR(st->vref_reg)) {
 		ret = regulator_enable(st->vref_reg);
 		if (ret) {
@@ -416,8 +416,13 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
 
 		st->vref = ret / 1000;
 	} else {
-		st->vref = st->chip_info->int_vref;
-		ctrl |= AD5380_CTRL_INT_VREF_EN;
+		if (PTR_ERR(st->vref_reg) == -ENODEV) {
+			st->vref = st->chip_info->int_vref;
+			ctrl |= AD5380_CTRL_INT_VREF_EN;
+		} else {
+			ret = st->vref_reg;
+			goto error_free_reg;
+		}
 	}
 
 	ret = regmap_write(st->regmap, AD5380_REG_SF_CTRL, ctrl);
-- 
2.8.0
