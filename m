Return-Path: <SRS0=Wx8j=G7=analog.com=StefanSerban.Popa@kernel.org>
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v2 3/6] iio:dac:ad5686: Add support for AD5685R
Date: Tue, 10 Apr 2018 18:57:29 +0300
Message-ID: <1523375849-29508-1-git-send-email-stefan.popa@analog.com>
In-Reply-To: <1522418118-11810-2-git-send-email-stefan.popa@analog.com>
References: <1522418118-11810-2-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This driver acctually supports the AD5685R device and NOT the AD5685, which
does not exist.

More information can be found in the datasheet:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5686_5684.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Refactored the patch to add support for new parts

 drivers/iio/dac/ad5686.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 4d1ae3d..7353c03 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -89,7 +89,7 @@ struct ad5686_state {
 
 enum ad5686_supported_device_ids {
 	ID_AD5684,
-	ID_AD5685,
+	ID_AD5685R,
 	ID_AD5686,
 };
 static int ad5686_spi_write(struct ad5686_state *st,
@@ -304,7 +304,7 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.num_channels = 4,
 		.int_vref_mv = 2500,
 	},
-	[ID_AD5685] = {
+	[ID_AD5685R] = {
 		.channels = ad5685r_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 4,
@@ -393,7 +393,7 @@ static int ad5686_remove(struct spi_device *spi)
 
 static const struct spi_device_id ad5686_id[] = {
 	{"ad5684", ID_AD5684},
-	{"ad5685", ID_AD5685},
+	{"ad5685r", ID_AD5685R},
 	{"ad5686", ID_AD5686},
 	{}
 };
-- 
2.7.4
