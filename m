Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org,
	greg@kroah.com
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio: unwind the IIO_IN -> IIO_VOLTAGE define
Date: Tue, 27 Sep 2011 09:56:41 +0100
Message-Id: <1317113801-21838-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317113801-21838-1-git-send-email-jic23@cam.ac.uk>
References: <1317113801-21838-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This was originally there to avoid churn during a complex change.
Now everything is stable lets get rid of this as it is missleading
and confusing.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_core.c      |    6 +-
 drivers/staging/iio/accel/adis16203_core.c      |    6 +-
 drivers/staging/iio/accel/adis16204_core.c      |    6 +-
 drivers/staging/iio/accel/adis16209_core.c      |    6 +-
 drivers/staging/iio/accel/adis16220_core.c      |    8 +-
 drivers/staging/iio/accel/adis16240_core.c      |    6 +-
 drivers/staging/iio/accel/kxsd9.c               |    2 +-
 drivers/staging/iio/adc/ad7150.c                |    8 +-
 drivers/staging/iio/adc/ad7291.c                |    4 +-
 drivers/staging/iio/adc/ad7298_core.c           |   16 ++--
 drivers/staging/iio/adc/ad7476_core.c           |   16 ++--
 drivers/staging/iio/adc/ad7606_core.c           |   36 +++++-----
 drivers/staging/iio/adc/ad7780.c                |    4 +-
 drivers/staging/iio/adc/ad7793.c                |    2 +-
 drivers/staging/iio/adc/ad7887_core.c           |    4 +-
 drivers/staging/iio/adc/ad799x_core.c           |   80 +++++++++++-----------
 drivers/staging/iio/adc/max1363_core.c          |   24 +++++--
 drivers/staging/iio/addac/adt7316.c             |    8 +-
 drivers/staging/iio/gyro/adis16060_core.c       |    4 +-
 drivers/staging/iio/gyro/adis16080_core.c       |    4 +-
 drivers/staging/iio/gyro/adis16260_core.c       |    6 +-
 drivers/staging/iio/iio.h                       |    4 -
 drivers/staging/iio/impedance-analyzer/ad5933.c |    4 +-
 drivers/staging/iio/imu/adis16400_core.c        |    8 +-
 drivers/staging/iio/meter/ade7758_core.c        |    6 +-
 25 files changed, 141 insertions(+), 137 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index e5364b7..d7ec505 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -325,7 +325,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
 	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
 		switch (chan->type) {
-		case IIO_IN:
+		case IIO_VOLTAGE:
 			*val = 0;
 			if (chan->channel == 0)
 				*val2 = 1220;
@@ -407,7 +407,7 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 }
 
 static struct iio_chan_spec adis16201_channels[] = {
-	IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 0, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "supply", 0, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		 in_supply, ADIS16201_SCAN_SUPPLY,
 		 IIO_ST('u', 12, 16, 0), 0),
@@ -426,7 +426,7 @@ static struct iio_chan_spec adis16201_channels[] = {
 		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
 		 accel_y, ADIS16201_SCAN_ACC_Y,
 		 IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		 in_aux, ADIS16201_SCAN_AUX_ADC,
 		 IIO_ST('u', 12, 16, 0), 0),
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 34975dc..2ffcf4e 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -332,7 +332,7 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
 	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
 		switch (chan->type) {
-		case IIO_IN:
+		case IIO_VOLTAGE:
 			*val = 0;
 			if (chan->channel == 0)
 				*val2 = 1220;
@@ -373,11 +373,11 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 }
 
 static struct iio_chan_spec adis16203_channels[] = {
-	IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 0, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "supply", 0, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		 in_supply, ADIS16203_SCAN_SUPPLY,
 		 IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		 in_aux, ADIS16203_SCAN_AUX_ADC,
 		 IIO_ST('u', 12, 16, 0), 0),
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 7a4c680..2ca617d 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -369,7 +369,7 @@ static int adis16204_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
 		switch (chan->type) {
-		case IIO_IN:
+		case IIO_VOLTAGE:
 			*val = 0;
 			if (chan->channel == 0)
 				*val2 = 1220;
@@ -445,11 +445,11 @@ static int adis16204_write_raw(struct iio_dev *indio_dev,
 }
 
 static struct iio_chan_spec adis16204_channels[] = {
-	IIO_CHAN(IIO_IN, 0, 0, 0, "supply", 0, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 0, 0, "supply", 0, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		 in_supply, ADIS16204_SCAN_SUPPLY,
 		 IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		 in_aux, ADIS16204_SCAN_AUX_ADC,
 		 IIO_ST('u', 12, 16, 0), 0),
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 1824e72..d03ac01 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -358,7 +358,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
 	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
 		switch (chan->type) {
-		case IIO_IN:
+		case IIO_VOLTAGE:
 			*val = 0;
 			if (chan->channel == 0)
 				*val2 = 305180;
@@ -409,7 +409,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 }
 
 static struct iio_chan_spec adis16209_channels[] = {
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		 in_supply, ADIS16209_SCAN_SUPPLY,
 		 IIO_ST('u', 14, 16, 0), 0),
@@ -428,7 +428,7 @@ static struct iio_chan_spec adis16209_channels[] = {
 		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
 		 accel_y, ADIS16209_SCAN_ACC_Y,
 		 IIO_ST('s', 14, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		 in_aux, ADIS16209_SCAN_AUX_ADC,
 		 IIO_ST('u', 12, 16, 0), 0),
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 18b0830..15f5f30 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -529,7 +529,7 @@ static int adis16220_read_raw(struct iio_dev *indio_dev,
 		case IIO_ACCEL:
 			*val2 = 1887042;
 			return IIO_VAL_INT_PLUS_MICRO;
-		case IIO_IN:
+		case IIO_VOLTAGE:
 			if (chan->channel == 0)
 				*val2 = 0012221;
 			else /* Should really be dependent on VDD */
@@ -571,7 +571,7 @@ static int adis16220_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_chan_spec adis16220_channels[] = {
 	{
-		.type = IIO_IN,
+		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "supply",
@@ -591,14 +591,14 @@ static const struct iio_chan_spec adis16220_channels[] = {
 			     (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		.address = temp,
 	}, {
-		.type = IIO_IN,
+		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
 		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
 			     (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		.address = in_1,
 	}, {
-		.type = IIO_IN,
+		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 2,
 		.address = in_2,
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 6d3194f..ee1e873 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -392,7 +392,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
 	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
 		switch (chan->type) {
-		case IIO_IN:
+		case IIO_VOLTAGE:
 			*val = 0;
 			if (chan->channel == 0)
 				*val2 = 4880;
@@ -469,11 +469,11 @@ static int adis16240_write_raw(struct iio_dev *indio_dev,
 }
 
 static struct iio_chan_spec adis16240_channels[] = {
-	IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 0, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "supply", 0, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		 in_supply, ADIS16240_SCAN_SUPPLY,
 		 IIO_ST('u', 10, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 		 0,
 		 in_aux, ADIS16240_SCAN_AUX_ADC,
 		 IIO_ST('u', 10, 16, 0), 0),
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index 2a05651..eeee808 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -188,7 +188,7 @@ error_ret:
 static struct iio_chan_spec kxsd9_channels[] = {
 	KXSD9_ACCEL_CHAN(X), KXSD9_ACCEL_CHAN(Y), KXSD9_ACCEL_CHAN(Z),
 	{
-		.type = IIO_IN,
+		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.address = KXSD9_REG_AUX,
 	}
diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index d5102e5..8943420 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -473,7 +473,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 	if ((int_status & AD7150_STATUS_OUT1) &&
 	    !(chip->old_state & AD7150_STATUS_OUT1))
 		iio_push_event(indio_dev,
-			       IIO_UNMOD_EVENT_CODE(IIO_IN,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
 						    0,
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_RISING),
@@ -481,7 +481,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 	else if ((!(int_status & AD7150_STATUS_OUT1)) &&
 		 (chip->old_state & AD7150_STATUS_OUT1))
 		iio_push_event(indio_dev,
-			       IIO_UNMOD_EVENT_CODE(IIO_IN,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
 						    0,
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_FALLING),
@@ -490,7 +490,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 	if ((int_status & AD7150_STATUS_OUT2) &&
 	    !(chip->old_state & AD7150_STATUS_OUT2))
 		iio_push_event(indio_dev,
-			       IIO_UNMOD_EVENT_CODE(IIO_IN,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
 						    1,
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_RISING),
@@ -498,7 +498,7 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 	else if ((!(int_status & AD7150_STATUS_OUT2)) &&
 		 (chip->old_state & AD7150_STATUS_OUT2))
 		iio_push_event(indio_dev,
-			       IIO_UNMOD_EVENT_CODE(IIO_IN,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
 						    1,
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_FALLING),
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index c486d72..ba3f19f 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -192,14 +192,14 @@ static irqreturn_t ad7291_event_handler(int irq, void *private)
 	for (i = 0; i < AD7291_VOLTAGE_LIMIT_COUNT*2; i += 2) {
 		if (v_status & (1 << i))
 			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(IIO_IN,
+				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
 							    i/2,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_FALLING),
 				       timestamp);
 		if (v_status & (1 << (i + 1)))
 			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(IIO_IN,
+				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
 							    i/2,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_RISING),
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 7f08ffa..9ef3102 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -26,28 +26,28 @@ static struct iio_chan_spec ad7298_channels[] = {
 	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		 9, AD7298_CH_TEMP, IIO_ST('s', 32, 32, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 0, 0, IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 1, 1, IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 2, 2, IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 3, 3, IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 4, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 4, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 4, 4, IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 5, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 5, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 5, 5, IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 6, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 6, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 6, 6, IIO_ST('u', 12, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 7, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 7, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 7, 7, IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN_SOFT_TIMESTAMP(8),
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index ec75332..9b050ce 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -68,49 +68,49 @@ static int ad7476_read_raw(struct iio_dev *dev_info,
 
 static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 	[ID_AD7466] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 12, 16, 0), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7467] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 10, 16, 2), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7468] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1 , 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1 , 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 8, 16, 4), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7475] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 12, 16, 0), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7476] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 12, 16, 0), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7477] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 10, 16, 2), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7478] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 8, 16, 4), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7495] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 12, 16, 0), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index c3ce74c..17cdafb 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -234,66 +234,66 @@ static const struct attribute_group ad7606_attribute_group = {
 };
 
 static struct iio_chan_spec ad7606_8_channels[] = {
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 0, 0, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 1, 1, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 2, 2, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 3, 3, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 4, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 4, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 4, 4, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 5, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 5, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 5, 5, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 6, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 6, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 6, 6, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 7, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 7, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 7, 7, IIO_ST('s', 16, 16, 0), 0),
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
 static struct iio_chan_spec ad7606_6_channels[] = {
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 0, 0, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 1, 1, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 2, 2, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 3, 3, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 4, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 4, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 4, 4, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 5, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 5, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 5, 5, IIO_ST('s', 16, 16, 0), 0),
 	IIO_CHAN_SOFT_TIMESTAMP(6),
 };
 
 static struct iio_chan_spec ad7606_4_channels[] = {
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 0, 0, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 1, 1, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 2, 2, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
 		 3, 3, IIO_ST('s', 16, 16, 0), 0),
 	IIO_CHAN_SOFT_TIMESTAMP(4),
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 4b6f8c6..a8103c0 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -126,12 +126,12 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7780] = {
-		.channel = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				    0, 0, IIO_ST('s', 24, 32, 8), 0),
 	},
 	[ID_AD7781] = {
-		.channel = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				    0, 0, IIO_ST('s', 20, 32, 12), 0),
 	},
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 788ee08..0a536c5 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -674,7 +674,7 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
 
 	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
 		switch (chan->type) {
-		case IIO_IN:
+		case IIO_VOLTAGE:
 			/* 1170mV / 2^23 * 6 */
 			scale_uv = (1170ULL * 100000000ULL * 6ULL)
 				>> (chan->scan_type.realbits -
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 465d715..71af6cb 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -71,11 +71,11 @@ static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
 	 * More devices added in future
 	 */
 	[ID_AD7887] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       1, 1, IIO_ST('u', 12, 16, 0), 0),
 
-		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[1] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 12, 16, 0), 0),
 
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index b8efd59..b6662db 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -336,11 +336,11 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
 		if (status & (1 << i))
 			iio_push_event(indio_dev,
 				       i & 0x1 ?
-				       IIO_UNMOD_EVENT_CODE(IIO_IN,
+				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
 							    (i >> 1),
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_RISING) :
-				       IIO_UNMOD_EVENT_CODE(IIO_IN,
+				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
 							    (i >> 1),
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_FALLING),
@@ -486,16 +486,16 @@ static const struct iio_info ad7993_4_7_8_info = {
 
 static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	[ad7991] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 12, 16, 0), 0),
-		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		.channel[1] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       1, 1, IIO_ST('u', 12, 16, 0), 0),
-		.channel[2] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+		.channel[2] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       2, 2, IIO_ST('u', 12, 16, 0), 0),
-		.channel[3] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+		.channel[3] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       3, 3, IIO_ST('u', 12, 16, 0), 0),
 		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
@@ -504,16 +504,16 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.info = &ad7991_info,
 	},
 	[ad7995] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 10, 16, 0), 0),
-		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		.channel[1] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       1, 1, IIO_ST('u', 10, 16, 0), 0),
-		.channel[2] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+		.channel[2] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       2, 2, IIO_ST('u', 10, 16, 0), 0),
-		.channel[3] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+		.channel[3] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       3, 3, IIO_ST('u', 10, 16, 0), 0),
 		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
@@ -522,16 +522,16 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.info = &ad7991_info,
 	},
 	[ad7999] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 10, 16, 0), 0),
-		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		.channel[1] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       1, 1, IIO_ST('u', 10, 16, 0), 0),
-		.channel[2] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+		.channel[2] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       2, 2, IIO_ST('u', 10, 16, 0), 0),
-		.channel[3] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+		.channel[3] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       3, 3, IIO_ST('u', 10, 16, 0), 0),
 		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
@@ -540,10 +540,10 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.info = &ad7991_info,
 	},
 	[ad7992] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 12, 16, 0), 0),
-		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		.channel[1] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       1, 1, IIO_ST('u', 12, 16, 0), 0),
 		.channel[2] = IIO_CHAN_SOFT_TIMESTAMP(2),
@@ -553,16 +553,16 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.info = &ad7992_info,
 	},
 	[ad7993] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 10, 16, 0), 0),
-		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		.channel[1] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       1, 1, IIO_ST('u', 10, 16, 0), 0),
-		.channel[2] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+		.channel[2] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       2, 2, IIO_ST('u', 10, 16, 0), 0),
-		.channel[3] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+		.channel[3] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       3, 3, IIO_ST('u', 10, 16, 0), 0),
 		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
@@ -572,16 +572,16 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.info = &ad7993_4_7_8_info,
 	},
 	[ad7994] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 12, 16, 0), 0),
-		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		.channel[1] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       1, 1, IIO_ST('u', 12, 16, 0), 0),
-		.channel[2] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+		.channel[2] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       2, 2, IIO_ST('u', 12, 16, 0), 0),
-		.channel[3] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+		.channel[3] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       3, 3, IIO_ST('u', 12, 16, 0), 0),
 		.channel[4] = IIO_CHAN_SOFT_TIMESTAMP(4),
@@ -591,28 +591,28 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.info = &ad7993_4_7_8_info,
 	},
 	[ad7997] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
 					  0, 0, IIO_ST('u', 10, 16, 0), 0),
-		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		.channel[1] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
 					  1, 1, IIO_ST('u', 10, 16, 0), 0),
-		.channel[2] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+		.channel[2] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
 					  2, 2, IIO_ST('u', 10, 16, 0), 0),
-		.channel[3] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+		.channel[3] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
 					  3, 3, IIO_ST('u', 10, 16, 0), 0),
-		.channel[4] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 4, 0,
+		.channel[4] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 4, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
 					  4, 4, IIO_ST('u', 10, 16, 0), 0),
-		.channel[5] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 5, 0,
+		.channel[5] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 5, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
 					  5, 5, IIO_ST('u', 10, 16, 0), 0),
-		.channel[6] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 6, 0,
+		.channel[6] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 6, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
 					  6, 6, IIO_ST('u', 10, 16, 0), 0),
-		.channel[7] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 7, 0,
+		.channel[7] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 7, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
 					  7, 7, IIO_ST('u', 10, 16, 0), 0),
 		.channel[8] = IIO_CHAN_SOFT_TIMESTAMP(8),
@@ -622,28 +622,28 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 		.info = &ad7993_4_7_8_info,
 	},
 	[ad7998] = {
-		.channel[0] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 0, 0,
+		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       0, 0, IIO_ST('u', 12, 16, 0), 0),
-		.channel[1] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		.channel[1] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       1, 1, IIO_ST('u', 12, 16, 0), 0),
-		.channel[2] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 2, 0,
+		.channel[2] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       2, 2, IIO_ST('u', 12, 16, 0), 0),
-		.channel[3] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 3, 0,
+		.channel[3] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       3, 3, IIO_ST('u', 12, 16, 0), 0),
-		.channel[4] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 4, 0,
+		.channel[4] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 4, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       4, 4, IIO_ST('u', 12, 16, 0), 0),
-		.channel[5] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 5, 0,
+		.channel[5] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 5, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       5, 5, IIO_ST('u', 12, 16, 0), 0),
-		.channel[6] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 6, 0,
+		.channel[6] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 6, 0,
 				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
 				       6, 6, IIO_ST('u', 12, 16, 0), 0),
-		.channel[7] = IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 7, 0,
+		.channel[7] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 7, 0,
 					  (1 << IIO_CHAN_INFO_SCALE_SHARED),
 					  7, 7, IIO_ST('u', 12, 16, 0), 0),
 		.channel[8] = IIO_CHAN_SOFT_TIMESTAMP(8),
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 2abcc32..e962f84 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -574,14 +574,22 @@ static int max1363_write_thresh(struct iio_dev *indio_dev,
 }
 
 static const u64 max1363_event_codes[] = {
-	IIO_UNMOD_EVENT_CODE(IIO_IN, 0, IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
-	IIO_UNMOD_EVENT_CODE(IIO_IN, 1, IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
-	IIO_UNMOD_EVENT_CODE(IIO_IN, 2, IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
-	IIO_UNMOD_EVENT_CODE(IIO_IN, 3, IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
-	IIO_UNMOD_EVENT_CODE(IIO_IN, 0, IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
-	IIO_UNMOD_EVENT_CODE(IIO_IN, 1, IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
-	IIO_UNMOD_EVENT_CODE(IIO_IN, 2, IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
-	IIO_UNMOD_EVENT_CODE(IIO_IN, 3, IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+	IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
+	IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 1,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
+	IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 2,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
+	IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 3,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
+	IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+	IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 1,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+	IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 2,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
+	IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 3,
+			     IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
 };
 
 static irqreturn_t max1363_event_handler(int irq, void *private)
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 17b6c13..d37726e 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1802,19 +1802,19 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
 				       time);
 		if (stat1 & (1 << 5))
 			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(IIO_IN, 1,
+				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 1,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_EITHER),
 				       time);
 		if (stat1 & (1 << 6))
 			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(IIO_IN, 2,
+				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 2,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_EITHER),
 				       time);
 		if (stat1 & (1 << 7))
 			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(IIO_IN, 3,
+				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 3,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_EITHER),
 				       time);
@@ -1823,7 +1823,7 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
 	if (!ret) {
 		if (stat2 & ADT7316_INT_MASK2_VDD)
 			iio_push_event(indio_dev,
-				       IIO_UNMOD_EVENT_CODE(IIO_IN,
+				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
 							    0,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_RISING),
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 4810805..f812991 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -122,12 +122,12 @@ static const struct iio_chan_spec adis16060_channels[] = {
 		.channel2 = IIO_MOD_Z,
 		.address = ADIS16060_GYRO,
 	}, {
-		.type = IIO_IN,
+		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 0,
 		.address = ADIS16060_AIN1,
 	}, {
-		.type = IIO_IN,
+		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
 		.address = ADIS16060_AIN2,
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 826f8f1..a2ee9be 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -113,12 +113,12 @@ static const struct iio_chan_spec adis16080_channels[] = {
 		.channel2 = IIO_MOD_Z,
 		.address = ADIS16080_DIN_GYRO,
 	}, {
-		.type = IIO_IN,
+		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 0,
 		.address = ADIS16080_DIN_AIN1,
 	}, {
-		.type = IIO_IN,
+		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
 		.address = ADIS16080_DIN_AIN2,
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 2ad43a8..efbee27 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -405,11 +405,11 @@ enum adis16260_channel {
 			 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),		\
 			 temp, ADIS16260_SCAN_TEMP,			\
 			 IIO_ST('u', 12, 16, 0), 0),			\
-		IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 0, 0,		\
+		IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "supply", 0, 0,		\
 			 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),		\
 			 in_supply, ADIS16260_SCAN_SUPPLY,		\
 			 IIO_ST('u', 12, 16, 0), 0),			\
-		IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,			\
+		IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,		\
 			 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),		\
 			 in_aux, ADIS16260_SCAN_AUX_ADC,		\
 			 IIO_ST('u', 12, 16, 0), 0),			\
@@ -475,7 +475,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 			else
 				*val2 = 1278;
 			return IIO_VAL_INT_PLUS_MICRO;
-		case IIO_IN:
+		case IIO_VOLTAGE:
 			*val = 0;
 			if (chan->channel == 0)
 				*val2 = 18315;
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 4851d6f..2a6c673 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -44,10 +44,6 @@ enum iio_chan_type {
 	IIO_CAPACITANCE,
 };
 
-/* Nasty hack to avoid massive churn */
-#define	IIO_IN IIO_VOLTAGE
-#define	IIO_IN_DIFF IIO_VOLTAGE_DIFF
-
 enum iio_modifier {
 	IIO_NO_MOD,
 	IIO_MOD_X,
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 929da9b..eab288e 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -111,10 +111,10 @@ static struct iio_chan_spec ad5933_channels[] = {
 	IIO_CHAN(IIO_TEMP, 0, 1, 1, NULL, 0, 0, 0,
 		 0, AD5933_REG_TEMP_DATA, IIO_ST('s', 14, 16, 0), 0),
 	/* Ring Channels */
-	IIO_CHAN(IIO_IN, 0, 1, 0, "real_raw", 0, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "real_raw", 0, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		 AD5933_REG_REAL_DATA, 0, IIO_ST('s', 16, 16, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, "imag_raw", 0, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "imag_raw", 0, 0,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
 		 AD5933_REG_IMAG_DATA, 1, IIO_ST('s', 16, 16, 0), 0),
 };
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index d99c56a..0e62d5e 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -511,7 +511,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 			*val = 0;
 			*val2 = st->variant->gyro_scale_micro;
 			return IIO_VAL_INT_PLUS_MICRO;
-		case IIO_IN:
+		case IIO_VOLTAGE:
 			*val = 0;
 			if (chan->channel == 0)
 				*val2 = 2418;
@@ -652,7 +652,7 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.scan_index = ADIS16400_SCAN_TEMP,
 		.scan_type = IIO_ST('s', 12, 16, 0),
 	}, {
-		.type = IIO_IN,
+		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
 		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
@@ -758,7 +758,7 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.scan_index = ADIS16350_SCAN_TEMP_Z,
 		.scan_type = IIO_ST('s', 12, 16, 0),
 	}, {
-		.type = IIO_IN,
+		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
 		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
@@ -825,7 +825,7 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.scan_index = ADIS16400_SCAN_TEMP,
 		.scan_type = IIO_ST('s', 12, 16, 0),
 	}, {
-		.type = IIO_IN,
+		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
 		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index bedd378..3f31368 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -663,7 +663,7 @@ static const struct attribute_group ade7758_attribute_group = {
 };
 
 static struct iio_chan_spec ade7758_channels[] = {
-	IIO_CHAN(IIO_IN, 0, 1, 0, "raw", 0, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "raw", 0, 0,
 		(1 << IIO_CHAN_INFO_SCALE_SHARED),
 		AD7758_WT(AD7758_PHASE_A, AD7758_VOLTAGE),
 		0, IIO_ST('s', 24, 32, 0), 0),
@@ -683,7 +683,7 @@ static struct iio_chan_spec ade7758_channels[] = {
 		(1 << IIO_CHAN_INFO_SCALE_SHARED),
 		AD7758_WT(AD7758_PHASE_A, AD7758_REACT_PWR),
 		4, IIO_ST('s', 24, 32, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, "raw", 1, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "raw", 1, 0,
 		(1 << IIO_CHAN_INFO_SCALE_SHARED),
 		AD7758_WT(AD7758_PHASE_B, AD7758_VOLTAGE),
 		5, IIO_ST('s', 24, 32, 0), 0),
@@ -703,7 +703,7 @@ static struct iio_chan_spec ade7758_channels[] = {
 		(1 << IIO_CHAN_INFO_SCALE_SHARED),
 		AD7758_WT(AD7758_PHASE_B, AD7758_REACT_PWR),
 		9, IIO_ST('s', 24, 32, 0), 0),
-	IIO_CHAN(IIO_IN, 0, 1, 0, "raw", 2, 0,
+	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "raw", 2, 0,
 		(1 << IIO_CHAN_INFO_SCALE_SHARED),
 		AD7758_WT(AD7758_PHASE_C, AD7758_VOLTAGE),
 		10, IIO_ST('s', 24, 32, 0), 0),
-- 
1.7.3.4
