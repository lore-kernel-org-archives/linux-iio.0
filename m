Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: greg@kroah.com,
	Michael.Hennerich@analog.com,
	rdunlap@xenotime.net,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio: gpio build dependency fixing
Date: Wed, 12 Oct 2011 10:57:33 +0100
Message-Id: <1318413453-7702-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Numerous drivers either had pointless includes of gpio.h
or should have been dependent on GENERIC_GPIO and were not.
Conversion of ads1210 to use array registration triggered
build failures that highlighted all was not well.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Reported-by: Randy Dunlap <rdunlap@xenotime.net>
---

Randy pointed out the issue with ad2s1210 triggered by
building without GENERIC_GPIO.  This motivated a quick
use of git grep on all the drivers and this patch fixes
all cases where there should have been a dependency,
or where they was and shouldn't have been (be it implied
by gpio.h includes).

One has to wonder what the point in having stubs for the
array calls is. I'll post on this point separately shortly.

I have no idea what the sca3000 was checking those gpios
for. It is probably lost somewhere in history but clearly
doesn't make sense.

Jonathan
 drivers/staging/iio/accel/Kconfig          |    1 +
 drivers/staging/iio/accel/adis16204_core.c |    1 -
 drivers/staging/iio/accel/sca3000_core.c   |    7 +++----
 drivers/staging/iio/adc/Kconfig            |    1 +
 drivers/staging/iio/addac/Kconfig          |    1 +
 drivers/staging/iio/dac/ad5504.c           |    1 -
 drivers/staging/iio/dac/ad5624r_spi.c      |    1 -
 drivers/staging/iio/dac/ad5686.c           |    1 -
 drivers/staging/iio/dac/ad5791.c           |    1 -
 drivers/staging/iio/gyro/adis16080_core.c  |    1 -
 drivers/staging/iio/gyro/adis16260_core.c  |    1 -
 drivers/staging/iio/gyro/adxrs450_core.c   |    1 -
 drivers/staging/iio/magnetometer/Kconfig   |    1 +
 drivers/staging/iio/meter/ade7753.c        |    1 -
 drivers/staging/iio/meter/ade7754.c        |    1 -
 drivers/staging/iio/meter/ade7758_core.c   |    1 -
 drivers/staging/iio/meter/ade7759.c        |    1 -
 drivers/staging/iio/meter/ade7854.c        |    1 -
 drivers/staging/iio/resolver/Kconfig       |    2 ++
 19 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index 71f8739..5ab7167 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -67,6 +67,7 @@ config LIS3L02DQ
 	depends on SPI
 	select IIO_TRIGGER if IIO_BUFFER
 	depends on !IIO_BUFFER || IIO_KFIFO_BUF || IIO_SW_RING
+	depends on GENERIC_GPIO
 	help
 	  Say yes here to build SPI support for the ST microelectronics
 	  accelerometer. The driver supplies direct access via sysfs files
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index cc6eb26..644ac8e 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -8,7 +8,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 62cdef4..a44a705 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
 #include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/slab.h>
@@ -1167,7 +1166,7 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 		iio_scan_mask_set(indio_dev->buffer, 2);
 	}
 
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
+	if (spi->irq) {
 		ret = request_threaded_irq(spi->irq,
 					   NULL,
 					   &sca3000_event_handler,
@@ -1184,7 +1183,7 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 	return 0;
 
 error_free_irq:
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
+	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
 error_unregister_ring:
 	iio_buffer_unregister(indio_dev);
@@ -1224,7 +1223,7 @@ static int sca3000_remove(struct spi_device *spi)
 	ret = sca3000_stop_all_interrupts(st);
 	if (ret)
 		return ret;
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
+	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
 	iio_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 2c1b7de..3bf975a 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -150,6 +150,7 @@ config AD7746
 config AD7816
 	tristate "Analog Devices AD7816/7/8 temperature sensor and ADC driver"
 	depends on SPI
+	depends on GENERIC_GPIO
 	help
 	  Say yes here to build support for Analog Devices AD7816/7/8
 	  temperature sensors and ADC.
diff --git a/drivers/staging/iio/addac/Kconfig b/drivers/staging/iio/addac/Kconfig
index 869540e..4b76375 100644
--- a/drivers/staging/iio/addac/Kconfig
+++ b/drivers/staging/iio/addac/Kconfig
@@ -5,6 +5,7 @@ menu "Analog digital bi-direction convertors"
 
 config ADT7316
 	tristate "Analog Devices ADT7316/7/8 ADT7516/7/9 temperature sensor, ADC and DAC driver"
+	depends on GENERIC_GPIO
 	help
 	  Say yes here to build support for Analog Devices ADT7316, ADT7317, ADT7318
 	  and ADT7516, ADT7517, ADT7519 temperature sensors, ADC and DAC.
diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index a0be132..60dd640 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
 #include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 01e8e48..284d879 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
 #include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index 97ce0e8..7274e73 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
 #include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/module.h>
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index abb5952..fbf446d 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
 #include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 5b5a60d6..5d7a906 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -5,7 +5,6 @@
  *
  * Licensed under the GPL-2 or later.
  */
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index d37fae7..aaa3967 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -8,7 +8,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 37837c7..3c3ef79 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -8,7 +8,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/iio/magnetometer/Kconfig
index b8c149d..722c4e1 100644
--- a/drivers/staging/iio/magnetometer/Kconfig
+++ b/drivers/staging/iio/magnetometer/Kconfig
@@ -6,6 +6,7 @@ menu "Magnetometer sensors"
 config SENSORS_AK8975
 	tristate "Asahi Kasei AK8975 3-Axis Magnetometer"
 	depends on I2C
+	depends on GENERIC_GPIO
 	help
 	  Say yes here to build support for Asahi Kasei AK8975 3-Axis
 	  Magnetometer.
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 10c3c54..940fef6 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -8,7 +8,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 39a069a..33f0d32 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -8,7 +8,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 7d66343..c5dafbd 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -8,7 +8,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 2e3fac5..b691f10 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -8,7 +8,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index ca88676..49c01c5 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -8,7 +8,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
index 90b3bbc..49f69ef 100644
--- a/drivers/staging/iio/resolver/Kconfig
+++ b/drivers/staging/iio/resolver/Kconfig
@@ -13,6 +13,7 @@ config AD2S90
 config AD2S1200
 	tristate "Analog Devices ad2s1200/ad2s1205 driver"
 	depends on SPI
+	depends on GENERIC_GPIO
 	help
 	  Say yes here to build support for Analog Devices spi resolver
 	  to digital converters, ad2s1200 and ad2s1205, provides direct access
@@ -21,6 +22,7 @@ config AD2S1200
 config AD2S1210
 	tristate "Analog Devices ad2s1210 driver"
 	depends on SPI
+	depends on GENERIC_GPIO
 	help
 	  Say yes here to build support for Analog Devices spi resolver
 	  to digital converters, ad2s1210, provides direct access via sysfs.
-- 
1.7.3.4
