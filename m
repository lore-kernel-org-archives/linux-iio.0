Return-Path: <bijosh.t@hotmail.com>
From: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
To: "jic23@kernel.org" <jic23@kernel.org>, "knaack.h@gmx.de"
	<knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net"
	<pmeerw@pmeerw.net>, "martink@posteo.de" <martink@posteo.de>,
	"christoph.muellner@theobroma-systems.com"
	<christoph.muellner@theobroma-systems.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] drivers:iio:accel:mma8452: removed unwanted return
 statements
Date: Mon, 4 Jul 2016 11:15:08 +0000
Message-ID: <KL1PR04MB12050202C107FB05AAB8EAEA80380@KL1PR04MB1205.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Removed unwanted return statements from the function
mma8452_set_freefall_mode.

Signed-off-by: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
---
 drivers/iio/accel/mma8452.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index e225d3c..d4a6d44 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -518,11 +518,7 @@ static int mma8452_set_freefall_mode(struct mma8452_da=
ta *data, bool state)
 		val |=3D MMA8452_FF_MT_CFG_OAE;
 	}
=20
-	val =3D mma8452_change_config(data, chip->ev_cfg, val);
-	if (val)
-		return val;
-
-	return 0;
+	return mma8452_change_config(data, chip->ev_cfg, val);
 }
=20
 static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
--=20
2.1.4
