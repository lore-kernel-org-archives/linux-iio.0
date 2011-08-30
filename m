Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 14/14] staging:iio:various cleanup regulator use paths.
Date: Tue, 30 Aug 2011 12:41:19 +0100
Message-Id: <1314704479-15956-15-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
References: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

No way iio_device_allocate or iio_device_unregister effected
by regulators so copying tricks not needed.

This is really about regularizing the layout of drivers.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7476_core.c |   26 +++++-------
 drivers/staging/iio/dac/ad5624r_spi.c |   47 ++++++++++-----------
 drivers/staging/iio/dac/ad5686.c      |    7 +--
 drivers/staging/iio/dac/ad5791.c      |   74 +++++++++++++++------------------
 4 files changed, 70 insertions(+), 84 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index f0393d5..7329b00 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -130,7 +130,6 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
 	bool reg_done = false;
-	struct regulator *reg;
 
 	indio_dev = iio_allocate_device(sizeof(*st));
 	if (indio_dev == NULL) {
@@ -138,15 +137,14 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 		goto error_ret;
 	}
 	st = iio_priv(indio_dev);
-	reg = regulator_get(&spi->dev, "vcc");
-	if (!IS_ERR(reg)) {
-		ret = regulator_enable(reg);
+	st->reg = regulator_get(&spi->dev, "vcc");
+	if (!IS_ERR(st->reg)) {
+		ret = regulator_enable(st->reg);
 		if (ret)
 			goto error_put_reg;
 
-		voltage_uv = regulator_get_voltage(reg);
+		voltage_uv = regulator_get_voltage(st->reg);
 	}
-	st->reg = reg;
 	st->chip_info =
 		&ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
@@ -197,11 +195,11 @@ error_cleanup_ring:
 	ad7476_ring_cleanup(indio_dev);
 	iio_device_unregister(indio_dev);
 error_disable_reg:
-	if (!IS_ERR(reg))
+	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 error_put_reg:
-	if (!IS_ERR(reg))
-		regulator_put(reg);
+	if (!IS_ERR(st->reg))
+		regulator_put(st->reg);
 	if (!reg_done)
 		iio_free_device(indio_dev);
 error_ret:
@@ -212,16 +210,14 @@ static int ad7476_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7476_state *st = iio_priv(indio_dev);
-	/* copy needed as st will have been freed */
-	struct regulator *reg = st->reg;
 
 	iio_ring_buffer_unregister(indio_dev);
 	ad7476_ring_cleanup(indio_dev);
-	iio_device_unregister(indio_dev);
-	if (!IS_ERR(reg)) {
-		regulator_disable(reg);
-		regulator_put(reg);
+	if (!IS_ERR(st->reg)) {
+		regulator_disable(st->reg);
+		regulator_put(st->reg);
 	}
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index c4bdf42..0f1d431 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -228,24 +228,23 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
 {
 	struct ad5624r_state *st;
 	struct iio_dev *indio_dev;
-	struct regulator *reg;
 	int ret, voltage_uv = 0;
 
-	reg = regulator_get(&spi->dev, "vcc");
-	if (!IS_ERR(reg)) {
-		ret = regulator_enable(reg);
-		if (ret)
-			goto error_put_reg;
-
-		voltage_uv = regulator_get_voltage(reg);
-	}
 	indio_dev = iio_allocate_device(sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
-		goto error_disable_reg;
+		goto error_ret;
 	}
 	st = iio_priv(indio_dev);
-	st->reg = reg;
+	st->reg = regulator_get(&spi->dev, "vcc");
+	if (!IS_ERR(st->reg)) {
+		ret = regulator_enable(st->reg);
+		if (ret)
+			goto error_put_reg;
+
+		voltage_uv = regulator_get_voltage(st->reg);
+	}
+
 	spi_set_drvdata(spi, indio_dev);
 	st->chip_info =
 		&ad5624r_chip_info_tbl[spi_get_device_id(spi)->driver_data];
@@ -265,22 +264,23 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
 	ret = ad5624r_spi_write(spi, AD5624R_CMD_INTERNAL_REFER_SETUP, 0,
 				!!voltage_uv, 16);
 	if (ret)
-		goto error_free_dev;
+		goto error_disable_reg;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_dev;
+		goto error_disable_reg;
 
 	return 0;
 
-error_free_dev:
-	iio_free_device(indio_dev);
+
 error_disable_reg:
-	if (!IS_ERR(reg))
-		regulator_disable(reg);
+	if (!IS_ERR(st->reg))
+		regulator_disable(st->reg);
 error_put_reg:
-	if (!IS_ERR(reg))
-		regulator_put(reg);
+	if (!IS_ERR(st->reg))
+		regulator_put(st->reg);
+	iio_free_device(indio_dev);
+error_ret:
 
 	return ret;
 }
@@ -289,13 +289,12 @@ static int __devexit ad5624r_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5624r_state *st = iio_priv(indio_dev);
-	struct regulator *reg = st->reg;
 
-	iio_device_unregister(indio_dev);
-	if (!IS_ERR(reg)) {
-		regulator_disable(reg);
-		regulator_put(reg);
+	if (!IS_ERR(st->reg)) {
+		regulator_disable(st->reg);
+		regulator_put(st->reg);
 	}
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index ae71d3f..6d7a33f 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -452,11 +452,10 @@ static int __devexit ad5686_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5686_state *st = iio_priv(indio_dev);
-	struct regulator *reg = st->reg;
 
-	if (!IS_ERR(reg)) {
-		regulator_disable(reg);
-		regulator_put(reg);
+	if (!IS_ERR(st->reg)) {
+		regulator_disable(st->reg);
+		regulator_put(st->reg);
 	}
 
 	iio_device_unregister(indio_dev);
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index 5c45d0f..5a5de97 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -297,38 +297,37 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 {
 	struct ad5791_platform_data *pdata = spi->dev.platform_data;
 	struct iio_dev *indio_dev;
-	struct regulator *reg_vdd, *reg_vss;
 	struct ad5791_state *st;
 	int ret, pos_voltage_uv = 0, neg_voltage_uv = 0;
 
-	reg_vdd = regulator_get(&spi->dev, "vdd");
-	if (!IS_ERR(reg_vdd)) {
-		ret = regulator_enable(reg_vdd);
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	st = iio_priv(indio_dev);
+	st->reg_vdd = regulator_get(&spi->dev, "vdd");
+	if (!IS_ERR(st->reg_vdd)) {
+		ret = regulator_enable(st->reg_vdd);
 		if (ret)
 			goto error_put_reg_pos;
 
-		pos_voltage_uv = regulator_get_voltage(reg_vdd);
+		pos_voltage_uv = regulator_get_voltage(st->reg_vdd);
 	}
 
-	reg_vss = regulator_get(&spi->dev, "vss");
-	if (!IS_ERR(reg_vss)) {
-		ret = regulator_enable(reg_vss);
+	st->reg_vss = regulator_get(&spi->dev, "vss");
+	if (!IS_ERR(st->reg_vss)) {
+		ret = regulator_enable(st->reg_vss);
 		if (ret)
 			goto error_put_reg_neg;
 
-		neg_voltage_uv = regulator_get_voltage(reg_vss);
+		neg_voltage_uv = regulator_get_voltage(st->reg_vss);
 	}
 
-	indio_dev = iio_allocate_device(sizeof(*st));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_disable_reg_neg;
-	}
-	st = iio_priv(indio_dev);
 	st->pwr_down = true;
 	st->spi = spi;
 
-	if (!IS_ERR(reg_vss) && !IS_ERR(reg_vdd))
+	if (!IS_ERR(st->reg_vss) && !IS_ERR(st->reg_vdd))
 		st->vref_mv = (pos_voltage_uv - neg_voltage_uv) / 1000;
 	else if (pdata)
 		st->vref_mv = pdata->vref_pos_mv - pdata->vref_neg_mv;
@@ -337,7 +336,7 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 
 	ret = ad5791_spi_write(spi, AD5791_ADDR_SW_CTRL, AD5791_SWCTRL_RESET);
 	if (ret)
-		goto error_free_dev;
+		goto error_disable_reg_neg;
 
 	st->chip_info =
 		&ad5791_chip_info_tbl[spi_get_device_id(spi)->driver_data];
@@ -350,10 +349,7 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 	ret = ad5791_spi_write(spi, AD5791_ADDR_CTRL, st->ctrl |
 		AD5791_CTRL_OPGND | AD5791_CTRL_DACTRI);
 	if (ret)
-		goto error_free_dev;
-
-	st->reg_vdd = reg_vdd;
-	st->reg_vss = reg_vss;
+		goto error_disable_reg_neg;
 
 	spi_set_drvdata(spi, indio_dev);
 	indio_dev->dev.parent = &spi->dev;
@@ -362,25 +358,24 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_dev;
+		goto error_disable_reg_neg;
 
 	return 0;
 
-error_free_dev:
-	iio_free_device(indio_dev);
-
 error_disable_reg_neg:
-	if (!IS_ERR(reg_vss))
-		regulator_disable(reg_vss);
+	if (!IS_ERR(st->reg_vss))
+		regulator_disable(st->reg_vss);
 error_put_reg_neg:
-	if (!IS_ERR(reg_vss))
-		regulator_put(reg_vss);
+	if (!IS_ERR(st->reg_vss))
+		regulator_put(st->reg_vss);
 
-	if (!IS_ERR(reg_vdd))
-		regulator_disable(reg_vdd);
+	if (!IS_ERR(st->reg_vdd))
+		regulator_disable(st->reg_vdd);
 error_put_reg_pos:
-	if (!IS_ERR(reg_vdd))
-		regulator_put(reg_vdd);
+	if (!IS_ERR(st->reg_vdd))
+		regulator_put(st->reg_vdd);
+	iio_free_device(indio_dev);
+error_ret:
 
 	return ret;
 }
@@ -389,20 +384,17 @@ static int __devexit ad5791_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5791_state *st = iio_priv(indio_dev);
-	struct regulator *reg_vdd = st->reg_vdd;
-	struct regulator *reg_vss = st->reg_vss;
-
-	iio_device_unregister(indio_dev);
 
 	if (!IS_ERR(st->reg_vdd)) {
-		regulator_disable(reg_vdd);
-		regulator_put(reg_vdd);
+		regulator_disable(st->reg_vdd);
+		regulator_put(st->reg_vdd);
 	}
 
 	if (!IS_ERR(st->reg_vss)) {
-		regulator_disable(reg_vss);
-		regulator_put(reg_vss);
+		regulator_disable(st->reg_vss);
+		regulator_put(st->reg_vss);
 	}
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
-- 
1.7.3.4
