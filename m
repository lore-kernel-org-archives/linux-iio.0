Return-Path: <denis@eukrea.com>
From: Denis Carikli <denis@eukrea.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Denis Carikli <denis@eukrea.com>
Subject: [PATCH 2/4] iio: adc: ti-adc128s052: Add adc108s022 ID
Date: Wed, 22 Jul 2015 18:04:22 +0200
Message-Id: <1437581064-9733-2-git-send-email-denis@eukrea.com>
In-Reply-To: <1437581064-9733-1-git-send-email-denis@eukrea.com>
References: <1437581064-9733-1-git-send-email-denis@eukrea.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 drivers/iio/adc/Kconfig         | 6 +++---
 drivers/iio/adc/ti-adc128s052.c | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 233d47b..ae92f23 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -313,11 +313,11 @@ config TI_ADC081C
 	  called ti-adc081c.
 
 config TI_ADC128S052
-	tristate "Texas Instruments ADC128S052/ADC122S021"
+	tristate "Texas Instruments ADC128S052, ADC122S021 and ADC108S022"
 	depends on SPI
 	help
-	  If you say yes here you get support for Texas Instruments ADC128S052
-	  and ADC122S021 chips.
+	  If you say yes here you get support for Texas Instruments ADC128S052,
+	  ADC122S021 and ADC108S022 chips.
 
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-adc128s052.
diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 915be6b..8aca0ff 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -5,6 +5,7 @@
  * Datasheets can be found here:
  * http://www.ti.com/lit/ds/symlink/adc128s052.pdf
  * http://www.ti.com/lit/ds/symlink/adc122s021.pdf
+ * http://www.ti.com/lit/ds/symlink/adc108s022.pdf
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -177,6 +178,7 @@ static int adc128_remove(struct spi_device *spi)
 static const struct spi_device_id adc128_id[] = {
 	{ "adc128s052", 0},	/* index into adc128_config */
 	{ "adc122s021",	1},
+	{ "adc108s022", 1},
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
-- 
2.4.5
