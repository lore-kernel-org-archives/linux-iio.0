Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] iio: st_sensors: fetch and enable regulators unconditionally
Date: Fri, 26 Aug 2016 00:10:08 +0200
Message-Id: <1472163008-9516-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

These sensors all have Vdd and Vdd_IO lines. This means the
supplies are *not* optional (optional means that the supply is
optional in the electrical sense, not the software sense)
so we need to get the and enable them at all times.

If the device tree or board file does not define suitable
regulators for the component, it will be substituted by a
dummy regulator, or, if regulators are disabled altogether,
by stubs. There is no need to use the IS_ERR_OR_NULL() check
that is considered harmful.

Cc: Giuseppe Barba <giuseppe.barba@st.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Gregor Boirie <gregor.boirie@parrot.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 55 +++++++++++--------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 2d5282e05482..41bfe1c5f4e9 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -234,39 +234,35 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
 	int err;
 
 	/* Regulators not mandatory, but if requested we should enable them. */
-	pdata->vdd = devm_regulator_get_optional(indio_dev->dev.parent, "vdd");
-	if (!IS_ERR(pdata->vdd)) {
-		err = regulator_enable(pdata->vdd);
-		if (err != 0) {
-			dev_warn(&indio_dev->dev,
-				 "Failed to enable specified Vdd supply\n");
-			return err;
-		}
-	} else {
-		err = PTR_ERR(pdata->vdd);
-		if (err != -ENODEV)
-			return err;
+	pdata->vdd = devm_regulator_get(indio_dev->dev.parent, "vdd");
+	if (IS_ERR(pdata->vdd)) {
+		dev_err(&indio_dev->dev, "unable to get Vdd supply\n");
+		return PTR_ERR(pdata->vdd);
+	}
+	err = regulator_enable(pdata->vdd);
+	if (err != 0) {
+		dev_warn(&indio_dev->dev,
+			 "Failed to enable specified Vdd supply\n");
+		return err;
 	}
 
-	pdata->vdd_io = devm_regulator_get_optional(indio_dev->dev.parent, "vddio");
-	if (!IS_ERR(pdata->vdd_io)) {
-		err = regulator_enable(pdata->vdd_io);
-		if (err != 0) {
-			dev_warn(&indio_dev->dev,
-				 "Failed to enable specified Vdd_IO supply\n");
-			goto st_sensors_disable_vdd;
-		}
-	} else {
-		err = PTR_ERR(pdata->vdd_io);
-		if (err != -ENODEV)
-			goto st_sensors_disable_vdd;
+	pdata->vdd_io = devm_regulator_get(indio_dev->dev.parent, "vddio");
+	if (IS_ERR(pdata->vdd)) {
+		dev_err(&indio_dev->dev, "unable to get Vdd_IO supply\n");
+		err = PTR_ERR(pdata->vdd);
+		goto st_sensors_disable_vdd;
+	}
+	err = regulator_enable(pdata->vdd_io);
+	if (err != 0) {
+		dev_warn(&indio_dev->dev,
+			 "Failed to enable specified Vdd_IO supply\n");
+		goto st_sensors_disable_vdd;
 	}
 
 	return 0;
 
 st_sensors_disable_vdd:
-	if (!IS_ERR_OR_NULL(pdata->vdd))
-		regulator_disable(pdata->vdd);
+	regulator_disable(pdata->vdd);
 	return err;
 }
 EXPORT_SYMBOL(st_sensors_power_enable);
@@ -275,11 +271,8 @@ void st_sensors_power_disable(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *pdata = iio_priv(indio_dev);
 
-	if (!IS_ERR_OR_NULL(pdata->vdd))
-		regulator_disable(pdata->vdd);
-
-	if (!IS_ERR_OR_NULL(pdata->vdd_io))
-		regulator_disable(pdata->vdd_io);
+	regulator_disable(pdata->vdd);
+	regulator_disable(pdata->vdd_io);
 }
 EXPORT_SYMBOL(st_sensors_power_disable);
 
-- 
2.7.4
