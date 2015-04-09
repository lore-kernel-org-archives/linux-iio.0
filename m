Return-Path: <sathyanarayanan.kuppuswamy@intel.com>
From: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
To: "Baluta, Daniel" <daniel.baluta@intel.com>, "jic23@kernel.org"
	<jic23@kernel.org>
CC: "knaack.h@gmx.de" <knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: light: ltr501: Fix alignment to match open
 parenthesis
Date: Thu, 9 Apr 2015 14:51:54 +0000
Message-ID: <EF0FAAD101DE534CAD726F2BFBA868D34264B683@ORSMSX113.amr.corp.intel.com>
References: <1428589067-3582-1-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1428589067-3582-1-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Daniel,

You have asked me to include this patch in my LTR501 patch set. I have alre=
ady sent few versions of my patch set with your patch. Do you want to submi=
t it again separately?

--
Sathyanarayanan KN

-----Original Message-----
From: Baluta, Daniel=20
Sent: Thursday, April 09, 2015 7:18 AM
To: jic23@kernel.org
Cc: knaack.h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net; Baluta, Daniel; li=
nux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Kuppuswamy, Sathyana=
rayanan
Subject: [PATCH] iio: light: ltr501: Fix alignment to match open parenthesi=
s

This makes ltr501 code consistent with the coding style adopted for the new=
 drivers added to IIO.
We prepare the path for adding support for LTR559 chip.

Reported by checkpatch.pl

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
Changes since v1:
	* rebased on top of 1ca510b0ea6 ("iio: light: ltr501: Powerdown device on =
error")
	* separated from path series related to LTR559 support because there are s=
till things
	to do there: http://marc.info/?l=3Dlinux-kernel&m=3D142779827617036&w=3D2

 drivers/iio/light/ltr501.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c index =
78b8783..f208c98 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -58,7 +58,7 @@ static int ltr501_drdy(struct ltr501_data *data, u8 drdy_=
mask)
=20
 	while (tries--) {
 		ret =3D i2c_smbus_read_byte_data(data->client,
-			LTR501_ALS_PS_STATUS);
+					       LTR501_ALS_PS_STATUS);
 		if (ret < 0)
 			return ret;
 		if ((ret & drdy_mask) =3D=3D drdy_mask)
@@ -77,7 +77,8 @@ static int ltr501_read_als(struct ltr501_data *data, __le=
16 buf[2])
 		return ret;
 	/* always read both ALS channels in given order */
 	return i2c_smbus_read_i2c_block_data(data->client,
-		LTR501_ALS_DATA1, 2 * sizeof(__le16), (u8 *) buf);
+					     LTR501_ALS_DATA1,
+					     2 * sizeof(__le16), (u8 *)buf);
 }
=20
 static int ltr501_read_ps(struct ltr501_data *data) @@ -107,7 +108,7 @@ st=
atic int ltr501_read_ps(struct ltr501_data *data)  static const struct iio_=
chan_spec ltr501_channels[] =3D {
 	LTR501_INTENSITY_CHANNEL(0, LTR501_ALS_DATA0, IIO_MOD_LIGHT_BOTH, 0),
 	LTR501_INTENSITY_CHANNEL(1, LTR501_ALS_DATA1, IIO_MOD_LIGHT_IR,
-		BIT(IIO_CHAN_INFO_SCALE)),
+				 BIT(IIO_CHAN_INFO_SCALE)),
 	{
 		.type =3D IIO_PROXIMITY,
 		.address =3D LTR501_PS_DATA,
@@ -129,8 +130,8 @@ static const int ltr501_ps_gain[4][2] =3D {  };
=20
 static int ltr501_read_raw(struct iio_dev *indio_dev,
-				struct iio_chan_spec const *chan,
-				int *val, int *val2, long mask)
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
 {
 	struct ltr501_data *data =3D iio_priv(indio_dev);
 	__le16 buf[2];
@@ -149,7 +150,7 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 			if (ret < 0)
 				return ret;
 			*val =3D le16_to_cpu(chan->address =3D=3D LTR501_ALS_DATA1 ?
-				buf[0] : buf[1]);
+					   buf[0] : buf[1]);
 			return IIO_VAL_INT;
 		case IIO_PROXIMITY:
 			mutex_lock(&data->lock_ps);
@@ -199,8 +200,8 @@ static int ltr501_get_ps_gain_index(int val, int val2) =
 }
=20
 static int ltr501_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val, int val2, long mask)
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
 {
 	struct ltr501_data *data =3D iio_priv(indio_dev);
 	int i;
@@ -219,7 +220,8 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 			else
 				return -EINVAL;
 			return i2c_smbus_write_byte_data(data->client,
-				LTR501_ALS_CONTR, data->als_contr);
+							 LTR501_ALS_CONTR,
+							 data->als_contr);
 		case IIO_PROXIMITY:
 			i =3D ltr501_get_ps_gain_index(val, val2);
 			if (i < 0)
@@ -227,7 +229,8 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 			data->ps_contr &=3D ~LTR501_CONTR_PS_GAIN_MASK;
 			data->ps_contr |=3D i << LTR501_CONTR_PS_GAIN_SHIFT;
 			return i2c_smbus_write_byte_data(data->client,
-				LTR501_PS_CONTR, data->ps_contr);
+							 LTR501_PS_CONTR,
+							 data->ps_contr);
 		default:
 			return -EINVAL;
 		}
@@ -279,7 +282,7 @@ static irqreturn_t ltr501_trigger_handler(int irq, void=
 *p)
=20
 	/* figure out which data needs to be ready */
 	if (test_bit(0, indio_dev->active_scan_mask) ||
-		test_bit(1, indio_dev->active_scan_mask))
+	    test_bit(1, indio_dev->active_scan_mask))
 		mask |=3D LTR501_STATUS_ALS_RDY;
 	if (test_bit(2, indio_dev->active_scan_mask))
 		mask |=3D LTR501_STATUS_PS_RDY;
@@ -290,7 +293,9 @@ static irqreturn_t ltr501_trigger_handler(int irq, void=
 *p)
=20
 	if (mask & LTR501_STATUS_ALS_RDY) {
 		ret =3D i2c_smbus_read_i2c_block_data(data->client,
-			LTR501_ALS_DATA1, sizeof(als_buf), (u8 *) als_buf);
+						    LTR501_ALS_DATA1,
+						    sizeof(als_buf),
+						    (u8 *)als_buf);
 		if (ret < 0)
 			return ret;
 		if (test_bit(0, indio_dev->active_scan_mask)) @@ -306,8 +311,7 @@ static=
 irqreturn_t ltr501_trigger_handler(int irq, void *p)
 		buf[j++] =3D ret & LTR501_PS_DATA_MASK;
 	}
=20
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
-		iio_get_time_ns());
+	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
=20
 done:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -330,7 +334,7 @@ static int ltr501_init(struct ltr501_data *data)
 	data->ps_contr =3D ret | LTR501_CONTR_ACTIVE;
=20
 	return ltr501_write_contr(data->client, data->als_contr,
-		data->ps_contr);
+				  data->ps_contr);
 }
=20
 static int ltr501_powerdown(struct ltr501_data *data) @@ -341,7 +345,7 @@ =
static int ltr501_powerdown(struct ltr501_data *data)  }
=20
 static int ltr501_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
+			const struct i2c_device_id *id)
 {
 	struct ltr501_data *data;
 	struct iio_dev *indio_dev;
@@ -375,7 +379,7 @@ static int ltr501_probe(struct i2c_client *client,
 		return ret;
=20
 	ret =3D iio_triggered_buffer_setup(indio_dev, NULL,
-		ltr501_trigger_handler, NULL);
+					 ltr501_trigger_handler, NULL);
 	if (ret)
 		goto powerdown_on_error;
=20
@@ -407,14 +411,14 @@ static int ltr501_remove(struct i2c_client *client)  =
static int ltr501_suspend(struct device *dev)  {
 	struct ltr501_data *data =3D iio_priv(i2c_get_clientdata(
-		to_i2c_client(dev)));
+					    to_i2c_client(dev)));
 	return ltr501_powerdown(data);
 }
=20
 static int ltr501_resume(struct device *dev)  {
 	struct ltr501_data *data =3D iio_priv(i2c_get_clientdata(
-		to_i2c_client(dev)));
+					    to_i2c_client(dev)));
=20
 	return ltr501_write_contr(data->client, data->als_contr,
 		data->ps_contr);
--
1.9.1
