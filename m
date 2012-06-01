Return-Path: <jic23@cam.ac.uk>
References: <1338565006-5682-1-git-send-email-leed.aguilar@ti.com>
In-Reply-To: <1338565006-5682-1-git-send-email-leed.aguilar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v3] staging:iio:magnetometer:ak8975: use gpio_request_one api
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Fri, 01 Jun 2012 18:30:13 +0100
To: Leed Aguilar <leed.aguilar@ti.com>,linux-iio@vger.kernel.org
CC: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b217f2db-08a9-4931-b86b-455ae923368a@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



Leed Aguilar <leed.aguilar@ti.com> wrote:

>Use gpio_request_one api, it =
looks cleaner.
>
>Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>

Acked-=
by: Jonathan Cameron <jic23@kernel.org>
>Cc: Jonathan Cameron <jic23@kernel=
.org>
>---
> drivers/staging/iio/magnetometer/Kconfig  |    2 +-
> drivers/=
staging/iio/magnetometer/ak8975.c |   10 +---------
> 2 files changed, 2 in=
sertions(+), 10 deletions(-)
>
>diff --git a/drivers/staging/iio/magnetomet=
er/Kconfig
>b/drivers/staging/iio/magnetometer/Kconfig
>index 722c4e1..e81d=
d9c 100644
>--- a/drivers/staging/iio/magnetometer/Kconfig
>+++ b/drivers/s=
taging/iio/magnetometer/Kconfig
>@@ -6,7 +6,7 @@ menu "Magnetometer sensors=
"
> config SENSORS_AK8975
> 	tristate "Asahi Kasei AK8975 3-Axis Magnetomet=
er"
> 	depends on I2C
>-	depends on GENERIC_GPIO
>+	depends on GPIOLIB
> 	h=
elp
> 	  Say yes here to build support for Asahi Kasei AK8975 3-Axis
> 	  M=
agnetometer.
>diff --git a/drivers/staging/iio/magnetometer/ak8975.c
>b/dri=
vers/staging/iio/magnetometer/ak8975.c
>index ebc2d08..52833cd 100644
>--- =
a/drivers/staging/iio/magnetometer/ak8975.c
>+++ b/drivers/staging/iio/magn=
etometer/ak8975.c
>@@ -487,21 +487,13 @@ static int ak8975_probe(struct i2c=
_client
>*client,
> 	/* We may not have a GPIO based IRQ to scan, that is f=
ine, we will
> 	   poll if so */
> 	if (gpio_is_valid(eoc_gpio)) {
>-		err =
=3D gpio_request(eoc_gpio, "ak_8975");
>+		err =3D gpio_request_one(eoc_gpi=
o, GPIOF_IN, "ak_8975");
> 		if (err < 0) {
> 			dev_err(&client->dev,
> 		=
		"failed to request GPIO %d, error %d\n",
> 							eoc_gpio, err);
> 			go=
to exit;
> 		}
>-
>-		err =3D gpio_direction_input(eoc_gpio);
>-		if (err <=
 0) {
>-			dev_err(&client->dev,
>-				"Failed to configure input direction=
 for GPIO %d, error %d\n",
>-						eoc_gpio, err);
>-			goto exit_gpio;
>-	=
	}
> 	}
> 
> 	/* Register with IIO */
>-- 
>1.7.1
>
>--
>To unsubscribe fro=
m this list: send the line "unsubscribe linux-iio" in
>the body of a messag=
e to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.=
org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Plea=
se excuse my brevity.
