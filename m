Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/3] staging:iio:gyro:adis16080 unused stub removal and cleanup
Date: Fri, 26 Nov 2010 15:02:39 +0000
Message-Id: <1290783760-6968-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1290783760-6968-1-git-send-email-jic23@cam.ac.uk>
References: <1290783760-6968-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16080.h      |   84 +++-------------------------
 drivers/staging/iio/gyro/adis16080_core.c |   54 ++-----------------
 2 files changed, 14 insertions(+), 124 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16080.h b/drivers/staging/iio/gyro/adis16080.h
index 3fcbe67..f4e3851 100644
--- a/drivers/staging/iio/gyro/adis16080.h
+++ b/drivers/staging/iio/gyro/adis16080.h
@@ -1,14 +1,19 @@
 #ifndef SPI_ADIS16080_H_
 #define SPI_ADIS16080_H_
 
-#define ADIS16080_DIN_CODE   4 /* Output data format setting. 0: Twos complement. 1: Offset binary. */
+/* Output data format setting. 0: Twos complement. 1: Offset binary. */
+#define ADIS16080_DIN_CODE   4
 #define ADIS16080_DIN_GYRO   (0 << 10) /* Gyroscope output */
 #define ADIS16080_DIN_TEMP   (1 << 10) /* Temperature output */
 #define ADIS16080_DIN_AIN1   (2 << 10)
 #define ADIS16080_DIN_AIN2   (3 << 10)
-#define ADIS16080_DIN_WRITE  (1 << 15) /* 1: Write contents on DIN to control register.
-					* 0: No changes to control register.
-					*/
+
+/*
+ * 1: Write contents on DIN to control register.
+ * 0: No changes to control register.
+ */
+
+#define ADIS16080_DIN_WRITE  (1 << 15)
 
 #define ADIS16080_MAX_TX     2
 #define ADIS16080_MAX_RX     2
@@ -16,87 +21,16 @@
 /**
  * struct adis16080_state - device instance specific data
  * @us:			actual spi_device to write data
- * @work_trigger_to_ring: bh for triggered event handling
- * @inter:		used to check if new interrupt has been triggered
- * @last_timestamp:	passing timestamp from th to bh of interrupt handler
  * @indio_dev:		industrial I/O device structure
- * @trig:		data ready trigger registered with iio
  * @tx:			transmit buffer
  * @rx:			recieve buffer
  * @buf_lock:		mutex to protect tx and rx
  **/
 struct adis16080_state {
 	struct spi_device		*us;
-	struct work_struct		work_trigger_to_ring;
-	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
-	struct iio_trigger		*trig;
 	u8				*tx;
 	u8				*rx;
 	struct mutex			buf_lock;
 };
-
-#if defined(CONFIG_IIO_RING_BUFFER) && defined(THIS_HAS_RING_BUFFER_SUPPORT)
-/* At the moment triggers are only used for ring buffer
- * filling. This may change!
- */
-
-enum adis16080_scan {
-	ADIS16080_SCAN_GYRO,
-	ADIS16080_SCAN_TEMP,
-	ADIS16080_SCAN_ADC_1,
-	ADIS16080_SCAN_ADC_2,
-};
-
-void adis16080_remove_trigger(struct iio_dev *indio_dev);
-int adis16080_probe_trigger(struct iio_dev *indio_dev);
-
-ssize_t adis16080_read_data_from_ring(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf);
-
-
-int adis16080_configure_ring(struct iio_dev *indio_dev);
-void adis16080_unconfigure_ring(struct iio_dev *indio_dev);
-
-int adis16080_initialize_ring(struct iio_ring_buffer *ring);
-void adis16080_uninitialize_ring(struct iio_ring_buffer *ring);
-#else /* CONFIG_IIO_RING_BUFFER */
-
-static inline void adis16080_remove_trigger(struct iio_dev *indio_dev)
-{
-}
-
-static inline int adis16080_probe_trigger(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline ssize_t
-adis16080_read_data_from_ring(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	return 0;
-}
-
-static int adis16080_configure_ring(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline void adis16080_unconfigure_ring(struct iio_dev *indio_dev)
-{
-}
-
-static inline int adis16080_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-
-static inline void adis16080_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
-
-#endif /* CONFIG_IIO_RING_BUFFER */
 #endif /* SPI_ADIS16080_H_ */
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 0efb768..252080b 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -25,11 +25,7 @@
 
 #include "adis16080.h"
 
-#define DRIVER_NAME		"adis16080"
-
-struct adis16080_state *adis16080_st;
-
-int adis16080_spi_write(struct device *dev,
+static int adis16080_spi_write(struct device *dev,
 		u16 val)
 {
 	int ret;
@@ -46,7 +42,7 @@ int adis16080_spi_write(struct device *dev,
 	return ret;
 }
 
-int adis16080_spi_read(struct device *dev,
+static int adis16080_spi_read(struct device *dev,
 		u16 *val)
 {
 	int ret;
@@ -69,7 +65,7 @@ static ssize_t adis16080_read(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	u16 val;
+	u16 val = 0;
 	ssize_t ret;
 
 	/* Take the iio_dev status lock */
@@ -169,45 +165,13 @@ static int __devinit adis16080_probe(struct spi_device *spi)
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = adis16080_configure_ring(st->indio_dev);
-	if (ret)
-		goto error_free_dev;
-
 	ret = iio_device_register(st->indio_dev);
 	if (ret)
-		goto error_unreg_ring_funcs;
+		goto error_free_dev;
 	regdone = 1;
 
-	ret = adis16080_initialize_ring(st->indio_dev->ring);
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
-				"adis16080");
-		if (ret)
-			goto error_uninitialize_ring;
-
-		ret = adis16080_probe_trigger(st->indio_dev);
-		if (ret)
-			goto error_unregister_line;
-	}
-
-	adis16080_st = st;
 	return 0;
 
-error_unregister_line:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
-error_uninitialize_ring:
-	adis16080_uninitialize_ring(st->indio_dev->ring);
-error_unreg_ring_funcs:
-	adis16080_unconfigure_ring(st->indio_dev);
 error_free_dev:
 	if (regdone)
 		iio_device_unregister(st->indio_dev);
@@ -229,14 +193,6 @@ static int adis16080_remove(struct spi_device *spi)
 	struct adis16080_state *st = spi_get_drvdata(spi);
 	struct iio_dev *indio_dev = st->indio_dev;
 
-	flush_scheduled_work();
-
-	adis16080_remove_trigger(indio_dev);
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
-		iio_unregister_interrupt_line(indio_dev, 0);
-
-	adis16080_uninitialize_ring(indio_dev->ring);
-	adis16080_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 	kfree(st->tx);
 	kfree(st->rx);
@@ -267,5 +223,5 @@ static __exit void adis16080_exit(void)
 module_exit(adis16080_exit);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADIS16080/100 Yaw Rate Gyroscope with SPI driver");
+MODULE_DESCRIPTION("Analog Devices ADIS16080/100 Yaw Rate Gyroscope Driver");
 MODULE_LICENSE("GPL v2");
-- 
1.7.2.2
