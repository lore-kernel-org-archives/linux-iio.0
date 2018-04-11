Return-Path: <SRS0=LAfQ=HA=analog.com=StefanSerban.Popa@kernel.org>
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 5/7] iio:dac:ad5686: Add AD5672R/76/76R/84R/86R support
Date: Wed, 11 Apr 2018 14:53:01 +0300
Message-ID: <1523447581-13496-1-git-send-email-stefan.popa@analog.com>
In-Reply-To: <1523375867-29616-1-git-send-email-stefan.popa@analog.com>
References: <1523375867-29616-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The AD5684R/AD5686R are a family of 4 channel DACs with 12-bit, 14-bit and
16-bit precision respectively. The devices come either with a built-in
reference or no built-in reference.

The AD5672R/AD5676/AD5676R are similar, except that they have 8 channels
instead of 4.

Datasheets:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5672R_5676R.pdf
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5686R_5685R_5684R.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Refactored the patch to add support for new parts
Changes in v3:
	- Nothing changed, just to follow the patch set version

 drivers/iio/dac/ad5686.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index a753ffd..54f67d5 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -87,9 +87,14 @@ struct ad5686_state {
  */
 
 enum ad5686_supported_device_ids {
+	ID_AD5672R,
+	ID_AD5676,
+	ID_AD5676R,
 	ID_AD5684,
+	ID_AD5684R,
 	ID_AD5685R,
 	ID_AD5686,
+	ID_AD5686R
 };
 static int ad5686_spi_write(struct ad5686_state *st,
 			     u8 cmd, u8 addr, u16 val, u8 shift)
@@ -293,15 +298,47 @@ static struct iio_chan_spec name[] = {				\
 		AD5868_CHANNEL(3, 8, bits, _shift),		\
 }
 
+#define DECLARE_AD5676_CHANNELS(name, bits, _shift)		\
+static struct iio_chan_spec name[] = {				\
+		AD5868_CHANNEL(0, 0, bits, _shift),		\
+		AD5868_CHANNEL(1, 1, bits, _shift),		\
+		AD5868_CHANNEL(2, 2, bits, _shift),		\
+		AD5868_CHANNEL(3, 3, bits, _shift),		\
+		AD5868_CHANNEL(4, 4, bits, _shift),		\
+		AD5868_CHANNEL(5, 5, bits, _shift),		\
+		AD5868_CHANNEL(6, 6, bits, _shift),		\
+		AD5868_CHANNEL(7, 7, bits, _shift),		\
+}
+
+DECLARE_AD5676_CHANNELS(ad5672_channels, 12, 4);
+DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
 DECLARE_AD5686_CHANNELS(ad5684_channels, 12, 4);
 DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
 DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
 
 static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
+	[ID_AD5672R] = {
+		.channels = ad5672_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 8,
+	},
+	[ID_AD5676] = {
+		.channels = ad5676_channels,
+		.num_channels = 8,
+	},
+	[ID_AD5676R] = {
+		.channels = ad5676_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 8,
+	},
 	[ID_AD5684] = {
 		.channels = ad5684_channels,
 		.num_channels = 4,
+	},
+	[ID_AD5684R] = {
+		.channels = ad5684_channels,
 		.int_vref_mv = 2500,
+		.num_channels = 4,
 	},
 	[ID_AD5685R] = {
 		.channels = ad5685r_channels,
@@ -311,7 +348,11 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 	[ID_AD5686] = {
 		.channels = ad5686_channels,
 		.num_channels = 4,
+	},
+	[ID_AD5686R] = {
+		.channels = ad5686_channels,
 		.int_vref_mv = 2500,
+		.num_channels = 4,
 	},
 };
 
@@ -391,9 +432,14 @@ static int ad5686_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id ad5686_id[] = {
+	{"ad5672r", ID_AD5672R},
+	{"ad5676", ID_AD5676},
+	{"ad5676r", ID_AD5676R},
 	{"ad5684", ID_AD5684},
+	{"ad5684r", ID_AD5684R},
 	{"ad5685r", ID_AD5685R},
 	{"ad5686", ID_AD5686},
+	{"ad5686r", ID_AD5686R},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad5686_id);
-- 
2.7.4
