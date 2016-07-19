Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35689 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbcGSA4p (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2016 20:56:45 -0400
Date: Mon, 18 Jul 2016 17:56:43 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: tiberiu.a.breana@intel.com, leonard.crestez@intel.com,
	mranostay@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: add Kconfig selects needed for triggered buffer compiles
Message-ID: <20160719005634.GA27399@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Select IIO_BUFFER and IIO_TRIGGERED_BUFFER to compile.
Remove IIO_TRIGGER if present since IIO_BUFFER selects it.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/accel/Kconfig       | 5 ++++-
 drivers/iio/humidity/Kconfig    | 2 ++
 drivers/iio/light/Kconfig       | 2 ++
 drivers/iio/temperature/Kconfig | 2 ++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 89d7820..78f148e 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -20,6 +20,8 @@ config BMA180
 config BMA220
     tristate "Bosch BMA220 3-Axis Accelerometer Driver"
 	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
     help
       Say yes here to add support for the Bosch BMA220 triaxial
       acceleration sensor.
@@ -234,7 +236,8 @@ config STK8312
 config STK8BA50
 	tristate "Sensortek STK8BA50 3-Axis Accelerometer Driver"
 	depends on I2C
-	depends on IIO_TRIGGER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to get support for the Sensortek STK8BA50 3-axis
 	  accelerometer.
diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 738a86d..d041243 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -6,6 +6,8 @@ menu "Humidity sensors"
 config AM2315
     tristate "Aosong AM2315 relative humidity and temperature sensor"
     depends on I2C
+    select IIO_BUFFER
+    select IIO_TRIGGERED_BUFFER
     help
       If you say yes here you get support for the Aosong AM2315
       relative humidity and ambient temperature sensor.
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 2821747..73c0140 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -238,6 +238,8 @@ config MAX44000
 	tristate "MAX44000 Ambient and Infrared Proximity Sensor"
 	depends on I2C
 	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	 Say Y here if you want to build support for Maxim Integrated's
 	 MAX44000 ambient and infrared proximity sensor device.
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 1d3da05..5ea77a7 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -6,6 +6,8 @@ menu "Temperature sensors"
 config MAXIM_THERMOCOUPLE
 	tristate "Maxim thermocouple sensors"
 	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for the Maxim series of
 	  thermocouple sensors connected via SPI.
-- 
2.1.4

