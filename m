Return-Path: <SRS0=eIxb=3H=gmail.com=singhalsimran0@kernel.org>
Date: Fri, 31 Mar 2017 00:32:26 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH] iio: gyro: adis16060: Change the function's name
Message-ID: <20170330190225.GA18838@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Change the name of function from adis16060_spi_write_than_read()
to adis16060_spi_write_then_read(). change "than" to "then" as
its time depended.
---
 drivers/staging/iio/gyro/adis16060_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 8115962..9675245 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -40,7 +40,7 @@ struct adis16060_state {
 
 static struct iio_dev *adis16060_iio_dev;
 
-static int adis16060_spi_write_than_read(struct iio_dev *indio_dev,
+static int adis16060_spi_write_then_read(struct iio_dev *indio_dev,
 					 u8 conf, u16 *val)
 {
 	int ret;
@@ -81,7 +81,7 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = adis16060_spi_write_than_read(indio_dev,
+		ret = adis16060_spi_write_then_read(indio_dev,
 						    chan->address, &tval);
 		if (ret < 0)
 			return ret;
-- 
2.7.4
