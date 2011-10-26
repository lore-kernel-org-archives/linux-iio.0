Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/5] staging:iio: Do not use bitmasks for channel info addresses
Date: Wed, 26 Oct 2011 17:41:35 +0100
Message-Id: <1319647296-4374-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319647296-4374-1-git-send-email-jic23@cam.ac.uk>
References: <1319647296-4374-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Lars-Peter Clausen <lars@metafoo.de>

Currently the iio framework uses bitmasks for the address field of channel info
attributes. This is for historical reasons and no longer required since it will
only ever query a single info attribute at once. This patch changes the code to
use the non-shifted iio_chan_info_enum values for the info attribute address.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_core.c |   10 +++++-----
 drivers/staging/iio/accel/adis16203_core.c |    8 ++++----
 drivers/staging/iio/accel/adis16204_core.c |   12 ++++++------
 drivers/staging/iio/accel/adis16209_core.c |   10 +++++-----
 drivers/staging/iio/accel/adis16220_core.c |    6 +++---
 drivers/staging/iio/accel/adis16240_core.c |   14 +++++++-------
 drivers/staging/iio/accel/kxsd9.c          |    4 ++--
 drivers/staging/iio/accel/lis3l02dq_core.c |   10 +++++-----
 drivers/staging/iio/accel/sca3000_core.c   |    2 +-
 drivers/staging/iio/adc/ad7192.c           |    6 +++---
 drivers/staging/iio/adc/ad7280a.c          |    2 +-
 drivers/staging/iio/adc/ad7291.c           |    6 +++---
 drivers/staging/iio/adc/ad7298_core.c      |    4 ++--
 drivers/staging/iio/adc/ad7476_core.c      |    2 +-
 drivers/staging/iio/adc/ad7606_core.c      |    2 +-
 drivers/staging/iio/adc/ad7780.c           |    2 +-
 drivers/staging/iio/adc/ad7793.c           |    6 +++---
 drivers/staging/iio/adc/ad7887_core.c      |    2 +-
 drivers/staging/iio/adc/ad799x_core.c      |    2 +-
 drivers/staging/iio/adc/max1363_core.c     |    2 +-
 drivers/staging/iio/cdc/ad7150.c           |    2 +-
 drivers/staging/iio/cdc/ad7152.c           |   14 +++++++-------
 drivers/staging/iio/cdc/ad7746.c           |   14 +++++++-------
 drivers/staging/iio/dac/ad5064.c           |    2 +-
 drivers/staging/iio/dac/ad5360.c           |   14 +++++++-------
 drivers/staging/iio/dac/ad5686.c           |    2 +-
 drivers/staging/iio/dac/ad5791.c           |    4 ++--
 drivers/staging/iio/gyro/adis16060_core.c  |    4 ++--
 drivers/staging/iio/gyro/adis16260_core.c  |   14 +++++++-------
 drivers/staging/iio/gyro/adxrs450_core.c   |    4 ++--
 drivers/staging/iio/iio.h                  |    3 ++-
 drivers/staging/iio/iio_simple_dummy.c     |   12 ++++++------
 drivers/staging/iio/imu/adis16400_core.c   |   10 +++++-----
 drivers/staging/iio/industrialio-core.c    |    2 +-
 drivers/staging/iio/light/isl29018.c       |    4 ++--
 drivers/staging/iio/light/tsl2563.c        |    2 +-
 drivers/staging/iio/magnetometer/ak8975.c  |    2 +-
 drivers/staging/iio/magnetometer/hmc5843.c |    2 +-
 38 files changed, 112 insertions(+), 111 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 1283519..f1c0602 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -322,8 +322,8 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			*val = 0;
@@ -348,10 +348,10 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 		break;
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+	case IIO_CHAN_INFO_OFFSET_SEPARATE:
 		*val = 25;
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		switch (chan->type) {
 		case IIO_ACCEL:
 			bits = 12;
@@ -388,7 +388,7 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 	s16 val16;
 	u8 addr;
 	switch (mask) {
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		switch (chan->type) {
 		case IIO_ACCEL:
 			bits = 12;
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 5483b59..5bf944b 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -329,8 +329,8 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			*val = 0;
@@ -350,10 +350,10 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+	case IIO_CHAN_INFO_OFFSET_SEPARATE:
 		*val = 25;
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		bits = 14;
 		mutex_lock(&indio_dev->mlock);
 		addr = adis16203_addresses[chan->address][1];
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 462f215..068f543 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -366,7 +366,7 @@ static int adis16204_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			*val = 0;
@@ -390,12 +390,12 @@ static int adis16204_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 		break;
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+	case IIO_CHAN_INFO_OFFSET_SEPARATE:
 		*val = 25;
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
-	case (1 << IIO_CHAN_INFO_PEAK_SEPARATE):
-		if (mask == (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE)) {
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_PEAK_SEPARATE:
+		if (mask == IIO_CHAN_INFO_CALIBBIAS_SEPARATE) {
 			bits = 12;
 			addrind = 1;
 		} else { /* PEAK_SEPARATE */
@@ -428,7 +428,7 @@ static int adis16204_write_raw(struct iio_dev *indio_dev,
 	s16 val16;
 	u8 addr;
 	switch (mask) {
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		switch (chan->type) {
 		case IIO_ACCEL:
 			bits = 12;
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 827499f..57540f1 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -304,7 +304,7 @@ static int adis16209_write_raw(struct iio_dev *indio_dev,
 	s16 val16;
 	u8 addr;
 	switch (mask) {
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		switch (chan->type) {
 		case IIO_ACCEL:
 		case IIO_INCLI:
@@ -355,8 +355,8 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			*val = 0;
@@ -381,10 +381,10 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 		break;
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+	case IIO_CHAN_INFO_OFFSET_SEPARATE:
 		*val = 25;
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		switch (chan->type) {
 		case IIO_ACCEL:
 			bits = 14;
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 6d4503d..284f810 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -510,17 +510,17 @@ static int adis16220_read_raw(struct iio_dev *indio_dev,
 	case 0:
 		addrind = 0;
 		break;
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+	case IIO_CHAN_INFO_OFFSET_SEPARATE:
 		if (chan->type == IIO_TEMP) {
 			*val = 25;
 			return IIO_VAL_INT;
 		}
 		addrind = 1;
 		break;
-	case (1 << IIO_CHAN_INFO_PEAK_SEPARATE):
+	case IIO_CHAN_INFO_PEAK_SEPARATE:
 		addrind = 2;
 		break;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
 		*val = 0;
 		switch (chan->type) {
 		case IIO_TEMP:
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 8123fe3..482a762 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -389,8 +389,8 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			*val = 0;
@@ -411,14 +411,14 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 		break;
-	case (1 << IIO_CHAN_INFO_PEAK_SCALE_SHARED):
+	case IIO_CHAN_INFO_PEAK_SCALE_SHARED:
 		*val = 6;
 		*val2 = 629295;
 		return IIO_VAL_INT_PLUS_MICRO;
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+	case IIO_CHAN_INFO_OFFSET_SEPARATE:
 		*val = 25;
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		bits = 10;
 		mutex_lock(&indio_dev->mlock);
 		addr = adis16240_addresses[chan->address][1];
@@ -432,7 +432,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_PEAK_SEPARATE):
+	case IIO_CHAN_INFO_PEAK_SEPARATE:
 		bits = 10;
 		mutex_lock(&indio_dev->mlock);
 		addr = adis16240_addresses[chan->address][2];
@@ -460,7 +460,7 @@ static int adis16240_write_raw(struct iio_dev *indio_dev,
 	s16 val16;
 	u8 addr;
 	switch (mask) {
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		val16 = val & ((1 << bits) - 1);
 		addr = adis16240_addresses[chan->address][1];
 		return adis16240_spi_write_reg_16(indio_dev, addr, val16);
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index 5238503..0ea0b5c 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -140,7 +140,7 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
 {
 	int ret = -EINVAL;
 
-	if (mask == (1 << IIO_CHAN_INFO_SCALE_SHARED)) {
+	if (mask == IIO_CHAN_INFO_SCALE_SHARED) {
 		/* Check no integer component */
 		if (val)
 			return -EINVAL;
@@ -164,7 +164,7 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
 			goto error_ret;
 		*val = ret;
 		break;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
 		if (ret)
 			goto error_ret;
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 358a9f6..d7706eb 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -227,14 +227,14 @@ static int lis3l02dq_write_raw(struct iio_dev *indio_dev,
 	u8 uval;
 	s8 sval;
 	switch (mask) {
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		if (val > 255 || val < -256)
 			return -EINVAL;
 		sval = val;
 		reg = lis3l02dq_axis_map[LIS3L02DQ_BIAS][chan->address];
 		ret = lis3l02dq_spi_write_reg_8(indio_dev, reg, sval);
 		break;
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
 		if (val & ~0xFF)
 			return -EINVAL;
 		uval = val;
@@ -272,11 +272,11 @@ static int lis3l02dq_read_raw(struct iio_dev *indio_dev,
 		}
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		*val = 0;
 		*val2 = 9580;
 		return IIO_VAL_INT_PLUS_MICRO;
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
 		reg = lis3l02dq_axis_map[LIS3L02DQ_GAIN][chan->address];
 		ret = lis3l02dq_spi_read_reg_8(indio_dev, reg, &utemp);
 		if (ret)
@@ -285,7 +285,7 @@ static int lis3l02dq_read_raw(struct iio_dev *indio_dev,
 		*val = utemp;
 		return IIO_VAL_INT;
 
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		reg = lis3l02dq_axis_map[LIS3L02DQ_BIAS][chan->address];
 		ret = lis3l02dq_spi_read_reg_8(indio_dev, reg, (u8 *)&stemp);
 		/* to match with what previous code does */
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 8a46983..1586963 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -475,7 +475,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 			(sizeof(*val)*8 - 13);
 		mutex_unlock(&st->lock);
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		*val = 0;
 		if (chan->type == IIO_ACCEL)
 			*val2 = st->info->scale;
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index b16130b..4674c2a 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -901,7 +901,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 		}
 		return IIO_VAL_INT;
 
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		mutex_lock(&indio_dev->mlock);
 		*val = st->scale_avail[AD7192_CONF_GAIN(st->conf)][0];
 		*val2 = st->scale_avail[AD7192_CONF_GAIN(st->conf)][1];
@@ -909,7 +909,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT_PLUS_NANO;
 
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
 		*val =  1000;
 
 		return IIO_VAL_INT;
@@ -935,7 +935,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 	}
 
 	switch (mask) {
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		ret = -EINVAL;
 		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
 			if (val2 == st->scale_avail[i][1]) {
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 5ccda4b..5397ba8 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -802,7 +802,7 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6)
 			scale_uv = (4000 * 1000) >> AD7280A_BITS;
 		else
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index e5f352b..bedd91a 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -501,7 +501,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-	case (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE):
+	case IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE:
 		ret = i2c_smbus_read_word_data(chip->client,
 					       AD7291_T_AVERAGE);
 			if (ret < 0)
@@ -510,12 +510,12 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 				AD7291_VALUE_MASK) << 4) >> 4;
 			*val = signval;
 			return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		scale_uv = (chip->int_vref_mv * 1000) >> AD7291_BITS;
 		*val =  scale_uv / 1000;
 		*val2 = (scale_uv % 1000) * 1000;
 		return IIO_VAL_INT_PLUS_MICRO;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
 		/*
 		* One LSB of the ADC corresponds to 0.25 deg C.
 		* The temperature reading is in 12-bit twos complement format
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 445b071..2e3b0d9 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -143,12 +143,12 @@ static int ad7298_read_raw(struct iio_dev *indio_dev,
 			*val = ret & RES_MASK(AD7298_BITS);
 
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		scale_uv = (st->int_vref_mv * 1000) >> AD7298_BITS;
 		*val =  scale_uv / 1000;
 		*val2 = (scale_uv % 1000) * 1000;
 		return IIO_VAL_INT_PLUS_MICRO;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
 		*val =  1;
 		*val2 = 0;
 		return IIO_VAL_INT_PLUS_MICRO;
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 1347313..163a254 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -56,7 +56,7 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 		*val = (ret >> st->chip_info->channel[0].scan_type.shift) &
 			RES_MASK(st->chip_info->channel[0].scan_type.realbits);
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		scale_uv = (st->int_vref_mv * 1000)
 			>> st->chip_info->channel[0].scan_type.realbits;
 		*val =  scale_uv/1000;
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 5317483..d58a0e3 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -100,7 +100,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		*val = (short) ret;
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		scale_uv = (st->range * 1000 * 2)
 			>> st->chip_info->channels[0].scan_type.realbits;
 		*val =  scale_uv / 1000;
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 7a579a1..b06f9ad 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -114,7 +114,7 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 			*val *= 128;
 
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		scale_uv = (st->int_vref_mv * 100000)
 			>> (channel.scan_type.realbits - 1);
 		*val =  scale_uv / 100000;
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 7d3a5af..2f0a1e1 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -666,13 +666,13 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		*val = st->scale_avail[(st->conf >> 8) & 0x7][0];
 		*val2 = st->scale_avail[(st->conf >> 8) & 0x7][1];
 
 		return IIO_VAL_INT_PLUS_NANO;
 
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			/* 1170mV / 2^23 * 6 */
@@ -715,7 +715,7 @@ static int ad7793_write_raw(struct iio_dev *indio_dev,
 	}
 
 	switch (mask) {
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		ret = -EINVAL;
 		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
 			if (val2 == st->scale_avail[i][1]) {
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index a7baa9b..245c943 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -55,7 +55,7 @@ static int ad7887_read_raw(struct iio_dev *indio_dev,
 		*val = (ret >> st->chip_info->channel[0].scan_type.shift) &
 			RES_MASK(st->chip_info->channel[0].scan_type.realbits);
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		scale_uv = (st->int_vref_mv * 1000)
 			>> st->chip_info->channel[0].scan_type.realbits;
 		*val =  scale_uv/1000;
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 64ac316..60a48a2 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -162,7 +162,7 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
 		*val = (ret >> chan->scan_type.shift) &
 			RES_MASK(chan->scan_type.realbits);
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		scale_uv = (st->int_vref_mv * 1000) >> chan->scan_type.realbits;
 		*val =  scale_uv / 1000;
 		*val2 = (scale_uv % 1000) * 1000;
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 73b209f..6b05e57 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -261,7 +261,7 @@ static int max1363_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		if ((1 << (st->chip_info->bits + 1)) >
 		    st->chip_info->int_vref_mv) {
 			*val = 0;
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index abe6509..10737fa 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -111,7 +111,7 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		*val = swab16(ret);
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE):
+	case IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE:
 		ret = i2c_smbus_read_word_data(chip->client,
 					ad7150_addresses[chan->channel][1]);
 		if (ret < 0)
diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 662584d..e5ca683 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -259,7 +259,7 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
 	mutex_lock(&indio_dev->mlock);
 
 	switch (mask) {
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
 		if (val != 1) {
 			ret = -EINVAL;
 			goto out;
@@ -276,7 +276,7 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
 		ret = 0;
 		break;
 
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		if ((val < 0) | (val > 0xFFFF)) {
 			ret = -EINVAL;
 			goto out;
@@ -289,7 +289,7 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
 
 		ret = 0;
 		break;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
 		if (val != 0) {
 			ret = -EINVAL;
 			goto out;
@@ -372,7 +372,7 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT;
 		break;
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
 
 		ret = i2c_smbus_read_word_data(chip->client,
 				ad7152_addresses[chan->channel][AD7152_GAIN]);
@@ -384,7 +384,7 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		ret = i2c_smbus_read_word_data(chip->client,
 				ad7152_addresses[chan->channel][AD7152_OFFS]);
 		if (ret < 0)
@@ -393,7 +393,7 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT;
 		break;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
 		ret = i2c_smbus_read_byte_data(chip->client,
 				ad7152_addresses[chan->channel][AD7152_SETUP]);
 		if (ret < 0)
@@ -416,7 +416,7 @@ static int ad7152_write_raw_get_fmt(struct iio_dev *indio_dev,
 			       long mask)
 {
 	switch (mask) {
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
 		return IIO_VAL_INT_PLUS_NANO;
 	default:
 		return IIO_VAL_INT_PLUS_MICRO;
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 2867943..5deaf85 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -477,7 +477,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 	mutex_lock(&indio_dev->mlock);
 
 	switch (mask) {
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
 		if (val != 1) {
 			ret = -EINVAL;
 			goto out;
@@ -503,7 +503,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 
 		ret = 0;
 		break;
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SHARED):
+	case IIO_CHAN_INFO_CALIBBIAS_SHARED:
 		if ((val < 0) | (val > 0xFFFF)) {
 			ret = -EINVAL;
 			goto out;
@@ -515,7 +515,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 
 		ret = 0;
 		break;
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+	case IIO_CHAN_INFO_OFFSET_SEPARATE:
 		if ((val < 0) | (val > 43008000)) { /* 21pF */
 			ret = -EINVAL;
 			goto out;
@@ -612,7 +612,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT;
 		break;
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
 		switch (chan->type) {
 		case IIO_CAPACITANCE:
 			reg = AD7746_REG_CAP_GAINH;
@@ -634,7 +634,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SHARED):
+	case IIO_CHAN_INFO_CALIBBIAS_SHARED:
 		ret = i2c_smbus_read_word_data(chip->client,
 					       AD7746_REG_CAP_OFFH);
 		if (ret < 0)
@@ -643,13 +643,13 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT;
 		break;
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+	case IIO_CHAN_INFO_OFFSET_SEPARATE:
 		*val = AD7746_CAPDAC_DACP(chip->capdac[chan->channel]
 			[chan->differential]) * 338646;
 
 		ret = IIO_VAL_INT;
 		break;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		switch (chan->type) {
 		case IIO_CAPACITANCE:
 			/* 8.192pf / 2^24 */
diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
index 24279f2..1c25403 100644
--- a/drivers/staging/iio/dac/ad5064.c
+++ b/drivers/staging/iio/dac/ad5064.c
@@ -287,7 +287,7 @@ static int ad5064_read_raw(struct iio_dev *indio_dev,
 	case 0:
 		*val = st->dac_cache[chan->channel];
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
 		vref = st->chip_info->shared_vref ? 0 : chan->channel;
 		scale_uv = regulator_get_voltage(st->vref_reg[vref].consumer);
 		if (scale_uv < 0)
diff --git a/drivers/staging/iio/dac/ad5360.c b/drivers/staging/iio/dac/ad5360.c
index 72d0f3f..7df1958 100644
--- a/drivers/staging/iio/dac/ad5360.c
+++ b/drivers/staging/iio/dac/ad5360.c
@@ -326,21 +326,21 @@ static int ad5360_write_raw(struct iio_dev *indio_dev,
 		return ad5360_write(indio_dev, AD5360_CMD_WRITE_DATA,
 				 chan->address, val, chan->scan_type.shift);
 
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		if (val >= max_val || val < 0)
 			return -EINVAL;
 
 		return ad5360_write(indio_dev, AD5360_CMD_WRITE_OFFSET,
 				 chan->address, val, chan->scan_type.shift);
 
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
 		if (val >= max_val || val < 0)
 			return -EINVAL;
 
 		return ad5360_write(indio_dev, AD5360_CMD_WRITE_GAIN,
 				 chan->address, val, chan->scan_type.shift);
 
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+	case IIO_CHAN_INFO_OFFSET_SEPARATE:
 		if (val <= -max_val || val > 0)
 			return -EINVAL;
 
@@ -383,7 +383,7 @@ static int ad5360_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		*val = ret >> chan->scan_type.shift;
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
 		/* vout = 4 * vref * dac_code */
 		scale_uv = ad5360_get_channel_vref(st, chan->channel) * 4 * 100;
 		if (scale_uv < 0)
@@ -393,21 +393,21 @@ static int ad5360_read_raw(struct iio_dev *indio_dev,
 		*val =  scale_uv / 100000;
 		*val2 = (scale_uv % 100000) * 10;
 		return IIO_VAL_INT_PLUS_MICRO;
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		ret = ad5360_read(indio_dev, AD5360_READBACK_OFFSET,
 			chan->address);
 		if (ret < 0)
 			return ret;
 		*val = ret;
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
 		ret = ad5360_read(indio_dev, AD5360_READBACK_GAIN,
 			chan->address);
 		if (ret < 0)
 			return ret;
 		*val = ret;
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+	case IIO_CHAN_INFO_OFFSET_SEPARATE:
 		ofs_index = ad5360_get_channel_vref_index(st, chan->channel);
 		ret = ad5360_read(indio_dev, AD5360_READBACK_SF,
 			AD5360_REG_SF_OFS(ofs_index));
diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index 48389e1..070de8d 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -305,7 +305,7 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 		return IIO_VAL_INT;
 		break;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		scale_uv = (st->vref_mv * 100000)
 			>> (chan->scan_type.realbits);
 		*val =  scale_uv / 100000;
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index 6fbca8d..d3b3b71 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -237,11 +237,11 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
 		*val &= AD5791_DAC_MASK;
 		*val >>= chan->scan_type.shift;
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		*val = 0;
 		*val2 = (((u64)st->vref_mv) * 1000000ULL) >> chan->scan_type.realbits;
 		return IIO_VAL_INT_PLUS_MICRO;
-	case (1 << IIO_CHAN_INFO_OFFSET_SHARED):
+	case IIO_CHAN_INFO_OFFSET_SHARED:
 		val64 = (((u64)st->vref_neg_mv) << chan->scan_type.realbits);
 		do_div(val64, st->vref_mv);
 		*val = -val64;
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 38cf3f4..88879b4 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -97,11 +97,11 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&indio_dev->mlock);
 		*val = tval;
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+	case IIO_CHAN_INFO_OFFSET_SEPARATE:
 		*val = -7;
 		*val2 = 461117;
 		return IIO_VAL_INT_PLUS_MICRO;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
 		*val = 0;
 		*val2 = 34000;
 		return IIO_VAL_INT_PLUS_MICRO;
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 40da955..4f5a7cb 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -464,8 +464,8 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
 			*val = 0;
@@ -489,10 +489,10 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 		break;
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+	case IIO_CHAN_INFO_OFFSET_SEPARATE:
 		*val = 25;
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
 			bits = 12;
@@ -512,7 +512,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
 			bits = 12;
@@ -544,11 +544,11 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 	s16 val16;
 	u8 addr;
 	switch (mask) {
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		val16 = val & ((1 << bits) - 1);
 		addr = adis16260_addresses[chan->address][1];
 		return adis16260_spi_write_reg_16(indio_dev, addr, val16);
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
 		val16 = val & ((1 << bits) - 1);
 		addr = adis16260_addresses[chan->address][2];
 		return adis16260_spi_write_reg_16(indio_dev, addr, val16);
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 3c3ef79..18406c7 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -243,7 +243,7 @@ static int adxrs450_write_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 	switch (mask) {
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		ret = adxrs450_spi_write_reg_16(indio_dev,
 						ADXRS450_DNC1,
 						val & 0x3FF);
@@ -287,7 +287,7 @@ static int adxrs450_read_raw(struct iio_dev *indio_dev,
 			break;
 		}
 		break;
-	case (1 << IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE):
+	case IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE:
 		ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_QUAD1, &t);
 		if (ret)
 			break;
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index cf95f74..4fb4cc4 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -26,7 +26,8 @@ enum iio_data_type {
 
 /* Could add the raw attributes as well - allowing buffer only devices */
 enum iio_chan_info_enum {
-	IIO_CHAN_INFO_SCALE_SHARED,
+	/* 0 is reserverd for raw attributes */
+	IIO_CHAN_INFO_SCALE_SHARED = 2,
 	IIO_CHAN_INFO_SCALE_SEPARATE,
 	IIO_CHAN_INFO_OFFSET_SHARED,
 	IIO_CHAN_INFO_OFFSET_SEPARATE,
diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index 06c022e..2196ff1 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -229,29 +229,29 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
 			break;
 		}
 		break;
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+	case IIO_CHAN_INFO_OFFSET_SEPARATE:
 		/* only single ended adc -> 7 */
 		*val = 7;
 		ret = IIO_VAL_INT;
 		break;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
 		/* only single ended adc -> 0.001333 */
 		*val = 0;
 		*val2 = 1333;
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		/* all differential adc channels -> 0.000001344 */
 		*val = 0;
 		*val2 = 1344;
 		ret = IIO_VAL_INT_PLUS_NANO;
 		break;
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		/* only the acceleration axis - read from cache */
 		*val = st->accel_calibbias;
 		ret = IIO_VAL_INT;
 		break;
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
 		*val = st->accel_calibscale->val;
 		*val2 = st->accel_calibscale->val2;
 		ret = IIO_VAL_INT_PLUS_MICRO;
@@ -296,7 +296,7 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
 		st->dac_val = val;
 		mutex_unlock(&st->lock);
 		return 0;
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		mutex_lock(&st->lock);
 		/* Compare against table - hard matching here */
 		for (i = 0; i < ARRAY_SIZE(dummy_scales); i++)
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index e6df4921..0018272 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -464,7 +464,7 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		mutex_lock(&indio_dev->mlock);
 		ret = adis16400_spi_write_reg_16(indio_dev,
 				adis16400_addresses[chan->address][1],
@@ -504,8 +504,8 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
 			*val = 0;
@@ -533,7 +533,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
 		mutex_lock(&indio_dev->mlock);
 		ret = adis16400_spi_read_reg_16(indio_dev,
 				adis16400_addresses[chan->address][1],
@@ -544,7 +544,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		val16 = ((val16 & 0xFFF) << 4) >> 4;
 		*val = val16;
 		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+	case IIO_CHAN_INFO_OFFSET_SEPARATE:
 		/* currently only temperature */
 		*val = 198;
 		*val2 = 160000;
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index bc91daf..a53e905 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -595,7 +595,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 					     chan,
 					     &iio_read_channel_info,
 					     &iio_write_channel_info,
-					     (1 << i),
+					     i,
 					     !(i%2),
 					     &indio_dev->dev,
 					     &indio_dev->channel_attr_list);
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 9dc9e63..bed18a7 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -362,7 +362,7 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
 	int ret = -EINVAL;
 
 	mutex_lock(&chip->lock);
-	if (mask == (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) &&
+	if (mask == IIO_CHAN_INFO_CALIBSCALE_SEPARATE &&
 	    chan->type == IIO_LIGHT) {
 		chip->lux_scale = val;
 		ret = 0;
@@ -402,7 +402,7 @@ static int isl29018_read_raw(struct iio_dev *indio_dev,
 		if (!ret)
 			ret = IIO_VAL_INT;
 		break;
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
 		if (chan->type == IIO_LIGHT) {
 			*val = chip->lux_scale;
 			ret = IIO_VAL_INT;
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 32dfce0..45d04a1 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -513,7 +513,7 @@ static int tsl2563_read_raw(struct iio_dev *indio_dev,
 		}
 		break;
 
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
 		if (chan->channel == 0)
 			*val = calib_to_sysfs(chip->calib0);
 		else
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 8b01712..b7d8cbb 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -431,7 +431,7 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case 0:
 		return ak8975_read_axis(indio_dev, chan->address, val);
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+	case IIO_CHAN_INFO_SCALE_SEPARATE:
 		*val = data->raw_to_gauss[chan->address];
 		return IIO_VAL_INT;
 	}
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index fc9ee97..4a42707 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -463,7 +463,7 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
 		return hmc5843_read_measurement(indio_dev,
 						chan->address,
 						val);
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+	case IIO_CHAN_INFO_SCALE_SHARED:
 		*val = 0;
 		*val2 = hmc5843_regval_to_nanoscale[data->range];
 		return IIO_VAL_INT_PLUS_NANO;
-- 
1.7.7
