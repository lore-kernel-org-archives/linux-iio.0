Return-Path: <bijosh.t@hotmail.com>
From: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
To: "jic23@kernel.org" <jic23@kernel.org>, "knaack.h@gmx.de"
	<knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net"
	<pmeerw@pmeerw.net>, "martink@posteo.de" <martink@posteo.de>,
	"christoph.muellner@theobroma-systems.com"
	<christoph.muellner@theobroma-systems.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] drivers:iio:accel:mma8452: added cleanup provision in case
 of failure.
Date: Mon, 4 Jul 2016 10:08:53 +0000
Message-ID: <KL1PR04MB1205AC29D431BAF1527101F980380@KL1PR04MB1205.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

mma8452_set_freefall_mode can return -ve value in case if
i2c_smbus_read_byte_data fails. This function is called from mma8452_probe,
and returning -ve value from probe indicates probe failure. Need to call
iio_triggered_buffer_cleanup & iio_trigger_cleanup in this case.

Signed-off-by: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
---
 drivers/iio/accel/mma8452.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index e225d3c..1bcf5c3 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1444,8 +1444,8 @@ static int mma8452_probe(struct i2c_client *client,
 		goto buffer_cleanup;
=20
 	ret =3D mma8452_set_freefall_mode(data, false);
-	if (ret)
-		return ret;
+	if (ret < 0)
+		goto buffer_cleanup;
=20
 	return 0;
=20
--=20
2.1.4
