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
Subject: [PATCH] iio: ad5380: Fix probe failure when no external reference is supplied
Date: Thu, 14 Jul 2016 01:32:01 +0200
Message-Id: <20160713233202.812-1-pgrudzinski@openmailbox.org>
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

Signed-off-by: Paweł Grudziński <pgrudzinski@openmailbox.org>
---
There are couple more places where I suspect similar issue with devices
having integrated reference, but I am sending this one because I tested it
with hardware. If this gets accepted, I will look through other drivers
obtaining Vref in same manner.

 drivers/iio/dac/ad5380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 97d2c51..257d455 100644
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
-- 
Best regards,

Paweł Grudziński
