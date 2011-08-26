Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 07/12] staging:iio: rework of attribute registration.
Date: Fri, 26 Aug 2011 11:16:30 +0100
Message-Id: <1314353795-7437-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
References: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This set also includes quite a number of bug fixes of particularly
remove functions.

Necessary due to issue pointed out in Bart Van Assche's patch:
docs/driver-model: Document device.groups

V2: Rebase due to patch reordering.
V3: Pull various error fixes and cleanups out into their own patches.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_core.c      |   16 +-
 drivers/staging/iio/accel/adis16203_core.c      |   17 +-
 drivers/staging/iio/accel/adis16204_core.c      |   18 +-
 drivers/staging/iio/accel/adis16209_core.c      |   16 +-
 drivers/staging/iio/accel/adis16240_core.c      |   15 +-
 drivers/staging/iio/accel/lis3l02dq_core.c      |   18 +-
 drivers/staging/iio/adc/ad7150.c                |   20 +-
 drivers/staging/iio/adc/ad7291.c                |   12 +-
 drivers/staging/iio/adc/ad7298_core.c           |   18 +-
 drivers/staging/iio/adc/ad7476_core.c           |   16 +-
 drivers/staging/iio/adc/ad7606_core.c           |   17 +-
 drivers/staging/iio/adc/ad7745.c                |   18 +-
 drivers/staging/iio/adc/ad7793.c                |   16 +-
 drivers/staging/iio/adc/ad7816.c                |   15 +-
 drivers/staging/iio/adc/ad7887_core.c           |   20 +-
 drivers/staging/iio/adc/ad799x_core.c           |   17 +-
 drivers/staging/iio/adc/adt7310.c               |   12 +-
 drivers/staging/iio/adc/adt7410.c               |   11 +-
 drivers/staging/iio/adc/adt75.c                 |   12 +-
 drivers/staging/iio/adc/max1363_core.c          |   18 +-
 drivers/staging/iio/addac/adt7316.c             |   13 +-
 drivers/staging/iio/dac/ad5504.c                |   40 ++--
 drivers/staging/iio/dac/ad5624r_spi.c           |    1 -
 drivers/staging/iio/dac/ad5686.c                |   13 +-
 drivers/staging/iio/dac/ad5791.c                |    2 +
 drivers/staging/iio/gyro/adis16060_core.c       |    8 +-
 drivers/staging/iio/gyro/adis16080_core.c       |    9 +-
 drivers/staging/iio/gyro/adis16260_core.c       |   15 +-
 drivers/staging/iio/iio.h                       |    7 +
 drivers/staging/iio/iio_core.h                  |    1 -
 drivers/staging/iio/impedance-analyzer/ad5933.c |   16 +-
 drivers/staging/iio/imu/adis16400_core.c        |   16 +-
 drivers/staging/iio/industrialio-core.c         |  226 +++++++++++------------
 drivers/staging/iio/industrialio-ring.c         |  107 +++++------
 drivers/staging/iio/industrialio-trigger.c      |    8 +-
 drivers/staging/iio/light/tsl2563.c             |    9 +-
 drivers/staging/iio/meter/ade7753.c             |   15 +-
 drivers/staging/iio/meter/ade7754.c             |   16 +-
 drivers/staging/iio/meter/ade7758_core.c        |   18 +-
 drivers/staging/iio/meter/ade7759.c             |   12 +-
 drivers/staging/iio/resolver/ad2s1210.c         |    1 +
 drivers/staging/iio/ring_generic.h              |    3 +-
 42 files changed, 390 insertions(+), 488 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 11fd17a..942a9886 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -462,7 +462,7 @@ static const struct iio_info adis16201_info = {
 
 static int __devinit adis16201_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct adis16201_state *st;
 	struct iio_dev *indio_dev;
 
@@ -491,11 +491,6 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unreg_ring_funcs;
-	regdone = 1;
-
 	ret = iio_ring_buffer_register(indio_dev,
 				       adis16201_channels,
 				       ARRAY_SIZE(adis16201_channels));
@@ -514,6 +509,10 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 	ret = adis16201_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto error_remove_trigger;
 	return 0;
 
 error_remove_trigger:
@@ -523,10 +522,7 @@ error_uninitialize_ring:
 error_unreg_ring_funcs:
 	adis16201_unconfigure_ring(indio_dev);
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 7909a67..067e761 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -418,7 +418,7 @@ static const struct iio_info adis16203_info = {
 
 static int __devinit adis16203_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct iio_dev *indio_dev;
 	struct adis16203_state *st;
 
@@ -445,11 +445,6 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unreg_ring_funcs;
-	regdone = 1;
-
 	ret = iio_ring_buffer_register(indio_dev,
 				       adis16203_channels,
 				       ARRAY_SIZE(adis16203_channels));
@@ -468,6 +463,11 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 	ret = adis16203_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_remove_trigger;
+
 	return 0;
 
 error_remove_trigger:
@@ -477,10 +477,7 @@ error_uninitialize_ring:
 error_unreg_ring_funcs:
 	adis16203_unconfigure_ring(indio_dev);
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 4458d9d..a653c19 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -493,7 +493,7 @@ static const struct iio_info adis16204_info = {
 
 static int __devinit adis16204_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct adis16204_state *st;
 	struct iio_dev *indio_dev;
 
@@ -520,11 +520,6 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unreg_ring_funcs;
-	regdone = 1;
-
 	ret = iio_ring_buffer_register(indio_dev,
 				       adis16204_channels,
 				       ARRAY_SIZE(adis16204_channels));
@@ -543,6 +538,10 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 	ret = adis16204_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_remove_trigger;
+
 	return 0;
 
 error_remove_trigger:
@@ -552,10 +551,7 @@ error_uninitialize_ring:
 error_unreg_ring_funcs:
 	adis16204_unconfigure_ring(indio_dev);
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
@@ -569,6 +565,8 @@ static int adis16204_remove(struct spi_device *spi)
 	adis16204_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 
+	iio_device_unregister(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 178d64e..183b5c2 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -466,7 +466,7 @@ static const struct iio_info adis16209_info = {
 
 static int __devinit adis16209_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct adis16209_state *st;
 	struct iio_dev *indio_dev;
 
@@ -493,11 +493,6 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unreg_ring_funcs;
-	regdone = 1;
-
 	ret = iio_ring_buffer_register(indio_dev,
 				       adis16209_channels,
 				       ARRAY_SIZE(adis16209_channels));
@@ -516,6 +511,10 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 	ret = adis16209_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_remove_trigger;
+
 	return 0;
 
 error_remove_trigger:
@@ -525,10 +524,7 @@ error_uninitialize_ring:
 error_unreg_ring_funcs:
 	adis16209_unconfigure_ring(indio_dev);
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index cae8b27..9ffd14c 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -518,7 +518,7 @@ static const struct iio_info adis16240_info = {
 
 static int __devinit adis16240_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct adis16240_state *st;
 	struct iio_dev *indio_dev;
 
@@ -546,11 +546,6 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unreg_ring_funcs;
-	regdone = 1;
-
 	ret = iio_ring_buffer_register(indio_dev,
 				       adis16240_channels,
 				       ARRAY_SIZE(adis16240_channels));
@@ -569,6 +564,9 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 	ret = adis16240_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_remove_trigger;
 	return 0;
 
 error_remove_trigger:
@@ -578,10 +576,7 @@ error_uninitialize_ring:
 error_unreg_ring_funcs:
 	adis16240_unconfigure_ring(indio_dev);
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 4ba1e44..98c5f55 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -662,7 +662,7 @@ static const struct iio_info lis3l02dq_info = {
 
 static int __devinit lis3l02dq_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct lis3l02dq_state *st;
 	struct iio_dev *indio_dev;
 
@@ -689,11 +689,6 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unreg_ring_funcs;
-	regdone = 1;
-
 	ret = iio_ring_buffer_register(indio_dev,
 				       lis3l02dq_channels,
 				       ARRAY_SIZE(lis3l02dq_channels));
@@ -721,6 +716,11 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	ret = lis3l02dq_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_remove_trigger;
+
 	return 0;
 
 error_remove_trigger:
@@ -734,9 +734,6 @@ error_uninitialize_ring:
 error_unreg_ring_funcs:
 	lis3l02dq_unconfigure_ring(indio_dev);
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
 		iio_free_device(indio_dev);
 error_ret:
 	return ret;
@@ -789,9 +786,8 @@ static int lis3l02dq_remove(struct spi_device *spi)
 	lis3l02dq_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev);
 	lis3l02dq_unconfigure_ring(indio_dev);
-	iio_device_unregister(indio_dev);
 
-	return 0;
+	iio_device_unregister(indio_dev);
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index 973fcea..3e4801f 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -718,7 +718,7 @@ static const struct iio_info ad7150_info = {
 static int __devinit ad7150_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
-	int ret = 0, regdone = 0;
+	int ret;
 	struct ad7150_chip_info *chip;
 	struct iio_dev *indio_dev;
 
@@ -741,11 +741,6 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_free_dev;
-	regdone = 1;
-
 	if (client->irq) {
 		ret = request_threaded_irq(client->irq,
 					   NULL,
@@ -758,15 +753,20 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 			goto error_free_dev;
 	}
 
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_free_irq;
+
+
 	dev_err(&client->dev, "%s capacitive sensor registered, irq: %d\n", id->name, client->irq);
 
 	return 0;
+error_free_irq:
+	if (client->irq)
+		free_irq(client->irq, indio_dev);
 
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index cf927e1..52e0311 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -810,10 +810,6 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 	indio_dev->info = &ad7291_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_free_dev;
-
 	if (client->irq > 0) {
 		ret = request_threaded_irq(client->irq,
 					   NULL,
@@ -822,7 +818,7 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 					   id->name,
 					   indio_dev);
 		if (ret)
-			goto error_unreg_dev;
+			goto error_free_dev;
 
 		/* set irq polarity low level */
 		chip->command |= AD7291_ALART_POLARITY;
@@ -834,6 +830,10 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 		goto error_unreg_irq;
 	}
 
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_unreg_irq;
+
 	dev_info(&client->dev, "%s temperature sensor registered.\n",
 			 id->name);
 
@@ -841,8 +841,6 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 
 error_unreg_irq:
 	free_irq(client->irq, indio_dev);
-error_unreg_dev:
-	iio_device_unregister(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
 error_ret:
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 1d89382..c25ae1a 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -164,7 +164,7 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 {
 	struct ad7298_platform_data *pdata = spi->dev.platform_data;
 	struct ad7298_state *st;
-	int ret, regdone = 0;
+	int ret;
 	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
 
 	if (indio_dev == NULL)
@@ -217,19 +217,19 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_disable_reg;
-	regdone = 1;
-
 	ret = iio_ring_buffer_register(indio_dev,
 				       &ad7298_channels[1], /* skip temp0 */
 				       ARRAY_SIZE(ad7298_channels) - 1);
 	if (ret)
 		goto error_cleanup_ring;
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_unregister_ring;
 
 	return 0;
 
+error_unregister_ring:
+	iio_ring_buffer_unregister(indio_dev);
 error_cleanup_ring:
 	ad7298_ring_cleanup(indio_dev);
 error_disable_reg:
@@ -238,11 +238,7 @@ error_disable_reg:
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 
 	return ret;
 }
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 161820f..bf86e5b 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -128,7 +128,6 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	struct ad7476_state *st;
 	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
-	bool reg_done = false;
 
 	indio_dev = iio_allocate_device(sizeof(*st));
 	if (indio_dev == NULL) {
@@ -179,28 +178,29 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
 	ret = iio_ring_buffer_register(indio_dev,
 				       st->chip_info->channel,
 				       ARRAY_SIZE(st->chip_info->channel));
 	if (ret)
 		goto error_cleanup_ring;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_ring_unregister;
 	return 0;
 
+error_ring_unregister:
+	iio_ring_buffer_unregister(indio_dev);
 error_cleanup_ring:
 	ad7476_ring_cleanup(indio_dev);
-	iio_device_unregister(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	if (!reg_done)
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
+
 error_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 784f963..29e6ed8 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -438,7 +438,7 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 {
 	struct ad7606_platform_data *pdata = dev->platform_data;
 	struct ad7606_state *st;
-	int ret, regdone = 0;
+	int ret;
 	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
 
 	if (indio_dev == NULL) {
@@ -500,18 +500,18 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 	if (ret)
 		goto error_free_irq;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_free_irq;
-	regdone = 1;
-
 	ret = iio_ring_buffer_register(indio_dev,
 				       indio_dev->channels,
 				       indio_dev->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_unregister_ring;
 
 	return indio_dev;
+error_unregister_ring:
+	iio_ring_buffer_unregister(indio_dev);
 
 error_cleanup_ring:
 	ad7606_ring_cleanup(indio_dev);
@@ -528,10 +528,7 @@ error_disable_reg:
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ERR_PTR(ret);
 }
diff --git a/drivers/staging/iio/adc/ad7745.c b/drivers/staging/iio/adc/ad7745.c
index 4a504ce..4739593 100644
--- a/drivers/staging/iio/adc/ad7745.c
+++ b/drivers/staging/iio/adc/ad7745.c
@@ -577,7 +577,7 @@ static const struct iio_info ad774x_info = {
 static int __devinit ad774x_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
-	int ret = 0, regdone = 0;
+	int ret;
 	struct ad774x_chip_info *chip;
 	struct iio_dev *indio_dev;
 
@@ -598,11 +598,6 @@ static int __devinit ad774x_probe(struct i2c_client *client,
 	indio_dev->info = &ad774x_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_free_dev;
-	regdone = 1;
-
 	if (client->irq) {
 		ret = request_threaded_irq(client->irq,
 					   NULL,
@@ -614,15 +609,18 @@ static int __devinit ad774x_probe(struct i2c_client *client,
 			goto error_free_dev;
 	}
 
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_free_irq;
+
 	dev_err(&client->dev, "%s capacitive sensor registered, irq: %d\n", id->name, client->irq);
 
 	return 0;
 
+error_free_irq:
+	free_irq(client->irq, indio_dev);
 error_free_dev:
-	if (regdone)
-		free_irq(client->irq, indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index b42a7ac..17d18fc 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -827,7 +827,7 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 	struct ad7793_platform_data *pdata = spi->dev.platform_data;
 	struct ad7793_state *st;
 	struct iio_dev *indio_dev;
-	int ret, i, voltage_uv = 0, regdone = 0;
+	int ret, i, voltage_uv = 0;
 
 	if (!pdata) {
 		dev_err(&spi->dev, "no platform data?\n");
@@ -890,11 +890,6 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unreg_ring;
-	regdone = 1;
-
 	ret = ad7793_probe_trigger(indio_dev);
 	if (ret)
 		goto error_unreg_ring;
@@ -909,6 +904,10 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 	if (ret)
 		goto error_uninitialize_ring;
 
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_uninitialize_ring;
+
 	return 0;
 
 error_uninitialize_ring:
@@ -924,10 +923,7 @@ error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
 
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 
 	return ret;
 }
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 3a9c0fc..3049c68 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -395,10 +395,6 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
 	indio_dev->info = &ad7816_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_free_gpio;
-
 	if (spi_dev->irq) {
 		/* Only low trigger is supported in ad7816/7/8 */
 		ret = request_threaded_irq(spi_dev->irq,
@@ -408,16 +404,19 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
 					   indio_dev->name,
 					   indio_dev);
 		if (ret)
-			goto error_unreg_dev;
+			goto error_free_gpio;
 	}
 
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_free_irq;
+
 	dev_info(&spi_dev->dev, "%s temperature sensor and ADC registered.\n",
 			 indio_dev->name);
 
 	return 0;
-
-error_unreg_dev:
-	iio_device_unregister(indio_dev);
+error_free_irq:
+	free_irq(spi_dev->irq, indio_dev);
 error_free_gpio:
 	gpio_free(chip->busy_pin);
 error_free_gpio_convert:
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index eb1bd9c..cdaef23 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -92,7 +92,7 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 {
 	struct ad7887_platform_data *pdata = spi->dev.platform_data;
 	struct ad7887_state *st;
-	int ret, voltage_uv = 0, regdone = 0;
+	int ret, voltage_uv = 0;
 	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
 
 	if (indio_dev == NULL)
@@ -188,18 +188,19 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_disable_reg;
-	regdone = 1;
-
 	ret = iio_ring_buffer_register(indio_dev,
 				       indio_dev->channels,
 				       indio_dev->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
-	return 0;
 
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_unregister_ring;
+
+	return 0;
+error_unregister_ring:
+	iio_ring_buffer_unregister(indio_dev);
 error_cleanup_ring:
 	ad7887_ring_cleanup(indio_dev);
 error_disable_reg:
@@ -208,10 +209,7 @@ error_disable_reg:
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 
 	return ret;
 }
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 0a80744..c9115a0 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -656,7 +656,7 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 static int __devinit ad799x_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct ad799x_platform_data *pdata = client->dev.platform_data;
 	struct ad799x_state *st;
 	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
@@ -700,11 +700,6 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_cleanup_ring;
-	regdone = 1;
-
 	ret = iio_ring_buffer_register(indio_dev,
 				       indio_dev->channels,
 				       indio_dev->num_channels);
@@ -722,9 +717,14 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 		if (ret)
 			goto error_cleanup_ring;
 	}
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_free_irq;
 
 	return 0;
 
+error_free_irq:
+	free_irq(client->irq, indio_dev);
 error_cleanup_ring:
 	ad799x_ring_cleanup(indio_dev);
 error_disable_reg:
@@ -733,10 +733,7 @@ error_disable_reg:
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 
 	return ret;
 }
diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index 096e097..15061f3 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -781,10 +781,6 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 	indio_dev->info = &adt7310_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_free_dev;
-
 	/* CT critcal temperature event. line 0 */
 	if (spi_dev->irq) {
 		if (adt7310_platform_data[2])
@@ -798,7 +794,7 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 					   indio_dev->name,
 					   indio_dev);
 		if (ret)
-			goto error_unreg_dev;
+			goto error_free_dev;
 	}
 
 	/* INT bound temperature alarm event. line 1 */
@@ -835,6 +831,10 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 		}
 	}
 
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_unreg_int_irq;
+
 	dev_info(&spi_dev->dev, "%s temperature sensor registered.\n",
 			indio_dev->name);
 
@@ -844,8 +844,6 @@ error_unreg_int_irq:
 	free_irq(adt7310_platform_data[0], indio_dev);
 error_unreg_ct_irq:
 	free_irq(spi_dev->irq, indio_dev);
-error_unreg_dev:
-	iio_device_unregister(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
 error_ret:
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index c7b1ceb..074ad7e 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -748,10 +748,6 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 	indio_dev->info = &adt7410_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_free_dev;
-
 	/* CT critcal temperature event. line 0 */
 	if (client->irq) {
 		ret = request_threaded_irq(client->irq,
@@ -761,7 +757,7 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 					   id->name,
 					   indio_dev);
 		if (ret)
-			goto error_unreg_dev;
+			goto error_free_dev;
 	}
 
 	/* INT bound temperature alarm event. line 1 */
@@ -798,6 +794,9 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 			goto error_unreg_int_irq;
 		}
 	}
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_unreg_int_irq;
 
 	dev_info(&client->dev, "%s temperature sensor registered.\n",
 			 id->name);
@@ -808,8 +807,6 @@ error_unreg_int_irq:
 	free_irq(adt7410_platform_data[0], indio_dev);
 error_unreg_ct_irq:
 	free_irq(client->irq, indio_dev);
-error_unreg_dev:
-	iio_device_unregister(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
 error_ret:
diff --git a/drivers/staging/iio/adc/adt75.c b/drivers/staging/iio/adc/adt75.c
index 988c200..22f6fa0 100644
--- a/drivers/staging/iio/adc/adt75.c
+++ b/drivers/staging/iio/adc/adt75.c
@@ -566,10 +566,6 @@ static int __devinit adt75_probe(struct i2c_client *client,
 	indio_dev->info = &adt75_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_free_dev;
-
 	if (client->irq > 0) {
 		ret = request_threaded_irq(client->irq,
 					   NULL,
@@ -578,7 +574,7 @@ static int __devinit adt75_probe(struct i2c_client *client,
 					   indio_dev->name,
 					   indio_dev);
 		if (ret)
-			goto error_unreg_dev;
+			goto error_free_dev;
 
 		ret = adt75_i2c_read(indio_dev, ADT75_CONFIG, &chip->config);
 		if (ret) {
@@ -596,14 +592,16 @@ static int __devinit adt75_probe(struct i2c_client *client,
 		}
 	}
 
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_unreg_irq;
+
 	dev_info(&client->dev, "%s temperature sensor registered.\n",
 			 indio_dev->name);
 
 	return 0;
 error_unreg_irq:
 	free_irq(client->irq, indio_dev);
-error_unreg_dev:
-	iio_device_unregister(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
 error_ret:
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index aacc49b..97db51d 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -1253,7 +1253,7 @@ static int max1363_initial_setup(struct max1363_state *st)
 static int __devinit max1363_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
-	int ret, i, regdone = 0;
+	int ret, i;
 	struct max1363_state *st;
 	struct iio_dev *indio_dev;
 	struct regulator *reg;
@@ -1311,10 +1311,6 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	if (ret)
 		goto error_free_available_scan_masks;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_cleanup_ring;
-	regdone = 1;
 	ret = iio_ring_buffer_register(indio_dev,
 				       st->chip_info->channels,
 				       st->chip_info->num_channels);
@@ -1333,8 +1329,13 @@ static int __devinit max1363_probe(struct i2c_client *client,
 			goto error_uninit_ring;
 	}
 
-	return 0;
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto error_free_irq;
 
+	return 0;
+error_free_irq:
+	free_irq(st->client->irq, indio_dev);
 error_uninit_ring:
 	iio_ring_buffer_unregister(indio_dev);
 error_cleanup_ring:
@@ -1342,10 +1343,7 @@ error_cleanup_ring:
 error_free_available_scan_masks:
 	kfree(indio_dev->available_scan_masks);
 error_free_device:
-	if (!regdone)
-		iio_free_device(indio_dev);
-	else
-		iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 error_disable_reg:
 	regulator_disable(reg);
 error_put_reg:
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 14319d1b..993d13a 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2166,10 +2166,6 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_free_dev;
-
 	if (chip->bus.irq > 0) {
 		if (adt7316_platform_data[0])
 			chip->bus.irq_flags = adt7316_platform_data[0];
@@ -2181,7 +2177,7 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 					   indio_dev->name,
 					   indio_dev);
 		if (ret)
-			goto error_unreg_dev;
+			goto error_free_dev;
 
 		if (chip->bus.irq_flags & IRQF_TRIGGER_HIGH)
 			chip->config1 |= ADT7316_INT_POLARITY;
@@ -2199,6 +2195,10 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 		goto error_unreg_irq;
 	}
 
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_unreg_irq;
+
 	dev_info(dev, "%s temperature sensor, ADC and DAC registered.\n",
 			indio_dev->name);
 
@@ -2206,8 +2206,6 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 
 error_unreg_irq:
 	free_irq(chip->bus.irq, indio_dev);
-error_unreg_dev:
-	iio_device_unregister(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
 error_ret:
@@ -2220,7 +2218,6 @@ int __devexit adt7316_remove(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adt7316_chip_info *chip = iio_priv(indio_dev);
 
-	dev_set_drvdata(dev, NULL);
 	if (chip->bus.irq)
 		free_irq(chip->bus.irq, indio_dev);
 	iio_device_unregister(indio_dev);
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index 1893274..74b8e43 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -281,6 +281,11 @@ static int __devinit ad5504_probe(struct spi_device *spi)
 	struct regulator *reg;
 	int ret, voltage_uv = 0;
 
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
 	reg = regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(reg)) {
 		ret = regulator_enable(reg);
@@ -290,11 +295,6 @@ static int __devinit ad5504_probe(struct spi_device *spi)
 		voltage_uv = regulator_get_voltage(reg);
 	}
 
-	indio_dev = iio_allocate_device(sizeof(*st));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_disable_reg;
-	}
 	spi_set_drvdata(spi, indio_dev);
 	st = iio_priv(indio_dev);
 	if (voltage_uv)
@@ -314,10 +314,6 @@ static int __devinit ad5504_probe(struct spi_device *spi)
 		indio_dev->info = &ad5504_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_free_dev;
-
 	if (spi->irq) {
 		ret = request_threaded_irq(spi->irq,
 					   NULL,
@@ -326,15 +322,17 @@ static int __devinit ad5504_probe(struct spi_device *spi)
 					   spi_get_device_id(st->spi)->name,
 					   indio_dev);
 		if (ret)
-			goto error_unreg_iio_device;
+			goto error_disable_reg;
 	}
 
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_free_irq;
+
 	return 0;
 
-error_unreg_iio_device:
-	iio_device_unregister(indio_dev);
-error_free_dev:
-	iio_free_device(indio_dev);
+error_free_irq:
+	free_irq(spi->irq, indio_dev);
 error_disable_reg:
 	if (!IS_ERR(reg))
 		regulator_disable(reg);
@@ -342,6 +340,8 @@ error_put_reg:
 	if (!IS_ERR(reg))
 		regulator_put(reg);
 
+	iio_free_device(indio_dev);
+error_ret:
 	return ret;
 }
 
@@ -349,17 +349,17 @@ static int __devexit ad5504_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad5504_state *st = iio_priv(indio_dev);
-	struct regulator *reg = st->reg;
+
 	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
 
-	iio_device_unregister(indio_dev);
-
-	if (!IS_ERR(reg)) {
-		regulator_disable(reg);
-		regulator_put(reg);
+	if (!IS_ERR(st->reg)) {
+		regulator_disable(st->reg);
+		regulator_put(st->reg);
 	}
 
+	iio_device_unregister(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 5117c76..c591c0e 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -271,7 +271,6 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
 
 	return 0;
 
-
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index 05545a2..dbebb01 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -392,16 +392,16 @@ static int __devinit ad5686_probe(struct spi_device *spi)
 	indio_dev->channels = st->chip_info->channel;
 	indio_dev->num_channels = AD5686_DAC_CHANNELS;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
 	regdone = 1;
 	ret = ad5686_spi_write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
 				!!voltage_uv, 0);
 	if (ret)
 		goto error_disable_reg;
 
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_disable_reg;
+
 	return 0;
 
 error_disable_reg:
@@ -411,10 +411,7 @@ error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
 
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 
 	return ret;
 }
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index edf7477..b266513 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -395,6 +395,8 @@ static int __devexit ad5791_remove(struct spi_device *spi)
 	}
 	iio_device_unregister(indio_dev);
 
+	iio_device_unregister(indio_dev);
+
 	return 0;
 }
 
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 0cbe677..d86ec06 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -142,7 +142,7 @@ static const struct iio_chan_spec adis16060_channels[] = {
 
 static int __devinit adis16060_r_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct adis16060_state *st;
 	struct iio_dev *indio_dev;
 
@@ -168,16 +168,12 @@ static int __devinit adis16060_r_probe(struct spi_device *spi)
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
-	regdone = 1;
 
 	adis16060_iio_dev = indio_dev;
 	return 0;
 
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index bd3eb10..69f446c 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -136,7 +136,7 @@ static const struct iio_info adis16080_info = {
 
 static int __devinit adis16080_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct adis16080_state *st;
 	struct iio_dev *indio_dev;
 
@@ -164,15 +164,10 @@ static int __devinit adis16080_probe(struct spi_device *spi)
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
-	regdone = 1;
-
 	return 0;
 
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 18d2a28..e45ea26 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -576,7 +576,7 @@ static const struct iio_info adis16260_info = {
 
 static int __devinit adis16260_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct adis16260_platform_data *pd = spi->dev.platform_data;
 	struct adis16260_state *st;
 	struct iio_dev *indio_dev;
@@ -624,10 +624,6 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unreg_ring_funcs;
-	regdone = 1;
 	ret = iio_ring_buffer_register(indio_dev,
 				       indio_dev->channels,
 				       ARRAY_SIZE(adis16260_channels_x));
@@ -653,6 +649,10 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	ret = adis16260_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_remove_trigger;
+
 	return 0;
 
 error_remove_trigger:
@@ -662,10 +662,7 @@ error_uninitialize_ring:
 error_unreg_ring_funcs:
 	adis16260_unconfigure_ring(indio_dev);
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index fad88fc..a59988f 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -283,9 +283,12 @@ struct iio_info {
  * @num_channels:	[DRIVER] number of chanels specified in @channels.
  * @channel_attr_list:	[INTERN] keep track of automatically created channel
  *			attributes
+ * @chan_attr_group:	[INTERN] group for all attrs in base directory
  * @name:		[DRIVER] name of the device.
  * @info:		[DRIVER] callbacks and constant info from driver
  * @chrdev:		[INTERN] associated character device
+ * @groups:		[INTERN] attribute groups
+ * @groupcounter:	[INTERN] index of next attribute group
  **/
 struct iio_dev {
 	int				id;
@@ -308,9 +311,13 @@ struct iio_dev {
 	int				num_channels;
 
 	struct list_head		channel_attr_list;
+	struct attribute_group		chan_attr_group;
 	const char			*name;
 	const struct iio_info		*info;
 	struct cdev			chrdev;
+#define IIO_MAX_GROUPS 6
+	const struct attribute_group	*groups[IIO_MAX_GROUPS + 1];
+	int				groupcounter;
 };
 
 /**
diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
index d7eb0d8..3a80dbf 100644
--- a/drivers/staging/iio/iio_core.h
+++ b/drivers/staging/iio/iio_core.h
@@ -14,7 +14,6 @@
 #define _IIO_CORE_H_
 
 int __iio_add_chan_devattr(const char *postfix,
-			   const char *group,
 			   struct iio_chan_spec const *chan,
 			   ssize_t (*func)(struct device *dev,
 					   struct device_attribute *attr,
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index e199bbe..65399d1 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -675,7 +675,7 @@ static void ad5933_work(struct work_struct *work)
 static int __devinit ad5933_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
-	int ret, regdone = 0, voltage_uv = 0;
+	int ret, voltage_uv = 0;
 	struct ad5933_platform_data *pdata = client->dev.platform_data;
 	struct ad5933_state *st;
 	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
@@ -727,11 +727,6 @@ static int __devinit ad5933_probe(struct i2c_client *client,
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unreg_ring;
-	regdone = 1;
-
 	/* skip temp0_input, register in0_(real|imag)_raw */
 	ret = iio_ring_buffer_register(indio_dev, &ad5933_channels[1], 2);
 	if (ret)
@@ -745,6 +740,10 @@ static int __devinit ad5933_probe(struct i2c_client *client,
 	if (ret)
 		goto error_uninitialize_ring;
 
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_uninitialize_ring;
+
 	return 0;
 
 error_uninitialize_ring:
@@ -758,10 +757,7 @@ error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
 
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 
 	return ret;
 }
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 8a93053..02ba9be 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -820,7 +820,7 @@ static const struct iio_info adis16400_info = {
 
 static int __devinit adis16400_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct adis16400_state *st;
 	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
 	if (indio_dev == NULL) {
@@ -847,11 +847,6 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unreg_ring_funcs;
-	regdone = 1;
-
 	ret = iio_ring_buffer_register(indio_dev,
 				       st->variant->channels,
 				       st->variant->num_channels);
@@ -870,6 +865,10 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 	ret = adis16400_initial_setup(indio_dev);
 	if (ret)
 		goto error_remove_trigger;
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_remove_trigger;
+
 	return 0;
 
 error_remove_trigger:
@@ -880,10 +879,7 @@ error_uninitialize_ring:
 error_unreg_ring_funcs:
 	adis16400_unconfigure_ring(indio_dev);
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 2af056c..49322bf 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -119,6 +119,7 @@ struct iio_event_interface {
 	int					current_events;
 	struct list_head dev_attr_list;
 	unsigned long flags;
+	struct attribute_group			group;
 };
 
 int iio_push_event(struct iio_dev *dev_info, u64 ev_code, s64 timestamp)
@@ -506,7 +507,6 @@ static void __iio_device_attr_deinit(struct device_attribute *dev_attr)
 }
 
 int __iio_add_chan_devattr(const char *postfix,
-			   const char *group,
 			   struct iio_chan_spec const *chan,
 			   ssize_t (*readfunc)(struct device *dev,
 					       struct device_attribute *attr,
@@ -544,12 +544,6 @@ int __iio_add_chan_devattr(const char *postfix,
 			ret = -EBUSY;
 			goto error_device_attr_deinit;
 		}
-
-	ret = sysfs_add_file_to_group(&dev->kobj,
-				      &iio_attr->dev_attr.attr, group);
-	if (ret < 0)
-		goto error_device_attr_deinit;
-
 	list_add(&iio_attr->l, attr_list);
 
 	return 0;
@@ -565,13 +559,13 @@ error_ret:
 static int iio_device_add_channel_sysfs(struct iio_dev *dev_info,
 					struct iio_chan_spec const *chan)
 {
-	int ret, i;
+	int ret, i, attrcount = 0;
 
 	if (chan->channel < 0)
 		return 0;
 
 	ret = __iio_add_chan_devattr(iio_data_type_name[chan->processed_val],
-				     NULL, chan,
+				     chan,
 				     &iio_read_channel_info,
 				     (chan->output ?
 				      &iio_write_channel_info : NULL),
@@ -581,10 +575,11 @@ static int iio_device_add_channel_sysfs(struct iio_dev *dev_info,
 				     &dev_info->channel_attr_list);
 	if (ret)
 		goto error_ret;
+	attrcount++;
 
 	for_each_set_bit(i, &chan->info_mask, sizeof(long)*8) {
 		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i/2],
-					     NULL, chan,
+					     chan,
 					     &iio_read_channel_info,
 					     &iio_write_channel_info,
 					     (1 << i),
@@ -597,7 +592,9 @@ static int iio_device_add_channel_sysfs(struct iio_dev *dev_info,
 		}
 		if (ret < 0)
 			goto error_ret;
+		attrcount++;
 	}
+	ret = attrcount;
 error_ret:
 	return ret;
 }
@@ -605,8 +602,6 @@ error_ret:
 static void iio_device_remove_and_free_read_attr(struct iio_dev *dev_info,
 						 struct iio_dev_attr *p)
 {
-	sysfs_remove_file_from_group(&dev_info->dev.kobj,
-				     &p->dev_attr.attr, NULL);
 	kfree(p->dev_attr.attr.name);
 	kfree(p);
 }
@@ -621,31 +616,19 @@ static ssize_t iio_show_dev_name(struct device *dev,
 
 static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
 
-static struct attribute *iio_base_dummy_attrs[] = {
-	NULL
-};
-static struct attribute_group iio_base_dummy_group = {
-	.attrs = iio_base_dummy_attrs,
-};
-
 static int iio_device_register_sysfs(struct iio_dev *dev_info)
 {
-	int i, ret = 0;
+	int i, ret = 0, attrcount, attrn, attrcount_orig = 0;
 	struct iio_dev_attr *p, *n;
+	struct attribute **attr;
 
-	if (dev_info->info->attrs)
-		ret = sysfs_create_group(&dev_info->dev.kobj,
-					 dev_info->info->attrs);
-	else
-		ret = sysfs_create_group(&dev_info->dev.kobj,
-					 &iio_base_dummy_group);
-	
-	if (ret) {
-		dev_err(dev_info->dev.parent,
-			"Failed to register sysfs hooks\n");
-		goto error_ret;
+	/* First count elements in any existing group */
+	if (dev_info->info->attrs) {
+		attr = dev_info->info->attrs->attrs;
+		while (*attr++ != NULL)
+			attrcount_orig++;
 	}
-
+	attrcount = attrcount_orig;
 	/*
 	 * New channel registration method - relies on the fact a group does
 	 *  not need to be initialized if it is name is NULL.
@@ -658,14 +641,36 @@ static int iio_device_register_sysfs(struct iio_dev *dev_info)
 							   ->channels[i]);
 			if (ret < 0)
 				goto error_clear_attrs;
+			attrcount += ret;
 		}
-	if (dev_info->name) { 
-		ret = sysfs_add_file_to_group(&dev_info->dev.kobj,
-					      &dev_attr_name.attr,
-					      NULL);
-		if (ret)
-			goto error_clear_attrs;
+
+	if (dev_info->name)
+		attrcount++;
+
+	dev_info->chan_attr_group.attrs
+		= kzalloc(sizeof(dev_info->chan_attr_group.attrs[0])*
+			  (attrcount + 1),
+			  GFP_KERNEL);
+	if (dev_info->chan_attr_group.attrs == NULL) {
+		ret = -ENOMEM;
+		goto error_clear_attrs;
 	}
+	/* Copy across original attributes */
+	if (dev_info->info->attrs)
+		memcpy(dev_info->chan_attr_group.attrs,
+		       dev_info->info->attrs->attrs,
+		       sizeof(dev_info->chan_attr_group.attrs[0])
+		       *attrcount_orig);
+	attrn = attrcount_orig;
+	/* Add all elements from the list. */
+	list_for_each_entry(p, &dev_info->channel_attr_list, l)
+		dev_info->chan_attr_group.attrs[attrn++] = &p->dev_attr.attr;
+	if (dev_info->name)
+		dev_info->chan_attr_group.attrs[attrn++] = &dev_attr_name.attr;
+
+	dev_info->groups[dev_info->groupcounter++] =
+		&dev_info->chan_attr_group;
+
 	return 0;
 
 error_clear_attrs:
@@ -674,32 +679,20 @@ error_clear_attrs:
 		list_del(&p->l);
 		iio_device_remove_and_free_read_attr(dev_info, p);
 	}
-	if (dev_info->info->attrs)
-		sysfs_remove_group(&dev_info->dev.kobj, dev_info->info->attrs);
-	else
-		sysfs_remove_group(&dev_info->dev.kobj, &iio_base_dummy_group);
-error_ret:
-	return ret;
 
+	return ret;
 }
 
 static void iio_device_unregister_sysfs(struct iio_dev *dev_info)
 {
 
 	struct iio_dev_attr *p, *n;
-	if (dev_info->name)
-		sysfs_remove_file_from_group(&dev_info->dev.kobj,
-					     &dev_attr_name.attr,
-					     NULL);
+
 	list_for_each_entry_safe(p, n, &dev_info->channel_attr_list, l) {
 		list_del(&p->l);
 		iio_device_remove_and_free_read_attr(dev_info, p);
 	}
-
-	if (dev_info->info->attrs)
-		sysfs_remove_group(&dev_info->dev.kobj, dev_info->info->attrs);
-	else
-		sysfs_remove_group(&dev_info->dev.kobj, &iio_base_dummy_group);
+	kfree(dev_info->chan_attr_group.attrs);
 }
 
 static const char * const iio_ev_type_text[] = {
@@ -790,7 +783,7 @@ static ssize_t iio_ev_value_store(struct device *dev,
 static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 				      struct iio_chan_spec const *chan)
 {
-	int ret = 0, i, mask = 0;
+	int ret = 0, i, mask = 0, attrcount = 0;
 	char *postfix;
 	if (!chan->event_mask)
 		return 0;
@@ -820,7 +813,6 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 						    i%IIO_EV_TYPE_MAX);
 
 		ret = __iio_add_chan_devattr(postfix,
-					     "events",
 					     chan,
 					     &iio_ev_state_show,
 					     iio_ev_state_store,
@@ -832,7 +824,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 		kfree(postfix);
 		if (ret)
 			goto error_ret;
-
+		attrcount++;
 		postfix = kasprintf(GFP_KERNEL, "%s_%s_value",
 				    iio_ev_type_text[i/IIO_EV_TYPE_MAX],
 				    iio_ev_dir_text[i%IIO_EV_TYPE_MAX]);
@@ -840,7 +832,7 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 			ret = -ENOMEM;
 			goto error_ret;
 		}
-		ret = __iio_add_chan_devattr(postfix, "events", chan,
+		ret = __iio_add_chan_devattr(postfix, chan,
 					     iio_ev_value_show,
 					     iio_ev_value_store,
 					     mask,
@@ -851,9 +843,9 @@ static int iio_device_add_event_sysfs(struct iio_dev *dev_info,
 		kfree(postfix);
 		if (ret)
 			goto error_ret;
-
+		attrcount++;
 	}
-
+	ret = attrcount;
 error_ret:
 	return ret;
 }
@@ -864,9 +856,6 @@ static inline void __iio_remove_event_config_attrs(struct iio_dev *dev_info)
 	list_for_each_entry_safe(p, n,
 				 &dev_info->event_interface->
 				 dev_attr_list, l) {
-		sysfs_remove_file_from_group(&dev_info->dev.kobj,
-					     &p->dev_attr.attr,
-					     NULL);
 		kfree(p->dev_attr.attr.name);
 		kfree(p);
 	}
@@ -874,18 +863,18 @@ static inline void __iio_remove_event_config_attrs(struct iio_dev *dev_info)
 
 static inline int __iio_add_event_config_attrs(struct iio_dev *dev_info)
 {
-	int j;
-	int ret;
+	int j, ret, attrcount = 0;
 
 	INIT_LIST_HEAD(&dev_info->event_interface->dev_attr_list);
 	/* Dynically created from the channels array */
 	for (j = 0; j < dev_info->num_channels; j++) {
 		ret = iio_device_add_event_sysfs(dev_info,
 						 &dev_info->channels[j]);
-		if (ret)
+		if (ret < 0)
 			goto error_clear_attrs;
+		attrcount += ret;
 	}
-	return 0;
+	return attrcount;
 
 error_clear_attrs:
 	__iio_remove_event_config_attrs(dev_info);
@@ -893,15 +882,6 @@ error_clear_attrs:
 	return ret;
 }
 
-static struct attribute *iio_events_dummy_attrs[] = {
-	NULL
-};
-
-static struct attribute_group iio_events_dummy_group = {
-	.name = "events",
-	.attrs = iio_events_dummy_attrs
-};
-
 static bool iio_check_for_dynamic_events(struct iio_dev *dev_info)
 {
 	int j;
@@ -922,9 +902,12 @@ static void iio_setup_ev_int(struct iio_event_interface *ev_int)
 	init_waitqueue_head(&ev_int->wait);
 }
 
+static const char *iio_event_group_name = "events";
 static int iio_device_register_eventset(struct iio_dev *dev_info)
 {
-	int ret = 0;
+	struct iio_dev_attr *p;
+	int ret = 0, attrcount_orig = 0, attrcount, attrn;
+	struct attribute **attr;
 
 	if (!(dev_info->info->event_attrs ||
 	      iio_check_for_dynamic_events(dev_info)))
@@ -938,41 +921,48 @@ static int iio_device_register_eventset(struct iio_dev *dev_info)
 	}
 
 	iio_setup_ev_int(dev_info->event_interface);
-	if (dev_info->info->event_attrs != NULL)
-		ret = sysfs_create_group(&dev_info->dev.kobj,
-					 dev_info->info->event_attrs);
-	else
-		ret = sysfs_create_group(&dev_info->dev.kobj,
-					 &iio_events_dummy_group);
-	if (ret) {
-		dev_err(&dev_info->dev,
-			"Failed to register sysfs for event attrs");
-		goto error_free_setup_event_lines;
+	if (dev_info->info->event_attrs != NULL) {
+		attr = dev_info->info->event_attrs->attrs;
+		while (*attr++ != NULL)
+			attrcount_orig++;
 	}
+	attrcount = attrcount_orig;
 	if (dev_info->channels) {
 		ret = __iio_add_event_config_attrs(dev_info);
-		if (ret) {
-			if (dev_info->info->event_attrs != NULL)
-				sysfs_remove_group(&dev_info->dev.kobj,
-						   dev_info->info
-						   ->event_attrs);
-			else
-				sysfs_remove_group(&dev_info->dev.kobj,
-						   &iio_events_dummy_group);
+		if (ret < 0)
 			goto error_free_setup_event_lines;
-		}
+		attrcount += ret;
 	}
 
+	dev_info->event_interface->group.name = iio_event_group_name;
+	dev_info->event_interface->group.attrs =
+		kzalloc(sizeof(dev_info->event_interface->group.attrs[0])
+			*(attrcount + 1),
+			GFP_KERNEL);
+	if (dev_info->event_interface->group.attrs == NULL) {
+		ret = -ENOMEM;
+		goto error_free_setup_event_lines;
+	}
+	if (dev_info->info->event_attrs)
+		memcpy(dev_info->event_interface->group.attrs,
+		       dev_info->info->event_attrs->attrs,
+		       sizeof(dev_info->event_interface->group.attrs[0])
+		       *attrcount_orig);
+	attrn = attrcount_orig;
+	/* Add all elements from the list. */
+	list_for_each_entry(p,
+			    &dev_info->event_interface->dev_attr_list,
+			    l)
+		dev_info->event_interface->group.attrs[attrn++] =
+			&p->dev_attr.attr;
+
+	dev_info->groups[dev_info->groupcounter++] =
+		&dev_info->event_interface->group;
+
 	return 0;
 
 error_free_setup_event_lines:
 	__iio_remove_event_config_attrs(dev_info);
-	if (dev_info->info->event_attrs != NULL)
-		sysfs_remove_group(&dev_info->dev.kobj,
-				   dev_info->info->event_attrs);
-	else
-		sysfs_remove_group(&dev_info->dev.kobj,
-				   &iio_events_dummy_group);
 	kfree(dev_info->event_interface);
 error_ret:
 
@@ -984,12 +974,7 @@ static void iio_device_unregister_eventset(struct iio_dev *dev_info)
 	if (dev_info->event_interface == NULL)
 		return;
 	__iio_remove_event_config_attrs(dev_info);
-	if (dev_info->info->event_attrs != NULL)
-		sysfs_remove_group(&dev_info->dev.kobj,
-				   dev_info->info->event_attrs);
-	else
-		sysfs_remove_group(&dev_info->dev.kobj,
-				   &iio_events_dummy_group);
+	kfree(dev_info->event_interface->group.attrs);
 	kfree(dev_info->event_interface);
 }
 
@@ -997,6 +982,11 @@ static void iio_dev_release(struct device *device)
 {
 	struct iio_dev *dev_info = container_of(device, struct iio_dev, dev);
 	cdev_del(&dev_info->chrdev);
+	if (dev_info->modes & INDIO_RING_TRIGGERED)
+		iio_device_unregister_trigger_consumer(dev_info);
+	iio_device_unregister_eventset(dev_info);
+	iio_device_unregister_sysfs(dev_info);
+	ida_simple_remove(&iio_ida, dev_info->id);
 	kfree(dev_info);
 }
 
@@ -1021,6 +1011,7 @@ struct iio_dev *iio_allocate_device(int sizeof_priv)
 	dev = kzalloc(alloc_size, GFP_KERNEL);
 
 	if (dev) {
+		dev->dev.groups = dev->groups;
 		dev->dev.type = &iio_dev_type;
 		dev->dev.bus = &iio_bus_type;
 		device_initialize(&dev->dev);
@@ -1104,14 +1095,11 @@ int iio_device_register(struct iio_dev *dev_info)
 	/* configure elements for the chrdev */
 	dev_info->dev.devt = MKDEV(MAJOR(iio_devt), dev_info->id);
 
-	ret = device_add(&dev_info->dev);
-	if (ret)
-		goto error_free_ida;
 	ret = iio_device_register_sysfs(dev_info);
 	if (ret) {
 		dev_err(dev_info->dev.parent,
 			"Failed to register sysfs interfaces\n");
-		goto error_del_device;
+		goto error_free_ida;
 	}
 	ret = iio_device_register_eventset(dev_info);
 	if (ret) {
@@ -1122,15 +1110,22 @@ int iio_device_register(struct iio_dev *dev_info)
 	if (dev_info->modes & INDIO_RING_TRIGGERED)
 		iio_device_register_trigger_consumer(dev_info);
 
+	ret = device_add(&dev_info->dev);
+	if (ret < 0)
+		goto error_unreg_eventset;
 	cdev_init(&dev_info->chrdev, &iio_ring_fileops);
 	dev_info->chrdev.owner = dev_info->info->driver_module;
 	ret = cdev_add(&dev_info->chrdev, dev_info->dev.devt, 1);
+	if (ret < 0)
+		goto error_del_device;
 	return 0;
 
-error_free_sysfs:
-	iio_device_unregister_sysfs(dev_info);
 error_del_device:
 	device_del(&dev_info->dev);
+error_unreg_eventset:
+	iio_device_unregister_eventset(dev_info);
+error_free_sysfs:
+	iio_device_unregister_sysfs(dev_info);
 error_free_ida:
 	ida_simple_remove(&iio_ida, dev_info->id);
 error_ret:
@@ -1140,11 +1135,6 @@ EXPORT_SYMBOL(iio_device_register);
 
 void iio_device_unregister(struct iio_dev *dev_info)
 {
-	if (dev_info->modes & INDIO_RING_TRIGGERED)
-		iio_device_unregister_trigger_consumer(dev_info);
-	iio_device_unregister_eventset(dev_info);
-	iio_device_unregister_sysfs(dev_info);
-	ida_simple_remove(&iio_ida, dev_info->id);
 	device_unregister(&dev_info->dev);
 }
 EXPORT_SYMBOL(iio_device_unregister);
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 6f14c0d..7a95fbe 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -207,10 +207,10 @@ error_ret:
 static int iio_ring_add_channel_sysfs(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan)
 {
-	int ret;
+	int ret, attrcount = 0;
 	struct iio_ring_buffer *ring = indio_dev->ring;
 
-	ret = __iio_add_chan_devattr("index", "scan_elements",
+	ret = __iio_add_chan_devattr("index",
 				     chan,
 				     &iio_show_scan_index,
 				     NULL,
@@ -220,8 +220,8 @@ static int iio_ring_add_channel_sysfs(struct iio_dev *indio_dev,
 				     &ring->scan_el_dev_attr_list);
 	if (ret)
 		goto error_ret;
-
-	ret = __iio_add_chan_devattr("type", "scan_elements",
+	attrcount++;
+	ret = __iio_add_chan_devattr("type",
 				     chan,
 				     &iio_show_fixed_type,
 				     NULL,
@@ -231,9 +231,9 @@ static int iio_ring_add_channel_sysfs(struct iio_dev *indio_dev,
 				     &ring->scan_el_dev_attr_list);
 	if (ret)
 		goto error_ret;
-
+	attrcount++;
 	if (chan->type != IIO_TIMESTAMP)
-		ret = __iio_add_chan_devattr("en", "scan_elements",
+		ret = __iio_add_chan_devattr("en",
 					     chan,
 					     &iio_scan_el_show,
 					     &iio_scan_el_store,
@@ -242,7 +242,7 @@ static int iio_ring_add_channel_sysfs(struct iio_dev *indio_dev,
 					     &indio_dev->dev,
 					     &ring->scan_el_dev_attr_list);
 	else
-		ret = __iio_add_chan_devattr("en", "scan_elements",
+		ret = __iio_add_chan_devattr("en",
 					     chan,
 					     &iio_scan_el_ts_show,
 					     &iio_scan_el_ts_store,
@@ -250,6 +250,8 @@ static int iio_ring_add_channel_sysfs(struct iio_dev *indio_dev,
 					     0,
 					     &indio_dev->dev,
 					     &ring->scan_el_dev_attr_list);
+	attrcount++;
+	ret = attrcount;
 error_ret:
 	return ret;
 }
@@ -257,66 +259,40 @@ error_ret:
 static void iio_ring_remove_and_free_scan_dev_attr(struct iio_dev *indio_dev,
 						   struct iio_dev_attr *p)
 {
-	sysfs_remove_file_from_group(&indio_dev->dev.kobj,
-				     &p->dev_attr.attr, "scan_elements");
 	kfree(p->dev_attr.attr.name);
 	kfree(p);
 }
 
-static struct attribute *iio_scan_el_dummy_attrs[] = {
-	NULL
-};
-
-static struct attribute_group iio_scan_el_dummy_group = {
-	.name = "scan_elements",
-	.attrs = iio_scan_el_dummy_attrs
-};
-
 static void __iio_ring_attr_cleanup(struct iio_dev *indio_dev)
 {
 	struct iio_dev_attr *p, *n;
 	struct iio_ring_buffer *ring = indio_dev->ring;
-	int anydynamic = !list_empty(&ring->scan_el_dev_attr_list);
+
 	list_for_each_entry_safe(p, n,
 				 &ring->scan_el_dev_attr_list, l)
 		iio_ring_remove_and_free_scan_dev_attr(indio_dev, p);
-
-	if (ring->scan_el_attrs)
-		sysfs_remove_group(&indio_dev->dev.kobj,
-				   ring->scan_el_attrs);
-	else if (anydynamic)
-		sysfs_remove_group(&indio_dev->dev.kobj,
-				   &iio_scan_el_dummy_group);
 }
 
+static const char * const iio_scan_elements_group_name = "scan_elements";
+
 int iio_ring_buffer_register(struct iio_dev *indio_dev,
 			     const struct iio_chan_spec *channels,
 			     int num_channels)
 {
+	struct iio_dev_attr *p;
+	struct attribute **attr;
 	struct iio_ring_buffer *ring = indio_dev->ring;
-	int ret, i;
-
-	if (ring->scan_el_attrs) {
-		ret = sysfs_create_group(&indio_dev->dev.kobj,
-					 ring->scan_el_attrs);
-		if (ret) {
-			dev_err(&indio_dev->dev,
-				"Failed to add sysfs scan elements\n");
-			goto error_ret;
-		}
-	} else if (channels) {
-		ret = sysfs_create_group(&indio_dev->dev.kobj,
-					 &iio_scan_el_dummy_group);
-		if (ret)
-			goto error_ret;
-	}
-	if (ring->attrs) {
-		ret = sysfs_create_group(&indio_dev->dev.kobj,
-					 ring->attrs);
-		if (ret)
-			goto error_cleanup_dynamic;
-	}
+	int ret, i, attrn, attrcount, attrcount_orig = 0;
+
+	if (ring->attrs)
+		indio_dev->groups[indio_dev->groupcounter++] = ring->attrs;
 
+	if (ring->scan_el_attrs != NULL) {
+		attr = ring->scan_el_attrs->attrs;
+		while (*attr++ != NULL)
+			attrcount_orig++;
+	}
+	attrcount = attrcount_orig;
 	INIT_LIST_HEAD(&ring->scan_el_dev_attr_list);
 	if (channels) {
 		/* new magic */
@@ -330,7 +306,8 @@ int iio_ring_buffer_register(struct iio_dev *indio_dev,
 			ret = iio_ring_add_channel_sysfs(indio_dev,
 							 &channels[i]);
 			if (ret < 0)
-				goto error_cleanup_group;
+				goto error_cleanup_dynamic;
+			attrcount += ret;
 		}
 		if (indio_dev->masklength && ring->scan_mask == NULL) {
 			ring->scan_mask
@@ -339,18 +316,36 @@ int iio_ring_buffer_register(struct iio_dev *indio_dev,
 					  GFP_KERNEL);
 			if (ring->scan_mask == NULL) {
 				ret = -ENOMEM;
-				goto error_cleanup_group;
+				goto error_cleanup_dynamic;
 			}
 		}
 	}
 
+	ring->scan_el_group.name = iio_scan_elements_group_name;
+
+	ring->scan_el_group.attrs
+		= kzalloc(sizeof(ring->scan_el_group.attrs[0])*(attrcount + 1),
+			  GFP_KERNEL);
+	if (ring->scan_el_group.attrs == NULL) {
+		ret = -ENOMEM;
+		goto error_free_scan_mask;
+	}
+	if (ring->scan_el_attrs)
+		memcpy(ring->scan_el_group.attrs, ring->scan_el_attrs,
+		       sizeof(ring->scan_el_group.attrs[0])*attrcount_orig);
+	attrn = attrcount_orig;
+
+	list_for_each_entry(p, &ring->scan_el_dev_attr_list, l)
+		ring->scan_el_group.attrs[attrn++] = &p->dev_attr.attr;
+	indio_dev->groups[indio_dev->groupcounter++] = &ring->scan_el_group;
+
 	return 0;
-error_cleanup_group:
-	if (ring->attrs)
-		sysfs_remove_group(&indio_dev->dev.kobj, ring->attrs);
+
+error_free_scan_mask:
+	kfree(ring->scan_mask);
 error_cleanup_dynamic:
 	__iio_ring_attr_cleanup(indio_dev);
-error_ret:
+
 	return ret;
 }
 EXPORT_SYMBOL(iio_ring_buffer_register);
@@ -358,9 +353,7 @@ EXPORT_SYMBOL(iio_ring_buffer_register);
 void iio_ring_buffer_unregister(struct iio_dev *indio_dev)
 {
 	kfree(indio_dev->ring->scan_mask);
-	if (indio_dev->ring->attrs)
-		sysfs_remove_group(&indio_dev->dev.kobj,
-				   indio_dev->ring->attrs);
+	kfree(indio_dev->ring->scan_el_group.attrs);
 	__iio_ring_attr_cleanup(indio_dev);
 }
 EXPORT_SYMBOL(iio_ring_buffer_unregister);
diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
index 3e60406..a66dcf7 100644
--- a/drivers/staging/iio/industrialio-trigger.c
+++ b/drivers/staging/iio/industrialio-trigger.c
@@ -475,8 +475,10 @@ EXPORT_SYMBOL(iio_free_trigger);
 
 int iio_device_register_trigger_consumer(struct iio_dev *dev_info)
 {
-	return sysfs_create_group(&dev_info->dev.kobj,
-				  &iio_trigger_consumer_attr_group);
+	dev_info->groups[dev_info->groupcounter++] =
+		&iio_trigger_consumer_attr_group;
+
+	return 0;
 }
 
 void iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
@@ -484,8 +486,6 @@ void iio_device_unregister_trigger_consumer(struct iio_dev *dev_info)
 	/* Clean up and associated but not attached triggers references */
 	if (dev_info->trig)
 		iio_put_trigger(dev_info->trig);
-	sysfs_remove_group(&dev_info->dev.kobj,
-			   &iio_trigger_consumer_attr_group);
 }
 
 int iio_triggered_ring_postenable(struct iio_dev *indio_dev)
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 7a57791..3707772 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -751,9 +751,6 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 		indio_dev->info = &tsl2563_info;
 	else
 		indio_dev->info = &tsl2563_info_no_irq;
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto fail1;
 	if (client->irq) {
 		ret = request_threaded_irq(client->irq,
 					   NULL,
@@ -772,12 +769,16 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 	/* The interrupt cannot yet be enabled so this is fine without lock */
 	schedule_delayed_work(&chip->poweroff_work, 5 * HZ);
 
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto fail3;
+
 	return 0;
 fail3:
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 fail2:
-	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 fail1:
 	kfree(chip);
 	return err;
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 4d1bd42..90f91db 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -512,7 +512,7 @@ static const struct iio_info ade7753_info = {
 
 static int __devinit ade7753_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct ade7753_state *st;
 	struct iio_dev *indio_dev;
 
@@ -534,22 +534,19 @@ static int __devinit ade7753_probe(struct spi_device *spi)
 	indio_dev->info = &ade7753_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
+	/* Get the device into a sane initial state */
+	ret = ade7753_initial_setup(indio_dev);
 	if (ret)
 		goto error_free_dev;
-	regdone = 1;
 
-	/* Get the device into a sane initial state */
-	ret = ade7753_initial_setup(indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
+
 	return 0;
 
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 
 error_ret:
 	return ret;
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index f4f85fd..5b825de 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -535,7 +535,7 @@ static const struct iio_info ade7754_info = {
 
 static int __devinit ade7754_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct ade7754_state *st;
 	struct iio_dev *indio_dev;
 
@@ -557,22 +557,18 @@ static int __devinit ade7754_probe(struct spi_device *spi)
 	indio_dev->info = &ade7754_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_free_dev;
-	regdone = 1;
-
 	/* Get the device into a sane initial state */
 	ret = ade7754_initial_setup(indio_dev);
 	if (ret)
 		goto error_free_dev;
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_free_dev;
+
 	return 0;
 
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 
 error_ret:
 	return ret;
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 13a7e9f..adcb5d2 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -732,7 +732,7 @@ static const struct iio_info ade7758_info = {
 
 static int __devinit ade7758_probe(struct spi_device *spi)
 {
-	int i, ret, regdone = 0;
+	int i, ret;
 	struct ade7758_state *st;
 	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
 
@@ -774,11 +774,6 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_tx;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unreg_ring_funcs;
-	regdone = 1;
-
 	ret = iio_ring_buffer_register(indio_dev,
 				       &ade7758_channels[0],
 				       ARRAY_SIZE(ade7758_channels));
@@ -795,9 +790,13 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	if (spi->irq) {
 		ret = ade7758_probe_trigger(indio_dev);
 		if (ret)
-			goto error_remove_trigger;
+			goto error_uninitialize_ring;
 	}
 
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_remove_trigger;
+
 	return 0;
 
 error_remove_trigger:
@@ -812,10 +811,7 @@ error_free_tx:
 error_free_rx:
 	kfree(st->rx);
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(indio_dev);
-	else
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index a51a64c..e78af76 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -479,19 +479,17 @@ static int __devinit ade7759_probe(struct spi_device *spi)
 	indio_dev->info = &ade7759_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(indio_dev);
+	/* Get the device into a sane initial state */
+	ret = ade7759_initial_setup(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
-	/* Get the device into a sane initial state */
-	ret = ade7759_initial_setup(indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_unreg_dev;
-	return 0;
+		goto error_free_dev;
 
+	return 0;
 
-error_unreg_dev:
-	iio_device_unregister(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
 error_ret:
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 1424469..535e242 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -783,6 +783,7 @@ static int __devexit ad2s1210_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad2s1210_state *st = iio_priv(indio_dev);
+
 	ad2s1210_free_gpios(st);
 	iio_device_unregister(indio_dev);
 
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 7a47f62..8f6ecde 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -9,6 +9,7 @@
 
 #ifndef _IIO_RING_GENERIC_H_
 #define _IIO_RING_GENERIC_H_
+#include <linux/sysfs.h>
 #include "iio.h"
 #include "chrdev.h"
 
@@ -109,7 +110,7 @@ struct iio_ring_buffer {
 	const struct iio_ring_access_funcs	*access;
 	const struct iio_ring_setup_ops		*setup_ops;
 	struct list_head			scan_el_dev_attr_list;
-
+	struct attribute_group			scan_el_group;
 	wait_queue_head_t			pollq;
 	bool					stufftoread;
 	unsigned long				flags;
-- 
1.7.3.4
