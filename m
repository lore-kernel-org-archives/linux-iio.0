Return-Path: <bijosh.t@hotmail.com>
From: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
To: "jic23@kernel.org" <jic23@kernel.org>, "knaack.h@gmx.de"
	<knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net"
	<pmeerw@pmeerw.net>, "k.kozlowski@samsung.com" <k.kozlowski@samsung.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drivers:iio:light:isl29125: added macros for sensing range
Date: Mon, 27 Jun 2016 15:37:41 +0000
Message-ID: <KL1PR04MB1205FC759593484E11F486A280210@KL1PR04MB1205.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Added macros for sensing range as the corresponding magic numbers
were used at multiple places.
   - ISL29125_SENSING_RANGE_0 for 375 lux full range
   - ISL29125_SENSING_RANGE_1 for 10k lux full range

Signed-off-by: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
---
 drivers/iio/light/isl29125.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index e2945a2..d0aa802 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -44,6 +44,9 @@
 #define ISL29125_MODE_B 0x3
 #define ISL29125_MODE_RGB 0x5
=20
+#define ISL29125_SENSING_RANGE_0 5722   /* 375 lux full range */
+#define ISL29125_SENSING_RANGE_1 152590 /* 10k lux full range */
+
 #define ISL29125_MODE_RANGE BIT(3)
=20
 #define ISL29125_STATUS_CONV BIT(1)
@@ -140,9 +143,9 @@ static int isl29125_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		*val =3D 0;
 		if (data->conf1 & ISL29125_MODE_RANGE)
-			*val2 =3D 152590; /* 10k lux full range */
+			*val2 =3D ISL29125_SENSING_RANGE_1; /*10k lux full range*/
 		else
-			*val2 =3D 5722; /* 375 lux full range */
+			*val2 =3D ISL29125_SENSING_RANGE_0; /*375 lux full range*/
 		return IIO_VAL_INT_PLUS_MICRO;
 	}
 	return -EINVAL;
@@ -158,9 +161,9 @@ static int isl29125_write_raw(struct iio_dev *indio_dev=
,
 	case IIO_CHAN_INFO_SCALE:
 		if (val !=3D 0)
 			return -EINVAL;
-		if (val2 =3D=3D 152590)
+		if (val2 =3D=3D ISL29125_SENSING_RANGE_1)
 			data->conf1 |=3D ISL29125_MODE_RANGE;
-		else if (val2 =3D=3D 5722)
+		else if (val2 =3D=3D ISL29125_SENSING_RANGE_0)
 			data->conf1 &=3D ~ISL29125_MODE_RANGE;
 		else
 			return -EINVAL;
--=20
2.1.4
