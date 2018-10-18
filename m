Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.157]:42092 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeJRTb2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Oct 2018 15:31:28 -0400
Date: Thu, 18 Oct 2018 13:31:09 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 1/1] staging: iio: adc: ad7280a: use crc8.h API to build crc
 table
Message-ID: <20181018113108.GA26916@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The custom build function ad7280_crc8_build_table is not needed. The
crc8_populate_msb funtion from linux/crc8.h will build the same crc
table.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/staging/iio/adc/ad7280a.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index b736275c10f5..c701f07853fa 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -6,6 +6,7 @@
  * Licensed under the GPL-2.
  */
 
+#include <linux/crc8.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -121,8 +122,6 @@ static unsigned int ad7280a_devaddr(unsigned int addr)
  * P(x) = x^8 + x^5 + x^3 + x^2 + x^1 + x^0 = 0b100101111 => 0x2F
  */
 #define POLYNOM		0x2F
-#define POLYNOM_ORDER	8
-#define HIGHBIT		(1 << (POLYNOM_ORDER - 1))
 
 struct ad7280_state {
 	struct spi_device		*spi;
@@ -131,7 +130,7 @@ struct ad7280_state {
 	int				slave_num;
 	int				scan_cnt;
 	int				readback_delay_us;
-	unsigned char			crc_tab[256];
+	unsigned char			crc_tab[CRC8_TABLE_SIZE];
 	unsigned char			ctrl_hb;
 	unsigned char			ctrl_lb;
 	unsigned char			cell_threshhigh;
@@ -144,23 +143,6 @@ struct ad7280_state {
 	__be32				buf[2] ____cacheline_aligned;
 };
 
-static void ad7280_crc8_build_table(unsigned char *crc_tab)
-{
-	unsigned char bit, crc;
-	int cnt, i;
-
-	for (cnt = 0; cnt < 256; cnt++) {
-		crc = cnt;
-		for (i = 0; i < 8; i++) {
-			bit = crc & HIGHBIT;
-			crc <<= 1;
-			if (bit)
-				crc ^= POLYNOM;
-		}
-		crc_tab[cnt] = crc;
-	}
-}
-
 static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigned int val)
 {
 	unsigned char crc;
@@ -857,7 +839,7 @@ static int ad7280_probe(struct spi_device *spi)
 	if (!pdata)
 		pdata = &ad7793_default_pdata;
 
-	ad7280_crc8_build_table(st->crc_tab);
+	crc8_populate_msb(st->crc_tab, POLYNOM);
 
 	st->spi->max_speed_hz = AD7280A_MAX_SPI_CLK_HZ;
 	st->spi->mode = SPI_MODE_1;
-- 
2.19.1
