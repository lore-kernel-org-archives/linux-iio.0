Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:60349 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab1JUPjg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2011 11:39:36 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, michael.hennerich@analog.com,
	device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:treewide only use shared to decide on interfaces
Date: Fri, 21 Oct 2011 16:39:39 +0100
Message-Id: <1319211579-14367-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319211579-14367-1-git-send-email-jic23@cam.ac.uk>
References: <1319211579-14367-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Internally the fact that say scale is shared across channels is
actually of remarkably little interest.  Hence lets not store it.
Numerous devices have weird combinations of channels sharing
scale anyway so it is not as though this was really telling
us much. Note however that we do still use the shared sysfs
attrs thus massively reducing the number of attrs in complex
drivers.

Side effect is that certain drivers that were abusing this
(mostly my work) needed to do a few more checks on what the
channel they are being queried on actually is.

This is also helpful for in kernel interfaces where we
just want to query the scale and don't care whether it
is shared with other channels or not.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_core.c      |   33 +++---
 drivers/staging/iio/accel/adis16203_core.c      |   21 ++--
 drivers/staging/iio/accel/adis16204_core.c      |   32 +++---
 drivers/staging/iio/accel/adis16209_core.c      |   29 +++---
 drivers/staging/iio/accel/adis16220_core.c      |   22 ++--
 drivers/staging/iio/accel/adis16240_core.c      |   29 +++---
 drivers/staging/iio/accel/kxsd9.c               |    6 +-
 drivers/staging/iio/accel/lis3l02dq_core.c      |   16 ++--
 drivers/staging/iio/accel/sca3000_core.c        |    4 +-
 drivers/staging/iio/adc/ad7192.c                |   34 +++---
 drivers/staging/iio/adc/ad7280a.c               |    6 +-
 drivers/staging/iio/adc/ad7291.c                |   38 ++++---
 drivers/staging/iio/adc/ad7298_core.c           |   41 ++++---
 drivers/staging/iio/adc/ad7476_core.c           |   18 ++--
 drivers/staging/iio/adc/ad7606_core.c           |    2 +-
 drivers/staging/iio/adc/ad7780.c                |    6 +-
 drivers/staging/iio/adc/ad7793.c                |   50 ++++----
 drivers/staging/iio/adc/ad7887_core.c           |    6 +-
 drivers/staging/iio/adc/ad799x_core.c           |    2 +-
 drivers/staging/iio/adc/max1363_core.c          |    4 +-
 drivers/staging/iio/cdc/ad7150.c                |    6 +-
 drivers/staging/iio/cdc/ad7152.c                |   38 +++---
 drivers/staging/iio/cdc/ad7746.c                |   50 ++++----
 drivers/staging/iio/dac/ad5064.c                |    4 +-
 drivers/staging/iio/dac/ad5360.c                |   22 ++--
 drivers/staging/iio/dac/ad5686.c                |    4 +-
 drivers/staging/iio/dac/ad5791.c                |    8 +-
 drivers/staging/iio/gyro/adis16060_core.c       |    8 +-
 drivers/staging/iio/gyro/adis16260_core.c       |   27 ++---
 drivers/staging/iio/gyro/adxrs450_core.c        |    8 +-
 drivers/staging/iio/iio.h                       |   62 +++++++---
 drivers/staging/iio/iio_simple_dummy.c          |   43 ++++---
 drivers/staging/iio/impedance-analyzer/ad5933.c |    4 +-
 drivers/staging/iio/imu/adis16400_core.c        |  143 +++++++++++------------
 drivers/staging/iio/industrialio-core.c         |   19 ++--
 drivers/staging/iio/light/isl29018.c            |    7 +-
 drivers/staging/iio/light/tsl2563.c             |    6 +-
 drivers/staging/iio/magnetometer/ak8975.c       |    4 +-
 drivers/staging/iio/magnetometer/hmc5843.c      |    4 +-
 drivers/staging/iio/meter/ade7758_core.c        |   30 +++---
 40 files changed, 468 insertions(+), 428 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index f1c0602..d3d877f 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -322,8 +322,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			*val = 0;
@@ -348,10 +347,10 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 		break;
-	case IIO_CHAN_INFO_OFFSET_SEPARATE:
+	case IIO_CHAN_INFO_OFFSET:
 		*val = 25;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
 		case IIO_ACCEL:
 			bits = 12;
@@ -388,7 +387,7 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 	s16 val16;
 	u8 addr;
 	switch (mask) {
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
 		case IIO_ACCEL:
 			bits = 12;
@@ -408,36 +407,36 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 
 static struct iio_chan_spec adis16201_channels[] = {
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "supply", 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		 in_supply, ADIS16201_SCAN_SUPPLY,
 		 IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		 IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
 		 temp, ADIS16201_SCAN_TEMP,
 		 IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		 accel_x, ADIS16201_SCAN_ACC_X,
 		 IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		 accel_y, ADIS16201_SCAN_ACC_Y,
 		 IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		 in_aux, ADIS16201_SCAN_AUX_ADC,
 		 IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		 incli_x, ADIS16201_SCAN_INCLI_X,
 		 IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		 incli_y, ADIS16201_SCAN_INCLI_Y,
 		 IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN_SOFT_TIMESTAMP(7)
diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index 5bf944b..bdc44fe 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -329,8 +329,7 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			*val = 0;
@@ -350,10 +349,10 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-	case IIO_CHAN_INFO_OFFSET_SEPARATE:
+	case IIO_CHAN_INFO_OFFSET:
 		*val = 25;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		bits = 14;
 		mutex_lock(&indio_dev->mlock);
 		addr = adis16203_addresses[chan->address][1];
@@ -374,26 +373,26 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 
 static struct iio_chan_spec adis16203_channels[] = {
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "supply", 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		 in_supply, ADIS16203_SCAN_SUPPLY,
 		 IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		 in_aux, ADIS16203_SCAN_AUX_ADC,
 		 IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		 incli_x, ADIS16203_SCAN_INCLI_X,
 		 IIO_ST('s', 14, 16, 0), 0),
 	/* Fixme: Not what it appears to be - see data sheet */
 	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		 incli_y, ADIS16203_SCAN_INCLI_Y,
 		 IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		 IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
 		 temp, ADIS16203_SCAN_TEMP,
 		 IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN_SOFT_TIMESTAMP(5),
diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 068f543..96d8c7b 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -366,7 +366,7 @@ static int adis16204_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			*val = 0;
@@ -390,12 +390,12 @@ static int adis16204_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 		break;
-	case IIO_CHAN_INFO_OFFSET_SEPARATE:
+	case IIO_CHAN_INFO_OFFSET:
 		*val = 25;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
-	case IIO_CHAN_INFO_PEAK_SEPARATE:
-		if (mask == IIO_CHAN_INFO_CALIBBIAS_SEPARATE) {
+	case IIO_CHAN_INFO_CALIBBIAS:
+	case IIO_CHAN_INFO_PEAK:
+		if (mask == IIO_CHAN_INFO_CALIBBIAS) {
 			bits = 12;
 			addrind = 1;
 		} else { /* PEAK_SEPARATE */
@@ -428,7 +428,7 @@ static int adis16204_write_raw(struct iio_dev *indio_dev,
 	s16 val16;
 	u8 addr;
 	switch (mask) {
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
 		case IIO_ACCEL:
 			bits = 12;
@@ -445,28 +445,28 @@ static int adis16204_write_raw(struct iio_dev *indio_dev,
 
 static struct iio_chan_spec adis16204_channels[] = {
 	IIO_CHAN(IIO_VOLTAGE, 0, 0, 0, "supply", 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		 in_supply, ADIS16204_SCAN_SUPPLY,
 		 IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		 in_aux, ADIS16204_SCAN_AUX_ADC,
 		 IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		 IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
 		 temp, ADIS16204_SCAN_TEMP,
 		 IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_PEAK_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		 IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
 		 accel_x, ADIS16204_SCAN_ACC_X,
 		 IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_PEAK_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		 IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
 		 accel_y, ADIS16204_SCAN_ACC_Y,
 		 IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN_SOFT_TIMESTAMP(5),
diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index 57540f1..62e6bd8 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -304,7 +304,7 @@ static int adis16209_write_raw(struct iio_dev *indio_dev,
 	s16 val16;
 	u8 addr;
 	switch (mask) {
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
 		case IIO_ACCEL:
 		case IIO_INCLI:
@@ -355,8 +355,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			*val = 0;
@@ -381,10 +380,10 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 		break;
-	case IIO_CHAN_INFO_OFFSET_SEPARATE:
+	case IIO_CHAN_INFO_OFFSET:
 		*val = 25;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
 		case IIO_ACCEL:
 			bits = 14;
@@ -410,34 +409,34 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
 
 static struct iio_chan_spec adis16209_channels[] = {
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		 in_supply, ADIS16209_SCAN_SUPPLY,
 		 IIO_ST('u', 14, 16, 0), 0),
 	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+		 IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
 		 temp, ADIS16209_SCAN_TEMP,
 		 IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		 accel_x, ADIS16209_SCAN_ACC_X,
 		 IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		 accel_y, ADIS16209_SCAN_ACC_Y,
 		 IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		 in_aux, ADIS16209_SCAN_AUX_ADC,
 		 IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		 incli_x, ADIS16209_SCAN_INCLI_X,
 		 IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_INCLI, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		 incli_y, ADIS16209_SCAN_INCLI_Y,
 		 IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_ROT, 0, 1, 0, NULL, 0, IIO_MOD_X,
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 284f810..ca18f72 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -510,17 +510,17 @@ static int adis16220_read_raw(struct iio_dev *indio_dev,
 	case 0:
 		addrind = 0;
 		break;
-	case IIO_CHAN_INFO_OFFSET_SEPARATE:
+	case IIO_CHAN_INFO_OFFSET:
 		if (chan->type == IIO_TEMP) {
 			*val = 25;
 			return IIO_VAL_INT;
 		}
 		addrind = 1;
 		break;
-	case IIO_CHAN_INFO_PEAK_SEPARATE:
+	case IIO_CHAN_INFO_PEAK:
 		addrind = 2;
 		break;
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		switch (chan->type) {
 		case IIO_TEMP:
@@ -575,27 +575,27 @@ static const struct iio_chan_spec adis16220_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "supply",
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_supply,
 	}, {
 		.type = IIO_ACCEL,
-		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-			     (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
-			     (1 << IIO_CHAN_INFO_PEAK_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
+			     IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
 		.address = accel,
 	}, {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-			     (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = temp,
 	}, {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-			     (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+			     IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_1,
 	}, {
 		.type = IIO_VOLTAGE,
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 482a762..1348393 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -389,8 +389,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			*val = 0;
@@ -411,14 +410,14 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 		break;
-	case IIO_CHAN_INFO_PEAK_SCALE_SHARED:
+	case IIO_CHAN_INFO_PEAK_SCALE:
 		*val = 6;
 		*val2 = 629295;
 		return IIO_VAL_INT_PLUS_MICRO;
-	case IIO_CHAN_INFO_OFFSET_SEPARATE:
+	case IIO_CHAN_INFO_OFFSET:
 		*val = 25;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		bits = 10;
 		mutex_lock(&indio_dev->mlock);
 		addr = adis16240_addresses[chan->address][1];
@@ -432,7 +431,7 @@ static int adis16240_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_PEAK_SEPARATE:
+	case IIO_CHAN_INFO_PEAK:
 		bits = 10;
 		mutex_lock(&indio_dev->mlock);
 		addr = adis16240_addresses[chan->address][2];
@@ -460,7 +459,7 @@ static int adis16240_write_raw(struct iio_dev *indio_dev,
 	s16 val16;
 	u8 addr;
 	switch (mask) {
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		val16 = val & ((1 << bits) - 1);
 		addr = adis16240_addresses[chan->address][1];
 		return adis16240_spi_write_reg_16(indio_dev, addr, val16);
@@ -470,7 +469,7 @@ static int adis16240_write_raw(struct iio_dev *indio_dev,
 
 static struct iio_chan_spec adis16240_channels[] = {
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "supply", 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		 in_supply, ADIS16240_SCAN_SUPPLY,
 		 IIO_ST('u', 10, 16, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
@@ -478,22 +477,22 @@ static struct iio_chan_spec adis16240_channels[] = {
 		 in_aux, ADIS16240_SCAN_AUX_ADC,
 		 IIO_ST('u', 10, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		 accel_x, ADIS16240_SCAN_ACC_X,
 		 IIO_ST('s', 10, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		 accel_y, ADIS16240_SCAN_ACC_Y,
 		 IIO_ST('s', 10, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED) |
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		 accel_z, ADIS16240_SCAN_ACC_Z,
 		 IIO_ST('s', 10, 16, 0), 0),
 	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		 temp, ADIS16240_SCAN_TEMP,
 		 IIO_ST('u', 10, 16, 0), 0),
 	IIO_CHAN_SOFT_TIMESTAMP(6)
diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index 0ea0b5c..abb6071 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -140,7 +140,7 @@ static int kxsd9_write_raw(struct iio_dev *indio_dev,
 {
 	int ret = -EINVAL;
 
-	if (mask == IIO_CHAN_INFO_SCALE_SHARED) {
+	if (mask == IIO_CHAN_INFO_SCALE) {
 		/* Check no integer component */
 		if (val)
 			return -EINVAL;
@@ -164,7 +164,7 @@ static int kxsd9_read_raw(struct iio_dev *indio_dev,
 			goto error_ret;
 		*val = ret;
 		break;
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
 		if (ret)
 			goto error_ret;
@@ -181,7 +181,7 @@ error_ret:
 		.type = IIO_ACCEL,					\
 		.modified = 1,						\
 		.channel2 = IIO_MOD_##axis,				\
-		.info_mask = 1 << IIO_CHAN_INFO_SCALE_SHARED,		\
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
 		.address = KXSD9_REG_##axis,				\
 	}
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index d7706eb..6d715a6 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -227,14 +227,14 @@ static int lis3l02dq_write_raw(struct iio_dev *indio_dev,
 	u8 uval;
 	s8 sval;
 	switch (mask) {
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		if (val > 255 || val < -256)
 			return -EINVAL;
 		sval = val;
 		reg = lis3l02dq_axis_map[LIS3L02DQ_BIAS][chan->address];
 		ret = lis3l02dq_spi_write_reg_8(indio_dev, reg, sval);
 		break;
-	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
+	case IIO_CHAN_INFO_CALIBSCALE:
 		if (val & ~0xFF)
 			return -EINVAL;
 		uval = val;
@@ -272,11 +272,11 @@ static int lis3l02dq_read_raw(struct iio_dev *indio_dev,
 		}
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		*val2 = 9580;
 		return IIO_VAL_INT_PLUS_MICRO;
-	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
+	case IIO_CHAN_INFO_CALIBSCALE:
 		reg = lis3l02dq_axis_map[LIS3L02DQ_GAIN][chan->address];
 		ret = lis3l02dq_spi_read_reg_8(indio_dev, reg, &utemp);
 		if (ret)
@@ -285,7 +285,7 @@ static int lis3l02dq_read_raw(struct iio_dev *indio_dev,
 		*val = utemp;
 		return IIO_VAL_INT;
 
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		reg = lis3l02dq_axis_map[LIS3L02DQ_BIAS][chan->address];
 		ret = lis3l02dq_spi_read_reg_8(indio_dev, reg, (u8 *)&stemp);
 		/* to match with what previous code does */
@@ -516,9 +516,9 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 }
 
 #define LIS3L02DQ_INFO_MASK				\
-	((1 << IIO_CHAN_INFO_SCALE_SHARED) |		\
-	 (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |	\
-	 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE))
+	(IIO_CHAN_INFO_SCALE_SHARED_BIT |		\
+	 IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |	\
+	 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT)
 
 #define LIS3L02DQ_EVENT_MASK					\
 	(IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |	\
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 1586963..021a08f 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -425,7 +425,7 @@ static IIO_DEVICE_ATTR(measurement_mode, S_IRUGO | S_IWUSR,
 static IIO_DEVICE_ATTR(revision, S_IRUGO, sca3000_show_rev, NULL, 0);
 
 #define SCA3000_INFO_MASK			\
-	(1 << IIO_CHAN_INFO_SCALE_SHARED)
+	IIO_CHAN_INFO_SCALE_SHARED_BIT
 #define SCA3000_EVENT_MASK					\
 	(IIO_EV_BIT(IIO_EV_TYPE_MAG, IIO_EV_DIR_RISING))
 
@@ -475,7 +475,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 			(sizeof(*val)*8 - 13);
 		mutex_unlock(&st->lock);
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		if (chan->type == IIO_ACCEL)
 			*val2 = st->info->scale;
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 4674c2a..1dd0f9f 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -901,18 +901,20 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 		}
 		return IIO_VAL_INT;
 
-	case IIO_CHAN_INFO_SCALE_SHARED:
-		mutex_lock(&indio_dev->mlock);
-		*val = st->scale_avail[AD7192_CONF_GAIN(st->conf)][0];
-		*val2 = st->scale_avail[AD7192_CONF_GAIN(st->conf)][1];
-		mutex_unlock(&indio_dev->mlock);
-
-		return IIO_VAL_INT_PLUS_NANO;
-
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
-		*val =  1000;
-
-		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			mutex_lock(&indio_dev->mlock);
+			*val = st->scale_avail[AD7192_CONF_GAIN(st->conf)][0];
+			*val2 = st->scale_avail[AD7192_CONF_GAIN(st->conf)][1];
+			mutex_unlock(&indio_dev->mlock);
+			return IIO_VAL_INT_PLUS_NANO;
+		case IIO_TEMP:
+			*val =  1000;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	}
 
 	return -EINVAL;
@@ -935,7 +937,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 	}
 
 	switch (mask) {
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		ret = -EINVAL;
 		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
 			if (val2 == st->scale_avail[i][1]) {
@@ -992,7 +994,7 @@ static const struct iio_info ad7192_info = {
 	  .extend_name = _name,						\
 	  .channel = _chan,						\
 	  .channel2 = _chan2,						\
-	  .info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),		\
+	  .info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
 	  .address = _address,						\
 	  .scan_index = _si,						\
 	  .scan_type =  IIO_ST('s', 24, 32, 0)}
@@ -1001,7 +1003,7 @@ static const struct iio_info ad7192_info = {
 	{ .type = IIO_VOLTAGE,						\
 	  .indexed = 1,							\
 	  .channel = _chan,						\
-	  .info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),		\
+	  .info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
 	  .address = _address,						\
 	  .scan_index = _si,						\
 	  .scan_type =  IIO_ST('s', 24, 32, 0)}
@@ -1010,7 +1012,7 @@ static const struct iio_info ad7192_info = {
 	{ .type = IIO_TEMP,						\
 	  .indexed = 1,							\
 	  .channel = _chan,						\
-	  .info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),		\
+	  .info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
 	  .address = _address,						\
 	  .scan_index = _si,						\
 	  .scan_type =  IIO_ST('s', 24, 32, 0)}
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 5397ba8..2b7cb52 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -508,7 +508,7 @@ static int ad7280_channel_init(struct ad7280_state *st)
 			}
 			st->channels[cnt].indexed = 1;
 			st->channels[cnt].info_mask =
-				(1 << IIO_CHAN_INFO_SCALE_SHARED);
+				IIO_CHAN_INFO_SCALE_SHARED_BIT;
 			st->channels[cnt].address =
 				AD7280A_DEVADDR(dev) << 8 | ch;
 			st->channels[cnt].scan_index = cnt;
@@ -524,7 +524,7 @@ static int ad7280_channel_init(struct ad7280_state *st)
 	st->channels[cnt].channel2 = dev * 6;
 	st->channels[cnt].address = AD7280A_ALL_CELLS;
 	st->channels[cnt].indexed = 1;
-	st->channels[cnt].info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED);
+	st->channels[cnt].info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT;
 	st->channels[cnt].scan_index = cnt;
 	st->channels[cnt].scan_type.sign = 'u';
 	st->channels[cnt].scan_type.realbits = 32;
@@ -802,7 +802,7 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6)
 			scale_uv = (4000 * 1000) >> AD7280A_BITS;
 		else
diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index bedd91a..c4977a7 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -501,7 +501,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-	case IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE:
+	case IIO_CHAN_INFO_AVERAGE_RAW:
 		ret = i2c_smbus_read_word_data(chip->client,
 					       AD7291_T_AVERAGE);
 			if (ret < 0)
@@ -510,18 +510,24 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 				AD7291_VALUE_MASK) << 4) >> 4;
 			*val = signval;
 			return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SHARED:
-		scale_uv = (chip->int_vref_mv * 1000) >> AD7291_BITS;
-		*val =  scale_uv / 1000;
-		*val2 = (scale_uv % 1000) * 1000;
-		return IIO_VAL_INT_PLUS_MICRO;
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
-		/*
-		* One LSB of the ADC corresponds to 0.25 deg C.
-		* The temperature reading is in 12-bit twos complement format
-		*/
-		*val = 250;
-		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			scale_uv = (chip->int_vref_mv * 1000) >> AD7291_BITS;
+			*val =  scale_uv / 1000;
+			*val2 = (scale_uv % 1000) * 1000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_TEMP:
+			/*
+			 * One LSB of the ADC corresponds to 0.25 deg C.
+			 * The temperature reading is in 12-bit twos
+			 * complement format
+			 */
+			*val = 250;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -530,7 +536,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 #define AD7291_VOLTAGE_CHAN(_chan)					\
 {									\
 	.type = IIO_VOLTAGE,						\
-	.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),			\
+	.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,			\
 	.indexed = 1,							\
 	.channel = _chan,						\
 	.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING)|\
@@ -548,8 +554,8 @@ static const struct iio_chan_spec ad7291_channels[] = {
 	AD7291_VOLTAGE_CHAN(7),
 	{
 		.type = IIO_TEMP,
-		.info_mask = (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE) |
-				(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE_BIT |
+				IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.indexed = 1,
 		.channel = 0,
 		.event_mask =
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 2e3b0d9..0be71df 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -24,31 +24,31 @@
 
 static struct iio_chan_spec ad7298_channels[] = {
 	IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		 9, AD7298_CH_TEMP, IIO_ST('s', 32, 32, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		 0, 0, IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		 1, 1, IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 2, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		 2, 2, IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 3, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		 3, 3, IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 4, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		 4, 4, IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 5, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		 5, 5, IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 6, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		 6, 6, IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 7, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		 7, 7, IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
@@ -143,15 +143,20 @@ static int ad7298_read_raw(struct iio_dev *indio_dev,
 			*val = ret & RES_MASK(AD7298_BITS);
 
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SHARED:
-		scale_uv = (st->int_vref_mv * 1000) >> AD7298_BITS;
-		*val =  scale_uv / 1000;
-		*val2 = (scale_uv % 1000) * 1000;
-		return IIO_VAL_INT_PLUS_MICRO;
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
-		*val =  1;
-		*val2 = 0;
-		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			scale_uv = (st->int_vref_mv * 1000) >> AD7298_BITS;
+			*val =  scale_uv / 1000;
+			*val2 = (scale_uv % 1000) * 1000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_TEMP:
+			*val =  1;
+			*val2 = 0;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
 	}
 	return -EINVAL;
 }
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 163a254..a06ae9e 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -56,7 +56,7 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 		*val = (ret >> st->chip_info->channel[0].scan_type.shift) &
 			RES_MASK(st->chip_info->channel[0].scan_type.realbits);
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		scale_uv = (st->int_vref_mv * 1000)
 			>> st->chip_info->channel[0].scan_type.realbits;
 		*val =  scale_uv/1000;
@@ -69,49 +69,49 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
 static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
 	[ID_AD7466] = {
 		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
 				       0, 0, IIO_ST('u', 12, 16, 0), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7467] = {
 		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
 				       0, 0, IIO_ST('u', 10, 16, 2), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7468] = {
 		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1 , 0, NULL, 0, 0,
-				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
 				       0, 0, IIO_ST('u', 8, 16, 4), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7475] = {
 		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
 				       0, 0, IIO_ST('u', 12, 16, 0), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7476] = {
 		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
 				       0, 0, IIO_ST('u', 12, 16, 0), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7477] = {
 		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
 				       0, 0, IIO_ST('u', 10, 16, 2), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7478] = {
 		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
 				       0, 0, IIO_ST('u', 8, 16, 4), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 	},
 	[ID_AD7495] = {
 		.channel[0] = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				       (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				       IIO_CHAN_INFO_SCALE_SHARED_BIT,
 				       0, 0, IIO_ST('u', 12, 16, 0), 0),
 		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
 		.int_vref_mv = 2500,
diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index d58a0e3..a8596b8 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -100,7 +100,7 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		*val = (short) ret;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		scale_uv = (st->range * 1000 * 2)
 			>> st->chip_info->channels[0].scan_type.realbits;
 		*val =  scale_uv / 1000;
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index b06f9ad..f5f7e76 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -114,7 +114,7 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 			*val *= 128;
 
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		scale_uv = (st->int_vref_mv * 100000)
 			>> (channel.scan_type.realbits - 1);
 		*val =  scale_uv / 100000;
@@ -127,12 +127,12 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7780] = {
 		.channel = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				    IIO_CHAN_INFO_SCALE_SHARED_BIT,
 				    0, 0, IIO_ST('s', 24, 32, 8), 0),
 	},
 	[ID_AD7781] = {
 		.channel = IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 0, 0,
-				    (1 << IIO_CHAN_INFO_SCALE_SHARED),
+				    IIO_CHAN_INFO_SCALE_SHARED_BIT,
 				    0, 0, IIO_ST('s', 20, 32, 12), 0),
 	},
 };
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 2f0a1e1..cbefa22 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -666,19 +666,21 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 
-	case IIO_CHAN_INFO_SCALE_SHARED:
-		*val = st->scale_avail[(st->conf >> 8) & 0x7][0];
-		*val2 = st->scale_avail[(st->conf >> 8) & 0x7][1];
-
-		return IIO_VAL_INT_PLUS_NANO;
-
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			/* 1170mV / 2^23 * 6 */
-			scale_uv = (1170ULL * 100000000ULL * 6ULL)
-				>> (chan->scan_type.realbits -
-				(unipolar ? 0 : 1));
+			if (chan->differential) {
+				*val = st->
+					scale_avail[(st->conf >> 8) & 0x7][0];
+				*val2 = st->
+					scale_avail[(st->conf >> 8) & 0x7][1];
+				return IIO_VAL_INT_PLUS_NANO;
+			} else {
+				/* 1170mV / 2^23 * 6 */
+				scale_uv = (1170ULL * 100000000ULL * 6ULL)
+					>> (chan->scan_type.realbits -
+					    (unipolar ? 0 : 1));
+			}
 			break;
 		case IIO_TEMP:
 			/* Always uses unity gain and internal ref */
@@ -715,7 +717,7 @@ static int ad7793_write_raw(struct iio_dev *indio_dev,
 	}
 
 	switch (mask) {
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		ret = -EINVAL;
 		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
 			if (val2 == st->scale_avail[i][1]) {
@@ -774,7 +776,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel = 0,
 			.channel2 = 0,
 			.address = AD7793_CH_AIN1P_AIN1M,
-			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 			.scan_index = 0,
 			.scan_type = IIO_ST('s', 24, 32, 0)
 		},
@@ -785,7 +787,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel = 1,
 			.channel2 = 1,
 			.address = AD7793_CH_AIN2P_AIN2M,
-			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 			.scan_index = 1,
 			.scan_type = IIO_ST('s', 24, 32, 0)
 		},
@@ -796,7 +798,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel = 2,
 			.channel2 = 2,
 			.address = AD7793_CH_AIN3P_AIN3M,
-			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 			.scan_index = 2,
 			.scan_type = IIO_ST('s', 24, 32, 0)
 		},
@@ -808,7 +810,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel = 2,
 			.channel2 = 2,
 			.address = AD7793_CH_AIN1M_AIN1M,
-			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 			.scan_index = 2,
 			.scan_type = IIO_ST('s', 24, 32, 0)
 		},
@@ -817,7 +819,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.indexed = 1,
 			.channel = 0,
 			.address = AD7793_CH_TEMP,
-			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+			.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 			.scan_index = 4,
 			.scan_type = IIO_ST('s', 24, 32, 0),
 		},
@@ -827,7 +829,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.indexed = 1,
 			.channel = 4,
 			.address = AD7793_CH_AVDD_MONITOR,
-			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+			.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 			.scan_index = 5,
 			.scan_type = IIO_ST('s', 24, 32, 0),
 		},
@@ -841,7 +843,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel = 0,
 			.channel2 = 0,
 			.address = AD7793_CH_AIN1P_AIN1M,
-			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 			.scan_index = 0,
 			.scan_type = IIO_ST('s', 16, 32, 0)
 		},
@@ -852,7 +854,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel = 1,
 			.channel2 = 1,
 			.address = AD7793_CH_AIN2P_AIN2M,
-			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 			.scan_index = 1,
 			.scan_type = IIO_ST('s', 16, 32, 0)
 		},
@@ -863,7 +865,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel = 2,
 			.channel2 = 2,
 			.address = AD7793_CH_AIN3P_AIN3M,
-			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 			.scan_index = 2,
 			.scan_type = IIO_ST('s', 16, 32, 0)
 		},
@@ -875,7 +877,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.channel = 2,
 			.channel2 = 2,
 			.address = AD7793_CH_AIN1M_AIN1M,
-			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 			.scan_index = 2,
 			.scan_type = IIO_ST('s', 16, 32, 0)
 		},
@@ -884,7 +886,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.indexed = 1,
 			.channel = 0,
 			.address = AD7793_CH_TEMP,
-			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+			.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 			.scan_index = 4,
 			.scan_type = IIO_ST('s', 16, 32, 0),
 		},
@@ -894,7 +896,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 			.indexed = 1,
 			.channel = 4,
 			.address = AD7793_CH_AVDD_MONITOR,
-			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+			.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 			.scan_index = 5,
 			.scan_type = IIO_ST('s', 16, 32, 0),
 		},
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 245c943..baa6e6a 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -55,7 +55,7 @@ static int ad7887_read_raw(struct iio_dev *indio_dev,
 		*val = (ret >> st->chip_info->channel[0].scan_type.shift) &
 			RES_MASK(st->chip_info->channel[0].scan_type.realbits);
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		scale_uv = (st->int_vref_mv * 1000)
 			>> st->chip_info->channel[0].scan_type.realbits;
 		*val =  scale_uv/1000;
@@ -75,7 +75,7 @@ static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
 			.type = IIO_VOLTAGE,
 			.indexed = 1,
 			.channel = 1,
-			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 			.address = 1,
 			.scan_index = 1,
 			.scan_type = IIO_ST('u', 12, 16, 0),
@@ -84,7 +84,7 @@ static const struct ad7887_chip_info ad7887_chip_info_tbl[] = {
 			.type = IIO_VOLTAGE,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+			.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 			.address = 0,
 			.scan_index = 0,
 			.scan_type = IIO_ST('u', 12, 16, 0),
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 60a48a2..cdee9b9 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -162,7 +162,7 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
 		*val = (ret >> chan->scan_type.shift) &
 			RES_MASK(chan->scan_type.realbits);
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		scale_uv = (st->int_vref_mv * 1000) >> chan->scan_type.realbits;
 		*val =  scale_uv / 1000;
 		*val2 = (scale_uv % 1000) * 1000;
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 6b05e57..c3e28e1 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -261,7 +261,7 @@ static int max1363_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		if ((1 << (st->chip_info->bits + 1)) >
 		    st->chip_info->int_vref_mv) {
 			*val = 0;
@@ -289,7 +289,7 @@ static const enum max1363_modes max1363_mode_list[] = {
 #define MAX1363_EV_M						\
 	(IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING)	\
 	 | IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
-#define MAX1363_INFO_MASK (1 << IIO_CHAN_INFO_SCALE_SHARED)
+#define MAX1363_INFO_MASK IIO_CHAN_INFO_SCALE_SHARED_BIT
 #define MAX1363_CHAN_U(num, addr, si, bits, evmask)			\
 	{								\
 		.type = IIO_VOLTAGE,					\
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 10737fa..6bcdb14 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -111,7 +111,7 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		*val = swab16(ret);
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE:
+	case IIO_CHAN_INFO_AVERAGE_RAW:
 		ret = i2c_smbus_read_word_data(chip->client,
 					ad7150_addresses[chan->channel][1]);
 		if (ret < 0)
@@ -429,7 +429,7 @@ static const struct iio_chan_spec ad7150_channels[] = {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE_BIT,
 		.event_mask =
 		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
 		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING) |
@@ -441,7 +441,7 @@ static const struct iio_chan_spec ad7150_channels[] = {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE_BIT,
 		.event_mask =
 		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
 		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING) |
diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index e5ca683..29b2dc6 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -259,7 +259,7 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
 	mutex_lock(&indio_dev->mlock);
 
 	switch (mask) {
-	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
+	case IIO_CHAN_INFO_CALIBSCALE:
 		if (val != 1) {
 			ret = -EINVAL;
 			goto out;
@@ -276,7 +276,7 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
 		ret = 0;
 		break;
 
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		if ((val < 0) | (val > 0xFFFF)) {
 			ret = -EINVAL;
 			goto out;
@@ -289,7 +289,7 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
 
 		ret = 0;
 		break;
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE:
 		if (val != 0) {
 			ret = -EINVAL;
 			goto out;
@@ -372,7 +372,7 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT;
 		break;
-	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
+	case IIO_CHAN_INFO_CALIBSCALE:
 
 		ret = i2c_smbus_read_word_data(chip->client,
 				ad7152_addresses[chan->channel][AD7152_GAIN]);
@@ -384,7 +384,7 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = i2c_smbus_read_word_data(chip->client,
 				ad7152_addresses[chan->channel][AD7152_OFFS]);
 		if (ret < 0)
@@ -393,7 +393,7 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT;
 		break;
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE:
 		ret = i2c_smbus_read_byte_data(chip->client,
 				ad7152_addresses[chan->channel][AD7152_SETUP]);
 		if (ret < 0)
@@ -416,7 +416,7 @@ static int ad7152_write_raw_get_fmt(struct iio_dev *indio_dev,
 			       long mask)
 {
 	switch (mask) {
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE:
 		return IIO_VAL_INT_PLUS_NANO;
 	default:
 		return IIO_VAL_INT_PLUS_MICRO;
@@ -436,34 +436,34 @@ static const struct iio_chan_spec ad7152_channels[] = {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 	}, {
 		.type = IIO_CAPACITANCE,
 		.differential = 1,
 		.indexed = 1,
 		.channel = 0,
 		.channel2 = 2,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 	}, {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 	}, {
 		.type = IIO_CAPACITANCE,
 		.differential = 1,
 		.indexed = 1,
 		.channel = 1,
 		.channel2 = 3,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 	}
 };
 /*
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 5deaf85..de8f844 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -123,7 +123,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_EXT_VIN,
 	},
@@ -132,7 +132,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.extend_name = "supply",
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_VDD_MON,
 	},
@@ -156,10 +156,10 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SHARED) |
-		(1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
+		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7746_REG_CAP_DATA_HIGH << 8,
 	},
 	[CIN1_DIFF] = {
@@ -168,10 +168,10 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.channel2 = 2,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SHARED) |
-		(1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
+		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
 			AD7746_CAPSETUP_CAPDIFF
 	},
@@ -179,10 +179,10 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.type = IIO_CAPACITANCE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SHARED) |
-		(1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
+		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
 			AD7746_CAPSETUP_CIN2,
 	},
@@ -192,10 +192,10 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.channel2 = 3,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SHARED) |
-		(1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
+		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
 			AD7746_CAPSETUP_CAPDIFF | AD7746_CAPSETUP_CIN2,
 	}
@@ -477,7 +477,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 	mutex_lock(&indio_dev->mlock);
 
 	switch (mask) {
-	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
+	case IIO_CHAN_INFO_CALIBSCALE:
 		if (val != 1) {
 			ret = -EINVAL;
 			goto out;
@@ -503,7 +503,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 
 		ret = 0;
 		break;
-	case IIO_CHAN_INFO_CALIBBIAS_SHARED:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		if ((val < 0) | (val > 0xFFFF)) {
 			ret = -EINVAL;
 			goto out;
@@ -515,7 +515,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 
 		ret = 0;
 		break;
-	case IIO_CHAN_INFO_OFFSET_SEPARATE:
+	case IIO_CHAN_INFO_OFFSET:
 		if ((val < 0) | (val > 43008000)) { /* 21pF */
 			ret = -EINVAL;
 			goto out;
@@ -612,7 +612,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT;
 		break;
-	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
+	case IIO_CHAN_INFO_CALIBSCALE:
 		switch (chan->type) {
 		case IIO_CAPACITANCE:
 			reg = AD7746_REG_CAP_GAINH;
@@ -634,7 +634,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
-	case IIO_CHAN_INFO_CALIBBIAS_SHARED:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = i2c_smbus_read_word_data(chip->client,
 					       AD7746_REG_CAP_OFFH);
 		if (ret < 0)
@@ -643,13 +643,13 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT;
 		break;
-	case IIO_CHAN_INFO_OFFSET_SEPARATE:
+	case IIO_CHAN_INFO_OFFSET:
 		*val = AD7746_CAPDAC_DACP(chip->capdac[chan->channel]
 			[chan->differential]) * 338646;
 
 		ret = IIO_VAL_INT;
 		break;
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_CAPACITANCE:
 			/* 8.192pf / 2^24 */
diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
index 1c25403..a701063 100644
--- a/drivers/staging/iio/dac/ad5064.c
+++ b/drivers/staging/iio/dac/ad5064.c
@@ -91,7 +91,7 @@ enum ad5064_type {
 	.indexed = 1,						\
 	.output = 1,						\
 	.channel = (chan),					\
-	.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),	\
+	.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,	\
 	.address = AD5064_ADDR_DAC(chan),			\
 	.scan_type = IIO_ST('u', (bits), 16, 20 - (bits))	\
 }
@@ -287,7 +287,7 @@ static int ad5064_read_raw(struct iio_dev *indio_dev,
 	case 0:
 		*val = st->dac_cache[chan->channel];
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE:
 		vref = st->chip_info->shared_vref ? 0 : chan->channel;
 		scale_uv = regulator_get_voltage(st->vref_reg[vref].consumer);
 		if (scale_uv < 0)
diff --git a/drivers/staging/iio/dac/ad5360.c b/drivers/staging/iio/dac/ad5360.c
index 7df1958..c5bf582 100644
--- a/drivers/staging/iio/dac/ad5360.c
+++ b/drivers/staging/iio/dac/ad5360.c
@@ -103,10 +103,10 @@ enum ad5360_type {
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
 	.output = 1,						\
-	.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |	\
-		(1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |		\
-		(1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |	\
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),	\
+	.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT |	\
+		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |		\
+		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |	\
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,	\
 	.scan_type = IIO_ST('u', (bits), 16, 16 - (bits))	\
 }
 
@@ -326,21 +326,21 @@ static int ad5360_write_raw(struct iio_dev *indio_dev,
 		return ad5360_write(indio_dev, AD5360_CMD_WRITE_DATA,
 				 chan->address, val, chan->scan_type.shift);
 
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		if (val >= max_val || val < 0)
 			return -EINVAL;
 
 		return ad5360_write(indio_dev, AD5360_CMD_WRITE_OFFSET,
 				 chan->address, val, chan->scan_type.shift);
 
-	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
+	case IIO_CHAN_INFO_CALIBSCALE:
 		if (val >= max_val || val < 0)
 			return -EINVAL;
 
 		return ad5360_write(indio_dev, AD5360_CMD_WRITE_GAIN,
 				 chan->address, val, chan->scan_type.shift);
 
-	case IIO_CHAN_INFO_OFFSET_SEPARATE:
+	case IIO_CHAN_INFO_OFFSET:
 		if (val <= -max_val || val > 0)
 			return -EINVAL;
 
@@ -383,7 +383,7 @@ static int ad5360_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		*val = ret >> chan->scan_type.shift;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE:
 		/* vout = 4 * vref * dac_code */
 		scale_uv = ad5360_get_channel_vref(st, chan->channel) * 4 * 100;
 		if (scale_uv < 0)
@@ -393,21 +393,21 @@ static int ad5360_read_raw(struct iio_dev *indio_dev,
 		*val =  scale_uv / 100000;
 		*val2 = (scale_uv % 100000) * 10;
 		return IIO_VAL_INT_PLUS_MICRO;
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = ad5360_read(indio_dev, AD5360_READBACK_OFFSET,
 			chan->address);
 		if (ret < 0)
 			return ret;
 		*val = ret;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
+	case IIO_CHAN_INFO_CALIBSCALE:
 		ret = ad5360_read(indio_dev, AD5360_READBACK_GAIN,
 			chan->address);
 		if (ret < 0)
 			return ret;
 		*val = ret;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_OFFSET_SEPARATE:
+	case IIO_CHAN_INFO_OFFSET:
 		ofs_index = ad5360_get_channel_vref_index(st, chan->channel);
 		ret = ad5360_read(indio_dev, AD5360_READBACK_SF,
 			AD5360_REG_SF_OFS(ofs_index));
diff --git a/drivers/staging/iio/dac/ad5686.c b/drivers/staging/iio/dac/ad5686.c
index 070de8d..8563b63 100644
--- a/drivers/staging/iio/dac/ad5686.c
+++ b/drivers/staging/iio/dac/ad5686.c
@@ -98,7 +98,7 @@ enum ad5686_supported_device_ids {
 		.indexed = 1,					\
 		.output = 1,					\
 		.channel = chan,				\
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),	\
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,	\
 		.address = AD5686_ADDR_DAC(chan),			\
 		.scan_type = IIO_ST('u', bits, 16, shift)	\
 }
@@ -305,7 +305,7 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 		*val = ret;
 		return IIO_VAL_INT;
 		break;
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		scale_uv = (st->vref_mv * 100000)
 			>> (chan->scan_type.realbits);
 		*val =  scale_uv / 100000;
diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index d3b3b71..db0bd12 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -77,8 +77,8 @@ static int ad5791_spi_read(struct spi_device *spi, u8 addr, u32 *val)
 	.indexed = 1,					\
 	.address = AD5791_ADDR_DAC0,			\
 	.channel = 0,					\
-	.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED) | \
-		(1 << IIO_CHAN_INFO_OFFSET_SHARED),	\
+	.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT | \
+		IIO_CHAN_INFO_OFFSET_SHARED_BIT,	\
 	.scan_type = IIO_ST('u', bits, 24, shift)	\
 }
 
@@ -237,11 +237,11 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
 		*val &= AD5791_DAC_MASK;
 		*val >>= chan->scan_type.shift;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		*val2 = (((u64)st->vref_mv) * 1000000ULL) >> chan->scan_type.realbits;
 		return IIO_VAL_INT_PLUS_MICRO;
-	case IIO_CHAN_INFO_OFFSET_SHARED:
+	case IIO_CHAN_INFO_OFFSET:
 		val64 = (((u64)st->vref_neg_mv) << chan->scan_type.realbits);
 		do_div(val64, st->vref_mv);
 		*val = -val64;
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 88879b4..465f870 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -97,11 +97,11 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&indio_dev->mlock);
 		*val = tval;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_OFFSET_SEPARATE:
+	case IIO_CHAN_INFO_OFFSET:
 		*val = -7;
 		*val2 = 461117;
 		return IIO_VAL_INT_PLUS_MICRO;
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		*val2 = 34000;
 		return IIO_VAL_INT_PLUS_MICRO;
@@ -135,8 +135,8 @@ static const struct iio_chan_spec adis16060_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = ADIS16060_TEMP_OUT,
 	}
 };
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 4f5a7cb..e86ce6a 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -390,9 +390,9 @@ enum adis16260_channel {
 #define ADIS16260_GYRO_CHANNEL_SET(axis, mod)				\
 	struct iio_chan_spec adis16260_channels_##axis[] = {		\
 		IIO_CHAN(IIO_ANGL_VEL, 1, 0, 0, NULL, 0, mod,		\
-			 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |	\
-			 (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |	\
-			 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),		\
+			 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |	\
+			 IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |	\
+			 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
 			 gyro, ADIS16260_SCAN_GYRO,			\
 			 IIO_ST('s', 14, 16, 0), 0),			\
 		IIO_CHAN(IIO_ANGL, 1, 0, 0, NULL, 0, mod,		\
@@ -400,16 +400,16 @@ enum adis16260_channel {
 			 angle, ADIS16260_SCAN_ANGL,			\
 			 IIO_ST('u', 14, 16, 0), 0),			\
 		IIO_CHAN(IIO_TEMP, 0, 1, 0, NULL, 0, 0,			\
-			 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |		\
-			 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),		\
+			 IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |		\
+			 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
 			 temp, ADIS16260_SCAN_TEMP,			\
 			 IIO_ST('u', 12, 16, 0), 0),			\
 		IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "supply", 0, 0,		\
-			 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),		\
+			 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
 			 in_supply, ADIS16260_SCAN_SUPPLY,		\
 			 IIO_ST('u', 12, 16, 0), 0),			\
 		IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, NULL, 1, 0,		\
-			 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),		\
+			 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
 			 in_aux, ADIS16260_SCAN_AUX_ADC,		\
 			 IIO_ST('u', 12, 16, 0), 0),			\
 		IIO_CHAN_SOFT_TIMESTAMP(5)				\
@@ -464,8 +464,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
 			*val = 0;
@@ -489,10 +488,10 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 		break;
-	case IIO_CHAN_INFO_OFFSET_SEPARATE:
+	case IIO_CHAN_INFO_OFFSET:
 		*val = 25;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
 			bits = 12;
@@ -512,7 +511,7 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
+	case IIO_CHAN_INFO_CALIBSCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
 			bits = 12;
@@ -544,11 +543,11 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 	s16 val16;
 	u8 addr;
 	switch (mask) {
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		val16 = val & ((1 << bits) - 1);
 		addr = adis16260_addresses[chan->address][1];
 		return adis16260_spi_write_reg_16(indio_dev, addr, val16);
-	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
+	case IIO_CHAN_INFO_CALIBSCALE:
 		val16 = val & ((1 << bits) - 1);
 		addr = adis16260_addresses[chan->address][2];
 		return adis16260_spi_write_reg_16(indio_dev, addr, val16);
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 18406c7..40bfb32 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -243,7 +243,7 @@ static int adxrs450_write_raw(struct iio_dev *indio_dev,
 {
 	int ret;
 	switch (mask) {
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = adxrs450_spi_write_reg_16(indio_dev,
 						ADXRS450_DNC1,
 						val & 0x3FF);
@@ -287,7 +287,7 @@ static int adxrs450_read_raw(struct iio_dev *indio_dev,
 			break;
 		}
 		break;
-	case IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE:
+	case IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW:
 		ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_QUAD1, &t);
 		if (ret)
 			break;
@@ -307,8 +307,8 @@ static const struct iio_chan_spec adxrs450_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE)
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE_BIT,
 	}, {
 		.type = IIO_TEMP,
 		.indexed = 1,
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 4fb4cc4..66c2604 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -27,24 +27,54 @@ enum iio_data_type {
 /* Could add the raw attributes as well - allowing buffer only devices */
 enum iio_chan_info_enum {
 	/* 0 is reserverd for raw attributes */
-	IIO_CHAN_INFO_SCALE_SHARED = 2,
-	IIO_CHAN_INFO_SCALE_SEPARATE,
-	IIO_CHAN_INFO_OFFSET_SHARED,
-	IIO_CHAN_INFO_OFFSET_SEPARATE,
-	IIO_CHAN_INFO_CALIBSCALE_SHARED,
-	IIO_CHAN_INFO_CALIBSCALE_SEPARATE,
-	IIO_CHAN_INFO_CALIBBIAS_SHARED,
-	IIO_CHAN_INFO_CALIBBIAS_SEPARATE,
-	IIO_CHAN_INFO_PEAK_SHARED,
-	IIO_CHAN_INFO_PEAK_SEPARATE,
-	IIO_CHAN_INFO_PEAK_SCALE_SHARED,
-	IIO_CHAN_INFO_PEAK_SCALE_SEPARATE,
-	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SHARED,
-	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE,
-	IIO_CHAN_INFO_AVERAGE_RAW_SHARED,
-	IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE,
+	IIO_CHAN_INFO_SCALE = 1,
+	IIO_CHAN_INFO_OFFSET,
+	IIO_CHAN_INFO_CALIBSCALE,
+	IIO_CHAN_INFO_CALIBBIAS,
+	IIO_CHAN_INFO_PEAK,
+	IIO_CHAN_INFO_PEAK_SCALE,
+	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW,
+	IIO_CHAN_INFO_AVERAGE_RAW,
 };
 
+#define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
+#define IIO_CHAN_INFO_SEPARATE_BIT(type) BIT(type*2 + 1)
+
+#define IIO_CHAN_INFO_SCALE_SEPARATE_BIT		\
+	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_SCALE)
+#define IIO_CHAN_INFO_SCALE_SHARED_BIT			\
+	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_SCALE)
+#define IIO_CHAN_INFO_OFFSET_SEPARATE_BIT			\
+	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_OFFSET)
+#define IIO_CHAN_INFO_OFFSET_SHARED_BIT			\
+	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_OFFSET)
+#define IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT			\
+	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_CALIBSCALE)
+#define IIO_CHAN_INFO_CALIBSCALE_SHARED_BIT			\
+	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_CALIBSCALE)
+#define IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT			\
+	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_CALIBBIAS)
+#define IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT			\
+	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_CALIBBIAS)
+#define IIO_CHAN_INFO_PEAK_SEPARATE_BIT			\
+	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_PEAK)
+#define IIO_CHAN_INFO_PEAK_SHARED_BIT			\
+	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_PEAK)
+#define IIO_CHAN_INFO_PEAKSCALE_SEPARATE_BIT			\
+	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_PEAKSCALE)
+#define IIO_CHAN_INFO_PEAKSCALE_SHARED_BIT			\
+	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_PEAKSCALE)
+#define IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE_BIT	\
+	IIO_CHAN_INFO_SEPARATE_BIT(				\
+		IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW)
+#define IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SHARED_BIT	\
+	IIO_CHAN_INFO_SHARED_BIT(				\
+		IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW)
+#define IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE_BIT			\
+	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_AVERAGE_RAW)
+#define IIO_CHAN_INFO_AVERAGE_RAW_SHARED_BIT			\
+	IIO_CHAN_INFO_SHARED_BIT(IIO_CHAN_INFO_AVERAGE_RAW)
+
 enum iio_endian {
 	IIO_CPU,
 	IIO_BE,
diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index 2196ff1..228f991 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -77,13 +77,13 @@ static struct iio_chan_spec iio_dummy_channels[] = {
 		 * Offset for userspace to apply prior to scale
 		 * when converting to standard units (microvolts)
 		 */
-		(1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
 		/*
 		 * in_voltage0_scale
 		 * Multipler for userspace to apply post offset
 		 * when converting to standard units (microvolts)
 		 */
-		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		/* The ordering of elements in the buffer via an enum */
 		.scan_index = voltage0,
 		.scan_type = { /* Description of storage in buffer */
@@ -118,7 +118,7 @@ static struct iio_chan_spec iio_dummy_channels[] = {
 		 * Shared version of scale - shared by differential
 		 * input channels of type IIO_VOLTAGE.
 		 */
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.scan_index = diffvoltage1m2,
 		.scan_type = { /* Description of storage in buffer */
 			.sign = 's', /* signed */
@@ -135,7 +135,7 @@ static struct iio_chan_spec iio_dummy_channels[] = {
 		.channel = 3,
 		.channel2 = 4,
 		.info_mask =
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.scan_index = diffvoltage3m4,
 		.scan_type = {
 			.sign = 's',
@@ -160,7 +160,7 @@ static struct iio_chan_spec iio_dummy_channels[] = {
 		 * seeing the readings. Typically part of hardware
 		 * calibration.
 		 */
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
 		.scan_index = accelx,
 		.scan_type = { /* Description of storage in buffer */
 			.sign = 's', /* signed */
@@ -229,29 +229,32 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
 			break;
 		}
 		break;
-	case IIO_CHAN_INFO_OFFSET_SEPARATE:
+	case IIO_CHAN_INFO_OFFSET:
 		/* only single ended adc -> 7 */
 		*val = 7;
 		ret = IIO_VAL_INT;
 		break;
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
-		/* only single ended adc -> 0.001333 */
-		*val = 0;
-		*val2 = 1333;
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
-	case IIO_CHAN_INFO_SCALE_SHARED:
-		/* all differential adc channels -> 0.000001344 */
-		*val = 0;
-		*val2 = 1344;
-		ret = IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->differential) {
+		case 0:
+			/* only single ended adc -> 0.001333 */
+			*val = 0;
+			*val2 = 1333;
+			ret = IIO_VAL_INT_PLUS_MICRO;
+			break;
+		case 1:
+			/* all differential adc channels -> 0.000001344 */
+			*val = 0;
+			*val2 = 1344;
+			ret = IIO_VAL_INT_PLUS_NANO;
+		}
 		break;
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		/* only the acceleration axis - read from cache */
 		*val = st->accel_calibbias;
 		ret = IIO_VAL_INT;
 		break;
-	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
+	case IIO_CHAN_INFO_CALIBSCALE:
 		*val = st->accel_calibscale->val;
 		*val2 = st->accel_calibscale->val2;
 		ret = IIO_VAL_INT_PLUS_MICRO;
@@ -296,7 +299,7 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
 		st->dac_val = val;
 		mutex_unlock(&st->lock);
 		return 0;
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		mutex_lock(&st->lock);
 		/* Compare against table - hard matching here */
 		for (i = 0; i < ARRAY_SIZE(dummy_scales); i++)
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 1f495da..56c89af 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -113,10 +113,10 @@ static struct iio_chan_spec ad5933_channels[] = {
 		 0, AD5933_REG_TEMP_DATA, IIO_ST('s', 14, 16, 0), 0),
 	/* Ring Channels */
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "real_raw", 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		 AD5933_REG_REAL_DATA, 0, IIO_ST('s', 16, 16, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "imag_raw", 0, 0,
-		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		 AD5933_REG_IMAG_DATA, 1, IIO_ST('s', 16, 16, 0), 0),
 };
 
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 0018272..174454a 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -464,7 +464,7 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		mutex_lock(&indio_dev->mlock);
 		ret = adis16400_spi_write_reg_16(indio_dev,
 				adis16400_addresses[chan->address][1],
@@ -504,8 +504,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		mutex_unlock(&indio_dev->mlock);
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE_SHARED:
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_ANGL_VEL:
 			*val = 0;
@@ -533,7 +532,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
-	case IIO_CHAN_INFO_CALIBBIAS_SEPARATE:
+	case IIO_CHAN_INFO_CALIBBIAS:
 		mutex_lock(&indio_dev->mlock);
 		ret = adis16400_spi_read_reg_16(indio_dev,
 				adis16400_addresses[chan->address][1],
@@ -544,7 +543,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		val16 = ((val16 & 0xFFF) << 4) >> 4;
 		*val = val16;
 		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_OFFSET_SEPARATE:
+	case IIO_CHAN_INFO_OFFSET:
 		/* currently only temperature */
 		*val = 198;
 		*val2 = 160000;
@@ -560,7 +559,7 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "supply",
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_supply,
 		.scan_index = ADIS16400_SCAN_SUPPLY,
 		.scan_type = IIO_ST('u', 14, 16, 0)
@@ -568,8 +567,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = gyro_x,
 		.scan_index = ADIS16400_SCAN_GYRO_X,
 		.scan_type = IIO_ST('s', 14, 16, 0)
@@ -577,8 +576,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = gyro_y,
 		.scan_index = ADIS16400_SCAN_GYRO_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -586,8 +585,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = gyro_z,
 		.scan_index = ADIS16400_SCAN_GYRO_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -595,8 +594,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = accel_x,
 		.scan_index = ADIS16400_SCAN_ACC_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -604,8 +603,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = accel_y,
 		.scan_index = ADIS16400_SCAN_ACC_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -613,8 +612,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = accel_z,
 		.scan_index = ADIS16400_SCAN_ACC_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -622,7 +621,7 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.type = IIO_MAGN,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = magn_x,
 		.scan_index = ADIS16400_SCAN_MAGN_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -630,7 +629,7 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.type = IIO_MAGN,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = magn_y,
 		.scan_index = ADIS16400_SCAN_MAGN_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -638,7 +637,7 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.type = IIO_MAGN,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = magn_z,
 		.scan_index = ADIS16400_SCAN_MAGN_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -646,8 +645,8 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = temp,
 		.scan_index = ADIS16400_SCAN_TEMP,
 		.scan_type = IIO_ST('s', 12, 16, 0),
@@ -655,7 +654,7 @@ static struct iio_chan_spec adis16400_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in1,
 		.scan_index = ADIS16400_SCAN_ADC_0,
 		.scan_type = IIO_ST('s', 12, 16, 0),
@@ -669,7 +668,7 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "supply",
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_supply,
 		.scan_index = ADIS16400_SCAN_SUPPLY,
 		.scan_type = IIO_ST('u', 12, 16, 0)
@@ -677,8 +676,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = gyro_x,
 		.scan_index = ADIS16400_SCAN_GYRO_X,
 		.scan_type = IIO_ST('s', 14, 16, 0)
@@ -686,8 +685,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = gyro_y,
 		.scan_index = ADIS16400_SCAN_GYRO_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -695,8 +694,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = gyro_z,
 		.scan_index = ADIS16400_SCAN_GYRO_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -704,8 +703,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 	.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = accel_x,
 		.scan_index = ADIS16400_SCAN_ACC_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -713,8 +712,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = accel_y,
 		.scan_index = ADIS16400_SCAN_ACC_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -722,8 +721,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = accel_z,
 		.scan_index = ADIS16400_SCAN_ACC_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -732,8 +731,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "x",
-		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = temp0,
 		.scan_index = ADIS16350_SCAN_TEMP_X,
 		.scan_type = IIO_ST('s', 12, 16, 0),
@@ -742,8 +741,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.indexed = 1,
 		.channel = 1,
 		.extend_name = "y",
-		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = temp1,
 		.scan_index = ADIS16350_SCAN_TEMP_Y,
 		.scan_type = IIO_ST('s', 12, 16, 0),
@@ -752,8 +751,8 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.indexed = 1,
 		.channel = 2,
 		.extend_name = "z",
-		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = temp2,
 		.scan_index = ADIS16350_SCAN_TEMP_Z,
 		.scan_type = IIO_ST('s', 12, 16, 0),
@@ -761,7 +760,7 @@ static struct iio_chan_spec adis16350_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in1,
 		.scan_index = ADIS16350_SCAN_ADC_0,
 		.scan_type = IIO_ST('s', 12, 16, 0),
@@ -775,7 +774,7 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.extend_name = "supply",
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in_supply,
 		.scan_index = ADIS16400_SCAN_SUPPLY,
 		.scan_type = IIO_ST('u', 12, 16, 0)
@@ -783,8 +782,8 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = gyro_x,
 		.scan_index = ADIS16400_SCAN_GYRO_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -792,8 +791,8 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = accel_x,
 		.scan_index = ADIS16400_SCAN_ACC_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -801,8 +800,8 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = accel_y,
 		.scan_index = ADIS16400_SCAN_ACC_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -810,8 +809,8 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = accel_z,
 		.scan_index = ADIS16400_SCAN_ACC_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -819,8 +818,8 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = temp,
 		.scan_index = ADIS16400_SCAN_TEMP,
 		.scan_type = IIO_ST('s', 12, 16, 0),
@@ -828,7 +827,7 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.type = IIO_VOLTAGE,
 		.indexed = 1,
 		.channel = 1,
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
 		.address = in1,
 		.scan_index = ADIS16350_SCAN_ADC_0,
 		.scan_type = IIO_ST('s', 12, 16, 0),
@@ -836,7 +835,7 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.type = IIO_INCLI,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = incli_x,
 		.scan_index = ADIS16300_SCAN_INCLI_X,
 		.scan_type = IIO_ST('s', 13, 16, 0),
@@ -844,7 +843,7 @@ static struct iio_chan_spec adis16300_channels[] = {
 		.type = IIO_INCLI,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = incli_y,
 		.scan_index = ADIS16300_SCAN_INCLI_Y,
 		.scan_type = IIO_ST('s', 13, 16, 0),
@@ -857,8 +856,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = gyro_x,
 		.scan_index = ADIS16400_SCAN_GYRO_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -866,8 +865,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = gyro_y,
 		.scan_index = ADIS16400_SCAN_GYRO_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -875,8 +874,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.type = IIO_ANGL_VEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = gyro_z,
 		.scan_index = ADIS16400_SCAN_GYRO_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -884,8 +883,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_X,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = accel_x,
 		.scan_index = ADIS16400_SCAN_ACC_X,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -893,8 +892,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Y,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = accel_y,
 		.scan_index = ADIS16400_SCAN_ACC_Y,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -902,8 +901,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.type = IIO_ACCEL,
 		.modified = 1,
 		.channel2 = IIO_MOD_Z,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = accel_z,
 		.scan_index = ADIS16400_SCAN_ACC_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
@@ -911,8 +910,8 @@ static const struct iio_chan_spec adis16334_channels[] = {
 		.type = IIO_TEMP,
 		.indexed = 1,
 		.channel = 0,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.address = accel_z,
 		.scan_index = ADIS16400_SCAN_ACC_Z,
 		.scan_type = IIO_ST('s', 14, 16, 0),
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index c6b47c5..3449371 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -77,15 +77,14 @@ static const char * const iio_modifier_names[] = {
 
 /* relies on pairs of these shared then separate */
 static const char * const iio_chan_info_postfix[] = {
-	[IIO_CHAN_INFO_SCALE_SHARED/2] = "scale",
-	[IIO_CHAN_INFO_OFFSET_SHARED/2] = "offset",
-	[IIO_CHAN_INFO_CALIBSCALE_SHARED/2] = "calibscale",
-	[IIO_CHAN_INFO_CALIBBIAS_SHARED/2] = "calibbias",
-	[IIO_CHAN_INFO_PEAK_SHARED/2] = "peak_raw",
-	[IIO_CHAN_INFO_PEAK_SCALE_SHARED/2] = "peak_scale",
-	[IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SHARED/2]
-	= "quadrature_correction_raw",
-	[IIO_CHAN_INFO_AVERAGE_RAW_SHARED/2] = "mean_raw",
+	[IIO_CHAN_INFO_SCALE] = "scale",
+	[IIO_CHAN_INFO_OFFSET] = "offset",
+	[IIO_CHAN_INFO_CALIBSCALE] = "calibscale",
+	[IIO_CHAN_INFO_CALIBBIAS] = "calibbias",
+	[IIO_CHAN_INFO_PEAK] = "peak_raw",
+	[IIO_CHAN_INFO_PEAK_SCALE] = "peak_scale",
+	[IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW] = "quadrature_correction_raw",
+	[IIO_CHAN_INFO_AVERAGE_RAW] = "mean_raw",
 };
 
 /**
@@ -593,7 +592,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 					     chan,
 					     &iio_read_channel_info,
 					     &iio_write_channel_info,
-					     i,
+					     i/2,
 					     !(i%2),
 					     &indio_dev->dev,
 					     &indio_dev->channel_attr_list);
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index bed18a7..f0c733a 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -362,8 +362,7 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
 	int ret = -EINVAL;
 
 	mutex_lock(&chip->lock);
-	if (mask == IIO_CHAN_INFO_CALIBSCALE_SEPARATE &&
-	    chan->type == IIO_LIGHT) {
+	if (mask == IIO_CHAN_INFO_CALIBSCALE && chan->type == IIO_LIGHT) {
 		chip->lux_scale = val;
 		ret = 0;
 	}
@@ -402,7 +401,7 @@ static int isl29018_read_raw(struct iio_dev *indio_dev,
 		if (!ret)
 			ret = IIO_VAL_INT;
 		break;
-	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
+	case IIO_CHAN_INFO_CALIBSCALE:
 		if (chan->type == IIO_LIGHT) {
 			*val = chip->lux_scale;
 			ret = IIO_VAL_INT;
@@ -421,7 +420,7 @@ static const struct iio_chan_spec isl29018_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.processed_val = IIO_PROCESSED,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
 	}, {
 		.type = IIO_INTENSITY,
 		.modified = 1,
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 5cee5ca..a7d7f03 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -511,7 +511,7 @@ static int tsl2563_read_raw(struct iio_dev *indio_dev,
 		}
 		break;
 
-	case IIO_CHAN_INFO_CALIBSCALE_SEPARATE:
+	case IIO_CHAN_INFO_CALIBSCALE:
 		if (chan->channel == 0)
 			*val = calib_to_sysfs(chip->calib0);
 		else
@@ -537,7 +537,7 @@ static const struct iio_chan_spec tsl2563_channels[] = {
 		.type = IIO_INTENSITY,
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_BOTH,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
 		.event_mask = (IIO_EV_BIT(IIO_EV_TYPE_THRESH,
 					  IIO_EV_DIR_RISING) |
 			       IIO_EV_BIT(IIO_EV_TYPE_THRESH,
@@ -546,7 +546,7 @@ static const struct iio_chan_spec tsl2563_channels[] = {
 		.type = IIO_INTENSITY,
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_IR,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE),
+		.info_mask = IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
 	}
 };
 
diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index b7d8cbb..a2c4d00 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -431,7 +431,7 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case 0:
 		return ak8975_read_axis(indio_dev, chan->address, val);
-	case IIO_CHAN_INFO_SCALE_SEPARATE:
+	case IIO_CHAN_INFO_SCALE:
 		*val = data->raw_to_gauss[chan->address];
 		return IIO_VAL_INT;
 	}
@@ -443,7 +443,7 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 		.type = IIO_MAGN,					\
 		.modified = 1,						\
 		.channel2 = IIO_MOD_##axis,				\
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),	\
+		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,	\
 		.address = index,					\
 	}
 
diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 4a42707..f90d4d1 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -463,7 +463,7 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
 		return hmc5843_read_measurement(indio_dev,
 						chan->address,
 						val);
-	case IIO_CHAN_INFO_SCALE_SHARED:
+	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		*val2 = hmc5843_regval_to_nanoscale[data->range];
 		return IIO_VAL_INT_PLUS_NANO;
@@ -476,7 +476,7 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
 		.type = IIO_MAGN,					\
 		.modified = 1,						\
 		.channel2 = IIO_MOD_##axis,				\
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),		\
+		.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,		\
 		.address = add						\
 	}
 
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 7028e87..839b48b 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -663,63 +663,63 @@ static const struct attribute_group ade7758_attribute_group = {
 
 static struct iio_chan_spec ade7758_channels[] = {
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "raw", 0, 0,
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		AD7758_WT(AD7758_PHASE_A, AD7758_VOLTAGE),
 		0, IIO_ST('s', 24, 32, 0), 0),
 	IIO_CHAN(IIO_CURRENT, 0, 1, 0, "raw", 0, 0,
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		AD7758_WT(AD7758_PHASE_A, AD7758_CURRENT),
 		1, IIO_ST('s', 24, 32, 0), 0),
 	IIO_CHAN(IIO_POWER, 0, 1, 0, "apparent_raw", 0, 0,
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		AD7758_WT(AD7758_PHASE_A, AD7758_APP_PWR),
 		2, IIO_ST('s', 24, 32, 0), 0),
 	IIO_CHAN(IIO_POWER, 0, 1, 0, "active_raw", 0, 0,
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		AD7758_WT(AD7758_PHASE_A, AD7758_ACT_PWR),
 		3, IIO_ST('s', 24, 32, 0), 0),
 	IIO_CHAN(IIO_POWER, 0, 1, 0, "reactive_raw", 0, 0,
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		AD7758_WT(AD7758_PHASE_A, AD7758_REACT_PWR),
 		4, IIO_ST('s', 24, 32, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "raw", 1, 0,
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		AD7758_WT(AD7758_PHASE_B, AD7758_VOLTAGE),
 		5, IIO_ST('s', 24, 32, 0), 0),
 	IIO_CHAN(IIO_CURRENT, 0, 1, 0, "raw", 1, 0,
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		AD7758_WT(AD7758_PHASE_B, AD7758_CURRENT),
 		6, IIO_ST('s', 24, 32, 0), 0),
 	IIO_CHAN(IIO_POWER, 0, 1, 0, "apparent_raw", 1, 0,
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		AD7758_WT(AD7758_PHASE_B, AD7758_APP_PWR),
 		7, IIO_ST('s', 24, 32, 0), 0),
 	IIO_CHAN(IIO_POWER, 0, 1, 0, "active_raw", 1, 0,
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		AD7758_WT(AD7758_PHASE_B, AD7758_ACT_PWR),
 		8, IIO_ST('s', 24, 32, 0), 0),
 	IIO_CHAN(IIO_POWER, 0, 1, 0, "reactive_raw", 1, 0,
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		AD7758_WT(AD7758_PHASE_B, AD7758_REACT_PWR),
 		9, IIO_ST('s', 24, 32, 0), 0),
 	IIO_CHAN(IIO_VOLTAGE, 0, 1, 0, "raw", 2, 0,
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		AD7758_WT(AD7758_PHASE_C, AD7758_VOLTAGE),
 		10, IIO_ST('s', 24, 32, 0), 0),
 	IIO_CHAN(IIO_CURRENT, 0, 1, 0, "raw", 2, 0,
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		AD7758_WT(AD7758_PHASE_C, AD7758_CURRENT),
 		11, IIO_ST('s', 24, 32, 0), 0),
 	IIO_CHAN(IIO_POWER, 0, 1, 0, "apparent_raw", 2, 0,
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		AD7758_WT(AD7758_PHASE_C, AD7758_APP_PWR),
 		12, IIO_ST('s', 24, 32, 0), 0),
 	IIO_CHAN(IIO_POWER, 0, 1, 0, "active_raw", 2, 0,
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		AD7758_WT(AD7758_PHASE_C, AD7758_ACT_PWR),
 		13, IIO_ST('s', 24, 32, 0), 0),
 	IIO_CHAN(IIO_POWER, 0, 1, 0, "reactive_raw", 2, 0,
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		AD7758_WT(AD7758_PHASE_C, AD7758_REACT_PWR),
 		14, IIO_ST('s', 24, 32, 0), 0),
 	IIO_CHAN_SOFT_TIMESTAMP(15),
-- 
1.7.7

