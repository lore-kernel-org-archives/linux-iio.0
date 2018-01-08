Return-Path: <alexandru.Ardelean@analog.com>
From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 1/2] staging: iio: adc: ad7192: add device-tree support
 to driver
Date: Mon, 8 Jan 2018 07:51:08 +0000
Message-ID: <E2AE62E8D995114A80E27C874A28DB3C97C501@NWD2MBX7.ad.analog.com>
References: <20180105152133.9681-1-alexandru.ardelean@analog.com>,<20180106125828.5da228f7@archlinux>
In-Reply-To: <20180106125828.5da228f7@archlinux>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

=0A=
________________________________________=0A=
From: Jonathan Cameron [jic23@jic23.retrosnub.co.uk]=0A=
Sent: Saturday, January 06, 2018 2:58 PM=0A=
To: Ardelean, Alexandru=0A=
Cc: linux-iio@vger.kernel.org=0A=
Subject: Re: [PATCH 1/2] staging: iio: adc: ad7192: add device-tree support=
 to driver=0A=
=0A=
On Fri, 5 Jan 2018 17:21:32 +0200=0A=
<alexandru.ardelean@analog.com> wrote:=0A=
=0A=
> From: Alexandru Ardelean <alexandru.ardelean@analog.com>=0A=
>=0A=
Say what the patch does before going into details of why=0A=
you have done it the way you have.=0A=
=0A=
Ack=0A=
=0A=
> Admittedly, this will always use up to=0A=
> sizeof(struct ad7192_platform_data) bytes (~12 bytes at most)=0A=
> on the stack, during the probing of the device.=0A=
=0A=
>=0A=
> But this will maintain most of the other=0A=
> init code unchanged.=0A=
>=0A=
=0A=
I'm hopeful that you are going to also do any remaining work necessary=0A=
to get this out of staging once and for all?=0A=
=0A=
Yep.=0A=
Once I get the gist of sending patches to the kernel.=0A=
So far, I've only sent to other smaller projects ; I'll make an effort to l=
earn the rules here.=0A=
=0A=
Anyhow, comments inline.=0A=
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>=0A=
> ---=0A=
>  drivers/staging/iio/adc/ad7192.c | 27 +++++++++++++++++++++++++--=0A=
>  1 file changed, 25 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/a=
d7192.c=0A=
> index cadfb96734ed..fca988330588 100644=0A=
> --- a/drivers/staging/iio/adc/ad7192.c=0A=
> +++ b/drivers/staging/iio/adc/ad7192.c=0A=
> @@ -610,18 +610,41 @@ static const struct iio_chan_spec ad7193_channels[]=
 =3D {=0A=
>       IIO_CHAN_SOFT_TIMESTAMP(14),=0A=
>  };=0A=
>=0A=
> +static void ad7192_parse_dt(struct device_node *np,=0A=
> +                         struct ad7192_platform_data *pdata)=0A=
> +{=0A=
> +     of_property_read_u16(np, "adi,reference-voltage-mv", &pdata->vref_m=
v);=0A=
> +     of_property_read_u8(np, "adi,clock-source-select", &pdata->clock_so=
urce_sel);=0A=
> +     of_property_read_u32(np, "adi,external-clock-Hz", &pdata->ext_clk_h=
z);=0A=
> +     pdata->refin2_en =3D of_property_read_bool(np, "adi,refin2-pins-ena=
ble");=0A=
> +     pdata->rej60_en =3D of_property_read_bool(np, "adi,rejection-60-Hz-=
enable");=0A=
> +     pdata->sinc3_en =3D of_property_read_bool(np, "adi,sinc3-filter-ena=
ble");=0A=
> +     pdata->chop_en =3D of_property_read_bool(np, "adi,chop-enable");=0A=
> +     pdata->buf_en =3D of_property_read_bool(np, "adi,buffer-enable");=
=0A=
> +     pdata->unipolar_en =3D of_property_read_bool(np, "adi,unipolar-enab=
le");=0A=
> +     pdata->burnout_curr_en =3D of_property_read_bool(np, "adi,burnout-c=
urrents-enable");=0A=
=0A=
Error checking?  No particular reason a devicetree must be right and have a=
ll of=0A=
these.=0A=
=0A=
Ack.=0A=
=0A=
> +}=0A=
> +=0A=
>  static int ad7192_probe(struct spi_device *spi)=0A=
>  {=0A=
>       const struct ad7192_platform_data *pdata =3D dev_get_platdata(&spi-=
>dev);=0A=
> +     const struct device_node *of_node =3D dev_of_node(&spi->dev);=0A=
> +     struct ad7192_platform_data lpdata;=0A=
>       struct ad7192_state *st;=0A=
>       struct iio_dev *indio_dev;=0A=
>       int ret, voltage_uv =3D 0;=0A=
>=0A=
> -     if (!pdata) {=0A=
> -             dev_err(&spi->dev, "no platform data?\n");=0A=
> +     if (!pdata && !of_node) {=0A=
> +             dev_err(&spi->dev, "no platform data or device tree configu=
ration?\n");=0A=
>               return -ENODEV;=0A=
>       }=0A=
>=0A=
> +     if (!pdata) {=0A=
> +             memset(&lpdata, 0, sizeof(lpdata));=0A=
> +             pdata =3D &lpdata;=0A=
> +             ad7192_parse_dt(of_node, pdata);=0A=
> +     }=0A=
> +=0A=
>       if (!spi->irq) {=0A=
>               dev_err(&spi->dev, "no IRQ?\n");=0A=
>               return -ENODEV;=0A=
=0A=
=0A=
