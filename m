Return-Path: <SRS0=LAfQ=HA=analog.com=StefanSerban.Popa@kernel.org>
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 4/7] iio:dac:ad5686: Add support for AD5685R
Date: Wed, 11 Apr 2018 14:52:48 +0300
Message-ID: <1523447568-13386-1-git-send-email-stefan.popa@analog.com>
In-Reply-To: <1523375849-29508-1-git-send-email-stefan.popa@analog.com>
References: <1523375849-29508-1-git-send-email-stefan.popa@analog.com>
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
Changes in v3:
	- Nothing changed, just to follow the patch set version.

 drivers/iio/dac/ad5686.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 87d6e6e..a753ffd 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -88,7 +88,7 @@ struct ad5686_state {
 
 enum ad5686_supported_device_ids {
 	ID_AD5684,
-	ID_AD5685,
+	ID_AD5685R,
 	ID_AD5686,
 };
 static int ad5686_spi_write(struct ad5686_state *st,
@@ -303,7 +303,7 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.num_channels = 4,
 		.int_vref_mv = 2500,
 	},
-	[ID_AD5685] = {
+	[ID_AD5685R] = {
 		.channels = ad5685r_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 4,
@@ -392,7 +392,7 @@ static int ad5686_remove(struct spi_device *spi)
 
 static const struct spi_device_id ad5686_id[] = {
 	{"ad5684", ID_AD5684},
-	{"ad5685", ID_AD5685},
+	{"ad5685r", ID_AD5685R},
 	{"ad5686", ID_AD5686},
 	{}
 };
-- 
2.7.4
