Return-Path: <bijosh.t@hotmail.com>
Message-ID: <BLU185-W19B0BC5AB22B590EF2F58380B90@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_c61e0dec-4dc7-465c-ae7b-1a36f6ae8781_"
From: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jic23@kernel.org" <jic23@kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC: "mahfouz.saif.elyazal@gmail.com" <mahfouz.saif.elyazal@gmail.com>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 1/1] staging: coding style cleanpus for
 staging/iio/light/tsl2583 driver
Date: Sun, 28 Feb 2016 22:14:14 +0530
In-Reply-To: <BLU436-SMTP17745B747C383EE9FA50C6F80B90@phx.gbl>
References: <BLU436-SMTP17745B747C383EE9FA50C6F80B90@phx.gbl>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

--_c61e0dec-4dc7-465c-ae7b-1a36f6ae8781_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Please ignore this patch as there is some typos in the commit message. Will=
 be sending new version by correcting the typos.=0A=
=0A=
> From: bijosh.t@hotmail.com=0A=
> To: gregkh@linuxfoundation.org=3B jic23@kernel.org=3B knaack.h@gmx.de=3B =
lars@metafoo.de=3B pmeerw@pmeerw.net=0A=
> CC: mahfouz.saif.elyazal@gmail.com=3B devel@driverdev.osuosl.org=3B linux=
-iio@vger.kernel.org=0A=
> Subject: [PATCH 1/1] staging: coding style cleanpus for staging/iio/light=
/tsl2583 driver=0A=
> Date: Sun=2C 28 Feb 2016 13:27:15 +0530=0A=
> =0A=
> This patch fixes following coding style warning for reported by=0A=
> check patch scrpit:=0A=
>     - Block comments use a trailing */ on a separate line=0A=
> =0A=
> Signed-off-by: Bijosh Thykkoottathil =0A=
> ---=0A=
>  drivers/staging/iio/light/tsl2583.c | 15 ++++++++++-----=0A=
>  1 file changed=2C 10 insertions(+)=2C 5 deletions(-)=0A=
> =0A=
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/li=
ght/tsl2583.c=0A=
> index 3100d96..9159298 100644=0A=
> --- a/drivers/staging/iio/light/tsl2583.c=0A=
> +++ b/drivers/staging/iio/light/tsl2583.c=0A=
> @@ -241=2C7 +241=2C8 @@ static int taos_get_lux(struct iio_dev *indio_dev=
)=0A=
>  	}=0A=
>  =0A=
>  	/* clear status=2C really interrupt status (interrupts are off)=2C but=
=0A=
> -	 * we use the bit anyway - don't forget 0x80 - this is a command*/=0A=
> +	 * we use the bit anyway - don't forget 0x80 - this is a command=0A=
> +	 */=0A=
>  	ret =3D i2c_smbus_write_byte(chip->client=2C=0A=
>  				   (TSL258X_CMD_REG | TSL258X_CMD_SPL_FN |=0A=
>  				    TSL258X_CMD_ALS_INT_CLR))=3B=0A=
> @@ -430=2C7 +431=2C8 @@ static int taos_chip_on(struct iio_dev *indio_dev=
)=0A=
>  	chip->als_time_scale =3D (als_time + 25) / 50=3B=0A=
>  =0A=
>  	/* TSL258x Specific power-on / adc enable sequence=0A=
> -	 * Power on the device 1st. */=0A=
> +	 * Power on the device 1st.=0A=
> +	 */=0A=
>  	utmp =3D TSL258X_CNTL_PWR_ON=3B=0A=
>  	ret =3D i2c_smbus_write_byte_data(chip->client=2C=0A=
>  					TSL258X_CMD_REG | TSL258X_CNTRL=2C utmp)=3B=0A=
> @@ -440=2C7 +442=2C8 @@ static int taos_chip_on(struct iio_dev *indio_dev=
)=0A=
>  	}=0A=
>  =0A=
>  	/* Use the following shadow copy for our delay before enabling ADC.=0A=
> -	 * Write all the registers. */=0A=
> +	 * Write all the registers.=0A=
> +	 */=0A=
>  	for (i =3D 0=2C uP =3D chip->taos_config=3B i < TSL258X_REG_MAX=3B i++)=
 {=0A=
>  		ret =3D i2c_smbus_write_byte_data(chip->client=2C=0A=
>  						TSL258X_CMD_REG + i=2C=0A=
> @@ -454=2C7 +457=2C8 @@ static int taos_chip_on(struct iio_dev *indio_dev=
)=0A=
>  =0A=
>  	usleep_range(3000=2C 3500)=3B=0A=
>  	/* NOW enable the ADC=0A=
> -	 * initialize the desired mode of operation */=0A=
> +	 * initialize the desired mode of operation=0A=
> +	 */=0A=
>  	utmp =3D TSL258X_CNTL_PWR_ON | TSL258X_CNTL_ADC_ENBL=3B=0A=
>  	ret =3D i2c_smbus_write_byte_data(chip->client=2C=0A=
>  					TSL258X_CMD_REG | TSL258X_CNTRL=2C=0A=
> @@ -696=2C7 +700=2C8 @@ static ssize_t taos_luxtable_show(struct device *=
dev=2C=0A=
>  				  taos_device_lux[i].ch1)=3B=0A=
>  		if (taos_device_lux[i].ratio =3D=3D 0) {=0A=
>  			/* We just printed the first "0" entry.=0A=
> -			 * Now get rid of the extra "=2C" and break. */=0A=
> +			 * Now get rid of the extra "=2C" and break.=0A=
> +			 */=0A=
>  			offset--=3B=0A=
>  			break=3B=0A=
>  		}=0A=
> -- =0A=
> 2.1.4=0A=
> =0A=
 		 	   		  =

--_c61e0dec-4dc7-465c-ae7b-1a36f6ae8781_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>Please ignore this patch as ther=
e is some typos in the commit message. Will be sending new version by corre=
cting the typos.=0A=
=0A=
> From: bijosh.t@hotmail.com=0A=
> To: gregkh@linuxfoundation.org=3B jic23@kernel.org=3B knaack.h@gmx.de=3B =
lars@metafoo.de=3B pmeerw@pmeerw.net=0A=
> CC: mahfouz.saif.elyazal@gmail.com=3B devel@driverdev.osuosl.org=3B linux=
-iio@vger.kernel.org=0A=
> Subject: [PATCH 1/1] staging: coding style cleanpus for staging/iio/light=
/tsl2583 driver=0A=
> Date: Sun=2C 28 Feb 2016 13:27:15 +0530=0A=
> =0A=
> This patch fixes following coding style warning for reported by=0A=
> check patch scrpit:=0A=
>     - Block comments use a trailing */ on a separate line=0A=
> =0A=
> Signed-off-by: Bijosh Thykkoottathil <bijosh.t@hotmail.com>=0A=
> ---=0A=
>  drivers/staging/iio/light/tsl2583.c | 15 ++++++++++-----=0A=
>  1 file changed=2C 10 insertions(+)=2C 5 deletions(-)=0A=
> =0A=
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/li=
ght/tsl2583.c=0A=
> index 3100d96..9159298 100644=0A=
> --- a/drivers/staging/iio/light/tsl2583.c=0A=
> +++ b/drivers/staging/iio/light/tsl2583.c=0A=
> @@ -241=2C7 +241=2C8 @@ static int taos_get_lux(struct iio_dev *indio_dev=
)=0A=
>  	}=0A=
>  =0A=
>  	/* clear status=2C really interrupt status (interrupts are off)=2C but=
=0A=
> -	 * we use the bit anyway - don't forget 0x80 - this is a command*/=0A=
> +	 * we use the bit anyway - don't forget 0x80 - this is a command=0A=
> +	 */=0A=
>  	ret =3D i2c_smbus_write_byte(chip->client=2C=0A=
>  				   (TSL258X_CMD_REG | TSL258X_CMD_SPL_FN |=0A=
>  				    TSL258X_CMD_ALS_INT_CLR))=3B=0A=
> @@ -430=2C7 +431=2C8 @@ static int taos_chip_on(struct iio_dev *indio_dev=
)=0A=
>  	chip->als_time_scale =3D (als_time + 25) / 50=3B=0A=
>  =0A=
>  	/* TSL258x Specific power-on / adc enable sequence=0A=
> -	 * Power on the device 1st. */=0A=
> +	 * Power on the device 1st.=0A=
> +	 */=0A=
>  	utmp =3D TSL258X_CNTL_PWR_ON=3B=0A=
>  	ret =3D i2c_smbus_write_byte_data(chip->client=2C=0A=
>  					TSL258X_CMD_REG | TSL258X_CNTRL=2C utmp)=3B=0A=
> @@ -440=2C7 +442=2C8 @@ static int taos_chip_on(struct iio_dev *indio_dev=
)=0A=
>  	}=0A=
>  =0A=
>  	/* Use the following shadow copy for our delay before enabling ADC.=0A=
> -	 * Write all the registers. */=0A=
> +	 * Write all the registers.=0A=
> +	 */=0A=
>  	for (i =3D 0=2C uP =3D chip->taos_config=3B i < TSL258X_REG_MAX=3B i++)=
 {=0A=
>  		ret =3D i2c_smbus_write_byte_data(chip->client=2C=0A=
>  						TSL258X_CMD_REG + i=2C=0A=
> @@ -454=2C7 +457=2C8 @@ static int taos_chip_on(struct iio_dev *indio_dev=
)=0A=
>  =0A=
>  	usleep_range(3000=2C 3500)=3B=0A=
>  	/* NOW enable the ADC=0A=
> -	 * initialize the desired mode of operation */=0A=
> +	 * initialize the desired mode of operation=0A=
> +	 */=0A=
>  	utmp =3D TSL258X_CNTL_PWR_ON | TSL258X_CNTL_ADC_ENBL=3B=0A=
>  	ret =3D i2c_smbus_write_byte_data(chip->client=2C=0A=
>  					TSL258X_CMD_REG | TSL258X_CNTRL=2C=0A=
> @@ -696=2C7 +700=2C8 @@ static ssize_t taos_luxtable_show(struct device *=
dev=2C=0A=
>  				  taos_device_lux[i].ch1)=3B=0A=
>  		if (taos_device_lux[i].ratio =3D=3D 0) {=0A=
>  			/* We just printed the first "0" entry.=0A=
> -			 * Now get rid of the extra "=2C" and break. */=0A=
> +			 * Now get rid of the extra "=2C" and break.=0A=
> +			 */=0A=
>  			offset--=3B=0A=
>  			break=3B=0A=
>  		}=0A=
> -- =0A=
> 2.1.4=0A=
> =0A=
 		 	   		  </div></body>
</html>=

--_c61e0dec-4dc7-465c-ae7b-1a36f6ae8781_--
