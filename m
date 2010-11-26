Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:45977 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab0KZO4D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Nov 2010 09:56:03 -0500
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/3] staging:iio:gyro:adis16060 cleanup and dead code removal
Date: Fri, 26 Nov 2010 15:02:38 +0000
Message-Id: <1290783760-6968-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1290783760-6968-1-git-send-email-jic23@cam.ac.uk>
References: <1290783760-6968-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Removed stubs related to buffering and triggering. Put them back
when they are actually needed.
Fixed line length issues.
Made a number of functions static as no longer in header.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16060.h      |   70 -----------------------------
 drivers/staging/iio/gyro/adis16060_core.c |   59 +++++-------------------
 2 files changed, 13 insertions(+), 116 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16060.h b/drivers/staging/iio/gyro/adis16060.h
index 5c00e53..e85121b 100644
--- a/drivers/staging/iio/gyro/adis16060.h
+++ b/drivers/staging/iio/gyro/adis16060.h
@@ -14,11 +14,7 @@
 /**
  * struct adis16060_state - device instance specific data
  * @us_w:			actual spi_device to write data
- * @work_trigger_to_ring: bh for triggered event handling
- * @inter:		used to check if new interrupt has been triggered
- * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
- * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
  * @rx:			recieve buffer
  * @buf_lock:		mutex to protect tx and rx
@@ -26,76 +22,10 @@
 struct adis16060_state {
 	struct spi_device		*us_w;
 	struct spi_device		*us_r;
-	struct work_struct		work_trigger_to_ring;
-	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
-	struct iio_trigger		*trig;
 	u8				*tx;
 	u8				*rx;
 	struct mutex			buf_lock;
 };
 
-#if defined(CONFIG_IIO_RING_BUFFER) && defined(THIS_HAS_RING_BUFFER_SUPPORT)
-/* At the moment triggers are only used for ring buffer
- * filling. This may change!
- */
-
-enum adis16060_scan {
-	ADIS16060_SCAN_GYRO,
-	ADIS16060_SCAN_TEMP,
-	ADIS16060_SCAN_ADC_1,
-	ADIS16060_SCAN_ADC_2,
-};
-
-void adis16060_remove_trigger(struct iio_dev *indio_dev);
-int adis16060_probe_trigger(struct iio_dev *indio_dev);
-
-ssize_t adis16060_read_data_from_ring(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf);
-
-
-int adis16060_configure_ring(struct iio_dev *indio_dev);
-void adis16060_unconfigure_ring(struct iio_dev *indio_dev);
-
-int adis16060_initialize_ring(struct iio_ring_buffer *ring);
-void adis16060_uninitialize_ring(struct iio_ring_buffer *ring);
-#else /* CONFIG_IIO_RING_BUFFER */
-
-static inline void adis16060_remove_trigger(struct iio_dev *indio_dev)
-{
-}
-
-static inline int adis16060_probe_trigger(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline ssize_t
-adis16060_read_data_from_ring(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	return 0;
-}
-
-static int adis16060_configure_ring(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline void adis16060_unconfigure_ring(struct iio_dev *indio_dev)
-{
-}
-
-static inline int adis16060_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-
-static inline void adis16060_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
-
-#endif /* CONFIG_IIO_RING_BUFFER */
 #endif /* SPI_ADIS16060_H_ */
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index fc48aca..11f51f2 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -25,11 +25,9 @@
 
 #include "adis16060.h"
 
-#define DRIVER_NAME		"adis16060"
+static struct adis16060_state *adis16060_st;
 
-struct adis16060_state *adis16060_st;
-
-int adis16060_spi_write(struct device *dev,
+static int adis16060_spi_write(struct device *dev,
 		u8 val)
 {
 	int ret;
@@ -47,7 +45,7 @@ int adis16060_spi_write(struct device *dev,
 	return ret;
 }
 
-int adis16060_spi_read(struct device *dev,
+static int adis16060_spi_read(struct device *dev,
 		u16 *val)
 {
 	int ret;
@@ -58,12 +56,15 @@ int adis16060_spi_read(struct device *dev,
 
 	ret = spi_read(st->us_r, st->rx, 3);
 
-	/* The internal successive approximation ADC begins the conversion process
-	 * on the falling edge of MSEL1 and starts to place data MSB first on the
-	 * DOUT line at the 6th falling edge of SCLK
+	/* The internal successive approximation ADC begins the
+	 * conversion process on the falling edge of MSEL1 and
+	 * starts to place data MSB first on the DOUT line at
+	 * the 6th falling edge of SCLK
 	 */
 	if (ret == 0)
-		*val = ((st->rx[0] & 0x3) << 12) | (st->rx[1] << 4) | ((st->rx[2] >> 4) & 0xF);
+		*val = ((st->rx[0] & 0x3) << 12) |
+			(st->rx[1] << 4) |
+			((st->rx[2] >> 4) & 0xF);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -74,7 +75,7 @@ static ssize_t adis16060_read(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	u16 val;
+	u16 val = 0;
 	ssize_t ret;
 
 	/* Take the iio_dev status lock */
@@ -174,45 +175,14 @@ static int __devinit adis16060_r_probe(struct spi_device *spi)
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = adis16060_configure_ring(st->indio_dev);
-	if (ret)
-		goto error_free_dev;
-
 	ret = iio_device_register(st->indio_dev);
 	if (ret)
-		goto error_unreg_ring_funcs;
+		goto error_free_dev;
 	regdone = 1;
 
-	ret = adis16060_initialize_ring(st->indio_dev->ring);
-	if (ret) {
-		printk(KERN_ERR "failed to initialize the ring\n");
-		goto error_unreg_ring_funcs;
-	}
-
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
-		ret = iio_register_interrupt_line(spi->irq,
-				st->indio_dev,
-				0,
-				IRQF_TRIGGER_RISING,
-				"adis16060");
-		if (ret)
-			goto error_uninitialize_ring;
-
-		ret = adis16060_probe_trigger(st->indio_dev);
-		if (ret)
-			goto error_unregister_line;
-	}
-
 	adis16060_st = st;
 	return 0;
 
-error_unregister_line:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
-error_uninitialize_ring:
-	adis16060_uninitialize_ring(st->indio_dev->ring);
-error_unreg_ring_funcs:
-	adis16060_unconfigure_ring(st->indio_dev);
 error_free_dev:
 	if (regdone)
 		iio_device_unregister(st->indio_dev);
@@ -236,12 +206,9 @@ static int adis16060_r_remove(struct spi_device *spi)
 
 	flush_scheduled_work();
 
-	adis16060_remove_trigger(indio_dev);
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
 		iio_unregister_interrupt_line(indio_dev, 0);
 
-	adis16060_uninitialize_ring(indio_dev->ring);
-	adis16060_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 	kfree(st->tx);
 	kfree(st->rx);
@@ -315,5 +282,5 @@ static __exit void adis16060_exit(void)
 module_exit(adis16060_exit);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADIS16060 Yaw Rate Gyroscope with SPI driver");
+MODULE_DESCRIPTION("Analog Devices ADIS16060 Yaw Rate Gyroscope Driver");
 MODULE_LICENSE("GPL v2");
-- 
1.7.2.2

