Return-Path: <SRS0=ZiRs=EI=gmail.com=milan.o.stevanovic@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 knaack.h@gmx.de, pmeerw@pmeerw.net, Michael.Hennerich@analog.com
From: Milan Stevanovic <milan.o.stevanovic@gmail.com>
Subject: [PATCH v2] iio: adc: driver for ti adc081s/adc101s/adc121s
Message-ID: <9a5e86de-1311-81a9-b3ec-6a099e7d131e@gmail.com>
Date: Sat, 13 Jan 2018 20:29:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

 From fab687d20ba46d78439b6cdaf0d40b78ae68222c Mon Sep 17 00:00:00 2001
From: Milan Stevanovic <milan.o.stevanovic@gmail.com>
Date: Sun, 7 Jan 2018 21:44:33 +0100
Subject: [PATCH v2] iio: adc: driver for ti adc081s/adc101s/adc121s

     Add Linux device driver for TI single-channel CMOS
     8/10/12-bit analog-to-digital converter with a
     high-speed serial interface.

Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>

---
Changes in v2:
      - Fix typo error
      - Keep Copyright comment
---
  drivers/iio/adc/ad7476.c | 25 +++++++++++++++++++++++--
  1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index b7706bf..4fe3cf1 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -1,9 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
  /*
- * AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver
+ * Analog Devices AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver
+ * TI ADC081S/ADC101S/ADC121S 8/10/12-bit SPI ADC driver
   *
   * Copyright 2010 Analog Devices Inc.
   *
- * Licensed under the GPL-2 or later.
   */
  
  #include <linux/device.h>
@@ -56,6 +57,9 @@ enum ad7476_supported_device_ids {
  	ID_AD7468,
  	ID_AD7495,
  	ID_AD7940,
+	ID_ADC081S,
+	ID_ADC101S,
+	ID_ADC121S,
  };
  
  static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
@@ -147,6 +151,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
  	},							\
  }
  
+#define ADC081S_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
+		BIT(IIO_CHAN_INFO_RAW))
  #define AD7476_CHAN(bits) _AD7476_CHAN((bits), 13 - (bits), \
  		BIT(IIO_CHAN_INFO_RAW))
  #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
@@ -192,6 +198,18 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
  		.channel[0] = AD7940_CHAN(14),
  		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
  	},
+	[ID_ADC081S] = {
+		.channel[0] = ADC081S_CHAN(8),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
+	[ID_ADC101S] = {
+		.channel[0] = ADC081S_CHAN(10),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
+	[ID_ADC121S] = {
+		.channel[0] = ADC081S_CHAN(12),
+		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
+	},
  };
  
  static const struct iio_info ad7476_info = {
@@ -294,6 +312,9 @@ static const struct spi_device_id ad7476_id[] = {
  	{"ad7910", ID_AD7467},
  	{"ad7920", ID_AD7466},
  	{"ad7940", ID_AD7940},
+	{"adc081s", ID_ADC081S},
+	{"adc101s", ID_ADC101S},
+	{"adc121s", ID_ADC121S},
  	{}
  };
  MODULE_DEVICE_TABLE(spi, ad7476_id);
-- 
2.7.4
la
