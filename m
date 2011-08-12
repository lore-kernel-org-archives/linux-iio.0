Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 10/12] staging:iio:accel:adis16204: use peak_raw info_mask element + push some defs down from header.
Date: Fri, 12 Aug 2011 17:48:01 +0100
Message-Id: <1313167683-11881-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313167683-11881-1-git-send-email-jic23@cam.ac.uk>
References: <1313167683-11881-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Currently this is the only driver using some of the defines in accel.h.
If these become common we'll just add them to the channel_spec options,
for now push down into this driver.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/accel/adis16204_core.c |   47 ++++++++++++++++------------
 1 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 3e2b626..6a64b2b 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -21,8 +21,6 @@
 #include "../iio.h"
 #include "../sysfs.h"
 #include "../ring_generic.h"
-#include "accel.h"
-#include "../adc/adc.h"
 
 #include "adis16204.h"
 
@@ -299,12 +297,15 @@ static int adis16204_initial_setup(struct iio_dev *indio_dev)
 err_ret:
 	return ret;
 }
+
+/* Unique to this driver currently */
+#define IIO_DEV_ATTR_ACCEL_XY(_show, _addr)			\
+	IIO_DEVICE_ATTR(accel_xy, S_IRUGO, _show, NULL, _addr)
+#define IIO_DEV_ATTR_ACCEL_XYPEAK(_show, _addr)		\
+	IIO_DEVICE_ATTR(accel_xypeak, S_IRUGO, _show, NULL, _addr)
+
 static IIO_DEV_ATTR_ACCEL_XY(adis16204_read_14bit_signed,
 		ADIS16204_XY_RSS_OUT);
-static IIO_DEV_ATTR_ACCEL_XPEAK(adis16204_read_14bit_signed,
-		ADIS16204_X_PEAK_OUT);
-static IIO_DEV_ATTR_ACCEL_YPEAK(adis16204_read_14bit_signed,
-		ADIS16204_Y_PEAK_OUT);
 static IIO_DEV_ATTR_ACCEL_XYPEAK(adis16204_read_14bit_signed,
 		ADIS16204_XY_PEAK_OUT);
 static IIO_CONST_ATTR(accel_xy_scale, "0.017125");
@@ -319,13 +320,16 @@ enum adis16204_channel {
 	accel_y,
 };
 
-static u8 adis16204_addresses[5][2] = {
+static u8 adis16204_addresses[5][3] = {
 	[in_supply] = { ADIS16204_SUPPLY_OUT },
 	[in_aux] = { ADIS16204_AUX_ADC },
 	[temp] = { ADIS16204_TEMP_OUT },
-	[accel_x] = { ADIS16204_XACCL_OUT, ADIS16204_XACCL_NULL },
-	[accel_y] = { ADIS16204_XACCL_OUT, ADIS16204_YACCL_NULL },
+	[accel_x] = { ADIS16204_XACCL_OUT, ADIS16204_XACCL_NULL,
+		      ADIS16204_X_PEAK_OUT },
+	[accel_y] = { ADIS16204_XACCL_OUT, ADIS16204_YACCL_NULL,
+		      ADIS16204_Y_PEAK_OUT },
 };
+
 static int adis16204_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int *val, int *val2,
@@ -335,6 +339,7 @@ static int adis16204_read_raw(struct iio_dev *indio_dev,
 	int bits;
 	u8 addr;
 	s16 val16;
+	int addrind;
 
 	switch (mask) {
 	case 0:
@@ -389,15 +394,16 @@ static int adis16204_read_raw(struct iio_dev *indio_dev,
 		*val = 25;
 		return IIO_VAL_INT;
 	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
-		switch (chan->type) {
-		case IIO_ACCEL:
+	case (1 << IIO_CHAN_INFO_PEAK_SEPARATE):
+		if (mask == (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE)) {
 			bits = 12;
-			break;
-		default:
-			return -EINVAL;
-		};
+			addrind = 1;
+		} else { /* PEAK_SEPARATE */
+			bits = 14;
+			addrind = 2;
+		}
 		mutex_lock(&indio_dev->mlock);
-		addr = adis16204_addresses[chan->address][1];
+		addr = adis16204_addresses[chan->address][addrind];
 		ret = adis16204_spi_read_reg_16(indio_dev, addr, &val16);
 		if (ret) {
 			mutex_unlock(&indio_dev->mlock);
@@ -453,21 +459,22 @@ static struct iio_chan_spec adis16204_channels[] = {
 		 IIO_ST('u', 12, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_PEAK_SEPARATE),
 		 accel_x, ADIS16204_SCAN_ACC_X,
 		 IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
 		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE) |
-		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE),
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_PEAK_SEPARATE),
 		 accel_y, ADIS16204_SCAN_ACC_Y,
 		 IIO_ST('s', 14, 16, 0), 0),
 	IIO_CHAN_SOFT_TIMESTAMP(5),
 };
+
 static struct attribute *adis16204_attributes[] = {
 	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_dev_attr_accel_xy.dev_attr.attr,
-	&iio_dev_attr_accel_xpeak.dev_attr.attr,
-	&iio_dev_attr_accel_ypeak.dev_attr.attr,
 	&iio_dev_attr_accel_xypeak.dev_attr.attr,
 	&iio_const_attr_accel_xy_scale.dev_attr.attr,
 	NULL
-- 
1.7.3.4
