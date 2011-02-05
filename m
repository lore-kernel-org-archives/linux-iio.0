Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:60069 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab1BERwP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Feb 2011 12:52:15 -0500
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: mensch0815@googlemail.com,
	device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/5] staging:iio:gyro:adis16130 stub removal and cleanup
Date: Sat,  5 Feb 2011 17:52:03 +0000
Message-Id: <1296928325-14967-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1296928325-14967-1-git-send-email-jic23@cam.ac.uk>
References: <1296928325-14967-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Get rid of unused stubs for trigger and buffer support.
Fix line length issues.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16130.h      |   72 +---------------------------
 drivers/staging/iio/gyro/adis16130_core.c |   61 +++---------------------
 2 files changed, 10 insertions(+), 123 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16130.h b/drivers/staging/iio/gyro/adis16130.h
index ab80ef6..9efc4c7 100644
--- a/drivers/staging/iio/gyro/adis16130.h
+++ b/drivers/staging/iio/gyro/adis16130.h
@@ -4,7 +4,9 @@
 #define ADIS16130_CON         0x0
 #define ADIS16130_CON_RD      (1 << 6)
 #define ADIS16130_IOP         0x1
-#define ADIS16130_IOP_ALL_RDY (1 << 3) /* 1 = data-ready signal low when unread data on all channels; */
+
+/* 1 = data-ready signal low when unread data on all channels; */
+#define ADIS16130_IOP_ALL_RDY (1 << 3)
 #define ADIS16130_IOP_SYNC    (1 << 0) /* 1 = synchronization enabled */
 #define ADIS16130_RATEDATA    0x8 /* Gyroscope output, rate of rotation */
 #define ADIS16130_TEMPDATA    0xA /* Temperature output */
@@ -23,86 +25,18 @@
 /**
  * struct adis16130_state - device instance specific data
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
 struct adis16130_state {
 	struct spi_device		*us;
-	struct work_struct		work_trigger_to_ring;
-	s64				last_timestamp;
 	struct iio_dev			*indio_dev;
-	struct iio_trigger		*trig;
 	u8				*tx;
 	u8				*rx;
 	u32                             mode; /* 1: 24bits mode 0:16bits mode */
 	struct mutex			buf_lock;
 };
 
-#if defined(CONFIG_IIO_RING_BUFFER) && defined(THIS_HAS_RING_BUFFER_SUPPORT)
-/* At the moment triggers are only used for ring buffer
- * filling. This may change!
- */
-
-enum adis16130_scan {
-	ADIS16130_SCAN_GYRO,
-	ADIS16130_SCAN_TEMP,
-};
-
-void adis16130_remove_trigger(struct iio_dev *indio_dev);
-int adis16130_probe_trigger(struct iio_dev *indio_dev);
-
-ssize_t adis16130_read_data_from_ring(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf);
-
-
-int adis16130_configure_ring(struct iio_dev *indio_dev);
-void adis16130_unconfigure_ring(struct iio_dev *indio_dev);
-
-int adis16130_initialize_ring(struct iio_ring_buffer *ring);
-void adis16130_uninitialize_ring(struct iio_ring_buffer *ring);
-#else /* CONFIG_IIO_RING_BUFFER */
-
-static inline void adis16130_remove_trigger(struct iio_dev *indio_dev)
-{
-}
-
-static inline int adis16130_probe_trigger(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline ssize_t
-adis16130_read_data_from_ring(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	return 0;
-}
-
-static int adis16130_configure_ring(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline void adis16130_unconfigure_ring(struct iio_dev *indio_dev)
-{
-}
-
-static inline int adis16130_initialize_ring(struct iio_ring_buffer *ring)
-{
-	return 0;
-}
-
-static inline void adis16130_uninitialize_ring(struct iio_ring_buffer *ring)
-{
-}
-
-#endif /* CONFIG_IIO_RING_BUFFER */
 #endif /* SPI_ADIS16130_H_ */
diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 49ffc7b..04d81d4 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -25,11 +25,7 @@
 
 #include "adis16130.h"
 
-#define DRIVER_NAME		"adis16130"
-
-struct adis16130_state *adis16130_st;
-
-int adis16130_spi_write(struct device *dev, u8 reg_addr,
+static int adis16130_spi_write(struct device *dev, u8 reg_addr,
 		u8 val)
 {
 	int ret;
@@ -46,7 +42,7 @@ int adis16130_spi_write(struct device *dev, u8 reg_addr,
 	return ret;
 }
 
-int adis16130_spi_read(struct device *dev, u8 reg_addr,
+static int adis16130_spi_read(struct device *dev, u8 reg_addr,
 		u32 *val)
 {
 	int ret;
@@ -148,7 +144,8 @@ static IIO_DEV_ATTR_GYRO(adis16130_gyro_read,
 #define IIO_DEV_ATTR_BITS_MODE(_mode, _show, _store, _addr)	\
 	IIO_DEVICE_ATTR(bits_mode, _mode, _show, _store, _addr)
 
-static IIO_DEV_ATTR_BITS_MODE(S_IWUSR | S_IRUGO, adis16130_bitsmode_read, adis16130_bitsmode_write,
+static IIO_DEV_ATTR_BITS_MODE(S_IWUSR | S_IRUGO, adis16130_bitsmode_read,
+			adis16130_bitsmode_write,
 			ADIS16130_MODE);
 
 static struct attribute *adis16130_event_attributes[] = {
@@ -173,7 +170,7 @@ static const struct attribute_group adis16130_attribute_group = {
 
 static int __devinit adis16130_probe(struct spi_device *spi)
 {
-	int ret, regdone = 0;
+	int ret;
 	struct adis16130_state *st = kzalloc(sizeof *st, GFP_KERNEL);
 	if (!st) {
 		ret =  -ENOMEM;
@@ -211,50 +208,14 @@ static int __devinit adis16130_probe(struct spi_device *spi)
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
 	st->mode = 1;
 
-	ret = adis16130_configure_ring(st->indio_dev);
-	if (ret)
-		goto error_free_dev;
-
 	ret = iio_device_register(st->indio_dev);
 	if (ret)
-		goto error_unreg_ring_funcs;
-	regdone = 1;
-
-	ret = adis16130_initialize_ring(st->indio_dev->ring);
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
-				"adis16130");
-		if (ret)
-			goto error_uninitialize_ring;
-
-		ret = adis16130_probe_trigger(st->indio_dev);
-		if (ret)
-			goto error_unregister_line;
-	}
+		goto error_free_dev;
 
-	adis16130_st = st;
 	return 0;
 
-error_unregister_line:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
-error_uninitialize_ring:
-	adis16130_uninitialize_ring(st->indio_dev->ring);
-error_unreg_ring_funcs:
-	adis16130_unconfigure_ring(st->indio_dev);
 error_free_dev:
-	if (regdone)
-		iio_device_unregister(st->indio_dev);
-	else
-		iio_free_device(st->indio_dev);
+	iio_free_device(st->indio_dev);
 error_free_tx:
 	kfree(st->tx);
 error_free_rx:
@@ -271,14 +232,6 @@ static int adis16130_remove(struct spi_device *spi)
 	struct adis16130_state *st = spi_get_drvdata(spi);
 	struct iio_dev *indio_dev = st->indio_dev;
 
-	flush_scheduled_work();
-
-	adis16130_remove_trigger(indio_dev);
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
-		iio_unregister_interrupt_line(indio_dev, 0);
-
-	adis16130_uninitialize_ring(indio_dev->ring);
-	adis16130_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 	kfree(st->tx);
 	kfree(st->rx);
-- 
1.7.3.4

