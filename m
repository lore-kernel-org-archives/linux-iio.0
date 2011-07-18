Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:47936 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab1GRNuG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2011 09:50:06 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de, manuel.stahl@iis.fraunhofer.de,
	device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 6/7] staging:iio: push the main buffer chrdev down to the top level.
Date: Mon, 18 Jul 2011 14:50:03 +0100
Message-Id: <1310997004-22728-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1310997004-22728-1-git-send-email-jic23@cam.ac.uk>
References: <1310997004-22728-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Sorry all, this one is very invasive, though the driver changes are
just trivial interface fixes. Not all done yet.
---
 drivers/staging/iio/Documentation/generic_buffer.c |   11 +-
 drivers/staging/iio/Documentation/iio_utils.h      |    2 +-
 drivers/staging/iio/accel/adis16201_core.c         |    6 +-
 drivers/staging/iio/accel/adis16203_core.c         |    6 +-
 drivers/staging/iio/accel/adis16204_core.c         |    6 +-
 drivers/staging/iio/accel/adis16209_core.c         |    6 +-
 drivers/staging/iio/accel/adis16240_core.c         |    6 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |    6 +-
 drivers/staging/iio/accel/sca3000_core.c           |    4 +-
 drivers/staging/iio/adc/ad7298_core.c              |    4 +-
 drivers/staging/iio/adc/ad7476_core.c              |    4 +-
 drivers/staging/iio/adc/ad7606_core.c              |    4 +-
 drivers/staging/iio/adc/ad7793.c                   |    6 +-
 drivers/staging/iio/adc/ad7887_core.c              |    4 +-
 drivers/staging/iio/adc/ad799x_core.c              |    4 +-
 drivers/staging/iio/adc/max1363_core.c             |    6 +-
 drivers/staging/iio/gyro/adis16260_core.c          |    6 +-
 drivers/staging/iio/iio.h                          |    1 +
 drivers/staging/iio/iio_core.h                     |   32 +++
 drivers/staging/iio/imu/adis16400_core.c           |    6 +-
 drivers/staging/iio/industrialio-core.c            |   62 +++++-
 drivers/staging/iio/industrialio-ring.c            |  236 ++++++--------------
 drivers/staging/iio/kfifo_buf.c                    |   35 ++--
 drivers/staging/iio/meter/ade7758_core.c           |    2 +-
 drivers/staging/iio/ring_generic.h                 |   24 +--
 drivers/staging/iio/ring_sw.c                      |   23 +--
 26 files changed, 245 insertions(+), 267 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index f82894f..c6f5822 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -173,7 +173,7 @@ int main(int argc, char **argv)
 		return -1;
 
 	/* Find the device requested */
-	dev_num = find_type_by_name(device_name, "device");
+	dev_num = find_type_by_name(device_name, "iio:device");
 	if (dev_num < 0) {
 		printf("Failed to find the %s\n", device_name);
 		ret = -ENODEV;
@@ -181,7 +181,7 @@ int main(int argc, char **argv)
 	}
 	printf("iio device number being used is %d\n", dev_num);
 
-	asprintf(&dev_dir_name, "%sdevice%d", iio_dir, dev_num);
+	asprintf(&dev_dir_name, "%siio:device%d", iio_dir, dev_num);
 	if (trigger_name == NULL) {
 		/*
 		 * Build the trigger name. If it is device associated it's
@@ -212,6 +212,7 @@ int main(int argc, char **argv)
 	ret = build_channel_array(dev_dir_name, &infoarray, &num_channels);
 	if (ret) {
 		printf("Problem reading scan element information\n");
+		printf("diag %s\n", dev_dir_name);
 		goto error_free_triggername;
 	}
 
@@ -220,7 +221,7 @@ int main(int argc, char **argv)
 	 * As we know that the lis3l02dq has only one buffer this may
 	 * be built rather than found.
 	 */
-	ret = asprintf(&buf_dir_name, "%sdevice%d:buffer0", iio_dir, dev_num);
+	ret = asprintf(&buf_dir_name, "%siio:device%d/buffer", iio_dir, dev_num);
 	if (ret < 0) {
 		ret = -ENOMEM;
 		goto error_free_triggername;
@@ -251,9 +252,7 @@ int main(int argc, char **argv)
 		goto error_free_buf_dir_name;
 	}
 
-	ret = asprintf(&buffer_access,
-		       "/dev/device%d:buffer0",
-		       dev_num);
+	ret = asprintf(&buffer_access, "/dev/iio:device%d", dev_num);
 	if (ret < 0) {
 		ret = -ENOMEM;
 		goto error_free_data;
diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 150f440..75938b2 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -16,7 +16,7 @@
 
 #define IIO_MAX_NAME_LENGTH 30
 
-#define FORMAT_SCAN_ELEMENTS_DIR "%s:buffer0/scan_elements"
+#define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
 #define FORMAT_TYPE_FILE "%s_type"
 
 const char *iio_dir = "/sys/bus/iio/devices/";
diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 16b388b..07d2bc9 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -496,7 +496,7 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  adis16201_channels,
 					  ARRAY_SIZE(adis16201_channels));
 	if (ret) {
@@ -519,7 +519,7 @@ static int __devinit adis16201_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16201_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	adis16201_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -536,7 +536,7 @@ static int adis16201_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	adis16201_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 	iio_device_unregister(indio_dev);
 	adis16201_unconfigure_ring(indio_dev);
 
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 034115a..2e03b48 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -446,7 +446,7 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  adis16203_channels,
 					  ARRAY_SIZE(adis16203_channels));
 	if (ret) {
@@ -469,7 +469,7 @@ static int __devinit adis16203_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16203_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	adis16203_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -486,7 +486,7 @@ static int adis16203_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	adis16203_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 	iio_device_unregister(indio_dev);
 	adis16203_unconfigure_ring(indio_dev);
 
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index c5a46fd..f7cd9d1 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -521,7 +521,7 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  adis16204_channels,
 					  ARRAY_SIZE(adis16204_channels));
 	if (ret) {
@@ -544,7 +544,7 @@ static int __devinit adis16204_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16204_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	adis16204_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -561,7 +561,7 @@ static int adis16204_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	adis16204_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 	iio_device_unregister(indio_dev);
 	adis16204_unconfigure_ring(indio_dev);
 
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 70a7e29..8b8ba5a 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -494,7 +494,7 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  adis16209_channels,
 					  ARRAY_SIZE(adis16209_channels));
 	if (ret) {
@@ -517,7 +517,7 @@ static int __devinit adis16209_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16209_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	adis16209_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -536,7 +536,7 @@ static int adis16209_remove(struct spi_device *spi)
 	flush_scheduled_work();
 
 	adis16209_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 	iio_device_unregister(indio_dev);
 	adis16209_unconfigure_ring(indio_dev);
 
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index b9dd92d..a5c3ed7 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -547,7 +547,7 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  adis16240_channels,
 					  ARRAY_SIZE(adis16240_channels));
 	if (ret) {
@@ -570,7 +570,7 @@ static int __devinit adis16240_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16240_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	adis16240_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -590,7 +590,7 @@ static int adis16240_remove(struct spi_device *spi)
 	flush_scheduled_work();
 
 	adis16240_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 	iio_device_unregister(indio_dev);
 	adis16240_unconfigure_ring(indio_dev);
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 7f946aa..062632b 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -695,7 +695,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  lis3l02dq_channels,
 					  ARRAY_SIZE(lis3l02dq_channels));
 	if (ret) {
@@ -731,7 +731,7 @@ error_free_interrupt:
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
 		free_irq(st->us->irq, indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	lis3l02dq_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -788,7 +788,7 @@ static int lis3l02dq_remove(struct spi_device *spi)
 		free_irq(st->us->irq, indio_dev);
 
 	lis3l02dq_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 	lis3l02dq_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index d5684fc..1669eaf 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1155,7 +1155,7 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 	if (ret < 0)
 		goto error_free_dev;
 	regdone = 1;
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  sca3000_channels,
 					  ARRAY_SIZE(sca3000_channels));
 	if (ret < 0)
@@ -1180,7 +1180,7 @@ error_free_irq:
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
 		free_irq(spi->irq, indio_dev);
 error_unregister_ring:
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 error_unregister_dev:
 error_free_dev:
 	if (regdone)
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 21d1931..d0bcdb1 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -222,7 +222,7 @@ static int __devinit ad7298_probe(struct spi_device *spi)
 		goto error_disable_reg;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  &ad7298_channels[1], /* skip temp0 */
 					  ARRAY_SIZE(ad7298_channels) - 1);
 	if (ret)
@@ -252,7 +252,7 @@ static int __devexit ad7298_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7298_state *st = iio_priv(indio_dev);
 
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 	ad7298_ring_cleanup(indio_dev);
 	iio_device_unregister(indio_dev);
 	if (!IS_ERR(st->reg)) {
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index f2fdd48..3ff2924 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -185,7 +185,7 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg;
 
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  st->chip_info->channel,
 					  ARRAY_SIZE(st->chip_info->channel));
 	if (ret)
@@ -214,7 +214,7 @@ static int ad7476_remove(struct spi_device *spi)
 	/* copy needed as st will have been freed */
 	struct regulator *reg = st->reg;
 
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 	ad7476_ring_cleanup(indio_dev);
 	iio_device_unregister(indio_dev);
 	if (!IS_ERR(reg)) {
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index dcdb180..f7840cf 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -505,7 +505,7 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
 		goto error_free_irq;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  indio_dev->channels,
 					  indio_dev->num_channels);
 	if (ret)
@@ -540,7 +540,7 @@ int ad7606_remove(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 	ad7606_ring_cleanup(indio_dev);
 
 	free_irq(st->irq, indio_dev);
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 1bcb3eb..ed993e3 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -895,7 +895,7 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 	if (ret)
 		goto error_unreg_ring;
 
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  indio_dev->channels,
 					  indio_dev->num_channels);
 	if (ret)
@@ -908,7 +908,7 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 	return 0;
 
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 error_remove_trigger:
 	ad7793_remove_trigger(indio_dev);
 error_unreg_ring:
@@ -933,7 +933,7 @@ static int ad7793_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7793_state *st = iio_priv(indio_dev);
 
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 	ad7793_remove_trigger(indio_dev);
 	ad7793_ring_cleanup(indio_dev);
 
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index a7da9e6..99c8828 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -193,7 +193,7 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 		goto error_disable_reg;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  indio_dev->channels,
 					  indio_dev->num_channels);
 	if (ret)
@@ -221,7 +221,7 @@ static int ad7887_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct ad7887_state *st = iio_priv(indio_dev);
 
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 	ad7887_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 2438ed5..a509e3d 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -705,7 +705,7 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 		goto error_cleanup_ring;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  indio_dev->channels,
 					  indio_dev->num_channels);
 	if (ret)
@@ -749,7 +749,7 @@ static __devexit int ad799x_remove(struct i2c_client *client)
 	if (client->irq > 0)
 		free_irq(client->irq, indio_dev);
 
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 	ad799x_ring_cleanup(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 79ae4a0..037fcc1 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -1310,7 +1310,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	if (ret)
 		goto error_cleanup_ring;
 	regdone = 1;
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  st->chip_info->channels,
 					  st->chip_info->num_channels);
 	if (ret)
@@ -1331,7 +1331,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	return 0;
 
 error_uninit_ring:
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 error_cleanup_ring:
 	max1363_ring_cleanup(indio_dev);
 error_free_available_scan_masks:
@@ -1357,7 +1357,7 @@ static int max1363_remove(struct i2c_client *client)
 
 	if (client->irq)
 		free_irq(st->client->irq, indio_dev);
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 	max1363_ring_cleanup(indio_dev);
 	kfree(indio_dev->available_scan_masks);
 	if (!IS_ERR(reg)) {
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index b09b367..0938afd 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -624,7 +624,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	if (ret)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  indio_dev->channels,
 					  ARRAY_SIZE(adis16260_channels_x));
 	if (ret) {
@@ -647,7 +647,7 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 error_remove_trigger:
 	adis16260_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	adis16260_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -671,7 +671,7 @@ static int adis16260_remove(struct spi_device *spi)
 	flush_scheduled_work();
 
 	adis16260_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 	iio_device_unregister(indio_dev);
 	adis16260_unconfigure_ring(indio_dev);
 
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 308b100..b4f0989 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -290,6 +290,7 @@ struct iio_dev {
 	struct list_head channel_attr_list;
 	const char *name;
 	const struct iio_info *info;
+	struct cdev				chrdev;
 };
 
 /**
diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
index 00e894d..380d782 100644
--- a/drivers/staging/iio/iio_core.h
+++ b/drivers/staging/iio/iio_core.h
@@ -10,6 +10,9 @@
  * drivers.
  */
 
+#ifndef _IIO_CORE_H_
+#define _IIO_CORE_H_
+
 /**
  * iio_device_get_chrdev_minor() - get an unused minor number
  **/
@@ -46,3 +49,32 @@ int __iio_add_chan_devattr(const char *postfix,
 
 /* Event interface flags */
 #define IIO_BUSY_BIT_POS 1
+
+#ifdef CONFIG_IIO_RING_BUFFER
+struct poll_table_struct;
+
+void iio_chrdev_ring_open(struct iio_dev *indio_dev);
+void iio_chrdev_ring_release(struct iio_dev *indio_dev);
+
+unsigned int iio_ring_poll(struct file *filp,
+			   struct poll_table_struct *wait);
+ssize_t iio_ring_read_first_n_outer(struct file *filp, char __user *buf,
+				    size_t n, loff_t *f_ps);
+
+
+#define iio_ring_poll_addr &iio_ring_poll
+#define iio_ring_read_first_n_outer_addr &iio_ring_read_first_n_outer
+
+#else
+
+static inline void iio_chrdev_ring_open(struct iio_dev *indio_dev)
+{}
+static inline void iio_chrdev_ring_release(struct iio_dev *indio_dev)
+{}
+
+#define iio_ring_poll_addr NULL
+#define iio_ring_read_first_n_outer_addr NULL
+
+#endif
+
+#endif
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 371eb01..bc740b0 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -852,7 +852,7 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  st->variant->channels,
 					  st->variant->num_channels);
 	if (ret) {
@@ -876,7 +876,7 @@ error_remove_trigger:
 	if (indio_dev->modes & INDIO_RING_TRIGGERED)
 		adis16400_remove_trigger(indio_dev);
 error_uninitialize_ring:
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	adis16400_unconfigure_ring(indio_dev);
 error_free_dev:
@@ -899,7 +899,7 @@ static int adis16400_remove(struct spi_device *spi)
 		goto err_ret;
 
 	adis16400_remove_trigger(indio_dev);
-	iio_ring_buffer_unregister(indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev);
 	adis16400_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index ca0ad61..7cd0485 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -1063,6 +1063,8 @@ static void iio_device_unregister_eventset(struct iio_dev *dev_info)
 static void iio_dev_release(struct device *device)
 {
 	struct iio_dev *dev_info = container_of(device, struct iio_dev, dev);
+	cdev_del(&dev_info->chrdev);
+	iio_device_free_chrdev_minor(MINOR(device->devt));
 	iio_put();
 	kfree(dev_info);
 }
@@ -1107,6 +1109,55 @@ void iio_free_device(struct iio_dev *dev)
 }
 EXPORT_SYMBOL(iio_free_device);
 
+/**
+ * iio_chrdev_open() - chrdev file open for ring buffer access and ioctls
+ **/
+static int iio_chrdev_open(struct inode *inode, struct file *filp)
+{
+	struct iio_dev *dev_info = container_of(inode->i_cdev,
+						struct iio_dev, chrdev);
+	filp->private_data = dev_info;
+	iio_chrdev_ring_open(dev_info);
+	return 0;
+}
+
+/**
+ * iio_chrdev_release() - chrdev file close ring buffer access and ioctls
+ **/
+static int iio_chrdev_release(struct inode *inode, struct file *filp)
+{
+	iio_chrdev_ring_release(container_of(inode->i_cdev,
+					     struct iio_dev, chrdev));
+	return 0;
+}
+
+/* Somewhat of a cross file organization violation - ioctls here are actually
+ * event related */
+static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct iio_dev *indio_dev = filp->private_data;
+	int __user *ip = (int __user *)arg;
+	int fd;
+
+	if (cmd == 0) {
+		fd = iio_event_getfd(indio_dev);
+		if (copy_to_user(ip, &fd, sizeof(fd)))
+			return -EFAULT;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static const struct file_operations iio_ring_fileops = {
+	.read = iio_ring_read_first_n_outer_addr,
+	.release = iio_chrdev_release,
+	.open = iio_chrdev_open,
+	.poll = iio_ring_poll_addr,
+	.owner = THIS_MODULE,
+	.llseek = noop_llseek,
+	.unlocked_ioctl = iio_ioctl,
+};
+
 int iio_device_register(struct iio_dev *dev_info)
 {
 	int ret;
@@ -1117,8 +1168,14 @@ int iio_device_register(struct iio_dev *dev_info)
 		dev_err(&dev_info->dev, "Failed to get id\n");
 		goto error_ret;
 	}
-	dev_set_name(&dev_info->dev, "device%d", dev_info->id);
+	dev_set_name(&dev_info->dev, "iio:device%d", dev_info->id);
+	ret = iio_device_get_chrdev_minor();
+	if (ret < 0)
+		goto error_free_ida;
 
+	/* configure elements for the chrdev */
+	dev_info->dev.devt = MKDEV(MAJOR(iio_devt), ret);
+	
 	ret = device_add(&dev_info->dev);
 	if (ret)
 		goto error_free_ida;
@@ -1137,6 +1194,9 @@ int iio_device_register(struct iio_dev *dev_info)
 	if (dev_info->modes & INDIO_RING_TRIGGERED)
 		iio_device_register_trigger_consumer(dev_info);
 
+	cdev_init(&dev_info->chrdev, &iio_ring_fileops);
+	dev_info->chrdev.owner = dev_info->info->driver_module;
+	ret = cdev_add(&dev_info->chrdev, dev_info->dev.devt, 1);
 	return 0;
 
 error_free_sysfs:
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index e478a5c..8ae53d8 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -24,42 +24,6 @@
 #include "iio_core.h"
 #include "ring_generic.h"
 
-/**
- * iio_ring_open() - chrdev file open for ring buffer access
- *
- * This function relies on all ring buffer implementations having an
- * iio_ring_buffer as their first element.
- **/
-static int iio_ring_open(struct inode *inode, struct file *filp)
-{
-	struct iio_ring_buffer *rb
-		= container_of(inode->i_cdev,
-			       struct iio_ring_buffer, chrdev);
-	filp->private_data = rb;
-	if (rb->access->mark_in_use)
-		rb->access->mark_in_use(rb);
-
-	return 0;
-}
-
-/**
- * iio_ring_release() - chrdev file close ring buffer access
- *
- * This function relies on all ring buffer implementations having an
- * iio_ring_buffer as their first element.
- **/
-static int iio_ring_release(struct inode *inode, struct file *filp)
-{
-	struct iio_ring_buffer *rb
-		= container_of(inode->i_cdev,
-			       struct iio_ring_buffer, chrdev);
-
-	clear_bit(IIO_BUSY_BIT_POS, &rb->flags);
-	if (rb->access->unmark_in_use)
-		rb->access->unmark_in_use(rb);
-
-	return 0;
-}
 
 /**
  * iio_ring_read_first_n_outer() - chrdev read for ring buffer access
@@ -67,10 +31,11 @@ static int iio_ring_release(struct inode *inode, struct file *filp)
  * This function relies on all ring buffer implementations having an
  * iio_ring _bufer as their first element.
  **/
-static ssize_t iio_ring_read_first_n_outer(struct file *filp, char __user *buf,
-				  size_t n, loff_t *f_ps)
+ssize_t iio_ring_read_first_n_outer(struct file *filp, char __user *buf,
+				    size_t n, loff_t *f_ps)
 {
-	struct iio_ring_buffer *rb = filp->private_data;
+	struct iio_dev *indio_dev = filp->private_data;
+	struct iio_ring_buffer *rb = indio_dev->ring;
 
 	if (!rb->access->read_first_n)
 		return -EINVAL;
@@ -80,10 +45,11 @@ static ssize_t iio_ring_read_first_n_outer(struct file *filp, char __user *buf,
 /**
  * iio_ring_poll() - poll the ring to find out if it has data
  */
-static unsigned int iio_ring_poll(struct file *filp,
-				  struct poll_table_struct *wait)
+unsigned int iio_ring_poll(struct file *filp,
+			   struct poll_table_struct *wait)
 {
-	struct iio_ring_buffer *rb = filp->private_data;
+	struct iio_dev *indio_dev = filp->private_data;
+	struct iio_ring_buffer *rb = indio_dev->ring;
 
 	poll_wait(filp, &rb->pollq, wait);
 	if (rb->stufftoread)
@@ -92,88 +58,22 @@ static unsigned int iio_ring_poll(struct file *filp,
 	return 0;
 }
 
-/* Somewhat of a cross file organization violation - ioctls here are actually
- * event related */
-static long iio_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+void iio_chrdev_ring_open(struct iio_dev *indio_dev)
 {
+	struct iio_ring_buffer *rb = indio_dev->ring;
+	if (rb && rb->access->mark_in_use)
+		rb->access->mark_in_use(rb);
 
-	struct iio_ring_buffer *rb = f->private_data;
-	struct iio_dev *indio_dev = rb->indio_dev;
-	int __user *ip = (int __user *)arg;
-	int fd;
-
-	if (cmd == 0) {
-		fd = iio_event_getfd(indio_dev);
-		if (copy_to_user(ip, &fd, sizeof(fd)))
-			return -EFAULT;
-		return 0;
-	}
-	return -EINVAL;
 }
 
- const struct file_operations iio_ring_fileops = {
-	.read = iio_ring_read_first_n_outer,
-	.release = iio_ring_release,
-	.open = iio_ring_open,
-	.poll = iio_ring_poll,
-	.owner = THIS_MODULE,
-	.llseek = noop_llseek,
-	.unlocked_ioctl = iio_ioctl,
-};
-
-void iio_ring_access_release(struct device *dev)
+void iio_chrdev_ring_release(struct iio_dev *indio_dev)
 {
-	struct iio_ring_buffer *buf
-		= container_of(dev, struct iio_ring_buffer, dev);
-	cdev_del(&buf->chrdev);
-	iio_device_free_chrdev_minor(MINOR(dev->devt));
-}
-EXPORT_SYMBOL(iio_ring_access_release);
+	struct iio_ring_buffer *rb = indio_dev->ring;
 
-static inline int
-__iio_request_ring_buffer_chrdev(struct iio_ring_buffer *buf,
-				 struct module *owner,
-				 int id)
-{
-	int ret;
-
-	buf->flags = 0;
-	buf->dev.bus = &iio_bus_type;
-	device_initialize(&buf->dev);
-
-	ret = iio_device_get_chrdev_minor();
-	if (ret < 0)
-		goto error_device_put;
-
-	buf->dev.devt = MKDEV(MAJOR(iio_devt), ret);
-	dev_set_name(&buf->dev, "%s:buffer%d",
-		     dev_name(buf->dev.parent),
-		     id);
-	ret = device_add(&buf->dev);
-	if (ret < 0) {
-		printk(KERN_ERR "failed to add the ring dev\n");
-		goto error_device_put;
-	}
-	cdev_init(&buf->chrdev, &iio_ring_fileops);
-	buf->chrdev.owner = owner;
-	ret = cdev_add(&buf->chrdev, buf->dev.devt, 1);
-	if (ret) {
-		printk(KERN_ERR "failed to allocate ring chrdev\n");
-		goto error_device_unregister;
-	}
-	return 0;
-
-error_device_unregister:
-	device_unregister(&buf->dev);
-error_device_put:
-	put_device(&buf->dev);
-
-	return ret;
-}
+	clear_bit(IIO_BUSY_BIT_POS, &rb->flags);
+	if (rb->access->unmark_in_use)
+		rb->access->unmark_in_use(rb);
 
-static void __iio_free_ring_buffer_chrdev(struct iio_ring_buffer *buf)
-{
-	device_unregister(&buf->dev);
 }
 
 void iio_ring_buffer_init(struct iio_ring_buffer *ring,
@@ -208,9 +108,10 @@ static ssize_t iio_scan_el_show(struct device *dev,
 				char *buf)
 {
 	int ret;
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
 
-	ret = iio_scan_mask_query(ring, to_iio_dev_attr(attr)->address);
+	ret = iio_scan_mask_query(dev_info->ring,
+				  to_iio_dev_attr(attr)->address);
 	if (ret < 0)
 		return ret;
 	return sprintf(buf, "%d\n", ret);
@@ -232,8 +133,8 @@ static ssize_t iio_scan_el_store(struct device *dev,
 {
 	int ret = 0;
 	bool state;
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_ring_buffer *ring = indio_dev->ring;
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	state = !(buf[0] == '0');
@@ -266,8 +167,8 @@ static ssize_t iio_scan_el_ts_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", ring->scan_timestamp);
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n", dev_info->ring->scan_timestamp);
 }
 
 static ssize_t iio_scan_el_ts_store(struct device *dev,
@@ -276,26 +177,27 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 				    size_t len)
 {
 	int ret = 0;
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *indio_dev = ring->indio_dev;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	bool state;
+
 	state = !(buf[0] == '0');
 	mutex_lock(&indio_dev->mlock);
 	if (indio_dev->currentmode == INDIO_RING_TRIGGERED) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
-	ring->scan_timestamp = state;
+	indio_dev->ring->scan_timestamp = state;
 error_ret:
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
 }
 
-static int iio_ring_add_channel_sysfs(struct iio_ring_buffer *ring,
+static int iio_ring_add_channel_sysfs(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan)
 {
 	int ret;
+	struct iio_ring_buffer *ring = indio_dev->ring;
 
 	ret = __iio_add_chan_devattr("index", "scan_elements",
 				     chan,
@@ -303,7 +205,7 @@ static int iio_ring_add_channel_sysfs(struct iio_ring_buffer *ring,
 				     NULL,
 				     0,
 				     0,
-				     &ring->dev,
+				     &indio_dev->dev,
 				     &ring->scan_el_dev_attr_list);
 	if (ret)
 		goto error_ret;
@@ -314,7 +216,7 @@ static int iio_ring_add_channel_sysfs(struct iio_ring_buffer *ring,
 				     NULL,
 				     0,
 				     0,
-				     &ring->dev,
+				     &indio_dev->dev,
 				     &ring->scan_el_dev_attr_list);
 	if (ret)
 		goto error_ret;
@@ -326,7 +228,7 @@ static int iio_ring_add_channel_sysfs(struct iio_ring_buffer *ring,
 					     &iio_scan_el_store,
 					     chan->scan_index,
 					     0,
-					     &ring->dev,
+					     &indio_dev->dev,
 					     &ring->scan_el_dev_attr_list);
 	else
 		ret = __iio_add_chan_devattr("en", "scan_elements",
@@ -335,16 +237,16 @@ static int iio_ring_add_channel_sysfs(struct iio_ring_buffer *ring,
 					     &iio_scan_el_ts_store,
 					     chan->scan_index,
 					     0,
-					     &ring->dev,
+					     &indio_dev->dev,
 					     &ring->scan_el_dev_attr_list);
 error_ret:
 	return ret;
 }
 
-static void iio_ring_remove_and_free_scan_dev_attr(struct iio_ring_buffer *ring,
+static void iio_ring_remove_and_free_scan_dev_attr(struct iio_dev *indio_dev,
 						   struct iio_dev_attr *p)
 {
-	sysfs_remove_file_from_group(&ring->dev.kobj,
+	sysfs_remove_file_from_group(&indio_dev->dev.kobj,
 				     &p->dev_attr.attr, "scan_elements");
 	kfree(p->dev_attr.attr.name);
 	kfree(p);
@@ -359,71 +261,78 @@ static struct attribute_group iio_scan_el_dummy_group = {
 	.attrs = iio_scan_el_dummy_attrs
 };
 
-static void __iio_ring_attr_cleanup(struct iio_ring_buffer *ring)
+static void __iio_ring_attr_cleanup(struct iio_dev *indio_dev)
 {
 	struct iio_dev_attr *p, *n;
+	struct iio_ring_buffer *ring = indio_dev->ring;
 	int anydynamic = !list_empty(&ring->scan_el_dev_attr_list);
 	list_for_each_entry_safe(p, n,
 				 &ring->scan_el_dev_attr_list, l)
-		iio_ring_remove_and_free_scan_dev_attr(ring, p);
+		iio_ring_remove_and_free_scan_dev_attr(indio_dev, p);
 
 	if (ring->scan_el_attrs)
-		sysfs_remove_group(&ring->dev.kobj,
+		sysfs_remove_group(&indio_dev->dev.kobj,
 				   ring->scan_el_attrs);
 	else if (anydynamic)
-		sysfs_remove_group(&ring->dev.kobj,
+		sysfs_remove_group(&indio_dev->dev.kobj,
 				   &iio_scan_el_dummy_group);
 }
 
-int iio_ring_buffer_register_ex(struct iio_ring_buffer *ring, int id,
+int iio_ring_buffer_register_ex(struct iio_dev *indio_dev, int id,
 				const struct iio_chan_spec *channels,
 				int num_channels)
 {
+	struct iio_ring_buffer *ring = indio_dev->ring;
 	int ret, i;
 
-	ret = __iio_request_ring_buffer_chrdev(ring, ring->owner, id);
-	if (ret)
-		goto error_ret;
-
 	if (ring->scan_el_attrs) {
-		ret = sysfs_create_group(&ring->dev.kobj,
+		ret = sysfs_create_group(&indio_dev->dev.kobj,
 					 ring->scan_el_attrs);
 		if (ret) {
-			dev_err(&ring->dev,
+			dev_err(&indio_dev->dev,
 				"Failed to add sysfs scan elements\n");
-			goto error_free_ring_buffer_chrdev;
+			goto error_ret;
 		}
 	} else if (channels) {
-		ret = sysfs_create_group(&ring->dev.kobj,
+		ret = sysfs_create_group(&indio_dev->dev.kobj,
 					 &iio_scan_el_dummy_group);
 		if (ret)
-			goto error_free_ring_buffer_chrdev;
+			goto error_ret;
+	}
+	if (ring->attrs) {
+		ret = sysfs_create_group(&indio_dev->dev.kobj,
+					 ring->attrs);
+		if (ret)
+			goto error_cleanup_dynamic;
 	}
 
 	INIT_LIST_HEAD(&ring->scan_el_dev_attr_list);
 	if (channels) {
 		/* new magic */
 		for (i = 0; i < num_channels; i++) {
-			ret = iio_ring_add_channel_sysfs(ring, &channels[i]);
+			ret = iio_ring_add_channel_sysfs(indio_dev, &channels[i]);
 			if (ret < 0)
-				goto error_cleanup_dynamic;
+				goto error_cleanup_group;
 		}
 	}
 
 	return 0;
+error_cleanup_group:
+	if (ring->attrs)
+		sysfs_remove_group(&indio_dev->dev.kobj, ring->attrs);
 error_cleanup_dynamic:
-	__iio_ring_attr_cleanup(ring);
-error_free_ring_buffer_chrdev:
-	__iio_free_ring_buffer_chrdev(ring);
+	__iio_ring_attr_cleanup(indio_dev);
 error_ret:
 	return ret;
 }
 EXPORT_SYMBOL(iio_ring_buffer_register_ex);
 
-void iio_ring_buffer_unregister(struct iio_ring_buffer *ring)
+void iio_ring_buffer_unregister(struct iio_dev *indio_dev)
 {
-	__iio_ring_attr_cleanup(ring);
-	__iio_free_ring_buffer_chrdev(ring);
+	if (indio_dev->ring->attrs)
+		sysfs_remove_group(&indio_dev->dev.kobj,
+				   indio_dev->ring->attrs);
+	__iio_ring_attr_cleanup(indio_dev);
 }
 EXPORT_SYMBOL(iio_ring_buffer_unregister);
 
@@ -431,7 +340,8 @@ ssize_t iio_read_ring_length(struct device *dev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_ring_buffer *ring = indio_dev->ring;
 
 	if (ring->access->get_length)
 		return sprintf(buf, "%d\n",
@@ -448,7 +358,8 @@ ssize_t iio_write_ring_length(struct device *dev,
 {
 	int ret;
 	ulong val;
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_ring_buffer *ring = indio_dev->ring;
 
 	ret = strict_strtoul(buf, 10, &val);
 	if (ret)
@@ -472,7 +383,8 @@ ssize_t iio_read_ring_bytes_per_datum(struct device *dev,
 			  struct device_attribute *attr,
 			  char *buf)
 {
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_ring_buffer *ring = indio_dev->ring;
 
 	if (ring->access->get_bytes_per_datum)
 		return sprintf(buf, "%d\n",
@@ -490,8 +402,8 @@ ssize_t iio_store_ring_enable(struct device *dev,
 	int ret;
 	bool requested_state, current_state;
 	int previous_mode;
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	struct iio_dev *dev_info = ring->indio_dev;
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct iio_ring_buffer *ring = dev_info->ring;
 
 	mutex_lock(&dev_info->mlock);
 	previous_mode = dev_info->currentmode;
@@ -583,8 +495,8 @@ ssize_t iio_show_ring_enable(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", !!(ring->indio_dev->currentmode
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n", !!(dev_info->currentmode
 				       & INDIO_ALL_RING_MODES));
 }
 EXPORT_SYMBOL(iio_show_ring_enable);
diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index 3c9516b..dcd5e36 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -87,25 +87,22 @@ static struct attribute *iio_kfifo_attributes[] = {
 
 static struct attribute_group iio_kfifo_attribute_group = {
 	.attrs = iio_kfifo_attributes,
+	.name = "buffer",
 };
 
-static const struct attribute_group *iio_kfifo_attribute_groups[] = {
-	&iio_kfifo_attribute_group,
-	NULL
-};
 
-static void iio_kfifo_release(struct device *dev)
-{
-	struct iio_ring_buffer *r = to_iio_ring_buffer(dev);
-	struct iio_kfifo *kf = iio_to_kfifo(r);
-	kfifo_free(&kf->kf);
-	kfree(kf);
-}
+//static void iio_kfifo_release(struct device *dev)
+//{
+//	struct iio_ring_buffer *r = to_iio_ring_buffer(dev);
+//	struct iio_kfifo *kf = iio_to_kfifo(r);
+//	kfifo_free(&kf->kf);
+//	kfree(kf);
+//}
 
-static struct device_type iio_kfifo_type = {
-	.release = iio_kfifo_release,
-	.groups = iio_kfifo_attribute_groups,
-};
+//static struct device_type iio_kfifo_type = {
+//	.release = iio_kfifo_release,
+//	.groups = iio_kfifo_attribute_groups,
+//};
 
 struct iio_ring_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
 {
@@ -116,10 +113,8 @@ struct iio_ring_buffer *iio_kfifo_allocate(struct iio_dev *indio_dev)
 		return NULL;
 	kf->update_needed = true;
 	iio_ring_buffer_init(&kf->ring, indio_dev);
+	kf->ring.attrs = &iio_kfifo_attribute_group;
 	__iio_init_kfifo(kf);
-	kf->ring.dev.type = &iio_kfifo_type;
-	kf->ring.dev.parent = &indio_dev->dev;
-	dev_set_drvdata(&kf->ring.dev, (void *)&(kf->ring));
 
 	return &kf->ring;
 }
@@ -159,8 +154,8 @@ static int iio_set_length_kfifo(struct iio_ring_buffer *r, int length)
 
 void iio_kfifo_free(struct iio_ring_buffer *r)
 {
-	if (r)
-		iio_put_ring_buffer(r);
+//	if (r)
+//		iio_put_ring_buffer(r);
 }
 EXPORT_SYMBOL(iio_kfifo_free);
 
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 299b954..517ab89 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -779,7 +779,7 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev, 0,
 					  &ade7758_channels[0],
 					  ARRAY_SIZE(ade7758_channels));
 	if (ret) {
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 2efebb7..e736dc1 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -94,7 +94,6 @@ struct iio_ring_setup_ops {
  * @flags:		[INTERN] file operations related flags including busy flag.
  **/
 struct iio_ring_buffer {
-	struct device				dev;
 	struct iio_dev				*indio_dev;
 	struct module				*owner;
 	int					length;
@@ -111,7 +110,7 @@ struct iio_ring_buffer {
 	wait_queue_head_t			pollq;
 	bool					stufftoread;
 	unsigned long				flags;
-	struct cdev				chrdev;
+	const struct attribute_group *attrs;
 };
 
 /**
@@ -200,24 +199,15 @@ static inline int iio_scan_mask_set(struct iio_ring_buffer *ring, int bit)
 	return 0;
 };
 
-/**
- * iio_put_ring_buffer() - notify done with buffer
- * @ring: the buffer we are done with.
- **/
-static inline void iio_put_ring_buffer(struct iio_ring_buffer *ring)
-{
-	put_device(&ring->dev);
-};
-
 #define to_iio_ring_buffer(d)				\
 	container_of(d, struct iio_ring_buffer, dev)
 
 /**
  * iio_ring_buffer_register_ex() - register the buffer with IIO core
- * @ring: the buffer to be registered
+ * @indio_dev: device with the buffer to be registered
  * @id: the id of the buffer (typically 0)
  **/
-int iio_ring_buffer_register_ex(struct iio_ring_buffer *ring, int id,
+int iio_ring_buffer_register_ex(struct iio_dev *indio_dev, int id,
 				const struct iio_chan_spec *channels,
 				int num_channels);
 
@@ -225,9 +215,9 @@ void iio_ring_access_release(struct device *dev);
 
 /**
  * iio_ring_buffer_unregister() - unregister the buffer from IIO core
- * @ring: the buffer to be unregistered
+ * @indio_dev: the device with the buffer to be unregistered
  **/
-void iio_ring_buffer_unregister(struct iio_ring_buffer *ring);
+void iio_ring_buffer_unregister(struct iio_dev *indio_dev);
 
 /**
  * iio_read_ring_length() - attr func to get number of datums in the buffer
@@ -274,7 +264,7 @@ int iio_sw_ring_preenable(struct iio_dev *indio_dev);
 
 #else /* CONFIG_IIO_RING_BUFFER */
 
-static inline int iio_ring_buffer_register_ex(struct iio_ring_buffer *ring,
+static inline int iio_ring_buffer_register_ex(struct iio_dev *indio_dev,
 					      int id,
 					      struct iio_chan_spec *channels,
 					      int num_channels)
@@ -282,7 +272,7 @@ static inline int iio_ring_buffer_register_ex(struct iio_ring_buffer *ring,
 	return 0;
 }
 
-static inline void iio_ring_buffer_unregister(struct iio_ring_buffer *ring)
+static inline void iio_ring_buffer_unregister(struct iio_dev *indio_dev)
 {};
 
 #endif /* CONFIG_IIO_RING_BUFFER */
diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
index feb84e2..ddc752d 100644
--- a/drivers/staging/iio/ring_sw.c
+++ b/drivers/staging/iio/ring_sw.c
@@ -394,8 +394,8 @@ static int iio_mark_update_needed_sw_rb(struct iio_ring_buffer *r)
 
 static void iio_sw_rb_release(struct device *dev)
 {
-	struct iio_ring_buffer *r = to_iio_ring_buffer(dev);
-	iio_ring_access_release(&r->dev);
+	struct iio_dev *indio_dev =  container_of(dev, struct iio_dev, dev);
+	struct iio_ring_buffer *r = indio_dev->ring;
 	kfree(iio_to_sw_ring(r));
 }
 
@@ -413,16 +413,7 @@ static struct attribute *iio_ring_attributes[] = {
 
 static struct attribute_group iio_ring_attribute_group = {
 	.attrs = iio_ring_attributes,
-};
-
-static const struct attribute_group *iio_ring_attribute_groups[] = {
-	&iio_ring_attribute_group,
-	NULL
-};
-
-static struct device_type iio_sw_ring_type = {
-	.release = iio_sw_rb_release,
-	.groups = iio_ring_attribute_groups,
+	.name = "buffer",
 };
 
 struct iio_ring_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev)
@@ -437,9 +428,7 @@ struct iio_ring_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev)
 	buf = &ring->buf;
 	iio_ring_buffer_init(buf, indio_dev);
 	__iio_init_sw_ring_buffer(ring);
-	buf->dev.type = &iio_sw_ring_type;
-	buf->dev.parent = &indio_dev->dev;
-	dev_set_drvdata(&buf->dev, (void *)buf);
+	buf->attrs = &iio_ring_attribute_group;
 
 	return buf;
 }
@@ -447,8 +436,8 @@ EXPORT_SYMBOL(iio_sw_rb_allocate);
 
 void iio_sw_rb_free(struct iio_ring_buffer *r)
 {
-	if (r)
-		iio_put_ring_buffer(r);
+	//if (r)
+	//	iio_put_ring_buffer(r);
 }
 EXPORT_SYMBOL(iio_sw_rb_free);
 
-- 
1.7.3.4

