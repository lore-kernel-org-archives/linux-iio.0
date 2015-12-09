Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bytesatwork.ch ([91.135.72.15]:41698 "EHLO bytesatwork.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059AbbLIJa5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 9 Dec 2015 04:30:57 -0500
From: =?UTF-8?q?Oliver=20St=C3=A4bler?= <oliver.staebler@bytesatwork.ch>
To: angelo.compagnucci@gmail.com, jic23@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	=?UTF-8?q?Oliver=20St=C3=A4bler?= <oliver.staebler@bytesatwork.ch>
Subject: [PATCH 1/1] iio:adc128s052: add support for adc124s021
Date: Wed,  9 Dec 2015 10:24:04 +0100
Message-Id: <1449653044-30127-2-git-send-email-oliver.staebler@bytesatwork.ch>
In-Reply-To: <1449653044-30127-1-git-send-email-oliver.staebler@bytesatwork.ch>
References: <1449653044-30127-1-git-send-email-oliver.staebler@bytesatwork.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Oliver Stäbler <oliver.staebler@bytesatwork.ch>
---
 Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt |  4 ++--
 drivers/iio/adc/Kconfig                                     |  6 +++---
 drivers/iio/adc/ti-adc128s052.c                             | 13 ++++++++++++-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
index 15ca6b4..daa2b2c 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
+++ b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
@@ -1,7 +1,7 @@
-* Texas Instruments' ADC128S052 and ADC122S021 ADC chip
+* Texas Instruments' ADC128S052, ADC122S021 and ADC124S021 ADC chip
 
 Required properties:
- - compatible: Should be "ti,adc128s052" or "ti,adc122s021"
+ - compatible: Should be "ti,adc128s052", "ti,adc122s021" or "ti,adc124s021"
  - reg: spi chip select number for the device
  - vref-supply: The regulator supply for ADC reference voltage
 
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7868c74..351bd11 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -324,11 +324,11 @@ config TI_ADC081C
 	  called ti-adc081c.
 
 config TI_ADC128S052
-	tristate "Texas Instruments ADC128S052/ADC122S021"
+	tristate "Texas Instruments ADC128S052/ADC122S021/ADC124S021"
 	depends on SPI
 	help
-	  If you say yes here you get support for Texas Instruments ADC128S052
-	  and ADC122S021 chips.
+	  If you say yes here you get support for Texas Instruments ADC128S052,
+	  ADC122S021 and ADC124S021 chips.
 
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-adc128s052.
diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index ff6f7f6..bc58867 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -1,10 +1,11 @@
 /*
  * Copyright (C) 2014 Angelo Compagnucci <angelo.compagnucci@gmail.com>
  *
- * Driver for Texas Instruments' ADC128S052 and ADC122S021 ADC chip.
+ * Driver for Texas Instruments' ADC128S052, ADC122S021 and ADC124S021 ADC chip.
  * Datasheets can be found here:
  * http://www.ti.com/lit/ds/symlink/adc128s052.pdf
  * http://www.ti.com/lit/ds/symlink/adc122s021.pdf
+ * http://www.ti.com/lit/ds/symlink/adc124s021.pdf
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -114,9 +115,17 @@ static const struct iio_chan_spec adc122s021_channels[] = {
 	ADC128_VOLTAGE_CHANNEL(1),
 };
 
+static const struct iio_chan_spec adc124s021_channels[] = {
+	ADC128_VOLTAGE_CHANNEL(0),
+	ADC128_VOLTAGE_CHANNEL(1),
+	ADC128_VOLTAGE_CHANNEL(2),
+	ADC128_VOLTAGE_CHANNEL(3),
+};
+
 static const struct adc128_configuration adc128_config[] = {
 	{ adc128s052_channels, ARRAY_SIZE(adc128s052_channels) },
 	{ adc122s021_channels, ARRAY_SIZE(adc122s021_channels) },
+	{ adc124s021_channels, ARRAY_SIZE(adc124s021_channels) },
 };
 
 static const struct iio_info adc128_info = {
@@ -177,6 +186,7 @@ static int adc128_remove(struct spi_device *spi)
 static const struct of_device_id adc128_of_match[] = {
 	{ .compatible = "ti,adc128s052", },
 	{ .compatible = "ti,adc122s021", },
+	{ .compatible = "ti,adc124s021", },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, adc128_of_match);
@@ -184,6 +194,7 @@ MODULE_DEVICE_TABLE(of, adc128_of_match);
 static const struct spi_device_id adc128_id[] = {
 	{ "adc128s052", 0},	/* index into adc128_config */
 	{ "adc122s021",	1},
+	{ "adc124s021", 2},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
-- 
2.4.10

