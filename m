Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam03on0073.outbound.protection.outlook.com ([104.47.42.73]:62159
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751856AbeDJP50 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Apr 2018 11:57:26 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 2/6] iio:dac:ad5686: Add support for various number of channels
Date: Tue, 10 Apr 2018 18:57:12 +0300
Message-ID: <1523375832-29402-1-git-send-email-stefan.popa@analog.com>
In-Reply-To: <1522418118-11810-2-git-send-email-stefan.popa@analog.com>
References: <1522418118-11810-2-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds a new num_channels attribute as part of the
ad5686_chip_info struct which replaces the AD5686_DAC_CHANNELS define. This
is a necessary step, since this driver should support similar devices which
differ only in the number of channels.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Refactored the patch to add num_channels and the new macro forms
	  for the existing parts.

 drivers/iio/dac/ad5686.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index f7f975c..4d1ae3d 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -19,8 +19,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#define AD5686_DAC_CHANNELS			4
-
 #define AD5686_ADDR(x)				((x) << 16)
 #define AD5686_CMD(x)				((x) << 20)
 
@@ -46,12 +44,14 @@
 /**
  * struct ad5686_chip_info - chip specific information
  * @int_vref_mv:	AD5620/40/60: the internal reference voltage
+ * @num_channels:	number of channels
  * @channel:		channel specification
 */
 
 struct ad5686_chip_info {
 	u16				int_vref_mv;
-	struct iio_chan_spec		channel[AD5686_DAC_CHANNELS];
+	unsigned int			num_channels;
+	struct iio_chan_spec		*channels;
 };
 
 /**
@@ -269,14 +269,14 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 	{ },
 };
 
-#define AD5868_CHANNEL(chan, bits, _shift) {			\
+#define AD5868_CHANNEL(chan, addr, bits, _shift) {		\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.output = 1,					\
 		.channel = chan,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
-		.address = AD5686_ADDR_DAC(chan),		\
+		.address = addr,				\
 		.scan_type = {					\
 			.sign = 'u',				\
 			.realbits = (bits),			\
@@ -286,31 +286,36 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 		.ext_info = ad5686_ext_info,			\
 }
 
+#define DECLARE_AD5686_CHANNELS(name, bits, _shift)		\
+static struct iio_chan_spec name[] = {				\
+		AD5868_CHANNEL(0, 1, bits, _shift),		\
+		AD5868_CHANNEL(1, 2, bits, _shift),		\
+		AD5868_CHANNEL(2, 4, bits, _shift),		\
+		AD5868_CHANNEL(3, 8, bits, _shift),		\
+}
+
+DECLARE_AD5686_CHANNELS(ad5684_channels, 12, 4);
+DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
+DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
+
 static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 	[ID_AD5684] = {
-		.channel[0] = AD5868_CHANNEL(0, 12, 4),
-		.channel[1] = AD5868_CHANNEL(1, 12, 4),
-		.channel[2] = AD5868_CHANNEL(2, 12, 4),
-		.channel[3] = AD5868_CHANNEL(3, 12, 4),
+		.channels = ad5684_channels,
+		.num_channels = 4,
 		.int_vref_mv = 2500,
 	},
 	[ID_AD5685] = {
-		.channel[0] = AD5868_CHANNEL(0, 14, 2),
-		.channel[1] = AD5868_CHANNEL(1, 14, 2),
-		.channel[2] = AD5868_CHANNEL(2, 14, 2),
-		.channel[3] = AD5868_CHANNEL(3, 14, 2),
+		.channels = ad5685r_channels,
 		.int_vref_mv = 2500,
+		.num_channels = 4,
 	},
 	[ID_AD5686] = {
-		.channel[0] = AD5868_CHANNEL(0, 16, 0),
-		.channel[1] = AD5868_CHANNEL(1, 16, 0),
-		.channel[2] = AD5868_CHANNEL(2, 16, 0),
-		.channel[3] = AD5868_CHANNEL(3, 16, 0),
+		.channels = ad5686_channels,
+		.num_channels = 4,
 		.int_vref_mv = 2500,
 	},
 };
 
-
 static int ad5686_probe(struct spi_device *spi)
 {
 	struct ad5686_state *st;
@@ -354,8 +359,8 @@ static int ad5686_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5686_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = st->chip_info->channel;
-	indio_dev->num_channels = AD5686_DAC_CHANNELS;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
 
 	ret = ad5686_spi_write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
 				!!voltage_uv, 0);
-- 
2.7.4

