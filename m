Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF96391E52;
	Thu, 23 Jul 2026 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784850156; cv=none; b=Se8I5UJO8o9Yv+GRSKYYYfJUb/6386l92n70X/Uumnw+zvZ80roknmzKmUcupcPL4kqqgiXYA+FH9dbS2MyGWJ4gy6el0As2Vlspc1cDUZl7LQgaOeEQa7wvLQAtS5IqYyIzkyCAMSEgCxqXzIYPi/d/iLgRIko/gXzqwL0ejhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784850156; c=relaxed/simple;
	bh=HdVNyRqV5+o+iMDk+Q0hME7CbDnARDvwDsVHFeUwKs4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6Tvtc0RjD4Z7DCDXBtcTMu9AVO1UzItvK1qNkuxREgGu5klt7UIU9zspUYWtUdXL8gJ3OIf0m7iS96vTzrYqLCNC4PxcyNC2DjeJ8SnJG4nMSSGIW37n6oueEg7XGhgx8vhlS5QzvwHlaeLsE5dlENIRQOwD4HoF6MCkTDFgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBo/rgsg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBo/rgsg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0D51F000E9;
	Thu, 23 Jul 2026 23:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784850154;
	bh=xx+l0K2KncoA+G1mHpT/bOfPYUB/BWeFV4G2/xnV8LQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NBo/rgsg3TUrk6rnE+4sAP3hGHUGEmg0pYZeSvzJJTfqcxkJYdh9z5zUrrayK6aVD
	 qXyfA3C8+05Guwry2Y3p0g/ef+N4Uo6d52GFj9TG/9Hwp9h2rRtvVaeByljzjM6jRl
	 hB3WfZDkIAfFc9RJqxY2WycaAwW9l1NlCwvnh6zrwyx+0jl/OEIatIv1Nedb9VnX8W
	 3sS1O1rVgfr5JQtUB+9iUfwLMZOPUNzyduuVqZEgVAqzIcqPj2IL7nboMabRQyMG84
	 MeHuhiUOJ1EvhcL1t4xir46w3T9YNTQGP6C5wxiTFles8mPsDJlF3VsQ9cgyrem3gx
	 SrHmD4kBbuJKA==
Date: Fri, 24 Jul 2026 00:42:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupert Zoone <zoone.rupert@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Petre Rodan
 <petre.rodan@subdimension.ro>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Akhilesh Patil <akhilesh@ee.iitb.ac.in>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Eddie James
 <eajames@linux.ibm.com>
Subject: Re: [PATCH v3] iio: pressure: dps310: add triggered buffer support
Message-ID: <20260724004231.6dead9d1@jic23-huawei>
In-Reply-To: <CABpb+S4Pkn7FEqbSVPW8pM3kc+en15Ewo-nGuOLxiwdUmhN1ZQ@mail.gmail.com>
References: <20260718224455.38acd927@jic23-huawei>
	<20260718235203.73699-1-zoone.rupert@gmail.com>
	<20260719231131.2a6b2364@jic23-huawei>
	<CABpb+S4Pkn7FEqbSVPW8pM3kc+en15Ewo-nGuOLxiwdUmhN1ZQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jul 2026 08:56:26 +0300
Rupert Zoone <zoone.rupert@gmail.com> wrote:

> On Mon, 20 Jul 2026, Jonathan Cameron wrote:
>   > Ah... This wasn't what I meant.  I was expecting to see the fifo
>   > stuff but coupled with use of buffers.
>   > ...
>   > I think what would make sense for this device would be
>   > that fifo mode is used when a trigger is not provided, but disabled w=
hen
>   > one is. =20
>=20
>   Thanks for the detailed review, and sorry for taking the FIFO suggestion
>   in the wrong direction. I'm happy to carry the triggered-buffer support
>   forward and build toward the design you describe, FIFO used when no
>   trigger is attached, disabled when one is.
>=20
>   Before I rework, one scope question :) would you prefer the FIFO and
>   external-trigger support in a single series (with the fifo-vs-trigger
>   selection as one patch), or is it OK to land the triggered-buffer suppo=
rt
>   first -> reworked per your comments -> and add the FIFO/watermark path =
as a
>   follow-up? Either is fine by me, just wanted to structure easiest
> for you to review.

In this particular case I think a single series is more appropriate
as then we can clearly evaluate how the switch between the two modes
is handled.

>=20
>   Either way I'll fold in the review comments:
>=20
>   > Just have local instances on the stack.
>   > + the discussion with Andy, that __aligned(8) isn't doing anything. =
=20
>   Will move the scan buffer to a stack local and drop the __aligned(8).

Please reply to these inline next time (so next to where they were made).
The context is useful to anyone trying to work out what these are about.
By all means crop out any code that has no more discussion in a given reply.

Where you are accepting a suggestion, don't bother mentioning it. Just crop
that bit or the thread out as we will be default assume you accept anything
you don't reply to :)


>=20
>   > Given temperature and pressure are effectively independent sequences I
>   > think you would be better off not providing available_scan_masks() =20
>   Makes sense - I'll drop available_scan_masks and push only the enabled
>   channels (still reading temperature internally for pressure compensatio=
n).
>=20
>   > Look at the ACQUIRE stuff in iio.h
>   > And similar ACQUIRE stuff for this one. =20
>   Will switch claim_direct and the mutex to the ACQUIRE()/guard() scoped
>   helpers, so the release-in-every-path handling goes away.
>=20
>   > Maybe wrap this up in a little helper given sharing with PROCESSED. =
=20
>   Will factor the shared read-and-calculate into a helper for the RAW and
>   PROCESSED cases.
>=20
>   > Would it make sense to provide a version of these calls that doesn't =
take
>   > the lock then take it here to avoid bouncing it? =20
>   Sure will add lock-free inner helpers and take the lock once in the
>   trigger handler rather than per call.
>=20
>   > Can you make sure to add some comments around the chan spec about thi=
s.
>   > I don't want it copied into other drivers! =20
>   Will add a comment on the pressure channel explaining the raw+scale cho=
ice
>   and it's relevancy to this driver.
>=20
>   Thanks,
>   Rupesh
>=20
> On Mon, Jul 20, 2026 at 1:11=E2=80=AFAM Jonathan Cameron
> <jonathan.cameron@oss.qualcomm.com> wrote:
> >
> > On Sun, 19 Jul 2026 02:51:58 +0300
> > Rupesh Majhi <zoone.rupert@gmail.com> wrote:
> > =20
> > > Add triggered buffer support so pressure and temperature can be captu=
red
> > > into a buffer instead of only through one-shot sysfs reads.
> > >
> > > Pressure is a processed value in kPa computed from a non-linear
> > > calibration polynomial. To keep full resolution in the buffer without
> > > disagreeing with the sysfs unit, add raw and scale attributes for
> > > pressure (raw in Pa, scale 1/1000 to kPa), following bme680; the exis=
ting
> > > processed attribute is kept for ABI compatibility. =20
> >
> > Hmm. That is unfortunate.  Ideally in original driver we'd have only
> > output RAW (even though somewhat processed) then this would be the
> > same.   Agreed that given the constraints, this is the way we'll have t=
o go.
> > Can you make sure to add some comments around the chan spec about this.
> > I don't want it copied into other drivers!
> > =20
> > > Temperature is already
> > > a full-resolution value in its base unit (millidegrees Celsius) and s=
tays
> > > a processed channel.
> > >
> > > Pressure compensation depends on a temperature reading, so both chann=
els
> > > are always captured together. The device already runs in continuous
> > > background mode, so no buffer setup ops are needed. Sysfs reads and
> > > reconfiguration return -EBUSY while the buffer is enabled, as they sh=
are
> > > the capture path's raw values and configuration.
> > >
> > > Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com> =20
> > https://sashiko.dev/#/patchset/20260718211727.39752-1-zoone.rupert%40gm=
ail.com
> >
> > Some stuff in there to check. I haven't looked closely beyond checking
> > for usual false positives (none of those).
> > =20
> > > ---
> > > Changes in v3:
> > >  - Rework from just enabling the FIFO into proper IIO triggered buffer
> > >    support, as suggested by Jonathan.
> > >  - Buffer the pressure and temperature values; add raw + scale for
> > >    pressure (bme680-style) so buffered pressure keeps full resolution
> > >    and stays consistent with the sysfs unit.
> > >  - Drop the unused FIFO enable/flush/read helpers. =20
> >
> > Ah... This wasn't what I meant.  I was expecting to see the fifo
> > stuff but coupled with use of buffers.  It may not make sense to support
> > triggered buffer for that case.  Often doesn't for FIFO equiped parts w=
here
> > the read out of a fifo is not reading just one 'scan' but many and where
> > timestamps are either not provided or are the subject of non trivial
> > interpolation of interrupt timings.
> >
> > So does supporting an external trigger (what this does) actually make
> > sense for this device?  There are drivers where we do both but I would
> > expect to see that in one patch set as the mechanism for choosing fifo
> > (and watermarks interrupt) vs direct reads and a trigger is the complex
> > corner.   I think what would make sense for this device would be
> > that fifo mode is used when a trigger is not provided, but disabled when
> > one is.
> >
> > Anyhow I've given this a quick review based on the fact we might
> > want to carry forward triggered buffer support as part of the solution.
> > =20
> > >
> > > v2 was a resend that still contained the v1 FIFO-enable code.
> > >
> > > Note: this touches dps310_probe() near the separately-sent fix "iio:
> > > pressure: dps310: fix NULL pointer deref on ACPI probe". It was gener=
ated
> > > on a plain base tree, so applying it after that fix needs a trivial
> > > 3-way merge/rebase - happy to resend in whatever order or branch you
> > > prefer.
> > >
> > >  drivers/iio/pressure/Kconfig  |   2 +
> > >  drivers/iio/pressure/dps310.c | 141 ++++++++++++++++++++++++++++++++=
--
> > >  2 files changed, 136 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kcon=
fig
> > > index 838a8340c4c0..cef8b90b9ae7 100644
> > > --- a/drivers/iio/pressure/Kconfig
> > > +++ b/drivers/iio/pressure/Kconfig
> > > @@ -112,6 +112,8 @@ config DPS310
> > >       tristate "Infineon DPS310 pressure and temperature sensor"
> > >       depends on I2C
> > >       select REGMAP_I2C
> > > +     select IIO_BUFFER
> > > +     select IIO_TRIGGERED_BUFFER
> > >       help
> > >         Support for the Infineon DPS310 digital barometric pressure s=
ensor.
> > >         It can be accessed over I2C bus.
> > > diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps=
310.c
> > > index f45af72a0554..967a2043550b 100644
> > > --- a/drivers/iio/pressure/dps310.c
> > > +++ b/drivers/iio/pressure/dps310.c
> > > @@ -20,8 +20,11 @@
> > >  #include <linux/module.h>
> > >  #include <linux/regmap.h>
> > >
> > > +#include <linux/iio/buffer.h>
> > >  #include <linux/iio/iio.h>
> > >  #include <linux/iio/sysfs.h>
> > > +#include <linux/iio/trigger_consumer.h>
> > > +#include <linux/iio/triggered_buffer.h>
> > >
> > >  #define DPS310_DEV_NAME              "dps310"
> > >
> > > @@ -90,6 +93,12 @@ struct dps310_data {
> > >       s32 pressure_raw;
> > >       s32 temp_raw;
> > >       bool timeout_recovery_failed;
> > > +
> > > +     /* Buffer to hold a scan; timestamp is naturally aligned */
> > > +     struct {
> > > +             s32 chan[2];
> > > +             aligned_s64 timestamp;
> > > +     } scan __aligned(8); =20
> >
> > See below.  No reason to have this in this structure. Just have local
> > instances on the stack.  + the discussion with Andy, that __aligned(8)
> > isn't doing anything.
> > =20
> > >  };
> > >
> > >  static const struct iio_chan_spec dps310_channels[] =3D {
> > > @@ -98,15 +107,38 @@ static const struct iio_chan_spec dps310_channel=
s[] =3D {
> > >               .info_mask_separate =3D BIT(IIO_CHAN_INFO_OVERSAMPLING_=
RATIO) |
> > >                       BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > >                       BIT(IIO_CHAN_INFO_PROCESSED),
> > > +             .scan_index =3D 0, =20
> >
> > Andy mentioned this.  I'd generally prefer an enum used for this
> > as then anywhere else we can clearly see which scan_index we are workin=
g with.
> > =20
> > > +             .scan_type =3D {
> > > +                     .sign =3D 's',
> > > +                     .realbits =3D 32,
> > > +                     .storagebits =3D 32,
> > > +                     .endianness =3D IIO_CPU,
> > > +             },
> > >       },
> > >       {
> > >               .type =3D IIO_PRESSURE,
> > >               .info_mask_separate =3D BIT(IIO_CHAN_INFO_OVERSAMPLING_=
RATIO) |
> > >                       BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > > -                     BIT(IIO_CHAN_INFO_PROCESSED),
> > > +                     BIT(IIO_CHAN_INFO_PROCESSED) |
> > > +                     BIT(IIO_CHAN_INFO_RAW) |
> > > +                     BIT(IIO_CHAN_INFO_SCALE),
> > > +             .scan_index =3D 1,
> > > +             .scan_type =3D {
> > > +                     .sign =3D 's',
> > > +                     .realbits =3D 32,
> > > +                     .storagebits =3D 32,
> > > +                     .endianness =3D IIO_CPU,
> > > +             },
> > >       },
> > > +     IIO_CHAN_SOFT_TIMESTAMP(2),
> > >  };
> > >
> > > +/*
> > > + * Pressure compensation needs a temperature reading, so the trigger
> > > + * handler always captures both channels; keep them enabled together.
> > > + */
> > > +static const unsigned long dps310_scan_masks[] =3D { GENMASK(1, 0), =
0 };
> > > +
> > >  /* To be called after checking the COEF_RDY bit in MEAS_CFG */
> > >  static int dps310_get_coefs(struct dps310_data *data)
> > >  {
> > > @@ -583,8 +615,14 @@ static int dps310_write_raw(struct iio_dev *iio,
> > >       int rc;
> > >       struct dps310_data *data =3D iio_priv(iio);
> > >
> > > -     if (mutex_lock_interruptible(&data->lock))
> > > +     /* Don't reconfigure the sensor while a buffered capture is run=
ning */
> > > +     if (!iio_device_claim_direct(iio))
> > > +             return -EBUSY; =20
> >
> > Look at the ACQUIRE stuff in iio.h =20
> > > +
> > > +     if (mutex_lock_interruptible(&data->lock)) { =20
> >
> > And similar ACQUIRE stuff for this one.  Given both are
> > release in all paths just before return it should simplify the flow a l=
ittle.
> > =20
> > > +             iio_device_release_direct(iio);
> > >               return -EINTR;
> > > +     }
> > >
> > >       switch (mask) {
> > >       case IIO_CHAN_INFO_SAMP_FREQ:
> > > @@ -625,6 +663,7 @@ static int dps310_write_raw(struct iio_dev *iio,
> > >       }
> > >
> > >       mutex_unlock(&data->lock);
> > > +     iio_device_release_direct(iio);
> > >       return rc;
> > >  }
> > >
> > > @@ -735,6 +774,23 @@ static int dps310_read_pressure(struct dps310_da=
ta *data, int *val, int *val2,
> > >               *val2 =3D 1000; /* Convert Pa to KPa per IIO ABI */
> > >               return IIO_VAL_FRACTIONAL;
> > >
> > > +     case IIO_CHAN_INFO_RAW:
> > > +             rc =3D dps310_read_pres_raw(data);
> > > +             if (rc)
> > > +                     return rc;
> > > +
> > > +             rc =3D dps310_calculate_pressure(data, val);
> > > +             if (rc)
> > > +                     return rc; =20
> >
> > Maybe wrap this up in a little helper given sharing with PROCESSED.
> > Will make that a little more visually obvious.
> > =20
> > > +
> > > +             return IIO_VAL_INT;
> > > +
> > > +     case IIO_CHAN_INFO_SCALE:
> > > +             /* Raw pressure is in Pa; scale to kPa per IIO ABI */
> > > +             *val =3D 1;
> > > +             *val2 =3D 1000;
> > > +             return IIO_VAL_FRACTIONAL;
> > > +
> > >       case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > >               rc =3D dps310_get_pres_precision(data, val);
> > >               if (rc)
> > > @@ -804,12 +860,10 @@ static int dps310_read_temp(struct dps310_data =
*data, int *val, int *val2, =20
> >
> > ...
> > =20
> > > +static int dps310_read_raw(struct iio_dev *iio,
> > > +                        struct iio_chan_spec const *chan,
> > > +                        int *val, int *val2, long mask)
> > > +{
> > > +     struct dps310_data *data =3D iio_priv(iio);
> > > +     int rc;
> > > +
> > > +     switch (mask) {
> > > +     case IIO_CHAN_INFO_RAW:
> > > +     case IIO_CHAN_INFO_PROCESSED:
> > > +             /*
> > > +              * Reading a sample uses the same raw values as the buf=
fered
> > > +              * capture path, so only allow it outside of buffered m=
ode.
> > > +              */
> > > +             if (!iio_device_claim_direct(iio))
> > > +                     return -EBUSY; =20
> >
> > Maybe add scope and use an ACQUIRE here similar to suggested above.
> > It is more marginal but might make sense to use it for consistency.
> > =20
> > > +
> > > +             rc =3D dps310_read_channel(data, chan, val, val2, mask);
> > > +             iio_device_release_direct(iio);
> > > +             return rc;
> > > +
> > > +     default:
> > > +             return dps310_read_channel(data, chan, val, val2, mask);
> > > +     }
> > > +}
> > > +
> > >  static void dps310_reset(void *action_data)
> > >  {
> > >       struct dps310_data *data =3D action_data;
> > > @@ -843,6 +923,46 @@ static const struct iio_info dps310_info =3D {
> > >       .write_raw =3D dps310_write_raw,
> > >  };
> > >
> > > +static irqreturn_t dps310_trigger_handler(int irq, void *p)
> > > +{
> > > +     struct iio_poll_func *pf =3D p;
> > > +     struct iio_dev *iio =3D pf->indio_dev;
> > > +     struct dps310_data *data =3D iio_priv(iio);
> > > +     int rc, pressure, temp;
> > > +
> > > +     /*
> > > +      * Don't hold data->lock across these calls: the read helpers t=
ake it
> > > +      * themselves and the mutex is not recursive (dps310_calculate_=
pressure
> > > +      * also grabs it with mutex_trylock to refresh the temperature)=
. =20
> >
> > Would it make sense to provide a version of these calls that doesn't ta=
ke the
> > lock then take it here to avoid bouncing it?
> > =20
> > > +      */
> > > +     rc =3D dps310_read_pres_raw(data);
> > > +     if (rc)
> > > +             goto out;
> > > +
> > > +     rc =3D dps310_read_temp_raw(data); =20
> >
> > Given temperature and pressure are effectively independent sequences I =
think
> > you would be better off not providing available_scan_masks() but instea=
d reading
> > only the ones that are enabled. Lots of examples of how to do that
> > in tree.
> > =20
> > > +     if (rc)
> > > +             goto out;
> > > +
> > > +     rc =3D dps310_calculate_pressure(data, &pressure);
> > > +     if (rc)
> > > +             goto out;
> > > +
> > > +     rc =3D dps310_calculate_temp(data, &temp);
> > > +     if (rc)
> > > +             goto out;
> > > +
> > > +     data->scan.chan[0] =3D temp;      /* millidegrees Celsius */
> > > +     data->scan.chan[1] =3D pressure;  /* Pascals */
> > > + =20
> >
> > Drag the scan in here as a local variable. It's fairly small and there
> > is nothing stopping you having it on the stack given no DMA to it
> > or anything like that.
> > =20
> > > +     iio_push_to_buffers_with_ts(iio, &data->scan, sizeof(data->scan=
),
> > > +                                 pf->timestamp);
> > > +
> > > +out:
> > > +     iio_trigger_notify_done(iio->trig);
> > > +
> > > +     return IRQ_HANDLED;
> > > +} =20
>=20

