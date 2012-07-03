Return-Path: <Sonic.Zhang@analog.com>
From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
To: Sascha Hauer <s.hauer@pengutronix.de>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 3 Jul 2012 06:41:40 -0400
Subject: RE: [PATCH 1/3] staging iio adt7410: sysfs store function must
 return length
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D17140805E77@NWD2CMBX1.ad.analog.com>
References: <1341307288-1926-1-git-send-email-s.hauer@pengutronix.de>
 <1341307288-1926-2-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1341307288-1926-2-git-send-email-s.hauer@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Acked-by: Sonic Zhang <sonic.zhang@analog.com>

>-----Original Message-----
>From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
>Sent: Tuesday, July 03, 2012 5:21 PM
>To: linux-iio@vger.kernel.org
>Cc: Jonathan Cameron; Zhang, Sonic; Sascha Hauer
>Subject: [PATCH 1/3] staging iio adt7410: sysfs store function must return=
 length
>
>Otherwise a write to the resolution entry never returns.
>
>Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>---
> drivers/staging/iio/adc/adt7410.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/a=
dt7410.c
>index d7d9ad9..fa54a40 100644
>--- a/drivers/staging/iio/adc/adt7410.c
>+++ b/drivers/staging/iio/adc/adt7410.c
>@@ -257,7 +257,7 @@ static ssize_t adt7410_store_resolution(struct device
>*dev,
>
>       chip->config =3D config;
>
>-      return ret;
>+      return len;
> }
>
> static IIO_DEVICE_ATTR(resolution, S_IRUGO | S_IWUSR,
>--
>1.7.10
>
