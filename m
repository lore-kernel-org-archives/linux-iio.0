Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 09/14] staging:iio:buffering cleanup ring_buffer_register_ex naming.
Date: Fri, 26 Aug 2011 11:05:43 +0100
Message-Id: <1314353148-6670-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353148-6670-1-git-send-email-jic23@cam.ac.uk>
References: <1314353148-6670-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Now the old method is long gone, lets get rid of the _ex and whilst
here remove the unused id parameter.

Trivial mechanical change, but will break any out of tree drivers
using this.

V2: rebase
V3: rebase

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_core.c      |    6 +++---
 drivers/staging/iio/accel/adis16203_core.c      |    6 +++---
 drivers/staging/iio/accel/adis16204_core.c      |    6 +++---
 drivers/staging/iio/accel/adis16209_core.c      |    6 +++---
 drivers/staging/iio/accel/adis16240_core.c      |    6 +++---
 drivers/staging/iio/accel/lis3l02dq_core.c      |    6 +++---
 drivers/staging/iio/accel/sca3000_core.c        |    6 +++---
 drivers/staging/iio/adc/ad7192.c                |    6 +++---
 drivers/staging/iio/adc/ad7298_core.c           |    6 +++---
 drivers/staging/iio/adc/ad7476_core.c           |    6 +++---
 drivers/staging/iio/adc/ad7606_core.c           |    6 +++---
 drivers/staging/iio/adc/ad7793.c                |    6 +++---
 drivers/staging/iio/adc/ad7887_core.c           |    6 +++---
 drivers/staging/iio/adc/ad799x_core.c           |    6 +++---
 drivers/staging/iio/adc/max1363_core.c          |    6 +++---
 drivers/staging/iio/gyro/adis16260_core.c       |    6 +++---
 drivers/staging/iio/impedance-analyzer/ad5933.c |    2 +-
 drivers/staging/iio/imu/adis16400_core.c        |    6 +++---
 drivers/staging/iio/industrialio-ring.c         |    8 ++++----
 drivers/staging/iio/meter/ade7758_core.c        |    6 +++---
 drivers/staging/iio/ring_generic.h              |   16 +++++++---------
 21 files changed, 66 insertions(+), 68 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 07d2bc9..0260026 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -496,9 +496,9 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  adis16201_channels,
-					  ARRAY_SIZE(adis16201_channels));
+	ret = iio_ring_buffer_register(indio_dev,
+				       adis16201_channels,
+				       ARRAY_SIZE(adis16201_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index f813d99..c13cfc7 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -450,9 +450,9 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  adis16203_channels,
-					  ARRAY_SIZE(adis16203_channels));
+	ret = iio_ring_buffer_register(indio_dev,
+				       adis16203_channels,
+				       ARRAY_SIZE(adis16203_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 9eb9b0d..16a0fbd 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -525,9 +525,9 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  adis16204_channels,
-					  ARRAY_SIZE(adis16204_channels));
+	ret = iio_ring_buffer_register(indio_dev,
+				       adis16204_channels,
+				       ARRAY_SIZE(adis16204_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 5b0ecc4..93b76ca 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -498,9 +498,9 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  adis16209_channels,
-					  ARRAY_SIZE(adis16209_channels));
+	ret = iio_ring_buffer_register(indio_dev,
+				       adis16209_channels,
+				       ARRAY_SIZE(adis16209_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index e14cb48..720fd45 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -551,9 +551,9 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  adis16240_channels,
-					  ARRAY_SIZE(adis16240_channels));
+	ret = iio_ring_buffer_register(indio_dev,
+				       adis16240_channels,
+				       ARRAY_SIZE(adis16240_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 83c12b0..80829b2 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -694,9 +694,9 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  lis3l02dq_channels,
-					  ARRAY_SIZE(lis3l02dq_channels));
+	ret = iio_ring_buffer_register(indio_dev,
+				       lis3l02dq_channels,
+				       ARRAY_SIZE(lis3l02dq_channels));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 02ff6ba..0f70b53 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1155,9 +1155,9 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 	if (ret < 0)
 		goto error_free_dev;
 	regdone = 1;
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  sca3000_channels,
-					  ARRAY_SIZE(sca3000_channels));
+	ret = iio_ring_buffer_register(indio_dev,
+				       sca3000_channels,
+				       ARRAY_SIZE(sca3000_channels));
 	if (ret < 0)
 		goto error_unregister_dev;
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 6e1656e..80b067c 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -1098,9 +1098,9 @@ static int __devinit ad7192_probe(struct spi_device *spi)
 	if (ret)
 		goto error_unreg_ring;
 
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  indio_dev->channels,
-					  indio_dev->num_channels);
+	ret = iio_ring_buffer_register(indio_dev,
+				       indio_dev->channels,
+				       indio_dev->num_channels);
 	if (ret)
 		goto error_remove_trigger;
 
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index d0bcdb1..1d89382 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -222,9 +222,9 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 		goto error_disable_reg;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  &ad7298_channels[1], /* skip temp0 */
-					  ARRAY_SIZE(ad7298_channels) - 1);
+	ret = iio_ring_buffer_register(indio_dev,
+				       &ad7298_channels[1], /* skip temp0 */
+				       ARRAY_SIZE(ad7298_channels) - 1);
 	if (ret)
 		goto error_cleanup_ring;
 
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 3ff2924..e38358b 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -185,9 +185,9 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  st->chip_info->channel,
-					  ARRAY_SIZE(st->chip_info->channel));
+	ret = iio_ring_buffer_register(indio_dev,
+				       st->chip_info->channel,
+				       ARRAY_SIZE(st->chip_info->channel));
 	if (ret)
 		goto error_cleanup_ring;
 	return 0;
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index f7840cf..784f963 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -505,9 +505,9 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 		goto error_free_irq;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  indio_dev->channels,
-					  indio_dev->num_channels);
+	ret = iio_ring_buffer_register(indio_dev,
+				       indio_dev->channels,
+				       indio_dev->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
 
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index ed993e3..38095eb 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -895,9 +895,9 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 	if (ret)
 		goto error_unreg_ring;
 
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  indio_dev->channels,
-					  indio_dev->num_channels);
+	ret = iio_ring_buffer_register(indio_dev,
+				       indio_dev->channels,
+				       indio_dev->num_channels);
 	if (ret)
 		goto error_remove_trigger;
 
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 99c8828..eb1bd9c 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -193,9 +193,9 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 		goto error_disable_reg;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  indio_dev->channels,
-					  indio_dev->num_channels);
+	ret = iio_ring_buffer_register(indio_dev,
+				       indio_dev->channels,
+				       indio_dev->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
 	return 0;
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 11d0add..ca2d822 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -705,9 +705,9 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 		goto error_cleanup_ring;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  indio_dev->channels,
-					  indio_dev->num_channels);
+	ret = iio_ring_buffer_register(indio_dev,
+				       indio_dev->channels,
+				       indio_dev->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
 
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index ad2631d..5cf8c98 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -1312,9 +1312,9 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	if (ret)
 		goto error_cleanup_ring;
 	regdone = 1;
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  st->chip_info->channels,
-					  st->chip_info->num_channels);
+	ret = iio_ring_buffer_register(indio_dev,
+				       st->chip_info->channels,
+				       st->chip_info->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
 
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index a62773d..66610a3 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -628,9 +628,9 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	if (ret)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  indio_dev->channels,
-					  ARRAY_SIZE(adis16260_channels_x));
+	ret = iio_ring_buffer_register(indio_dev,
+				       indio_dev->channels,
+				       ARRAY_SIZE(adis16260_channels_x));
 	if (ret) {
 		printk(KERN_ERR "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 8668291..1c1cd8e 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -733,7 +733,7 @@ static int __devinit ad5933_probe(struct i2c_client *client,
 	regdone = 1;
 
 	/* skip temp0_input, register in0_(real|imag)_raw */
-	ret = iio_ring_buffer_register_ex(indio_dev, 0, &ad5933_channels[1], 2);
+	ret = iio_ring_buffer_register(indio_dev, &ad5933_channels[1], 2);
 	if (ret)
 		goto error_unreg_ring;
 
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index bc740b0..8a93053 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -852,9 +852,9 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  st->variant->channels,
-					  st->variant->num_channels);
+	ret = iio_ring_buffer_register(indio_dev,
+				       st->variant->channels,
+				       st->variant->num_channels);
 	if (ret) {
 		dev_err(&spi->dev, "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 1607293..947f542 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -277,9 +277,9 @@ static void __iio_ring_attr_cleanup(struct iio_dev *indio_dev)
 				   &iio_scan_el_dummy_group);
 }
 
-int iio_ring_buffer_register_ex(struct iio_dev *indio_dev, int id,
-				const struct iio_chan_spec *channels,
-				int num_channels)
+int iio_ring_buffer_register(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *channels,
+			     int num_channels)
 {
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	int ret, i;
@@ -325,7 +325,7 @@ error_cleanup_dynamic:
 error_ret:
 	return ret;
 }
-EXPORT_SYMBOL(iio_ring_buffer_register_ex);
+EXPORT_SYMBOL(iio_ring_buffer_register);
 
 void iio_ring_buffer_unregister(struct iio_dev *indio_dev)
 {
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index ce2d156..151b28f 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -779,9 +779,9 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev, 0,
-					  &ade7758_channels[0],
-					  ARRAY_SIZE(ade7758_channels));
+	ret = iio_ring_buffer_register(indio_dev,
+				       &ade7758_channels[0],
+				       ARRAY_SIZE(ade7758_channels));
 	if (ret) {
 		dev_err(&spi->dev, "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 37ab4db..25aacf3 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -206,13 +206,12 @@ static inline int iio_scan_mask_set(struct iio_ring_buffer *ring, int bit)
 	container_of(d, struct iio_ring_buffer, dev)
 
 /**
- * iio_ring_buffer_register_ex() - register the buffer with IIO core
+ * iio_ring_buffer_register() - register the buffer with IIO core
  * @indio_dev: device with the buffer to be registered
- * @id: the id of the buffer (typically 0)
  **/
-int iio_ring_buffer_register_ex(struct iio_dev *indio_dev, int id,
-				const struct iio_chan_spec *channels,
-				int num_channels);
+int iio_ring_buffer_register(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *channels,
+			     int num_channels);
 
 /**
  * iio_ring_buffer_unregister() - unregister the buffer from IIO core
@@ -265,10 +264,9 @@ int iio_sw_ring_preenable(struct iio_dev *indio_dev);
 
 #else /* CONFIG_IIO_RING_BUFFER */
 
-static inline int iio_ring_buffer_register_ex(struct iio_dev *indio_dev,
-					      int id,
-					      struct iio_chan_spec *channels,
-					      int num_channels)
+static inline int iio_ring_buffer_register(struct iio_dev *indio_dev,
+					   struct iio_chan_spec *channels,
+					   int num_channels)
 {
 	return 0;
 }
-- 
1.7.3.4
