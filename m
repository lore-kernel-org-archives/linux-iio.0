Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:65336 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753695AbcKVBPM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Nov 2016 20:15:12 -0500
From: Reto Schneider <reto@reto-schneider.ch>
Subject: [PATCH 1/2] iio: adis1620x: Fix mixed up device descriptions
Cc: jic23@kernel.org, linux-iio@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-ID: <b9c4b9f8-0c6a-3fb6-18bb-9a325cebeb09@reto-schneider.ch>
Date: Tue, 22 Nov 2016 01:40:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Reto Schneider <code@reto-schneider.ch>
Date: Sun, 20 Nov 2016 22:11:24 +0100
Subject: [PATCH 1/2] iio: adis1620x: Fix mixed up device descriptions

The module descriptions for the ADIS 16201, 16203 and 16209 drivers do not
match the actual function of the devices. Update them accordingly to fix
this.

Signed-off-by: Reto Schneider <code@reto-schneider.ch>
---
 drivers/staging/iio/accel/adis16201_core.c | 4 ++--
 drivers/staging/iio/accel/adis16203_core.c | 4 ++--
 drivers/staging/iio/accel/adis16209_core.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 6f3f8ff..7963d4a 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -1,5 +1,5 @@
 /*
- * ADIS16201 Programmable Digital Vibration Sensor driver
+ * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
  *
  * Copyright 2010 Analog Devices Inc.
  *
@@ -243,6 +243,6 @@ static struct spi_driver adis16201_driver = {
 module_spi_driver(adis16201_driver);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADIS16201 Programmable Digital Vibration Sensor driver");
+MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("spi:adis16201");
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index c706717..f32c900 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -1,5 +1,5 @@
 /*
- * ADIS16203 Programmable Digital Vibration Sensor driver
+ * ADIS16203 Programmable 360 Degrees Inclinometer
  *
  * Copyright 2030 Analog Devices Inc.
  *
@@ -211,6 +211,6 @@ static struct spi_driver adis16203_driver = {
 module_spi_driver(adis16203_driver);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADIS16203 Programmable Digital Vibration Sensor driver");
+MODULE_DESCRIPTION("Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("spi:adis16203");
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 8dbad58..a599e19 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -1,5 +1,5 @@
 /*
- * ADIS16209 Programmable Digital Vibration Sensor driver
+ * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
  *
  * Copyright 2010 Analog Devices Inc.
  *
@@ -243,6 +243,6 @@ static struct spi_driver adis16209_driver = {
 module_spi_driver(adis16209_driver);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADIS16209 Digital Vibration Sensor driver");
+MODULE_DESCRIPTION("Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("spi:adis16209");
-- 
2.10.2
