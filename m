Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH v2 2/5] iio:light:stk3310: make endianness independent of host
Date: Thu,  9 Jul 2015 23:51:30 +0200
Message-Id: <942ccba3622543a862cb399c6f57e8b8ddcdbe6e.1436398691.git.knaack.h@gmx.de>
In-Reply-To: <cover.1436398691.git.knaack.h@gmx.de>
References: <cover.1436398691.git.knaack.h@gmx.de>
In-Reply-To: <cover.1436398691.git.knaack.h@gmx.de>
References: <cover.1436398691.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Data is stored in the device in be16 format. Make use of be16_to_cpu and
cpu_to_be16 to have correct endianness on any host architecture.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
 drivers/iio/light/stk3310.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index e7e6e5a2b1f8..11a027adc204 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -200,7 +200,7 @@ static int stk3310_read_event(struct iio_dev *indio_dev,
 			      int *val, int *val2)
 {
 	u8 reg;
-	u16 buf;
+	__be16 buf;
 	int ret;
 	struct stk3310_data *data = iio_priv(indio_dev);
 
@@ -222,7 +222,7 @@ static int stk3310_read_event(struct iio_dev *indio_dev,
 		dev_err(&data->client->dev, "register read failed\n");
 		return ret;
 	}
-	*val = swab16(buf);
+	*val = be16_to_cpu(buf);
 
 	return IIO_VAL_INT;
 }
@@ -235,7 +235,7 @@ static int stk3310_write_event(struct iio_dev *indio_dev,
 			       int val, int val2)
 {
 	u8 reg;
-	u16 buf;
+	__be16 buf;
 	int ret;
 	unsigned int index;
 	struct stk3310_data *data = iio_priv(indio_dev);
@@ -252,7 +252,7 @@ static int stk3310_write_event(struct iio_dev *indio_dev,
 	else
 		return -EINVAL;
 
-	buf = swab16(val);
+	buf = cpu_to_be16(val);
 	ret = regmap_bulk_write(data->regmap, reg, &buf, 2);
 	if (ret < 0)
 		dev_err(&client->dev, "failed to set PS threshold!\n");
@@ -301,7 +301,7 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	u8 reg;
-	u16 buf;
+	__be16 buf;
 	int ret;
 	unsigned int index;
 	struct stk3310_data *data = iio_priv(indio_dev);
@@ -322,7 +322,7 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
 			mutex_unlock(&data->lock);
 			return ret;
 		}
-		*val = swab16(buf);
+		*val = be16_to_cpu(buf);
 		mutex_unlock(&data->lock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_INT_TIME:
-- 
2.4.3
