Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 10/54] staging:iio:accel:adis16220 allocate tx and rx in state plus state via iio_priv
Date: Mon, 27 Jun 2011 11:04:20 +0100
Message-Id: <1309169104-22139-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Few other misc cleanups.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/accel/adis16220.h      |   14 +---
 drivers/staging/iio/accel/adis16220_core.c |  105 ++++++++++-----------------
 2 files changed, 43 insertions(+), 76 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16220.h b/drivers/staging/iio/accel/adis16220.h
index 4d5758c..024313c 100644
--- a/drivers/staging/iio/accel/adis16220.h
+++ b/drivers/staging/iio/accel/adis16220.h
@@ -126,21 +126,15 @@
 /**
  * struct adis16220_state - device instance specific data
  * @us:			actual spi_device
- * @work_trigger_to_ring: bh for triggered event handling
- * @inter:		used to check if new interrupt has been triggered
- * @last_timestamp:	passing timestamp from th to bh of interrupt handler
- * @indio_dev:		industrial I/O device structure
- * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
  * @rx:			receive buffer
  * @buf_lock:		mutex to protect tx and rx
  **/
 struct adis16220_state {
-	struct spi_device		*us;
-	struct iio_dev			*indio_dev;
-	u8				*tx;
-	u8				*rx;
-	struct mutex			buf_lock;
+	struct spi_device	*us;
+	struct mutex		buf_lock;
+	u8			tx[ADIS16220_MAX_TX] ____cacheline_aligned;
+	u8			rx[ADIS16220_MAX_RX];
 };
 
 #endif /* SPI_ADIS16220_H_ */
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 605a75e..bf9ba07 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -39,7 +39,7 @@ static int adis16220_spi_write_reg_8(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16220_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16220_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADIS16220_WRITE_REG(reg_address);
@@ -65,7 +65,7 @@ static int adis16220_spi_write_reg_16(struct device *dev,
 	int ret;
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16220_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16220_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx,
@@ -110,7 +110,7 @@ static int adis16220_spi_read_reg_16(struct device *dev,
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16220_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16220_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -316,10 +316,10 @@ err_ret:
 	return ret;
 }
 
-static int adis16220_initial_setup(struct adis16220_state *st)
+static int adis16220_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct device *dev = &st->indio_dev->dev;
+	struct device *dev = &indio_dev->dev;
 
 	/* Do self test */
 	ret = adis16220_self_test(dev);
@@ -341,19 +341,17 @@ static int adis16220_initial_setup(struct adis16220_state *st)
 		}
 	}
 
-	printk(KERN_INFO DRIVER_NAME ": at CS%d (irq %d)\n",
-			st->us->chip_select, st->us->irq);
-
 err_ret:
 	return ret;
 }
 
-static ssize_t adis16220_capture_buffer_read(struct adis16220_state *st,
+static ssize_t adis16220_capture_buffer_read(struct iio_dev *indio_dev,
 					char *buf,
 					loff_t off,
 					size_t count,
 					int addr)
 {
+	struct adis16220_state *st = iio_priv(indio_dev);
 	struct spi_message msg;
 	struct spi_transfer xfers[] = {
 		{
@@ -383,7 +381,7 @@ static ssize_t adis16220_capture_buffer_read(struct adis16220_state *st,
 		count = ADIS16220_CAPTURE_SIZE - off;
 
 	/* write the begin position of capture buffer */
-	ret = adis16220_spi_write_reg_16(&st->indio_dev->dev,
+	ret = adis16220_spi_write_reg_16(&indio_dev->dev,
 					ADIS16220_CAPT_PNTR,
 					off > 1);
 	if (ret)
@@ -422,9 +420,8 @@ static ssize_t adis16220_accel_bin_read(struct file *filp, struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16220_state *st = iio_dev_get_devdata(indio_dev);
 
-	return adis16220_capture_buffer_read(st, buf,
+	return adis16220_capture_buffer_read(indio_dev, buf,
 					off, count,
 					ADIS16220_CAPT_BUFA);
 }
@@ -445,9 +442,8 @@ static ssize_t adis16220_adc1_bin_read(struct file *filp, struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16220_state *st = iio_dev_get_devdata(indio_dev);
 
-	return adis16220_capture_buffer_read(st, buf,
+	return adis16220_capture_buffer_read(indio_dev, buf,
 					off, count,
 					ADIS16220_CAPT_BUF1);
 }
@@ -468,9 +464,8 @@ static ssize_t adis16220_adc2_bin_read(struct file *filp, struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16220_state *st = iio_dev_get_devdata(indio_dev);
 
-	return adis16220_capture_buffer_read(st, buf,
+	return adis16220_capture_buffer_read(indio_dev, buf,
 					off, count,
 					ADIS16220_CAPT_BUF2);
 }
@@ -551,98 +546,76 @@ static const struct iio_info adis16220_info = {
 static int __devinit adis16220_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
-	struct adis16220_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
+	struct adis16220_state *st;
+	struct iio_dev *indio_dev;
+
+	/* setup the industrialio driver allocated elements */
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
 		goto error_ret;
 	}
+
+	st = iio_priv(indio_dev);
 	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, st);
+	spi_set_drvdata(spi, indio_dev);
 
-	/* Allocate the comms buffers */
-	st->rx = kzalloc(sizeof(*st->rx)*ADIS16220_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*ADIS16220_MAX_TX, GFP_KERNEL);
-	if (st->tx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_rx;
-	}
 	st->us = spi;
 	mutex_init(&st->buf_lock);
-	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_tx;
-	}
 
-	st->indio_dev->name = spi->dev.driver->name;
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->info = &adis16220_info;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = spi->dev.driver->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &adis16220_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 	regdone = 1;
 
-	ret = sysfs_create_bin_file(&st->indio_dev->dev.kobj, &accel_bin);
+	ret = sysfs_create_bin_file(&indio_dev->dev.kobj, &accel_bin);
 	if (ret)
 		goto error_free_dev;
 
-	ret = sysfs_create_bin_file(&st->indio_dev->dev.kobj, &adc1_bin);
+	ret = sysfs_create_bin_file(&indio_dev->dev.kobj, &adc1_bin);
 	if (ret)
 		goto error_rm_accel_bin;
 
-	ret = sysfs_create_bin_file(&st->indio_dev->dev.kobj, &adc2_bin);
+	ret = sysfs_create_bin_file(&indio_dev->dev.kobj, &adc2_bin);
 	if (ret)
 		goto error_rm_adc1_bin;
 
 	/* Get the device into a sane initial state */
-	ret = adis16220_initial_setup(st);
+	ret = adis16220_initial_setup(indio_dev);
 	if (ret)
 		goto error_rm_adc2_bin;
 	return 0;
 
 error_rm_adc2_bin:
-	sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &adc2_bin);
+	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc2_bin);
 error_rm_adc1_bin:
-	sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &adc1_bin);
+	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc1_bin);
 error_rm_accel_bin:
-	sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &accel_bin);
+	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
 error_free_dev:
 	if (regdone)
-		iio_device_unregister(st->indio_dev);
+		iio_device_unregister(indio_dev);
 	else
-		iio_free_device(st->indio_dev);
-error_free_tx:
-	kfree(st->tx);
-error_free_rx:
-	kfree(st->rx);
-error_free_st:
-	kfree(st);
+		iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
 
 static int adis16220_remove(struct spi_device *spi)
 {
-	struct adis16220_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	flush_scheduled_work();
 
-	sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &adc2_bin);
-	sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &adc1_bin);
-	sysfs_remove_bin_file(&st->indio_dev->dev.kobj, &accel_bin);
+	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc2_bin);
+	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc1_bin);
+	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
 	iio_device_unregister(indio_dev);
-	kfree(st->tx);
-	kfree(st->rx);
-	kfree(st);
 
 	return 0;
 }
-- 
1.7.3.4
