Return-Path: <SRS0=PUYO=EJ=gmail.com=milan.o.stevanovic@kernel.org>
From: Milan Stevanovic <milan.o.stevanovic@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-kernel@vger.kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	pombredanne@nexb.com,
	Milan Stevanovic <milan.o.stevanovic@gmail.com>
Subject: [PATCH v3 2/2] iio: adc: change license description
Date: Sun, 14 Jan 2018 21:32:40 +0100
Message-Id: <1515961960-35157-2-git-send-email-milan.o.stevanovic@gmail.com>
In-Reply-To: <1515961960-35157-1-git-send-email-milan.o.stevanovic@gmail.com>
References: <1515961960-35157-1-git-send-email-milan.o.stevanovic@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

   Using an SPDX tag. Remove a license notice to keep
   the whole purpose of using an SPDx id.

Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>
---
 drivers/iio/adc/ad7476.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 0ea0f90..4fe3cf1 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -1,10 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Analog Devices AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver
  * TI ADC081S/ADC101S/ADC121S 8/10/12-bit SPI ADC driver
  *
  * Copyright 2010 Analog Devices Inc.
  *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/device.h>
-- 
2.7.4
