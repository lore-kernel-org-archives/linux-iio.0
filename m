Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 13/67] iio:adc:lp8778_adc move to
 info_mask_(shared_by_type/separate)
Date: Thu, 7 Mar 2013 00:49:03 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F82E4585D@DQHE02.ent.ti.com>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
 <1362241044-3534-14-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-14-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

Can I get the git tree location for the IIO subsystem if available?
It looks this patch-set has not been merged yet in the staging-next.

Best Regards,
Milo

> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Sunday, March 03, 2013 1:17 AM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron; Kim, Milo
> Subject: [PATCH 13/67] iio:adc:lp8778_adc move to
> info_mask_(shared_by_type/separate)
>=20
> The original info_mask is going away in favour of the broken out
> versions.
>=20
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> cc: Milo(Woogyom) Kim <milo.kim@ti.com>
> ---
>  drivers/iio/adc/lp8788_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/lp8788_adc.c
> b/drivers/iio/adc/lp8788_adc.c
> index 763f575..62bc39e 100644
> --- a/drivers/iio/adc/lp8788_adc.c
> +++ b/drivers/iio/adc/lp8788_adc.c
> @@ -132,8 +132,8 @@ static const struct iio_info lp8788_adc_info =3D {
>  		.type =3D _type,					\
>  		.indexed =3D 1,					\
>  		.channel =3D LPADC_##_id,				\
> -		.info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_BIT |	\
> -			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,	\
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |	\
> +			BIT(IIO_CHAN_INFO_SCALE),		\
>  		.datasheet_name =3D #_id,				\
>  }
>=20
> --
> 1.8.1.4
