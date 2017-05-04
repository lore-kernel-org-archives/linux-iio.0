Return-Path: <SRS0=bj6U=4K=intel.com=thomas.langer@kernel.org>
From: "Langer, Thomas" <thomas.langer@intel.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	"jic23@kernel.org" <jic23@kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "carlo@caione.org" <carlo@caione.org>, "khilman@baylibre.com"
	<khilman@baylibre.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-amlogic@lists.infradead.org"
	<linux-amlogic@lists.infradead.org>
Subject: RE: [PATCH v3 1/3] iio: adc: meson-saradc: mark all
 meson_sar_adc_data static and const
Date: Thu, 4 May 2017 19:07:24 +0000
Message-ID: <0DAF21CFE1B20740AE23D6AF6E54843F1E8BCDB2@IRSMSX101.ger.corp.intel.com>
References: <20170504180136.27025-1-martin.blumenstingl@googlemail.com>
 <20170504180136.27025-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20170504180136.27025-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hello Martin,

>=20
> These are only passed as of_device_id.data and never modified. Thus we
> can mark them as static const, just like the of_device_id instances
> where they are used.

Here you talk about static const, but in the code below the const is missin=
g.

>=20
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/iio/adc/meson_saradc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/meson_saradc.c
> b/drivers/iio/adc/meson_saradc.c
> index dd4190b50df6..1cb5df306001 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -834,17 +834,17 @@ static const struct iio_info meson_sar_adc_iio_info
> =3D {
>  	.driver_module =3D THIS_MODULE,
>  };
>=20
> -struct meson_sar_adc_data meson_sar_adc_gxbb_data =3D {
> +static struct meson_sar_adc_data meson_sar_adc_gxbb_data =3D {
>  	.resolution =3D 10,
>  	.name =3D "meson-gxbb-saradc",
>  };
>=20
> -struct meson_sar_adc_data meson_sar_adc_gxl_data =3D {
> +static struct meson_sar_adc_data meson_sar_adc_gxl_data =3D {
>  	.resolution =3D 12,
>  	.name =3D "meson-gxl-saradc",
>  };
>=20
> -struct meson_sar_adc_data meson_sar_adc_gxm_data =3D {
> +static struct meson_sar_adc_data meson_sar_adc_gxm_data =3D {
>  	.resolution =3D 12,
>  	.name =3D "meson-gxm-saradc",
>  };
> --
> 2.12.2
>=20
