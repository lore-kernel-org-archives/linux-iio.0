Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:43202 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557Ab1ITQLR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2011 12:11:17 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org, greg@kroah.com
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 07/14] staging:iio: tree wide IIO_RING_BUFFER config symbol to IIO_BUFFER
Date: Tue, 20 Sep 2011 17:11:06 +0100
Message-Id: <1316535073-21444-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316535073-21444-1-git-send-email-jic23@cam.ac.uk>
References: <1316535073-21444-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Functionality is generic, so name is missleading.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Kconfig                    |    6 ++--
 drivers/staging/iio/Makefile                   |    2 +-
 drivers/staging/iio/accel/Kconfig              |   28 ++++++++++++------------
 drivers/staging/iio/accel/Makefile             |   12 +++++-----
 drivers/staging/iio/accel/adis16201.h          |    6 ++--
 drivers/staging/iio/accel/adis16203.h          |    6 ++--
 drivers/staging/iio/accel/adis16204.h          |    6 ++--
 drivers/staging/iio/accel/adis16209.h          |    6 ++--
 drivers/staging/iio/accel/adis16240.h          |    6 ++--
 drivers/staging/iio/accel/lis3l02dq.h          |    6 ++--
 drivers/staging/iio/accel/lis3l02dq_core.c     |    2 +-
 drivers/staging/iio/accel/sca3000.h            |    2 +-
 drivers/staging/iio/adc/Kconfig                |   18 +++++++-------
 drivers/staging/iio/adc/Makefile               |    8 +++---
 drivers/staging/iio/adc/ad7298.h               |    6 ++--
 drivers/staging/iio/adc/ad7476.h               |    6 ++--
 drivers/staging/iio/adc/ad7887.h               |    6 ++--
 drivers/staging/iio/gyro/Kconfig               |    4 +-
 drivers/staging/iio/gyro/Makefile              |    2 +-
 drivers/staging/iio/gyro/adis16260.h           |    6 ++--
 drivers/staging/iio/iio_core.h                 |    2 +-
 drivers/staging/iio/impedance-analyzer/Kconfig |    2 +-
 drivers/staging/iio/imu/Kconfig                |    4 +-
 drivers/staging/iio/imu/Makefile               |    2 +-
 drivers/staging/iio/imu/adis16400.h            |    6 ++--
 drivers/staging/iio/meter/Kconfig              |    4 +-
 drivers/staging/iio/meter/Makefile             |    2 +-
 drivers/staging/iio/meter/ade7758.h            |    6 ++--
 drivers/staging/iio/ring_generic.h             |    6 ++--
 29 files changed, 89 insertions(+), 89 deletions(-)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 7526567..db4a79f 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -12,13 +12,13 @@ menuconfig IIO
 	  drivers/staging/iio/Documentation for more information.
 if IIO
 
-config IIO_RING_BUFFER
+config IIO_BUFFER
 	bool "Enable buffer support within IIO"
 	help
 	  Provide core support for various buffer based data
 	  acquisition methods.
 
-if IIO_RING_BUFFER
+if IIO_BUFFER
 
 config IIO_SW_RING
        select IIO_TRIGGER
@@ -38,7 +38,7 @@ config IIO_KFIFO_BUF
 	  no buffer events so it is up to userspace to work out how
 	  often to read from the buffer.
 
-endif # IIO_RINGBUFFER
+endif # IIO_BUFFER
 
 config IIO_TRIGGER
 	boolean "Enable triggered sampling support"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index eaff649..67a1d9c 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_IIO) += industrialio.o
 industrialio-y := industrialio-core.o
-industrialio-$(CONFIG_IIO_RING_BUFFER) += industrialio-ring.o
+industrialio-$(CONFIG_IIO_BUFFER) += industrialio-ring.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
 
 obj-$(CONFIG_IIO_SW_RING) += ring_sw.o
diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index bf38114..71f8739 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -6,8 +6,8 @@ menu "Accelerometers"
 config ADIS16201
 	tristate "Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer"
 	depends on SPI
-	select IIO_TRIGGER if IIO_RING_BUFFER
-	select IIO_SW_RING if IIO_RING_BUFFER
+	select IIO_TRIGGER if IIO_BUFFER
+	select IIO_SW_RING if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices adis16201 dual-axis
 	  digital inclinometer and accelerometer.
@@ -15,8 +15,8 @@ config ADIS16201
 config ADIS16203
 	tristate "Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer"
 	depends on SPI
-	select IIO_TRIGGER if IIO_RING_BUFFER
-	select IIO_SW_RING if IIO_RING_BUFFER
+	select IIO_TRIGGER if IIO_BUFFER
+	select IIO_SW_RING if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices adis16203 Programmable
 	  360 Degrees Inclinometer.
@@ -24,8 +24,8 @@ config ADIS16203
 config ADIS16204
 	tristate "Analog Devices ADIS16204 Programmable High-g Digital Impact Sensor and Recorder"
 	depends on SPI
-	select IIO_TRIGGER if IIO_RING_BUFFER
-	select IIO_SW_RING if IIO_RING_BUFFER
+	select IIO_TRIGGER if IIO_BUFFER
+	select IIO_SW_RING if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices adis16204 Programmable
 	  High-g Digital Impact Sensor and Recorder.
@@ -33,8 +33,8 @@ config ADIS16204
 config ADIS16209
 	tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
 	depends on SPI
-	select IIO_TRIGGER if IIO_RING_BUFFER
-	select IIO_SW_RING if IIO_RING_BUFFER
+	select IIO_TRIGGER if IIO_BUFFER
+	select IIO_SW_RING if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices adis16209 dual-axis digital inclinometer
 	  and accelerometer.
@@ -49,8 +49,8 @@ config ADIS16220
 config ADIS16240
 	tristate "Analog Devices ADIS16240 Programmable Impact Sensor and Recorder"
 	depends on SPI
-	select IIO_TRIGGER if IIO_RING_BUFFER
-	select IIO_SW_RING if IIO_RING_BUFFER
+	select IIO_TRIGGER if IIO_BUFFER
+	select IIO_SW_RING if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices adis16240 programmable
 	  impact Sensor and recorder.
@@ -65,8 +65,8 @@ config KXSD9
 config LIS3L02DQ
 	tristate "ST Microelectronics LIS3L02DQ Accelerometer Driver"
 	depends on SPI
-	select IIO_TRIGGER if IIO_RING_BUFFER
-	depends on !IIO_RING_BUFFER || IIO_KFIFO_BUF || IIO_SW_RING
+	select IIO_TRIGGER if IIO_BUFFER
+	depends on !IIO_BUFFER || IIO_KFIFO_BUF || IIO_SW_RING
 	help
 	  Say yes here to build SPI support for the ST microelectronics
 	  accelerometer. The driver supplies direct access via sysfs files
@@ -74,7 +74,7 @@ config LIS3L02DQ
 
 choice
 	prompt "Buffer type"
-       	depends on LIS3L02DQ && IIO_RING_BUFFER
+       	depends on LIS3L02DQ && IIO_BUFFER
 
 config LIS3L02DQ_BUF_KFIFO
        depends on IIO_KFIFO_BUF
@@ -94,7 +94,7 @@ config LIS3L02DQ_BUF_RING_SW
 endchoice
 
 config SCA3000
-	depends on IIO_RING_BUFFER
+	depends on IIO_BUFFER
 	depends on SPI
 	tristate "VTI SCA3000 series accelerometers"
 	help
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index 1b2a6d3..95c6666 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -3,32 +3,32 @@
 #
 
 adis16201-y             := adis16201_core.o
-adis16201-$(CONFIG_IIO_RING_BUFFER) += adis16201_ring.o adis16201_trigger.o
+adis16201-$(CONFIG_IIO_BUFFER) += adis16201_ring.o adis16201_trigger.o
 obj-$(CONFIG_ADIS16201) += adis16201.o
 
 adis16203-y             := adis16203_core.o
-adis16203-$(CONFIG_IIO_RING_BUFFER) += adis16203_ring.o adis16203_trigger.o
+adis16203-$(CONFIG_IIO_BUFFER) += adis16203_ring.o adis16203_trigger.o
 obj-$(CONFIG_ADIS16203) += adis16203.o
 
 adis16204-y             := adis16204_core.o
-adis16204-$(CONFIG_IIO_RING_BUFFER) += adis16204_ring.o adis16204_trigger.o
+adis16204-$(CONFIG_IIO_BUFFER) += adis16204_ring.o adis16204_trigger.o
 obj-$(CONFIG_ADIS16204) += adis16204.o
 
 adis16209-y             := adis16209_core.o
-adis16209-$(CONFIG_IIO_RING_BUFFER) += adis16209_ring.o adis16209_trigger.o
+adis16209-$(CONFIG_IIO_BUFFER) += adis16209_ring.o adis16209_trigger.o
 obj-$(CONFIG_ADIS16209) += adis16209.o
 
 adis16220-y             := adis16220_core.o
 obj-$(CONFIG_ADIS16220) += adis16220.o
 
 adis16240-y             := adis16240_core.o
-adis16240-$(CONFIG_IIO_RING_BUFFER) += adis16240_ring.o adis16240_trigger.o
+adis16240-$(CONFIG_IIO_BUFFER) += adis16240_ring.o adis16240_trigger.o
 obj-$(CONFIG_ADIS16240) += adis16240.o
 
 obj-$(CONFIG_KXSD9)	+= kxsd9.o
 
 lis3l02dq-y		:= lis3l02dq_core.o
-lis3l02dq-$(CONFIG_IIO_RING_BUFFER) += lis3l02dq_ring.o
+lis3l02dq-$(CONFIG_IIO_BUFFER) += lis3l02dq_ring.o
 obj-$(CONFIG_LIS3L02DQ)	+= lis3l02dq.o
 
 sca3000-y		:= sca3000_core.o sca3000_ring.o
diff --git a/drivers/staging/iio/accel/adis16201.h b/drivers/staging/iio/accel/adis16201.h
index dac5540..72750f7 100644
--- a/drivers/staging/iio/accel/adis16201.h
+++ b/drivers/staging/iio/accel/adis16201.h
@@ -89,7 +89,7 @@ enum adis16201_scan {
 	ADIS16201_SCAN_INCLI_Y,
 };
 
-#ifdef CONFIG_IIO_RING_BUFFER
+#ifdef CONFIG_IIO_BUFFER
 void adis16201_remove_trigger(struct iio_dev *indio_dev);
 int adis16201_probe_trigger(struct iio_dev *indio_dev);
 
@@ -100,7 +100,7 @@ ssize_t adis16201_read_data_from_ring(struct device *dev,
 int adis16201_configure_ring(struct iio_dev *indio_dev);
 void adis16201_unconfigure_ring(struct iio_dev *indio_dev);
 
-#else /* CONFIG_IIO_RING_BUFFER */
+#else /* CONFIG_IIO_BUFFER */
 
 static inline void adis16201_remove_trigger(struct iio_dev *indio_dev)
 {
@@ -137,5 +137,5 @@ static inline void adis16201_uninitialize_ring(struct iio_ring_buffer *ring)
 {
 }
 
-#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* CONFIG_IIO_BUFFER */
 #endif /* SPI_ADIS16201_H_ */
diff --git a/drivers/staging/iio/accel/adis16203.h b/drivers/staging/iio/accel/adis16203.h
index 4071bc0..3f96ad3 100644
--- a/drivers/staging/iio/accel/adis16203.h
+++ b/drivers/staging/iio/accel/adis16203.h
@@ -82,7 +82,7 @@ enum adis16203_scan {
 	ADIS16203_SCAN_INCLI_Y,
 };
 
-#ifdef CONFIG_IIO_RING_BUFFER
+#ifdef CONFIG_IIO_BUFFER
 void adis16203_remove_trigger(struct iio_dev *indio_dev);
 int adis16203_probe_trigger(struct iio_dev *indio_dev);
 
@@ -93,7 +93,7 @@ ssize_t adis16203_read_data_from_ring(struct device *dev,
 int adis16203_configure_ring(struct iio_dev *indio_dev);
 void adis16203_unconfigure_ring(struct iio_dev *indio_dev);
 
-#else /* CONFIG_IIO_RING_BUFFER */
+#else /* CONFIG_IIO_BUFFER */
 
 static inline void adis16203_remove_trigger(struct iio_dev *indio_dev)
 {
@@ -121,5 +121,5 @@ static inline void adis16203_unconfigure_ring(struct iio_dev *indio_dev)
 {
 }
 
-#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* CONFIG_IIO_BUFFER */
 #endif /* SPI_ADIS16203_H_ */
diff --git a/drivers/staging/iio/accel/adis16204.h b/drivers/staging/iio/accel/adis16204.h
index 3bb0490..7cf4e91 100644
--- a/drivers/staging/iio/accel/adis16204.h
+++ b/drivers/staging/iio/accel/adis16204.h
@@ -90,7 +90,7 @@ enum adis16204_scan {
 	ADIS16204_SCAN_TEMP,
 };
 
-#ifdef CONFIG_IIO_RING_BUFFER
+#ifdef CONFIG_IIO_BUFFER
 void adis16204_remove_trigger(struct iio_dev *indio_dev);
 int adis16204_probe_trigger(struct iio_dev *indio_dev);
 
@@ -101,7 +101,7 @@ ssize_t adis16204_read_data_from_ring(struct device *dev,
 int adis16204_configure_ring(struct iio_dev *indio_dev);
 void adis16204_unconfigure_ring(struct iio_dev *indio_dev);
 
-#else /* CONFIG_IIO_RING_BUFFER */
+#else /* CONFIG_IIO_BUFFER */
 
 static inline void adis16204_remove_trigger(struct iio_dev *indio_dev)
 {
@@ -129,5 +129,5 @@ static inline void adis16204_unconfigure_ring(struct iio_dev *indio_dev)
 {
 }
 
-#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* CONFIG_IIO_BUFFER */
 #endif /* SPI_ADIS16204_H_ */
diff --git a/drivers/staging/iio/accel/adis16209.h b/drivers/staging/iio/accel/adis16209.h
index c8b7b00..3c88b86 100644
--- a/drivers/staging/iio/accel/adis16209.h
+++ b/drivers/staging/iio/accel/adis16209.h
@@ -128,7 +128,7 @@ int adis16209_set_irq(struct iio_dev *indio_dev, bool enable);
 #define ADIS16209_SCAN_INCLI_Y	6
 #define ADIS16209_SCAN_ROT	7
 
-#ifdef CONFIG_IIO_RING_BUFFER
+#ifdef CONFIG_IIO_BUFFER
 
 void adis16209_remove_trigger(struct iio_dev *indio_dev);
 int adis16209_probe_trigger(struct iio_dev *indio_dev);
@@ -140,7 +140,7 @@ ssize_t adis16209_read_data_from_ring(struct device *dev,
 int adis16209_configure_ring(struct iio_dev *indio_dev);
 void adis16209_unconfigure_ring(struct iio_dev *indio_dev);
 
-#else /* CONFIG_IIO_RING_BUFFER */
+#else /* CONFIG_IIO_BUFFER */
 
 static inline void adis16209_remove_trigger(struct iio_dev *indio_dev)
 {
@@ -168,5 +168,5 @@ static inline void adis16209_unconfigure_ring(struct iio_dev *indio_dev)
 {
 }
 
-#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* CONFIG_IIO_BUFFER */
 #endif /* SPI_ADIS16209_H_ */
diff --git a/drivers/staging/iio/accel/adis16240.h b/drivers/staging/iio/accel/adis16240.h
index f1dd047..3fabcc0 100644
--- a/drivers/staging/iio/accel/adis16240.h
+++ b/drivers/staging/iio/accel/adis16240.h
@@ -152,7 +152,7 @@ int adis16240_set_irq(struct iio_dev *indio_dev, bool enable);
 #define ADIS16240_SCAN_AUX_ADC	4
 #define ADIS16240_SCAN_TEMP	5
 
-#ifdef CONFIG_IIO_RING_BUFFER
+#ifdef CONFIG_IIO_BUFFER
 void adis16240_remove_trigger(struct iio_dev *indio_dev);
 int adis16240_probe_trigger(struct iio_dev *indio_dev);
 
@@ -164,7 +164,7 @@ ssize_t adis16240_read_data_from_ring(struct device *dev,
 int adis16240_configure_ring(struct iio_dev *indio_dev);
 void adis16240_unconfigure_ring(struct iio_dev *indio_dev);
 
-#else /* CONFIG_IIO_RING_BUFFER */
+#else /* CONFIG_IIO_BUFFER */
 
 static inline void adis16240_remove_trigger(struct iio_dev *indio_dev)
 {
@@ -192,5 +192,5 @@ static inline void adis16240_unconfigure_ring(struct iio_dev *indio_dev)
 {
 }
 
-#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* CONFIG_IIO_BUFFER */
 #endif /* SPI_ADIS16240_H_ */
diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index 18b23ac..5a18f50 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -174,7 +174,7 @@ int lis3l02dq_spi_write_reg_8(struct iio_dev *indio_dev,
 
 int lis3l02dq_disable_all_events(struct iio_dev *indio_dev);
 
-#ifdef CONFIG_IIO_RING_BUFFER
+#ifdef CONFIG_IIO_BUFFER
 /* At the moment triggers are only used for ring buffer
  * filling. This may change!
  */
@@ -202,7 +202,7 @@ void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev);
 irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private);
 #define lis3l02dq_th lis3l02dq_data_rdy_trig_poll
 
-#else /* CONFIG_IIO_RING_BUFFER */
+#else /* CONFIG_IIO_BUFFER */
 #define lis3l02dq_th lis3l02dq_noring
 
 static inline void lis3l02dq_remove_trigger(struct iio_dev *indio_dev)
@@ -227,5 +227,5 @@ static int lis3l02dq_configure_ring(struct iio_dev *indio_dev)
 static inline void lis3l02dq_unconfigure_ring(struct iio_dev *indio_dev)
 {
 }
-#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* CONFIG_IIO_BUFFER */
 #endif /* SPI_LIS3L02DQ_H_ */
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 52b3a12..6d600f6 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -34,7 +34,7 @@
  * This means that use cannot be made of spi_write etc.
  */
 /* direct copy of the irq_default_primary_handler */
-#ifndef CONFIG_IIO_RING_BUFFER
+#ifndef CONFIG_IIO_BUFFER
 static irqreturn_t lis3l02dq_noring(int irq, void *private)
 {
 	return IRQ_WAKE_THREAD;
diff --git a/drivers/staging/iio/accel/sca3000.h b/drivers/staging/iio/accel/sca3000.h
index 1e396ce..0dabfad 100644
--- a/drivers/staging/iio/accel/sca3000.h
+++ b/drivers/staging/iio/accel/sca3000.h
@@ -221,7 +221,7 @@ int sca3000_read_data_short(struct sca3000_state *st,
  **/
 int sca3000_write_reg(struct sca3000_state *st, u8 address, u8 val);
 
-#ifdef CONFIG_IIO_RING_BUFFER
+#ifdef CONFIG_IIO_BUFFER
 /**
  * sca3000_register_ring_funcs() setup the ring state change functions
  **/
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 27dda13..070efd3 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -44,7 +44,7 @@ config AD7314
 config AD7606
 	tristate "Analog Devices AD7606 ADC driver"
 	depends on GPIOLIB
-	select IIO_RING_BUFFER
+	select IIO_BUFFER
 	select IIO_TRIGGER
 	select IIO_SW_RING
 	help
@@ -72,7 +72,7 @@ config AD7606_IFACE_SPI
 config AD799X
 	tristate "Analog Devices AD799x ADC driver"
 	depends on I2C
-	select IIO_TRIGGER if IIO_RING_BUFFER
+	select IIO_TRIGGER if IIO_BUFFER
 	select AD799X_RING_BUFFER
 	help
 	  Say yes here to build support for Analog Devices:
@@ -83,7 +83,7 @@ config AD799X
 config AD799X_RING_BUFFER
 	bool "Analog Devices AD799x: use ring buffer"
 	depends on AD799X
-	select IIO_RING_BUFFER
+	select IIO_BUFFER
 	select IIO_SW_RING
 	help
 	  Say yes here to include ring buffer support in the AD799X
@@ -92,7 +92,7 @@ config AD799X_RING_BUFFER
 config AD7476
 	tristate "Analog Devices AD7475/6/7/8 AD7466/7/8 and AD7495 ADC driver"
 	depends on SPI
-	select IIO_RING_BUFFER
+	select IIO_BUFFER
 	select IIO_SW_RING
 	select IIO_TRIGGER
 	help
@@ -107,7 +107,7 @@ config AD7476
 config AD7887
 	tristate "Analog Devices AD7887 ADC driver"
 	depends on SPI
-	select IIO_RING_BUFFER
+	select IIO_BUFFER
 	select IIO_SW_RING
 	select IIO_TRIGGER
 	help
@@ -133,7 +133,7 @@ config AD7780
 config AD7793
 	tristate "Analog Devices AD7792 AD7793 ADC driver"
 	depends on SPI
-	select IIO_RING_BUFFER
+	select IIO_BUFFER
 	select IIO_SW_RING
 	select IIO_TRIGGER
 	help
@@ -164,7 +164,7 @@ config AD7816
 config AD7192
 	tristate "Analog Devices AD7190 AD7192 AD7195 ADC driver"
 	depends on SPI
-	select IIO_RING_BUFFER
+	select IIO_BUFFER
 	select IIO_SW_RING
 	select IIO_TRIGGER
 	help
@@ -209,7 +209,7 @@ config AD7280
 config MAX1363
 	tristate "Maxim max1363 ADC driver"
 	depends on I2C
-	select IIO_TRIGGER if IIO_RING_BUFFER
+	select IIO_TRIGGER if IIO_BUFFER
 	select MAX1363_RING_BUFFER
 	help
 	  Say yes here to build support for many Maxim i2c analog to digital
@@ -224,7 +224,7 @@ config MAX1363
 config MAX1363_RING_BUFFER
 	bool "Maxim max1363: use ring buffer"
 	depends on MAX1363
-	select IIO_RING_BUFFER
+	select IIO_BUFFER
 	select IIO_SW_RING
 	help
 	  Say yes here to include ring buffer support in the MAX1363
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index 5ba3cdb..8adf096 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -8,7 +8,7 @@ max1363-y += max1363_ring.o
 obj-$(CONFIG_MAX1363) += max1363.o
 
 ad7606-y := ad7606_core.o
-ad7606-$(CONFIG_IIO_RING_BUFFER) += ad7606_ring.o
+ad7606-$(CONFIG_IIO_BUFFER) += ad7606_ring.o
 ad7606-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
 ad7606-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
 obj-$(CONFIG_AD7606) += ad7606.o
@@ -18,15 +18,15 @@ ad799x-$(CONFIG_AD799X_RING_BUFFER) += ad799x_ring.o
 obj-$(CONFIG_AD799X) += ad799x.o
 
 ad7476-y := ad7476_core.o
-ad7476-$(CONFIG_IIO_RING_BUFFER) += ad7476_ring.o
+ad7476-$(CONFIG_IIO_BUFFER) += ad7476_ring.o
 obj-$(CONFIG_AD7476) += ad7476.o
 
 ad7887-y := ad7887_core.o
-ad7887-$(CONFIG_IIO_RING_BUFFER) += ad7887_ring.o
+ad7887-$(CONFIG_IIO_BUFFER) += ad7887_ring.o
 obj-$(CONFIG_AD7887) += ad7887.o
 
 ad7298-y := ad7298_core.o
-ad7298-$(CONFIG_IIO_RING_BUFFER) += ad7298_ring.o
+ad7298-$(CONFIG_IIO_BUFFER) += ad7298_ring.o
 obj-$(CONFIG_AD7298) += ad7298.o
 
 obj-$(CONFIG_AD7150) += ad7150.o
diff --git a/drivers/staging/iio/adc/ad7298.h b/drivers/staging/iio/adc/ad7298.h
index 628f5ad..9ddf5cf 100644
--- a/drivers/staging/iio/adc/ad7298.h
+++ b/drivers/staging/iio/adc/ad7298.h
@@ -53,11 +53,11 @@ struct ad7298_state {
 	unsigned short			tx_buf[2];
 };
 
-#ifdef CONFIG_IIO_RING_BUFFER
+#ifdef CONFIG_IIO_BUFFER
 int ad7298_scan_from_ring(struct iio_dev *indio_dev, long ch);
 int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void ad7298_ring_cleanup(struct iio_dev *indio_dev);
-#else /* CONFIG_IIO_RING_BUFFER */
+#else /* CONFIG_IIO_BUFFER */
 static inline int ad7298_scan_from_ring(struct iio_dev *indio_dev, long ch)
 {
 	return 0;
@@ -72,5 +72,5 @@ ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 static inline void ad7298_ring_cleanup(struct iio_dev *indio_dev)
 {
 }
-#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* CONFIG_IIO_BUFFER */
 #endif /* IIO_ADC_AD7298_H_ */
diff --git a/drivers/staging/iio/adc/ad7476.h b/drivers/staging/iio/adc/ad7476.h
index 0d44976..6014292 100644
--- a/drivers/staging/iio/adc/ad7476.h
+++ b/drivers/staging/iio/adc/ad7476.h
@@ -49,11 +49,11 @@ enum ad7476_supported_device_ids {
 	ID_AD7495
 };
 
-#ifdef CONFIG_IIO_RING_BUFFER
+#ifdef CONFIG_IIO_BUFFER
 int ad7476_scan_from_ring(struct iio_dev *indio_dev);
 int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void ad7476_ring_cleanup(struct iio_dev *indio_dev);
-#else /* CONFIG_IIO_RING_BUFFER */
+#else /* CONFIG_IIO_BUFFER */
 static inline int ad7476_scan_from_ring(struct iio_dev *indio_dev)
 {
 	return 0;
@@ -68,5 +68,5 @@ ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 static inline void ad7476_ring_cleanup(struct iio_dev *indio_dev)
 {
 }
-#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* CONFIG_IIO_BUFFER */
 #endif /* IIO_ADC_AD7476_H_ */
diff --git a/drivers/staging/iio/adc/ad7887.h b/drivers/staging/iio/adc/ad7887.h
index 1b7a772..3452d18 100644
--- a/drivers/staging/iio/adc/ad7887.h
+++ b/drivers/staging/iio/adc/ad7887.h
@@ -82,11 +82,11 @@ enum ad7887_supported_device_ids {
 	ID_AD7887
 };
 
-#ifdef CONFIG_IIO_RING_BUFFER
+#ifdef CONFIG_IIO_BUFFER
 int ad7887_scan_from_ring(struct ad7887_state *st, int channum);
 int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void ad7887_ring_cleanup(struct iio_dev *indio_dev);
-#else /* CONFIG_IIO_RING_BUFFER */
+#else /* CONFIG_IIO_BUFFER */
 static inline int ad7887_scan_from_ring(struct ad7887_state *st, int channum)
 {
 	return 0;
@@ -101,5 +101,5 @@ ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 static inline void ad7887_ring_cleanup(struct iio_dev *indio_dev)
 {
 }
-#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* CONFIG_IIO_BUFFER */
 #endif /* IIO_ADC_AD7887_H_ */
diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index 86774e3..22aea5b 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -27,8 +27,8 @@ config ADIS16130
 config ADIS16260
 	tristate "Analog Devices ADIS16260 Digital Gyroscope Sensor SPI driver"
 	depends on SPI
-	select IIO_TRIGGER if IIO_RING_BUFFER
-	select IIO_SW_RING if IIO_RING_BUFFER
+	select IIO_TRIGGER if IIO_BUFFER
+	select IIO_SW_RING if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices ADIS16260 ADIS16265
 	  ADIS16250 ADIS16255 and ADIS16251 programmable digital gyroscope sensors.
diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
index 2212240..9ba5ec1 100644
--- a/drivers/staging/iio/gyro/Makefile
+++ b/drivers/staging/iio/gyro/Makefile
@@ -12,7 +12,7 @@ adis16130-y             := adis16130_core.o
 obj-$(CONFIG_ADIS16130) += adis16130.o
 
 adis16260-y             := adis16260_core.o
-adis16260-$(CONFIG_IIO_RING_BUFFER) += adis16260_ring.o adis16260_trigger.o
+adis16260-$(CONFIG_IIO_BUFFER) += adis16260_ring.o adis16260_trigger.o
 obj-$(CONFIG_ADIS16260) += adis16260.o
 
 adis16251-y             := adis16251_core.o
diff --git a/drivers/staging/iio/gyro/adis16260.h b/drivers/staging/iio/gyro/adis16260.h
index 969b624..4c4b251 100644
--- a/drivers/staging/iio/gyro/adis16260.h
+++ b/drivers/staging/iio/gyro/adis16260.h
@@ -112,7 +112,7 @@ int adis16260_set_irq(struct iio_dev *indio_dev, bool enable);
 #define ADIS16260_SCAN_TEMP	3
 #define ADIS16260_SCAN_ANGL	4
 
-#ifdef CONFIG_IIO_RING_BUFFER
+#ifdef CONFIG_IIO_BUFFER
 void adis16260_remove_trigger(struct iio_dev *indio_dev);
 int adis16260_probe_trigger(struct iio_dev *indio_dev);
 
@@ -124,7 +124,7 @@ ssize_t adis16260_read_data_from_ring(struct device *dev,
 int adis16260_configure_ring(struct iio_dev *indio_dev);
 void adis16260_unconfigure_ring(struct iio_dev *indio_dev);
 
-#else /* CONFIG_IIO_RING_BUFFER */
+#else /* CONFIG_IIO_BUFFER */
 
 static inline void adis16260_remove_trigger(struct iio_dev *indio_dev)
 {
@@ -152,5 +152,5 @@ static inline void adis16260_unconfigure_ring(struct iio_dev *indio_dev)
 {
 }
 
-#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* CONFIG_IIO_BUFFER */
 #endif /* SPI_ADIS16260_H_ */
diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
index 803bdd8..a173321 100644
--- a/drivers/staging/iio/iio_core.h
+++ b/drivers/staging/iio/iio_core.h
@@ -30,7 +30,7 @@ int __iio_add_chan_devattr(const char *postfix,
 /* Event interface flags */
 #define IIO_BUSY_BIT_POS 1
 
-#ifdef CONFIG_IIO_RING_BUFFER
+#ifdef CONFIG_IIO_BUFFER
 struct poll_table_struct;
 
 void iio_chrdev_ring_open(struct iio_dev *indio_dev);
diff --git a/drivers/staging/iio/impedance-analyzer/Kconfig b/drivers/staging/iio/impedance-analyzer/Kconfig
index cce1ce3..ad0ff76 100644
--- a/drivers/staging/iio/impedance-analyzer/Kconfig
+++ b/drivers/staging/iio/impedance-analyzer/Kconfig
@@ -6,7 +6,7 @@ menu "Network Analyzer, Impedance Converters"
 config AD5933
 	tristate "Analog Devices AD5933, AD5934 driver"
 	depends on I2C
-	select IIO_RING_BUFFER
+	select IIO_BUFFER
 	select IIO_SW_RING
 	help
 	  Say yes here to build support for Analog Devices Impedance Converter,
diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
index 233c76a..2e2fa8c 100644
--- a/drivers/staging/iio/imu/Kconfig
+++ b/drivers/staging/iio/imu/Kconfig
@@ -6,8 +6,8 @@ menu "Inertial measurement units"
 config ADIS16400
 	tristate "Analog Devices ADIS16400 and similar IMU SPI driver"
 	depends on SPI
-	select IIO_SW_RING if IIO_RING_BUFFER
-	select IIO_TRIGGER if IIO_RING_BUFFER
+	select IIO_SW_RING if IIO_BUFFER
+	select IIO_TRIGGER if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices adis16300, adis16350,
 	  adis16354, adis16355, adis16360, adis16362, adis16364, adis16365,
diff --git a/drivers/staging/iio/imu/Makefile b/drivers/staging/iio/imu/Makefile
index d46a691..3400a13 100644
--- a/drivers/staging/iio/imu/Makefile
+++ b/drivers/staging/iio/imu/Makefile
@@ -3,5 +3,5 @@
 #
 
 adis16400-y             := adis16400_core.o
-adis16400-$(CONFIG_IIO_RING_BUFFER) += adis16400_ring.o adis16400_trigger.o
+adis16400-$(CONFIG_IIO_BUFFER) += adis16400_ring.o adis16400_trigger.o
 obj-$(CONFIG_ADIS16400) += adis16400.o
diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index 1f8f0c6..f3546ee 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -184,7 +184,7 @@ int adis16400_set_irq(struct iio_dev *indio_dev, bool enable);
 #define ADIS16300_SCAN_INCLI_X	12
 #define ADIS16300_SCAN_INCLI_Y	13
 
-#ifdef CONFIG_IIO_RING_BUFFER
+#ifdef CONFIG_IIO_BUFFER
 void adis16400_remove_trigger(struct iio_dev *indio_dev);
 int adis16400_probe_trigger(struct iio_dev *indio_dev);
 
@@ -196,7 +196,7 @@ ssize_t adis16400_read_data_from_ring(struct device *dev,
 int adis16400_configure_ring(struct iio_dev *indio_dev);
 void adis16400_unconfigure_ring(struct iio_dev *indio_dev);
 
-#else /* CONFIG_IIO_RING_BUFFER */
+#else /* CONFIG_IIO_BUFFER */
 
 static inline void adis16400_remove_trigger(struct iio_dev *indio_dev)
 {
@@ -224,5 +224,5 @@ static inline void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 {
 }
 
-#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* CONFIG_IIO_BUFFER */
 #endif /* SPI_ADIS16400_H_ */
diff --git a/drivers/staging/iio/meter/Kconfig b/drivers/staging/iio/meter/Kconfig
index a8deab2..d290d27 100644
--- a/drivers/staging/iio/meter/Kconfig
+++ b/drivers/staging/iio/meter/Kconfig
@@ -20,8 +20,8 @@ config ADE7754
 config ADE7758
 	tristate "Analog Devices ADE7758 Poly Phase Multifunction Energy Metering IC Driver"
 	depends on SPI
-	select IIO_TRIGGER if IIO_RING_BUFFER
-	select IIO_SW_RING if IIO_RING_BUFFER
+	select IIO_TRIGGER if IIO_BUFFER
+	select IIO_SW_RING if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices ADE7758 Polyphase
 	  Multifunction Energy Metering IC with Per Phase Information Driver.
diff --git a/drivers/staging/iio/meter/Makefile b/drivers/staging/iio/meter/Makefile
index 0cc7d51..de3863d 100644
--- a/drivers/staging/iio/meter/Makefile
+++ b/drivers/staging/iio/meter/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_ADE7753) += ade7753.o
 obj-$(CONFIG_ADE7754) += ade7754.o
 
 ade7758-y             := ade7758_core.o
-ade7758-$(CONFIG_IIO_RING_BUFFER) += ade7758_ring.o ade7758_trigger.o
+ade7758-$(CONFIG_IIO_BUFFER) += ade7758_ring.o ade7758_trigger.o
 obj-$(CONFIG_ADE7758) += ade7758.o
 
 obj-$(CONFIG_ADE7759) += ade7759.o
diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
index 20a2bca..bdd1b05 100644
--- a/drivers/staging/iio/meter/ade7758.h
+++ b/drivers/staging/iio/meter/ade7758.h
@@ -134,7 +134,7 @@ struct ade7758_state {
 	unsigned char		tx_buf[8];
 
 };
-#ifdef CONFIG_IIO_RING_BUFFER
+#ifdef CONFIG_IIO_BUFFER
 /* At the moment triggers are only used for ring buffer
  * filling. This may change!
  */
@@ -158,7 +158,7 @@ int ade7758_spi_write_reg_8(struct device *dev,
 int ade7758_spi_read_reg_8(struct device *dev,
 		u8 reg_address, u8 *val);
 
-#else /* CONFIG_IIO_RING_BUFFER */
+#else /* CONFIG_IIO_BUFFER */
 
 static inline void ade7758_remove_trigger(struct iio_dev *indio_dev)
 {
@@ -182,6 +182,6 @@ static inline int ade7758_initialize_ring(struct iio_ring_buffer *ring)
 static inline void ade7758_uninitialize_ring(struct iio_dev *indio_dev)
 {
 }
-#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* CONFIG_IIO_BUFFER */
 
 #endif
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 8f6ecde..6a89ec0 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -13,7 +13,7 @@
 #include "iio.h"
 #include "chrdev.h"
 
-#ifdef CONFIG_IIO_RING_BUFFER
+#ifdef CONFIG_IIO_BUFFER
 
 struct iio_ring_buffer;
 
@@ -209,7 +209,7 @@ ssize_t iio_show_ring_enable(struct device *dev,
 
 int iio_sw_ring_preenable(struct iio_dev *indio_dev);
 
-#else /* CONFIG_IIO_RING_BUFFER */
+#else /* CONFIG_IIO_BUFFER */
 
 static inline int iio_ring_buffer_register(struct iio_dev *indio_dev,
 					   struct iio_chan_spec *channels,
@@ -221,6 +221,6 @@ static inline int iio_ring_buffer_register(struct iio_dev *indio_dev,
 static inline void iio_ring_buffer_unregister(struct iio_dev *indio_dev)
 {};
 
-#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* CONFIG_IIO_BUFFER */
 
 #endif /* _IIO_RING_GENERIC_H_ */
-- 
1.7.3.4

