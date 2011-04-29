Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>, <jic23@cam.ac.uk>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 5/6] IIO: GYRO: ADXRS450: Fix sign issues, properly shift results and limit values
Date: Fri, 29 Apr 2011 14:17:03 +0200
Message-ID: <1304079424-18506-5-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1304079424-18506-1-git-send-email-michael.hennerich@analog.com>
References: <1304079424-18506-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

RATE and QUADRATURE_CORRECTION data is formatted as a twos complement number,
and therefore must be handled as type signed short.

TEMP result should be properly shifted.

Dynamic Null Correction is a 10-bit signed number.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adxrs450_core.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index d73acff..e71b91c 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -126,7 +126,7 @@ static int adxrs450_spi_write_reg_16(struct device *dev,
  * @dev: device associated with child of actual iio_dev
  * @val: somewhere to pass back the value read
  **/
-static int adxrs450_spi_sensor_data(struct device *dev, u16 *val)
+static int adxrs450_spi_sensor_data(struct device *dev, s16 *val)
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -217,7 +217,7 @@ static ssize_t adxrs450_read_temp(struct device *dev,
 			&t);
 	if (ret)
 		return ret;
-	return sprintf(buf, "%d\n", t);
+	return sprintf(buf, "%d\n", t >> 7);
 }

 static ssize_t adxrs450_read_quad(struct device *dev,
@@ -225,7 +225,7 @@ static ssize_t adxrs450_read_quad(struct device *dev,
 		char *buf)
 {
 	int ret;
-	u16 t;
+	s16 t;
 	ret = adxrs450_spi_read_reg_16(dev,
 			ADXRS450_QUAD1,
 			&t);
@@ -247,7 +247,7 @@ static ssize_t adxrs450_write_dnc(struct device *dev,
 		goto error_ret;
 	ret = adxrs450_spi_write_reg_16(dev,
 			ADXRS450_DNC1,
-			val);
+			val & 0x3FF);
 error_ret:
 	return ret ? ret : len;
 }
@@ -257,7 +257,7 @@ static ssize_t adxrs450_read_sensor_data(struct device *dev,
 		char *buf)
 {
 	int ret;
-	u16 t;
+	s16 t;

 	ret = adxrs450_spi_sensor_data(dev, &t);
 	if (ret)
--
1.6.0.2
