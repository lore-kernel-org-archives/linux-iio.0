Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, <jic23@cam.ac.uk>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH] iio: adc: Relocate Capacitance to Digital Converters (CDC) into own subdir
Date: Wed, 19 Oct 2011 13:02:03 +0200
Message-ID: <1319022123-14108-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

No functional changes.
Fix Kconfig description.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Kconfig               |    1 +
 drivers/staging/iio/Makefile              |    1 +
 drivers/staging/iio/adc/Kconfig           |   24 -------------------
 drivers/staging/iio/adc/Makefile          |    3 --
 drivers/staging/iio/cdc/Kconfig           |   36 +++++++++++++++++++++++++++++
 drivers/staging/iio/cdc/Makefile          |    7 +++++
 drivers/staging/iio/{adc => cdc}/ad7150.c |    0
 drivers/staging/iio/{adc => cdc}/ad7152.c |    0
 drivers/staging/iio/{adc => cdc}/ad7746.c |    0
 drivers/staging/iio/{adc => cdc}/ad7746.h |    0
 10 files changed, 45 insertions(+), 27 deletions(-)
 create mode 100644 drivers/staging/iio/cdc/Kconfig
 create mode 100644 drivers/staging/iio/cdc/Makefile
 rename drivers/staging/iio/{adc => cdc}/ad7150.c (100%)
 rename drivers/staging/iio/{adc => cdc}/ad7152.c (100%)
 rename drivers/staging/iio/{adc => cdc}/ad7746.c (100%)
 rename drivers/staging/iio/{adc => cdc}/ad7746.h (100%)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 09cf580..4ec9118 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -59,6 +59,7 @@ config IIO_CONSUMERS_PER_TRIGGER
 source "drivers/staging/iio/accel/Kconfig"
 source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/addac/Kconfig"
+source "drivers/staging/iio/cdc/Kconfig"
 source "drivers/staging/iio/dac/Kconfig"
 source "drivers/staging/iio/dds/Kconfig"
 source "drivers/staging/iio/gyro/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index eaa07b0..1340aea 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_IIO_DUMMY_EVGEN) += iio_dummy_evgen.o
 obj-y += accel/
 obj-y += adc/
 obj-y += addac/
+obj-y += cdc/
 obj-y += dac/
 obj-y += dds/
 obj-y += gyro/
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 13e93fb..d9decea 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -3,20 +3,6 @@
 #
 menu "Analog to digital converters"

-config AD7150
-	tristate "Analog Devices ad7150/1/6 capacitive sensor driver"
-	depends on I2C
-	help
-	  Say yes here to build support for Analog Devices capacitive sensors.
-	  (ad7150, ad7151, ad7156) Provides direct access via sysfs.
-
-config AD7152
-	tristate "Analog Devices ad7152/3 capacitive sensor driver"
-	depends on I2C
-	help
-	  Say yes here to build support for Analog Devices capacitive sensors.
-	  (ad7152, ad7153) Provides direct access via sysfs.
-
 config AD7291
 	tristate "Analog Devices AD7291 ADC driver"
 	depends on I2C
@@ -137,16 +123,6 @@ config AD7793
 	  To compile this driver as a module, choose M here: the
 	  module will be called AD7793.

-config AD7746
-	tristate "Analog Devices AD7745, AD7746 AD7747 capacitive sensor driver"
-	depends on I2C
-	help
-	  Say yes here to build support for Analog Devices capacitive sensors.
-	  (AD7745, AD7746, AD7747) Provides direct access via sysfs.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7745.
-
 config AD7816
 	tristate "Analog Devices AD7816/7/8 temperature sensor and ADC driver"
 	depends on SPI
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index be7faaa..ceee7f3 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -29,10 +29,7 @@ ad7298-y := ad7298_core.o
 ad7298-$(CONFIG_IIO_BUFFER) += ad7298_ring.o
 obj-$(CONFIG_AD7298) += ad7298.o

-obj-$(CONFIG_AD7150) += ad7150.o
-obj-$(CONFIG_AD7152) += ad7152.o
 obj-$(CONFIG_AD7291) += ad7291.o
-obj-$(CONFIG_AD7746) += ad7746.o
 obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7816) += ad7816.o
diff --git a/drivers/staging/iio/cdc/Kconfig b/drivers/staging/iio/cdc/Kconfig
new file mode 100644
index 0000000..80211df
--- /dev/null
+++ b/drivers/staging/iio/cdc/Kconfig
@@ -0,0 +1,36 @@
+#
+# CDC drivers
+#
+menu "Capacitance to digital converters"
+
+config AD7150
+	tristate "Analog Devices ad7150/1/6 capacitive sensor driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Analog Devices capacitive sensors.
+	  (ad7150, ad7151, ad7156) Provides direct access via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7150.
+
+config AD7152
+	tristate "Analog Devices ad7152/3 capacitive sensor driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Analog Devices capacitive sensors.
+	  (ad7152, ad7153) Provides direct access via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7152.
+
+config AD7746
+	tristate "Analog Devices AD7745, AD7746 AD7747 capacitive sensor driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Analog Devices capacitive sensors.
+	  (AD7745, AD7746, AD7747) Provides direct access via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7746.
+
+endmenu
diff --git a/drivers/staging/iio/cdc/Makefile b/drivers/staging/iio/cdc/Makefile
new file mode 100644
index 0000000..a5fbabf
--- /dev/null
+++ b/drivers/staging/iio/cdc/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for industrial I/O DAC drivers
+#
+
+obj-$(CONFIG_AD7150) += ad7150.o
+obj-$(CONFIG_AD7152) += ad7152.o
+obj-$(CONFIG_AD7746) += ad7746.o
diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
similarity index 100%
rename from drivers/staging/iio/adc/ad7150.c
rename to drivers/staging/iio/cdc/ad7150.c
diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
similarity index 100%
rename from drivers/staging/iio/adc/ad7152.c
rename to drivers/staging/iio/cdc/ad7152.c
diff --git a/drivers/staging/iio/adc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
similarity index 100%
rename from drivers/staging/iio/adc/ad7746.c
rename to drivers/staging/iio/cdc/ad7746.c
diff --git a/drivers/staging/iio/adc/ad7746.h b/drivers/staging/iio/cdc/ad7746.h
similarity index 100%
rename from drivers/staging/iio/adc/ad7746.h
rename to drivers/staging/iio/cdc/ad7746.h
--
1.7.0.4
