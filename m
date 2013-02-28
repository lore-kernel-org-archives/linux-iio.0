Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 28 Feb 2013 09:25:37 +0000
Subject: RE: [PATCH 54/67] staging:iio:cdc:ad7746 move to
 info_mask_(shared_by_type/separate)
Message-ID: <544AC56F16B56944AEC3BD4E3D591771602C51E75D@LIMKCMBX1.ad.analog.com>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
 <1361997553-31058-55-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-55-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



-----Original Message-----
From: Jonathan Cameron [mailto:jic23@kernel.org]=20
Sent: Mittwoch, 27. Februar 2013 21:39
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron; Hennerich, Michael; Lars-Peter Clausen
Subject: [PATCH 54/67] staging:iio:cdc:ad7746 move to info_mask_(shared_by_=
type/separate)

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Michael Hennerich <michael.hennerich@analog.com>
cc: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

All CC: me

---
 drivers/staging/iio/cdc/ad7746.c | 48 ++++++++++++++++++------------------=
----
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7=
746.c
index 466b82e..2789839 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -123,8 +123,8 @@ static const struct iio_chan_spec ad7746_channels[] =3D=
 {
 		.type =3D IIO_VOLTAGE,
 		.indexed =3D 1,
 		.channel =3D 0,
-		.info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate =3D IIO_CHAN_INFO_RAW,
+		.info_mask_shared_by_type =3D IIO_CHAN_INFO_SCALE,
 		.address =3D AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_EXT_VIN,
 	},
@@ -133,8 +133,8 @@ static const struct iio_chan_spec ad7746_channels[] =3D=
 {
 		.indexed =3D 1,
 		.channel =3D 1,
 		.extend_name =3D "supply",
-		.info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate =3D IIO_CHAN_INFO_RAW,
+		.info_mask_shared_by_type =3D IIO_CHAN_INFO_SCALE,
 		.address =3D AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_VDD_MON,
 	},
@@ -142,7 +142,7 @@ static const struct iio_chan_spec ad7746_channels[] =3D=
 {
 		.type =3D IIO_TEMP,
 		.indexed =3D 1,
 		.channel =3D 0,
-		.info_mask =3D IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
+		.info_mask_separate =3D IIO_CHAN_INFO_PROCESSED,
 		.address =3D AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_INT_TEMP,
 	},
@@ -150,7 +150,7 @@ static const struct iio_chan_spec ad7746_channels[] =3D=
 {
 		.type =3D IIO_TEMP,
 		.indexed =3D 1,
 		.channel =3D 1,
-		.info_mask =3D IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
+		.info_mask_separate =3D IIO_CHAN_INFO_PROCESSED,
 		.address =3D AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_EXT_TEMP,
 	},
@@ -158,11 +158,10 @@ static const struct iio_chan_spec ad7746_channels[] =
=3D {
 		.type =3D IIO_CAPACITANCE,
 		.indexed =3D 1,
 		.channel =3D 0,
-		.info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate =3D IIO_CHAN_INFO_RAW |
+		IIO_CHAN_INFO_CALIBSCALE | IIO_CHAN_INFO_OFFSET,
+		.info_mask_shared_by_type =3D IIO_CHAN_INFO_CALIBBIAS |
+		IIO_CHAN_INFO_SCALE,
 		.address =3D AD7746_REG_CAP_DATA_HIGH << 8,
 	},
 	[CIN1_DIFF] =3D {
@@ -171,11 +170,10 @@ static const struct iio_chan_spec ad7746_channels[] =
=3D {
 		.indexed =3D 1,
 		.channel =3D 0,
 		.channel2 =3D 2,
-		.info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate =3D IIO_CHAN_INFO_RAW |
+		IIO_CHAN_INFO_CALIBSCALE | IIO_CHAN_INFO_OFFSET,
+		.info_mask_shared_by_type =3D IIO_CHAN_INFO_CALIBBIAS |
+		IIO_CHAN_INFO_SCALE,
 		.address =3D AD7746_REG_CAP_DATA_HIGH << 8 |
 			AD7746_CAPSETUP_CAPDIFF
 	},
@@ -183,11 +181,10 @@ static const struct iio_chan_spec ad7746_channels[] =
=3D {
 		.type =3D IIO_CAPACITANCE,
 		.indexed =3D 1,
 		.channel =3D 1,
-		.info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate =3D IIO_CHAN_INFO_RAW |
+		IIO_CHAN_INFO_CALIBSCALE | IIO_CHAN_INFO_OFFSET,
+		.info_mask_shared_by_type =3D IIO_CHAN_INFO_CALIBBIAS |
+		IIO_CHAN_INFO_SCALE,
 		.address =3D AD7746_REG_CAP_DATA_HIGH << 8 |
 			AD7746_CAPSETUP_CIN2,
 	},
@@ -197,11 +194,10 @@ static const struct iio_chan_spec ad7746_channels[] =
=3D {
 		.indexed =3D 1,
 		.channel =3D 1,
 		.channel2 =3D 3,
-		.info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |
-		IIO_CHAN_INFO_CALIBBIAS_SHARED_BIT |
-		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT |
-		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.info_mask_separate =3D IIO_CHAN_INFO_RAW |
+		IIO_CHAN_INFO_CALIBSCALE | IIO_CHAN_INFO_OFFSET,
+		.info_mask_shared_by_type =3D IIO_CHAN_INFO_CALIBBIAS |
+		IIO_CHAN_INFO_SCALE,
 		.address =3D AD7746_REG_CAP_DATA_HIGH << 8 |
 			AD7746_CAPSETUP_CAPDIFF | AD7746_CAPSETUP_CIN2,
 	}
--=20
1.8.1.1
