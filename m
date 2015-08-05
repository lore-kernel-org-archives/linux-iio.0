Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 9/9] iio: adis16136: Add ADIS16137 support
Date: Wed,  5 Aug 2015 15:38:21 +0200
Message-Id: <1438781901-28000-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1438781901-28000-1-git-send-email-lars@metafoo.de>
References: <1438781901-28000-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The ADIS16137 is register map compatible to the ADIS16136, but has a
different scale factor for the gyroscope output.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/gyro/adis16136.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index 591bd55..26de876 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -473,6 +473,7 @@ enum adis16136_id {
 	ID_ADIS16133,
 	ID_ADIS16135,
 	ID_ADIS16136,
+	ID_ADIS16137,
 };
 
 static const struct adis16136_chip_info adis16136_chip_info[] = {
@@ -488,6 +489,10 @@ static const struct adis16136_chip_info adis16136_chip_info[] = {
 		.precision = IIO_DEGREE_TO_RAD(450),
 		.fullscale = 24623,
 	},
+	[ID_ADIS16137] = {
+		.precision = IIO_DEGREE_TO_RAD(1000),
+		.fullscale = 24609,
+	},
 };
 
 static int adis16136_probe(struct spi_device *spi)
@@ -557,6 +562,7 @@ static const struct spi_device_id adis16136_ids[] = {
 	{ "adis16133", ID_ADIS16133 },
 	{ "adis16135", ID_ADIS16135 },
 	{ "adis16136", ID_ADIS16136 },
+	{ "adis16137", ID_ADIS16137 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adis16136_ids);
-- 
2.1.4
