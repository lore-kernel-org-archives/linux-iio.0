Return-Path: <neilb@suse.de>
Date: Tue, 24 Feb 2015 13:24:41 +1100
From: NeilBrown <neilb@suse.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners
 <gta04-owner@goldelico.com>, Doug Anderson <dianders@chromium.org>,
 Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>, Manuel Stahl
 <manuel.stahl@iis.fraunhofer.de>, Christian Strobel
 <christian.strobel@iis.fraunhofer.de>, Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH v2] iio: gyro: itg3200: add suspend/resume support.
Message-ID: <20150224132441.2cb8ae6d@notabene.brown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/_ACoLr95MR.wTVDaWAB65Ub"; protocol="application/pgp-signature"
List-ID: <linux-iio@vger.kernel.org>

--Sig_/_ACoLr95MR.wTVDaWAB65Ub
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


Unless we put the device to sleep when not it use, it wastes
6mA.

If the device is asleep on probe, the 'id' register
sometimes mis-reads - so reset first.  If the device responds
at all a command sent to the address, it is almost certainly
the correct device already.

Acked-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Signed-off-by: NeilBrown <neil@brown.name>

---
v1 of this was sent in November.  I got some useful feedback, but then got =
distracted
by something.  Sorry for the long gap.
NeilBrown


diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_cor=
e.c
index 6a8020d48140..f0fd94055d88 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -223,6 +223,10 @@ static int itg3200_initial_setup(struct iio_dev *indio=
_dev)
 	int ret;
 	u8 val;
=20
+	ret =3D itg3200_reset(indio_dev);
+	if (ret)
+		goto err_ret;
+
 	ret =3D itg3200_read_reg_8(indio_dev, ITG3200_REG_ADDRESS, &val);
 	if (ret)
 		goto err_ret;
@@ -233,10 +237,6 @@ static int itg3200_initial_setup(struct iio_dev *indio=
_dev)
 		goto err_ret;
 	}
=20
-	ret =3D itg3200_reset(indio_dev);
-	if (ret)
-		goto err_ret;
-
 	ret =3D itg3200_enable_full_scale(indio_dev);
 err_ret:
 	return ret;
@@ -351,6 +351,26 @@ static int itg3200_remove(struct i2c_client *client)
 	return 0;
 }
=20
+static int __maybe_unused itg3200_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+	struct itg3200 *st =3D iio_priv(indio_dev);
+
+	dev_dbg(&st->i2c->dev, "suspend device");
+
+	return itg3200_write_reg_8(indio_dev, ITG3200_REG_POWER_MANAGEMENT,
+				   ITG3200_SLEEP);
+}
+
+static int __maybe_unused itg3200_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+
+	return itg3200_initial_setup(indio_dev);
+}
+
+static SIMPLE_DEV_PM_OPS(itg3200_pm_ops, itg3200_suspend, itg3200_resume);
+
 static const struct i2c_device_id itg3200_id[] =3D {
 	{ "itg3200", 0 },
 	{ }
@@ -361,6 +381,7 @@ static struct i2c_driver itg3200_driver =3D {
 	.driver =3D {
 		.owner  =3D THIS_MODULE,
 		.name	=3D "itg3200",
+		.pm	=3D &itg3200_pm_ops,
 	},
 	.id_table	=3D itg3200_id,
 	.probe		=3D itg3200_probe,

--Sig_/_ACoLr95MR.wTVDaWAB65Ub
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVOvg6Tnsnt1WYoG5AQI0Sg/9Ex04ScBIxZDjrNV8hmFUJ8+zbfLNgXY4
9hcujk4Rm4LtzwLEy3i4U2RS/qUgNOxbrkew/Q+PSPGpo9kk3CdbflTtapNDSP7t
W72jJsr2T8hTDJZN7ylBELpilxajYePpch4KvtWaiCrkm6lGXuzB7i6v41AHrz9m
kFo6eqMzpZUprel/O5ZNwLM3oQffecd5HHuLJkhskL5mRpwNUSfZxqoO1go0e64e
hy6tsftM56+qBLA1WYbXVBtpHWrnbuKVMiGsSlGPBSKoa8uzDQYB73RdssytID/p
TZerC0g57oIh+VvKhm7eF72RJpMZ6r/fsaiMlcFVhFdo7+LfGkbhWLewU5bQ3A5m
FWGg5aryew+/nlSneAgTEJZra0mpz7sGOK0JcX+4vPuAqYk+rgcSrUSIyx7vqsK3
GKu5561YMBzG3DZ8mbHl6TSut/ycG3u2tZnitSnkPOxEpEZ45GTXQUkkoit6T0lM
HbqTllBqJDYfO/dV08AlGPSf1Ands0adUEcDX38IvgDPwm6OtP69Lc1tACvpbClP
9VUMCnNwSKxNhtWKBMp7zufTn1wa5yNWwsIY6zdcK9CscOkL7wETUiAnSFy2pbPb
sp3wOAOIPkxy35qac2UBqeKjmc+z8+kE5k3eXjmkqQFHqAu1rQ7towQFxYVhvBA5
7aamxEtopdM=
=rTga
-----END PGP SIGNATURE-----

--Sig_/_ACoLr95MR.wTVDaWAB65Ub--
