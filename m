Return-Path: <Sonic.Zhang@analog.com>
From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
To: Sascha Hauer <s.hauer@pengutronix.de>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 3 Jul 2012 06:43:04 -0400
Subject: RE: [PATCH] stagin iio adt7410: use local platformdata if none is
 specified
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D17140805E7A@NWD2CMBX1.ad.analog.com>
References: <1341307673-7936-1-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1341307673-7936-1-git-send-email-s.hauer@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Acked-by: Sonic Zhang <sonic.zhang@analog.com>

>-----Original Message-----
>From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
>Sent: Tuesday, July 03, 2012 5:28 PM
>To: linux-iio@vger.kernel.org
>Cc: Jonathan Cameron; Zhang, Sonic; Sascha Hauer
>Subject: [PATCH] stagin iio adt7410: use local platformdata if none is spe=
cified
>
>The adt7410 expects information about an irq in platform_data.
>The driver can work without an irq, so make platform_data optional
>by specifying a dummy platform_data if the device has none.
>
>Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>---
>
>This should have been part of the other series for the adt7410 I just sent=
,
>but I overlooked this patch.
>
> drivers/staging/iio/adc/adt7410.c |    4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/a=
dt7410.c
>index 917b692..d7d9ad9 100644
>--- a/drivers/staging/iio/adc/adt7410.c
>+++ b/drivers/staging/iio/adc/adt7410.c
>@@ -720,6 +720,7 @@ static int __devinit adt7410_probe(struct i2c_client *=
client,
>       struct iio_dev *indio_dev;
>       int ret =3D 0;
>       unsigned long *adt7410_platform_data =3D client->dev.platform_data;
>+      unsigned long local_pdata[] =3D {0, 0};
>
>       indio_dev =3D iio_device_alloc(sizeof(*chip));
>       if (indio_dev =3D=3D NULL) {
>@@ -737,6 +738,9 @@ static int __devinit adt7410_probe(struct i2c_client *=
client,
>       indio_dev->info =3D &adt7410_info;
>       indio_dev->modes =3D INDIO_DIRECT_MODE;
>
>+      if (!adt7410_platform_data)
>+              adt7410_platform_data =3D local_pdata;
>+
>       /* CT critcal temperature event. line 0 */
>       if (client->irq) {
>               ret =3D request_threaded_irq(client->irq,
>--
>1.7.10
>
