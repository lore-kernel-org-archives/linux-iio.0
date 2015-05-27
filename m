Return-Path: <tiberiu.a.breana@intel.com>
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Jonathan Cameron
	<jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
Subject: RE: [patch] iio: light: signedness bug in stk3310_write_raw()
Date: Wed, 27 May 2015 09:10:26 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F4022142F80@IRSMSX109.ger.corp.intel.com>
References: <20150527082425.GB19423@mwanda>
In-Reply-To: <20150527082425.GB19423@mwanda>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Wednesday, May 27, 2015 11:24 AM
> To: Jonathan Cameron
> Cc: Hartmut Knaack; Lars-Peter Clausen; Peter Meerwald; Breana, Tiberiu A=
;
> linux-iio@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [patch] iio: light: signedness bug in stk3310_write_raw()
>=20
> "index" needs to be signed for the error handling to work.
>=20

Thanks for this. I don't know how it slipped by our reviews.

Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>

> Fixes: be9e6229d676 ('iio: light: Add support for Sensortek STK3310')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c in=
dex
> e79b9d8..fee4297 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -370,7 +370,7 @@ static int stk3310_write_raw(struct iio_dev
> *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	int ret;
> -	unsigned int index;
> +	int index;
>  	struct stk3310_data *data =3D iio_priv(indio_dev);
>=20
>  	switch (mask) {
