Return-Path: <karniksayli1995@gmail.com>
Date: Mon, 10 Oct 2016 11:50:48 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 21cnbao@gmail.com,
	linux-iio@vger.kernel.org
Subject: [PATCH v2] staging: iio: cdc: ad7152: Replace mlock with a local
 mutex lock
Message-ID: <20161010062048.GA14750@sayli-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

mlock is intended to protect only switches between modes.
Given this driver doesn't support more than one mode (sysfs polled reads
only), replace mlock with a local mutex lock.

Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
---
v2:
Made changes on top of previous commit i.e, implement IIO_CHAN_INFO_SAMP_FREQ

 drivers/staging/iio/cdc/ad7152.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index b3cc629..24d355d 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -89,6 +89,7 @@ struct ad7152_chip_info {
 	 */
 	u8	filter_rate_setup;
 	u8	setup[2];
+	struct mutex state_lock;	/* protect hardware state */
 };
 
 static inline ssize_t ad7152_start_calib(struct device *dev,
@@ -115,10 +116,10 @@ static inline ssize_t ad7152_start_calib(struct device *dev,
 	else
 		regval |= AD7152_CONF_CH2EN;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&chip->state_lock);
 	ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG, regval);
 	if (ret < 0) {
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&chip->state_lock);
 		return ret;
 	}
 
@@ -126,12 +127,12 @@ static inline ssize_t ad7152_start_calib(struct device *dev,
 		mdelay(20);
 		ret = i2c_smbus_read_byte_data(chip->client, AD7152_REG_CFG);
 		if (ret < 0) {
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&chip->state_lock);
 			return ret;
 		}
 	} while ((ret == regval) && timeout--);
 
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&chip->state_lock);
 	return len;
 }
 static ssize_t ad7152_start_offset_calib(struct device *dev,
@@ -229,14 +230,14 @@ static int ad7152_write_raw_samp_freq(struct device *dev, int val)
 	if (i >= ARRAY_SIZE(ad7152_filter_rate_table))
 		i = ARRAY_SIZE(ad7152_filter_rate_table) - 1;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&chip->state_lock);
 	ret = i2c_smbus_write_byte_data(chip->client,
 					AD7152_REG_CFG2, AD7152_CFG2_OSR(i));
 	if (ret < 0)
 		return ret;
 
 	chip->filter_rate_setup = i;
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&chip->state_lock);
 
 	return ret;
 }
@@ -249,7 +250,7 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
 	struct ad7152_chip_info *chip = iio_priv(indio_dev);
 	int ret, i;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&chip->state_lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBSCALE:
@@ -317,7 +318,7 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
 	}
 
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&chip->state_lock);
 	return ret;
 }
 static int ad7152_read_raw(struct iio_dev *indio_dev,
@@ -329,7 +330,7 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
 	int ret;
 	u8 regval = 0;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&chip->state_lock);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -417,7 +418,7 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
 		ret = -EINVAL;
 	}
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&chip->state_lock);
 	return ret;
 }
 
@@ -503,6 +504,7 @@ static int ad7152_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 
 	chip->client = client;
+	mutex_init(&chip->state_lock);
 
 	/* Establish that the iio_dev is a child of the i2c device */
 	indio_dev->name = id->name;
-- 
2.7.4
