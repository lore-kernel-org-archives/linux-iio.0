Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36619 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934674AbeFROux (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2018 10:50:53 -0400
Received: by mail-pg0-f66.google.com with SMTP id m5-v6so7645477pgd.3
        for <linux-iio@vger.kernel.org>; Mon, 18 Jun 2018 07:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <1529161484-28781-1-git-send-email-akinobu.mita@gmail.com>
 <1529161484-28781-4-git-send-email-akinobu.mita@gmail.com> <20180616194835.46e75a99@archlinux>
In-Reply-To: <20180616194835.46e75a99@archlinux>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 18 Jun 2018 23:50:41 +0900
Message-ID: <CAC5umyhqm1eH5GHZTtCp+KRoP2kx351Fqh1OEqAoZUCXL9V5Kw@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: accel: adxl345: add calibration offset support
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2018=E5=B9=B46=E6=9C=8817=E6=97=A5(=E6=97=A5) 3:48 Jonathan Cameron <jic23@=
kernel.org>:
>
> On Sun, 17 Jun 2018 00:04:42 +0900
> Akinobu Mita <akinobu.mita@gmail.com> wrote:
>
> > The ADXL345 provides the offset adjustment registers for each axis.
> > This adds the iio channel information for the calibraion offsets with
> > that feature.
> >
> > Cc: Eva Rachel Retuya <eraretuya@gmail.com>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Hi,
>
> The use of calibscale surprised me.  Calibbias is often effectively in
> 'unknown units' as there is non linear stuff in the way but roughly speak=
ing
> the assumption is that it is in the same units as the _raw measurement if=
 it
> can be (hence calibscale =3D 1).
>
> adc reading =3D ((actualval + calibbias)*calibscale)
> processed reading =3D (adc reading + offset)*scale
>
> Looks like it would be easy enough to do that here and rely on default fo=
r
> calibscale of 1.  That gives us one less userspace interface which is one
> less thing for people to use wrong :)
>
> > ---
> >  drivers/iio/accel/adxl345_core.c | 52 ++++++++++++++++++++++++++++++++=
+++-----
> >  1 file changed, 46 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 6b62f82..a392f9e 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -18,6 +18,9 @@
> >  #include "adxl345.h"
> >
> >  #define ADXL345_REG_DEVID            0x00
> > +#define ADXL345_REG_OFSX             0x1e
> > +#define ADXL345_REG_OFSY             0x1f
> > +#define ADXL345_REG_OFSZ             0x20
> >  #define ADXL345_REG_POWER_CTL                0x2D
> >  #define ADXL345_REG_DATA_FORMAT              0x31
> >  #define ADXL345_REG_DATAX0           0x32
> > @@ -53,8 +56,10 @@ struct adxl345_data {
> >       .type =3D IIO_ACCEL,                                             =
 \
> >       .modified =3D 1,                                                 =
 \
> >       .channel2 =3D IIO_MOD_##axis,                                    =
 \
> > -     .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),                  =
 \
> > -     .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),          =
 \
> > +     .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |                 =
 \
> > +             BIT(IIO_CHAN_INFO_CALIBBIAS),                           \
> > +     .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |         =
 \
> > +             BIT(IIO_CHAN_INFO_CALIBSCALE),                          \
> >       .scan_index =3D si,                                              =
 \
> >  }
> >
> > @@ -69,7 +74,8 @@ static int adxl345_read_raw(struct iio_dev *indio_dev=
,
> >                           int *val, int *val2, long mask)
> >  {
> >       struct adxl345_data *data =3D iio_priv(indio_dev);
> > -     __le16 regval;
> > +     __le16 accel;
> > +     unsigned int regval;
> >       int ret;
> >
> >       switch (mask) {
> > @@ -80,18 +86,51 @@ static int adxl345_read_raw(struct iio_dev *indio_d=
ev,
> >                * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significan=
t byte
> >                */
> >               ret =3D regmap_bulk_read(data->regmap, ADXL345_REG_DATAX0=
 +
> > -                                    sizeof(regval) * chan->scan_index,
> > -                                    &regval, sizeof(regval));
> > +                                    sizeof(accel) * chan->scan_index, =
&accel,
> > +                                    sizeof(accel));
> >               if (ret < 0)
> >                       return ret;
> >
> > -             *val =3D sign_extend32(le16_to_cpu(regval), 12);
> > +             *val =3D sign_extend32(le16_to_cpu(accel), 12);
> >               return IIO_VAL_INT;
> >       case IIO_CHAN_INFO_SCALE:
> >               *val =3D 0;
> >               *val2 =3D adxl345_uscale;
> >
> >               return IIO_VAL_INT_PLUS_MICRO;
> > +     case IIO_CHAN_INFO_CALIBBIAS:
> > +             ret =3D regmap_read(data->regmap,
> > +                               ADXL345_REG_OFSX + chan->scan_index, &r=
egval);
> > +             if (ret < 0)
> > +                     return ret;
> > +             *val =3D sign_extend32(regval, 7);
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_CALIBSCALE:
> > +             /*
> > +              * 8-bit resolution at +/- 2g, that is 4x accel data scal=
e
> > +              * factor
> > +              */
> > +             *val =3D 0;
> > +             *val2 =3D adxl345_uscale * 4;
>
> This surprises me.  Why am I seeing a read only calibration scale paramet=
er?
> The ABI doesn't say that this is the scale of the bias if that's what you=
 are thinking...

I completely misunderstood calibscale.

> calibbias is kind of unit less as often it's before a non linear transfor=
m of some
> type.  However, if we were going to assume it was simple, we'd assume it =
had the
> same scale as _raw.  Hence I would just adjust the value in the read and =
write for
> the calibbias itself.

Sounds good. I'll change the code to adjust the value for the calibbias
to make the same scale as the _raw measurement, and remove misused
calibscale.

> > +
> > +             return IIO_VAL_INT_PLUS_MICRO;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int adxl345_write_raw(struct iio_dev *indio_dev,
> > +                         struct iio_chan_spec const *chan,
> > +                         int val, int val2, long mask)
> > +{
> > +     struct adxl345_data *data =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_CALIBBIAS:
> > +             ret =3D regmap_write(data->regmap,
> > +                                ADXL345_REG_OFSX + chan->scan_index, v=
al);
> > +             return ret;
> >       }
> >
> >       return -EINVAL;
> > @@ -99,6 +138,7 @@ static int adxl345_read_raw(struct iio_dev *indio_de=
v,
> >
> >  static const struct iio_info adxl345_info =3D {
> >       .read_raw       =3D adxl345_read_raw,
> > +     .write_raw      =3D adxl345_write_raw,
> >  };
> >
> >  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>
