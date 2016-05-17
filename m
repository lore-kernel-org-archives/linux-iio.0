Return-Path: <tiberiu.a.breana@intel.com>
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Jonathan Cameron
	<jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [patch] iio: humidity: Remove a stray unlock
Date: Tue, 17 May 2016 07:43:21 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F4023597A48@IRSMSX109.ger.corp.intel.com>
References: <20160517073133.GA10872@mwanda>
In-Reply-To: <20160517073133.GA10872@mwanda>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Tuesday, May 17, 2016 10:32 AM
> To: Jonathan Cameron <jic23@kernel.org>; Breana, Tiberiu A
> <tiberiu.a.breana@intel.com>
> Cc: Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen
> <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>;
> linux-iio@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [patch] iio: humidity: Remove a stray unlock
>=20
> We haven't taken the lock yet so we don't need to unlock here.
>=20
> Fixes: 0d96d5ead3f7 ('iio: humidity: Add triggered buffer support for
> AM2315')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.=
c
> index 3be6d20..1153591 100644
> --- a/drivers/iio/humidity/am2315.c
> +++ b/drivers/iio/humidity/am2315.c
> @@ -165,10 +165,8 @@ static irqreturn_t am2315_trigger_handler(int irq,
> void *p)
>  	struct am2315_sensor_data sensor_data;
>=20
>  	ret =3D am2315_read_data(data, &sensor_data);
> -	if (ret < 0) {
> -		mutex_unlock(&data->lock);
> +	if (ret < 0)
>  		goto err;
> -	}
>=20
>  	mutex_lock(&data->lock);
>  	if (*(indio_dev->active_scan_mask) =3D=3D
> AM2315_ALL_CHANNEL_MASK) {

That one must have slipped by during development versions.
You might also want to add am2315 in the patch title.
Thanks,

Acked-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
