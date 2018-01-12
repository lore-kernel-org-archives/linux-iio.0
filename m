Return-Path: <SRS0=D/ng=EH=gmail.com=milan.o.stevanovic@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 knaack.h@gmx.de, pmeerw@pmeerw.net, Michael.Hennerich@analog.com,
 "lars@metafoo.de >> Lars-Peter Clausen" <lars@metafoo.de>
From: Milan Stevanovic <milan.o.stevanovic@gmail.com>
Subject: [PATCH] iio: adc: driver for ti adc081s/adc101s/adc121s
Message-ID: <23df1de6-dd7e-5c45-9634-1a3ec2e9687b@gmail.com>
Date: Fri, 12 Jan 2018 21:38:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

 From cb437dd49444fb12897f88ccf485369e6ed3184e Mon Sep 17 00:00:00 2001
From: Milan Stevanovic <milan.o.stevanovic@gmail.com>
Date: Sun, 7 Jan 2018 21:44:33 +0100
Subject: [PATCH] iio: adc: driver for ti adc081s/adc101s/adc121s

     Add Linux device driver for TI single-channel CMOS
     8/10/12-bit analog-to-digital converter with a
     high-speed serial interface.

Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>
---
  drivers/iio/adc/ad7476.c | 26 +++++++++++++++++++++++---
  1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index b7706bf..e872081 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
  /*
- * AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver
   *
- * Copyright 2010 Analog Devices Inc.
+ * Analog Device AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver
+ * TI ADC081S/ADC101S/ADC121S 8/10/12-bit SPI ADC driver
   *
- * Licensed under the GPL-2 or later.
   */
  
  #include <linux/device.h>
@@ -56,6 +56,9 @@ enum ad7476_supported_device_ids {
  	ID_AD7468,
  	ID_AD7495,
  	ID_AD7940,
+	ID_ADC081S,
+	ID_ADC101S,
+	ID_ADC121S,
  };
  
  static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
@@ -147,6 +150,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
  	},							\
  }
  
+#define ADC081S_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
+		BIT(IIO_CHAN_INFO_RAW))
  #define AD7476_CHAN(bits) _AD7476_CHAN((bits), 13 - (bits), \
  		BIT(IIO_CHAN_INFO_RAW))
  #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
@@ -192,6 +197,18 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
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
@@ -294,6 +311,9 @@ static const struct spi_device_id ad7476_id[] = {
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
