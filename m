Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/8] staging:iio: Add ability to allocate private data space to iio_allocate_device
Date: Thu, 17 Mar 2011 21:00:23 +0000
Message-Id: <1300395627-18547-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1300395627-18547-1-git-send-email-jic23@cam.ac.uk>
References: <1300395627-18547-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Suggested by Arnd Bergmann

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/device.txt |    2 +-
 drivers/staging/iio/accel/adis16201_core.c   |    2 +-
 drivers/staging/iio/accel/adis16203_core.c   |    2 +-
 drivers/staging/iio/accel/adis16204_core.c   |    2 +-
 drivers/staging/iio/accel/adis16209_core.c   |    2 +-
 drivers/staging/iio/accel/adis16220_core.c   |    2 +-
 drivers/staging/iio/accel/adis16240_core.c   |    2 +-
 drivers/staging/iio/accel/kxsd9.c            |    2 +-
 drivers/staging/iio/accel/lis3l02dq_core.c   |    2 +-
 drivers/staging/iio/accel/sca3000_core.c     |    2 +-
 drivers/staging/iio/adc/ad7150.c             |    2 +-
 drivers/staging/iio/adc/ad7152.c             |    2 +-
 drivers/staging/iio/adc/ad7291.c             |    2 +-
 drivers/staging/iio/adc/ad7298_core.c        |    2 +-
 drivers/staging/iio/adc/ad7314.c             |    2 +-
 drivers/staging/iio/adc/ad7476_core.c        |    2 +-
 drivers/staging/iio/adc/ad7606_core.c        |    2 +-
 drivers/staging/iio/adc/ad7745.c             |    2 +-
 drivers/staging/iio/adc/ad7816.c             |    2 +-
 drivers/staging/iio/adc/ad7887_core.c        |    2 +-
 drivers/staging/iio/adc/ad799x_core.c        |    2 +-
 drivers/staging/iio/adc/adt7310.c            |    2 +-
 drivers/staging/iio/adc/adt7410.c            |    2 +-
 drivers/staging/iio/adc/adt75.c              |    2 +-
 drivers/staging/iio/adc/max1363_core.c       |    2 +-
 drivers/staging/iio/addac/adt7316.c          |    2 +-
 drivers/staging/iio/dac/ad5446.c             |    2 +-
 drivers/staging/iio/dac/ad5624r_spi.c        |    2 +-
 drivers/staging/iio/dac/max517.c             |    2 +-
 drivers/staging/iio/dds/ad5930.c             |    2 +-
 drivers/staging/iio/dds/ad9832.c             |    2 +-
 drivers/staging/iio/dds/ad9834.c             |    2 +-
 drivers/staging/iio/dds/ad9850.c             |    2 +-
 drivers/staging/iio/dds/ad9852.c             |    2 +-
 drivers/staging/iio/dds/ad9910.c             |    2 +-
 drivers/staging/iio/dds/ad9951.c             |    2 +-
 drivers/staging/iio/gyro/adis16060_core.c    |    2 +-
 drivers/staging/iio/gyro/adis16080_core.c    |    2 +-
 drivers/staging/iio/gyro/adis16130_core.c    |    2 +-
 drivers/staging/iio/gyro/adis16260_core.c    |    2 +-
 drivers/staging/iio/iio.h                    |   17 ++++++++++++++++-
 drivers/staging/iio/imu/adis16300_core.c     |    2 +-
 drivers/staging/iio/imu/adis16350_core.c     |    2 +-
 drivers/staging/iio/imu/adis16400_core.c     |    2 +-
 drivers/staging/iio/industrialio-core.c      |   15 +++++++++++++--
 drivers/staging/iio/light/isl29018.c         |    2 +-
 drivers/staging/iio/light/tsl2563.c          |    2 +-
 drivers/staging/iio/magnetometer/ak8975.c    |    2 +-
 drivers/staging/iio/magnetometer/hmc5843.c   |    2 +-
 drivers/staging/iio/meter/ade7753.c          |    2 +-
 drivers/staging/iio/meter/ade7754.c          |    2 +-
 drivers/staging/iio/meter/ade7758_core.c     |    2 +-
 drivers/staging/iio/meter/ade7759.c          |    2 +-
 drivers/staging/iio/meter/ade7854.c          |    2 +-
 drivers/staging/iio/resolver/ad2s120x.c      |    2 +-
 drivers/staging/iio/resolver/ad2s1210.c      |    2 +-
 drivers/staging/iio/resolver/ad2s90.c        |    2 +-
 57 files changed, 84 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/iio/Documentation/device.txt b/drivers/staging/iio/Documentation/device.txt
index 69d9570..c81e517 100644
--- a/drivers/staging/iio/Documentation/device.txt
+++ b/drivers/staging/iio/Documentation/device.txt
@@ -8,7 +8,7 @@ The crucial structure for device drivers in iio is iio_dev.
 
 First allocate one using:
 
-struct iio_dev *indio_dev = iio_allocate_device();
+struct iio_dev *indio_dev = iio_allocate_device(0);
 
 Then fill in the following:
 
diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 79b785a..df1101c 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -539,7 +539,7 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index b57f190..e5a2a47 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -448,7 +448,7 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index cc15e40..97376aa 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -493,7 +493,7 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index e4ac956..d2fb990 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -488,7 +488,7 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 1c1e98a..0689e41 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -572,7 +572,7 @@ static int __devinit adis16220_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index d11d164..31f64ae 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -485,7 +485,7 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index 79f5795..431aa0f 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -329,7 +329,7 @@ static int __devinit kxsd9_probe(struct spi_device *spi)
 
 	st->us = spi;
 	mutex_init(&st->buf_lock);
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index c4b4ab7..b5d6711 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -805,7 +805,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->help.indio_dev = iio_allocate_device();
+	st->help.indio_dev = iio_allocate_device(0);
 	if (st->help.indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 5b06dea..6abf2b7 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1339,7 +1339,7 @@ static int __devinit __sca3000_probe(struct spi_device *spi,
 	mutex_init(&st->lock);
 	st->info = &sca3000_spi_chip_info_tbl[variant];
 
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_rx;
diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index 8555766..5a2991a 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -778,7 +778,7 @@ static int __devinit ad7150_probe(struct i2c_client *client,
 	chip->client = client;
 	chip->name = id->name;
 
-	chip->indio_dev = iio_allocate_device();
+	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_chip;
diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index fa7f8406..163c307 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -533,7 +533,7 @@ static int __devinit ad7152_probe(struct i2c_client *client,
 	chip->client = client;
 	chip->name = id->name;
 
-	chip->indio_dev = iio_allocate_device();
+	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_chip;
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 34041a7..976ae7f 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -926,7 +926,7 @@ static int __devinit ad7291_probe(struct i2c_client *client,
 	chip->name = id->name;
 	chip->command = AD7291_NOISE_DELAY | AD7291_T_SENSE_MASK;
 
-	chip->indio_dev = iio_allocate_device();
+	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_chip;
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 2e9154e..8b3a490 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -173,7 +173,7 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 	atomic_set(&st->protect_ring, 0);
 	st->spi = spi;
 
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
diff --git a/drivers/staging/iio/adc/ad7314.c b/drivers/staging/iio/adc/ad7314.c
index 8c17b1f..dffbec1 100644
--- a/drivers/staging/iio/adc/ad7314.c
+++ b/drivers/staging/iio/adc/ad7314.c
@@ -229,7 +229,7 @@ static int __devinit ad7314_probe(struct spi_device *spi_dev)
 	chip->spi_dev = spi_dev;
 	chip->name = spi_dev->modalias;
 
-	chip->indio_dev = iio_allocate_device();
+	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_chip;
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index d263904..b16744c 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -184,7 +184,7 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	atomic_set(&st->protect_ring, 0);
 	st->spi = spi;
 
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 4c700f0..7ef9a6f 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -447,7 +447,7 @@ struct ad7606_state *ad7606_probe(struct device *dev, int irq,
 
 	atomic_set(&st->protect_ring, 0);
 
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
diff --git a/drivers/staging/iio/adc/ad7745.c b/drivers/staging/iio/adc/ad7745.c
index ab7ef84..1373d23 100644
--- a/drivers/staging/iio/adc/ad7745.c
+++ b/drivers/staging/iio/adc/ad7745.c
@@ -635,7 +635,7 @@ static int __devinit ad774x_probe(struct i2c_client *client,
 	chip->client = client;
 	chip->name = id->name;
 
-	chip->indio_dev = iio_allocate_device();
+	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_chip;
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index ad7415a..9e30d35 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -418,7 +418,7 @@ static int __devinit ad7816_probe(struct spi_device *spi_dev)
 	}
 	gpio_direction_input(chip->busy_pin);
 
-	chip->indio_dev = iio_allocate_device();
+	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_gpio;
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 5d85efa..11c9fcf 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -153,7 +153,7 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 	atomic_set(&st->protect_ring, 0);
 	st->spi = spi;
 
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index e50841b..d70ff25 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -801,7 +801,7 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 	}
 	st->client = client;
 
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index 771a409..7e66c42 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -794,7 +794,7 @@ static int __devinit adt7310_probe(struct spi_device *spi_dev)
 	chip->spi_dev = spi_dev;
 	chip->name = spi_dev->modalias;
 
-	chip->indio_dev = iio_allocate_device();
+	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_chip;
diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index c345f27..7cc3feb 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -764,7 +764,7 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 	chip->client = client;
 	chip->name = id->name;
 
-	chip->indio_dev = iio_allocate_device();
+	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_chip;
diff --git a/drivers/staging/iio/adc/adt75.c b/drivers/staging/iio/adc/adt75.c
index aff4d31..f247c4c 100644
--- a/drivers/staging/iio/adc/adt75.c
+++ b/drivers/staging/iio/adc/adt75.c
@@ -614,7 +614,7 @@ static int __devinit adt75_probe(struct i2c_client *client,
 	chip->client = client;
 	chip->name = id->name;
 
-	chip->indio_dev = iio_allocate_device();
+	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_chip;
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index dde097a..29d2d6e 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -1695,7 +1695,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	}
 	st->client = client;
 
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index d1b5b13..6145963 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2299,7 +2299,7 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
 		chip->int_mask |= ADT7516_AIN_INT_MASK;
 
-	chip->indio_dev = iio_allocate_device();
+	chip->indio_dev = iio_allocate_device(0);
 	if (chip->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_chip;
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 8623a72..f289f4e 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -367,7 +367,7 @@ static int __devinit ad5446_probe(struct spi_device *spi)
 
 	st->spi = spi;
 
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index a945b18..cfb5828 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -260,7 +260,7 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
 		st->vref_mv = st->chip_info->int_vref_mv;
 
 	st->us = spi;
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index 7071f71..3eb48b6 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/staging/iio/dac/max517.c
@@ -206,7 +206,7 @@ static int max517_probe(struct i2c_client *client,
 
 	data->client = client;
 
-	data->indio_dev = iio_allocate_device();
+	data->indio_dev = iio_allocate_device(0);
 	if (data->indio_dev == NULL) {
 		err = -ENOMEM;
 		goto exit_free_data;
diff --git a/drivers/staging/iio/dds/ad5930.c b/drivers/staging/iio/dds/ad5930.c
index f80039c..5d98f93 100644
--- a/drivers/staging/iio/dds/ad5930.c
+++ b/drivers/staging/iio/dds/ad5930.c
@@ -102,7 +102,7 @@ static int __devinit ad5930_probe(struct spi_device *spi)
 	mutex_init(&st->lock);
 	st->sdev = spi;
 
-	st->idev = iio_allocate_device();
+	st->idev = iio_allocate_device(0);
 	if (st->idev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_st;
diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/dds/ad9832.c
index 3e8491f..9c6114f 100644
--- a/drivers/staging/iio/dds/ad9832.c
+++ b/drivers/staging/iio/dds/ad9832.c
@@ -236,7 +236,7 @@ static int __devinit ad9832_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, st);
 	st->spi = spi;
 
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index eb1a681..da5e302 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -349,7 +349,7 @@ static int __devinit ad9834_probe(struct spi_device *spi)
 	st->spi = spi;
 	st->devid = spi_get_device_id(spi)->driver_data;
 
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
diff --git a/drivers/staging/iio/dds/ad9850.c b/drivers/staging/iio/dds/ad9850.c
index b259bfe..34bc0e6 100644
--- a/drivers/staging/iio/dds/ad9850.c
+++ b/drivers/staging/iio/dds/ad9850.c
@@ -88,7 +88,7 @@ static int __devinit ad9850_probe(struct spi_device *spi)
 	mutex_init(&st->lock);
 	st->sdev = spi;
 
-	st->idev = iio_allocate_device();
+	st->idev = iio_allocate_device(0);
 	if (st->idev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_st;
diff --git a/drivers/staging/iio/dds/ad9852.c b/drivers/staging/iio/dds/ad9852.c
index 594fb6a..899a72a 100644
--- a/drivers/staging/iio/dds/ad9852.c
+++ b/drivers/staging/iio/dds/ad9852.c
@@ -237,7 +237,7 @@ static int __devinit ad9852_probe(struct spi_device *spi)
 	mutex_init(&st->lock);
 	st->sdev = spi;
 
-	st->idev = iio_allocate_device();
+	st->idev = iio_allocate_device(0);
 	if (st->idev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_st;
diff --git a/drivers/staging/iio/dds/ad9910.c b/drivers/staging/iio/dds/ad9910.c
index e8fb75c..fddb6e7 100644
--- a/drivers/staging/iio/dds/ad9910.c
+++ b/drivers/staging/iio/dds/ad9910.c
@@ -372,7 +372,7 @@ static int __devinit ad9910_probe(struct spi_device *spi)
 	mutex_init(&st->lock);
 	st->sdev = spi;
 
-	st->idev = iio_allocate_device();
+	st->idev = iio_allocate_device(0);
 	if (st->idev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_st;
diff --git a/drivers/staging/iio/dds/ad9951.c b/drivers/staging/iio/dds/ad9951.c
index 57eddf6..a9e56c6 100644
--- a/drivers/staging/iio/dds/ad9951.c
+++ b/drivers/staging/iio/dds/ad9951.c
@@ -181,7 +181,7 @@ static int __devinit ad9951_probe(struct spi_device *spi)
 	mutex_init(&st->lock);
 	st->sdev = spi;
 
-	st->idev = iio_allocate_device();
+	st->idev = iio_allocate_device(0);
 	if (st->idev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_st;
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 700eb39..c689afa 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -147,7 +147,7 @@ static int __devinit adis16060_r_probe(struct spi_device *spi)
 	st->us_r = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_st;
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index fb4336c..1a14850 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -140,7 +140,7 @@ static int __devinit adis16080_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_st;
diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 70e2831..02fbe07 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -191,7 +191,7 @@ static int __devinit adis16130_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_st;
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 69a29ec..26e3af4 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -596,7 +596,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 248bdd2..bf84799 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -264,10 +264,25 @@ static inline void *iio_dev_get_devdata(struct iio_dev *d)
 	return d->dev_data;
 }
 
+
+/* Can we make this smaller? */
+#define IIO_ALIGN L1_CACHE_BYTES
 /**
  * iio_allocate_device() - allocate an iio_dev from a driver
+ * @sizeof_priv: Space to allocate for private structure.
  **/
-struct iio_dev *iio_allocate_device(void);
+struct iio_dev *iio_allocate_device(int sizeof_priv);
+
+static inline void *iio_priv(const struct iio_dev *dev)
+{
+	return (char *)dev + ALIGN(sizeof(struct iio_dev), IIO_ALIGN);
+}
+
+static inline struct iio_dev *iio_priv_to_dev(void *priv)
+{
+	return (struct iio_dev *)((char *)priv -
+				  ALIGN(sizeof(struct iio_dev), IIO_ALIGN));
+}
 
 /**
  * iio_free_device() - free an iio_dev from a driver
diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/iio/imu/adis16300_core.c
index 7ad13f4..0734d4a 100644
--- a/drivers/staging/iio/imu/adis16300_core.c
+++ b/drivers/staging/iio/imu/adis16300_core.c
@@ -628,7 +628,7 @@ static int __devinit adis16300_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index cf7176b..2081924 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -617,7 +617,7 @@ static int __devinit adis16350_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index cfb108a..3439239 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -622,7 +622,7 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index f3bf111..54a61a3 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -720,9 +720,20 @@ static struct device_type iio_dev_type = {
 	.release = iio_dev_release,
 };
 
-struct iio_dev *iio_allocate_device(void)
+struct iio_dev *iio_allocate_device(int sizeof_priv)
 {
-	struct iio_dev *dev = kzalloc(sizeof *dev, GFP_KERNEL);
+	struct iio_dev *dev;
+	size_t alloc_size;
+
+	alloc_size = sizeof(struct iio_dev);
+	if (sizeof_priv) {
+		alloc_size = ALIGN(alloc_size, IIO_ALIGN);
+		alloc_size += sizeof_priv;
+	}
+	/* ensure 32-byte alignment of whole construct ? */
+	alloc_size += IIO_ALIGN - 1;
+
+	dev = kzalloc(alloc_size, GFP_KERNEL);
 
 	if (dev) {
 		dev->dev.type = &iio_dev_type;
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index f919cc1..dfbc423 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -492,7 +492,7 @@ static int __devinit isl29018_probe(struct i2c_client *client,
 	if (err)
 		goto exit_free;
 
-	chip->indio_dev = iio_allocate_device();
+	chip->indio_dev = iio_allocate_device(0);
 	if (!chip->indio_dev) {
 		dev_err(&client->dev, "iio allocation fails\n");
 		goto exit_free;
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index dadae75..35d94c6 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -857,7 +857,7 @@ static int __devinit tsl2563_probe(struct i2c_client *client,
 
 	dev_info(&client->dev, "model %d, rev. %d\n", id >> 4, id & 0x0f);
 
-	chip->indio_dev = iio_allocate_device();
+	chip->indio_dev = iio_allocate_device(0);
 	if (!chip->indio_dev)
 		goto fail1;
 	chip->indio_dev->attrs = &tsl2563_group;
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 420f206..9fbda02 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -482,7 +482,7 @@ static int ak8975_probe(struct i2c_client *client,
 	}
 
 	/* Register with IIO */
-	data->indio_dev = iio_allocate_device();
+	data->indio_dev = iio_allocate_device(0);
 	if (data->indio_dev == NULL) {
 		err = -ENOMEM;
 		goto exit_gpio;
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 5168917..d0676e9 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -552,7 +552,7 @@ static int hmc5843_probe(struct i2c_client *client,
 	/* Initialize the HMC5843 chip */
 	hmc5843_init_client(client);
 
-	data->indio_dev = iio_allocate_device();
+	data->indio_dev = iio_allocate_device(0);
 	if (!data->indio_dev) {
 		err = -ENOMEM;
 		goto exit_free1;
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 8b86d82..d62d9e2 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -532,7 +532,7 @@ static int __devinit ade7753_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 4272818..2d0b8cc 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -557,7 +557,7 @@ static int __devinit ade7754_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index b7634cb..8d37ef7 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -737,7 +737,7 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index a9d3203..42b3b27 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -478,7 +478,7 @@ static int __devinit ade7759_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 866e585..d3f1df7 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -568,7 +568,7 @@ int ade7854_probe(struct ade7854_state *st, struct device *dev)
 	}
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
+	st->indio_dev = iio_allocate_device(0);
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_tx;
diff --git a/drivers/staging/iio/resolver/ad2s120x.c b/drivers/staging/iio/resolver/ad2s120x.c
index 8f497a2..e0237ff 100644
--- a/drivers/staging/iio/resolver/ad2s120x.c
+++ b/drivers/staging/iio/resolver/ad2s120x.c
@@ -240,7 +240,7 @@ static int __devinit ad2s120x_probe(struct spi_device *spi)
 	st->sample = pins[0];
 	st->rdvel = pins[1];
 
-	st->idev = iio_allocate_device();
+	st->idev = iio_allocate_device(0);
 	if (st->idev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_st;
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index c12f64c..dc7cae8 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -800,7 +800,7 @@ static int __devinit ad2s1210_probe(struct spi_device *spi)
 	st->res0 = pins[3];
 	st->res1 = pins[4];
 
-	st->idev = iio_allocate_device();
+	st->idev = iio_allocate_device(0);
 	if (st->idev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_st;
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 4143535..e300ade 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -90,7 +90,7 @@ static int __devinit ad2s90_probe(struct spi_device *spi)
 	mutex_init(&st->lock);
 	st->sdev = spi;
 
-	st->idev = iio_allocate_device();
+	st->idev = iio_allocate_device(0);
 	if (st->idev == NULL) {
 		ret = -ENOMEM;
 		goto error_free_st;
-- 
1.7.3.4
