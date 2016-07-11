Return-Path: <tiberiu.a.breana@intel.com>
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Alison Schofield <amsfield22@gmail.com>, "jic23@kernel.org"
	<jic23@kernel.org>
CC: "mranostay@gmail.com" <mranostay@gmail.com>, "knaack.h@gmx.de"
	<knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net"
	<pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] iio: accel: bma220_spi: set up buffer timestamps
 for non-zero values
Date: Mon, 11 Jul 2016 15:53:30 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F40235BAB3C@IRSMSX109.ger.corp.intel.com>
References: <cover.1468203399.git.amsfield22@gmail.com>
 <6097ec724dae1e1fc5a9838b840ba9710a494a6d.1468203399.git.amsfield22@gmail.com>
In-Reply-To: <6097ec724dae1e1fc5a9838b840ba9710a494a6d.1468203399.git.amsfield22@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> -----Original Message-----
> From: Alison Schofield [mailto:amsfield22@gmail.com]
> Sent: Monday, July 11, 2016 6:25 PM
> To: jic23@kernel.org
> Cc: Breana, Tiberiu A <tiberiu.a.breana@intel.com>; mranostay@gmail.com;
> knaack.h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 1/3] iio: accel: bma220_spi: set up buffer timestamps for=
 non-
> zero values
>=20
> Use the iio_pollfunc_store_time parameter during triggered buffer set-up =
to get
> valid timestamps.=09
>=20
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>

+1
Reviewed-By: Tiberiu Breana <tiberiu.a.breana@intel.com>

> ---
>  drivers/iio/accel/bma220_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_sp=
i.c
> index 1098d10..5099f29 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -253,7 +253,7 @@ static int bma220_probe(struct spi_device *spi)
>  	if (ret < 0)
>  		return ret;
>=20
> -	ret =3D iio_triggered_buffer_setup(indio_dev, NULL,
> +	ret =3D iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
>  					 bma220_trigger_handler, NULL);
>  	if (ret < 0) {
>  		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
> --
> 2.1.4
