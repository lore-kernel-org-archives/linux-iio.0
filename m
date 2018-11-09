Return-Path: <SRS0=Jz46=NU=gmail.com=nishadkamdar@kernel.org>
Date: Fri, 9 Nov 2018 13:07:18 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] staging: iio: ad7816: Set RD/WR pin and CONVST pin as
 outputs.
Message-ID: <fbc5a97bc44a0c57ba21f375ccec888f5113d702.1541733949.git.nishadkamdar@gmail.com>
References: <cover.1541733949.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1541733949.git.nishadkamdar@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The RD/WR pin and CONVST pin are logical inputs to the AD78xx
chip as per the datasheet. Hence convert them to outputs.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 3cda5cd09365..a2fead85cd46 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -369,14 +369,15 @@ static int ad7816_probe(struct spi_device *spi_dev)
 		chip->oti_data[i] = 203;
 
 	chip->id = spi_get_device_id(spi_dev)->driver_data;
-	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
+	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
 	if (IS_ERR(chip->rdwr_pin)) {
 		ret = PTR_ERR(chip->rdwr_pin);
 		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
 			ret);
 		return ret;
 	}
-	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert", GPIOD_IN);
+	chip->convert_pin = devm_gpiod_get(&spi_dev->dev, "convert",
+					   GPIOD_OUT_HIGH);
 	if (IS_ERR(chip->convert_pin)) {
 		ret = PTR_ERR(chip->convert_pin);
 		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
-- 
2.17.1
