Return-Path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH 07/27] iio: Allow compile test of GPIO consumers if !GPIOLIB
Date: Tue,  5 May 2015 18:32:23 +0200
Message-Id: <1430843563-18615-7-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
References: <1430836404-15513-1-git-send-email-geert@linux-m68k.org>
 <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
List-ID: <linux-iio@vger.kernel.org>

The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
functionality only, can still be compiled if GPIOLIB is not enabled.

Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
appropriate.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/humidity/Kconfig     | 2 +-
 drivers/iio/magnetometer/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 4813b793b9f7f944..688c0d1cb47dea36 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -5,7 +5,7 @@ menu "Humidity sensors"
 
 config DHT11
 	tristate "DHT11 (and compatible sensors) driver"
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  This driver supports reading data via a single interrupt
 	  generating GPIO line. Currently tested are DHT11 and DHT22.
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index a5d6de72c523bab2..00297bbb7e4b4a0b 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -8,7 +8,7 @@ menu "Magnetometer sensors"
 config AK8975
 	tristate "Asahi Kasei AK 3-Axis Magnetometer"
 	depends on I2C
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	help
 	  Say yes here to build support for Asahi Kasei AK8975, AK8963,
 	  AK09911 or AK09912 3-Axis Magnetometer.
@@ -19,7 +19,7 @@ config AK8975
 config AK09911
 	tristate "Asahi Kasei AK09911 3-axis Compass"
 	depends on I2C
-	depends on GPIOLIB
+	depends on GPIOLIB || COMPILE_TEST
 	select AK8975
 	help
 	  Deprecated: AK09911 is now supported by AK8975 driver.
-- 
1.9.1
