Return-Path: <SRS0=r+Hi=6V=gmail.com=rjdurga@kernel.org>
From: Jaya Durga <rjdurga@gmail.com>
To: gregkh@linuxfoundation.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Jaya Durga <rjdurga@gmail.com>
Subject: [PATCH v2 3/3] Staging: iio: adc: ad7280a.c: Fixed Macro argument reuse
Date: Tue, 18 Jul 2017 16:45:04 +0530
Message-Id: <1500376504-22779-3-git-send-email-rjdurga@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

CHECK: Macro argument reuse 'addr' - possible side-effects?

convert AD7280A_DEVADDR to ad7280a_devaddr static function
to fix checkpath check

Signed-off-by: Jaya Durga <rjdurga@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index d5ab83f..f543b42 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -99,9 +99,14 @@
 #define AD7280A_DEVADDR_MASTER		0
 #define AD7280A_DEVADDR_ALL		0x1F
 /* 5-bit device address is sent LSB first */
-#define AD7280A_DEVADDR(addr)	(((addr & 0x1) << 4) | ((addr & 0x2) << 3) | \
-				(addr & 0x4) | ((addr & 0x8) >> 3) | \
-				((addr & 0x10) >> 4))
+static unsigned int ad7280a_devaddr(unsigned int addr)
+{
+	return ((addr & 0x1) << 4) |
+		((addr & 0x2) << 3) |
+		(addr & 0x4)       |
+		((addr & 0x8) >> 3) |
+		((addr & 0x10) >> 4);
+}
 
 /* During a read a valid write is mandatory.
  * So writing to the highest available address (Address 0x1F)
@@ -372,7 +377,7 @@ static int ad7280_chain_setup(struct ad7280_state *st)
 		if (ad7280_check_crc(st, val))
 			return -EIO;
 
-		if (n != AD7280A_DEVADDR(val >> 27))
+		if (n != ad7280a_devaddr(val >> 27))
 			return -EIO;
 	}
 
@@ -511,7 +516,7 @@ static int ad7280_channel_init(struct ad7280_state *st)
 			st->channels[cnt].info_mask_shared_by_type =
 				BIT(IIO_CHAN_INFO_SCALE);
 			st->channels[cnt].address =
-				AD7280A_DEVADDR(dev) << 8 | ch;
+				ad7280a_devaddr(dev) << 8 | ch;
 			st->channels[cnt].scan_index = cnt;
 			st->channels[cnt].scan_type.sign = 'u';
 			st->channels[cnt].scan_type.realbits = 12;
@@ -558,7 +563,7 @@ static int ad7280_attr_init(struct ad7280_state *st)
 		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_CELL_VOLTAGE_6;
 			ch++, cnt++) {
 			st->iio_attr[cnt].address =
-				AD7280A_DEVADDR(dev) << 8 | ch;
+				ad7280a_devaddr(dev) << 8 | ch;
 			st->iio_attr[cnt].dev_attr.attr.mode =
 				0644;
 			st->iio_attr[cnt].dev_attr.show =
@@ -574,7 +579,7 @@ static int ad7280_attr_init(struct ad7280_state *st)
 				&st->iio_attr[cnt].dev_attr.attr;
 			cnt++;
 			st->iio_attr[cnt].address =
-				AD7280A_DEVADDR(dev) << 8 |
+				ad7280a_devaddr(dev) << 8 |
 				(AD7280A_CB1_TIMER + ch);
 			st->iio_attr[cnt].dev_attr.attr.mode =
 				0644;
@@ -918,7 +923,7 @@ static int ad7280_probe(struct spi_device *spi)
 		if (ret)
 			goto error_unregister;
 
-		ret = ad7280_write(st, AD7280A_DEVADDR(st->slave_num),
+		ret = ad7280_write(st, ad7280a_devaddr(st->slave_num),
 				   AD7280A_ALERT, 0,
 				   AD7280A_ALERT_GEN_STATIC_HIGH |
 				   (pdata->chain_last_alert_ignore & 0xF));
-- 
1.9.1
