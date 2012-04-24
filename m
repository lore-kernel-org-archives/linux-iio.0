Return-Path: <jbrenner@TAOSinc.com>
Subject: [PATCH V9a] TAOS tsl2x7x
From: Jon Brenner <jbrenner@taosinc.com>
To: gregkh <gregkh@linuxfoundation.org>, Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio <linux-iio@vger.kernel.org>, Linux Kernel
 <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Apr 2012 17:59:10 -0500
Message-ID: <1335308350.18759.3.camel@jonz-ub2>
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

TAOS (version 9a) tsl2x7x driver change / bug fix.

Fixed - removed decimal multiplications.
        Added missing 'static' declarations
        Fixed _read_raw case logic to allow reading of _PROCESSED IIO_LIGHT
	Replaced udelay with mdelay to accomodate eabi.

Signed-off-by: Jon Brenner <jbrenner@taosinc.com>
---
 drivers/staging/iio/light/tsl2x7x_core.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio=
/light/tsl2x7x_core.c
index ff44989..f3fc85a 100755
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -130,6 +130,8 @@
 		(IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) | \
 		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING)),

+#define TSL2X7X_MIN_ITIME 3
+
 /* TAOS txx2x7x Device family members */
 enum {
 	tsl2571,
@@ -277,7 +279,7 @@ enum {
 	ALSPRX2,
 };

-const u8 device_channel_config[] =3D {
+static const u8 device_channel_config[] =3D {
 	ALS,
 	PRX,
 	PRX,
@@ -778,7 +780,7 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 		}
 	}

-	udelay(3000);	/* Power-on settling time */
+	mdelay(3);	/* Power-on settling time */

 	/* NOW enable the ADC
 	 * initialize the desired mode of operation */
@@ -853,6 +855,7 @@ static int tsl2x7x_chip_off(struct iio_dev *indio_dev)
  * put device back into proper state, and unlock
  * resource.
  */
+static
 int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
 {
 	struct tsl2X7X_chip *chip =3D iio_priv(indio_dev);
@@ -1021,7 +1024,7 @@ static ssize_t tsl2x7x_als_time_show(struct device *d=
ev,
 	int y, z;

 	y =3D (TSL2X7X_MAX_TIMER_CNT - (u8)chip->tsl2x7x_settings.als_time) + 1;
-	z =3D y * 2.72;
+	z =3D y * TSL2X7X_MIN_ITIME;
 	y /=3D 1000;
 	z %=3D 1000;

@@ -1092,7 +1095,7 @@ static ssize_t tsl2x7x_als_persistence_show(struct de=
vice *dev,

 	/* Determine integration time */
 	y =3D (TSL2X7X_MAX_TIMER_CNT - (u8)chip->tsl2x7x_settings.als_time) + 1;
-	z =3D y * 2.72;
+	z =3D y * TSL2X7X_MIN_ITIME;
 	filter_delay =3D z * (chip->tsl2x7x_settings.persistence & 0x0F);
 	y =3D (filter_delay / 1000);
 	z =3D (filter_delay % 1000);
@@ -1114,7 +1117,7 @@ static ssize_t tsl2x7x_als_persistence_store(struct d=
evice *dev,

 	result.fract /=3D 1000;
 	y =3D (TSL2X7X_MAX_TIMER_CNT - (u8)chip->tsl2x7x_settings.als_time) + 1;
-	z =3D y * 2.72;
+	z =3D y * TSL2X7X_MIN_ITIME;

 	filter_delay =3D
 		DIV_ROUND_UP(((result.integer * 1000) + result.fract), z);
@@ -1138,7 +1141,7 @@ static ssize_t tsl2x7x_prox_persistence_show(struct d=
evice *dev,

 	/* Determine integration time */
 	y =3D (TSL2X7X_MAX_TIMER_CNT - (u8)chip->tsl2x7x_settings.prx_time) + 1;
-	z =3D y * 2.72;
+	z =3D y * TSL2X7X_MIN_ITIME;
 	filter_delay =3D z * ((chip->tsl2x7x_settings.persistence & 0xF0) >> 4);
 	y =3D (filter_delay / 1000);
 	z =3D (filter_delay % 1000);
@@ -1160,7 +1163,7 @@ static ssize_t tsl2x7x_prox_persistence_store(struct =
device *dev,

 	result.fract /=3D 1000;
 	y =3D (TSL2X7X_MAX_TIMER_CNT - (u8)chip->tsl2x7x_settings.prx_time) + 1;
-	z =3D y * 2.72;
+	z =3D y * TSL2X7X_MIN_ITIME;

 	filter_delay =3D
 		DIV_ROUND_UP(((result.integer * 1000) + result.fract), z);
@@ -1389,13 +1392,20 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_d=
ev,
 	struct tsl2X7X_chip *chip =3D iio_priv(indio_dev);

 	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_LIGHT:
 			tsl2x7x_get_lux(indio_dev);
 			*val =3D chip->als_cur_info.lux;
 			ret =3D IIO_VAL_INT;
 			break;
+		default:
+			return -EINVAL;
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
 		case IIO_INTENSITY:
 			tsl2x7x_get_lux(indio_dev);
 			if (chan->channel =3D=3D 0)
--
1.7.4.1
