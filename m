Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322663A963C
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784527016; cv=pass; b=jACPURVoLpozMzo1jHu1SjLOYM2XGDmM1x6PZkR5B/8qAJwexkSocgN3xGFwslSxiYnT2LuRIhM+l7oDigIbfNZuVJExBcQogW6ern1mCjMSDrXPgcCE1JWvEZMvZ8RfJZKREjRHul43BWWc+itDTEorF6qg9Ghdg9Z2C6Eazo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784527016; c=relaxed/simple;
	bh=4hOBbt3oax0xaS4o/GbwZAx93TBWbvTdp5EoCvDS5us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNGvrxPwqcl7J7p6SD4lrrE3z7WPp99rqzzAmysh0RRe5IVTuAiC7cOJ2cbIP07GzGE+pYYzWBubmOqwWZqWCBf5SG56On/n1XaZ0Tya6h62/E40RTt8bMHgWFyMqhkq4QJRuEy0KnCmVgGjE5lO9adnVKjgyCAf4K4KhQNS0T0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6TyY7+/; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6TyY7+/"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8e5be46f663so44467036d6.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 22:56:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784526998; cv=none;
        d=google.com; s=arc-20260327;
        b=c7W3FsZVANwqbF50DD9ECof9jmHmnpbPoXXF+3KD7hLr+w3uc/IJa/M7XYxyH2fleC
         kNiOGn55/6R9NzYP0Ah1sWPP/mYwAamq66FSl5QzI6o5igj/I7No2mBN5ZpslKjavu9H
         ZsVS/k3CCVpLbHITr5TGk67QY+7SdjwEL5staBJNuG/cB/KMf0U4I1EvspRRdoes2SG5
         /lrWQbQSvCGS1cCVdfiKjErbHdrY5q9bGd+ahun7MAFlcA03iSuRrX5fBG7PHWKVa265
         COf3dIOmGxNK+6R6A3gBu1wEOweP5odYVLm8xIH6mmSDUMCc4uK1Y3uy/eapGtEmfRNC
         Pt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pZjPI1hRwIGQ150voqUoNbySnaxOj9yZc7mNDJD8uC0=;
        fh=Qwe140h/kN166u9u7BnY1AKn48bF/vp79rhWg20gjkU=;
        b=TlVn/t+pxFIj1NDDV4mXOKnmOc0tuh6ll7yfmtnmsfB9QoaVAhvtIG+dHr/aQ2fakE
         R+3oDseEx/jKJOmFzzloIUtVg0TBLCc5gvFBvG/dPmYTzjve8xh6ZiePOhYGlx7xdDh2
         u7JfvwN74iqcQIaB2PTjPT+MAr7c2VgJ9U3CSz97pIkCfRFoUKbjF3RflbQt4EMbIEkg
         WJar2r0AW5HI8qU2EkAbD/TWi9vlhpcBIJg6LMaizb6IRplvCyXpd5mCZF0nxAETSjuc
         KPj5JV8sDJNaNC77CxdjMXpfjvhUxYde4NERHXJ5SVQHiznr/oV6pX9PjHIF4iou8W8e
         wxEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784526998; x=1785131798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pZjPI1hRwIGQ150voqUoNbySnaxOj9yZc7mNDJD8uC0=;
        b=S6TyY7+/YQA5IQD9U2EM+bg1cIJlqZsEF3bSCwNYKIohJTlYph3XvJ01D2oOJjL6js
         k+2qItX/wndnPW00lMvgftES/V0wSIJW6IADwSIoNPDuYEfm2Tvcb+C45KBe6lEvvVGr
         WZfD16iLmBdUGo6FILrJR977h35FSGRFE9qpi5/7wzK+dXmvnybqgxJKq+8AHcnOPqw6
         mSAEXJOZqay3nuUT1odCOb4hd0rBu6ML5Sm5ky0db7WEUZWz2ufRcpFkqSEbmoQLxJAA
         BPNRsn3eCypHWJxwqljokrpm2kpSxxl6z5WORd944hT4wLiEjyTKAOIHVO/KKDmG0kzo
         wZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784526998; x=1785131798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZjPI1hRwIGQ150voqUoNbySnaxOj9yZc7mNDJD8uC0=;
        b=doyymwna3kRR/k9j9K/DkfiHuRj0Iby+uJzy5PaeUjO5zfa+a09hHsj+GGiwp/sKUG
         uF4axhtYAHVe7iC50thgfxPx4tcqqb32eWQzb0Ij5z+ScyCOoBZt2F5dvgUgDGyqJJti
         zb1WP433W6ZNOBMNXD+AOOQ/ii1zQGyS1IrRRtRW6XrbCqJa0jKucWOAQ+v514CusmGu
         x5XLZkG0U9ENBojQWZepsYiEhugNNS5eb5bgFKnx2OEP7jVsL8hzYh2x9py5iF3Hgb8H
         /z5F/8QrKtEDkDg7V1F8ZpsArh9OR4iZAevRVXezRiHJqq3syu3LPnUpDov1EdK5RWCZ
         rQxg==
X-Forwarded-Encrypted: i=1; AHgh+RqvzvXHGi7QnMKSSQ4PKFDqc5+5hM21XloXt1iWEQXwtQKAGvGiKFkod1HEezVwRLy9XqCEnbTUsYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGkz82EBbxNKeizrNqrqC4Pl980gFl29yBSnKixacQoJbt9w1f
	6yjvvakdFN4bWYlxcUL7yYrw4V51tf3S5GgGsanGpR7blfA7hyhLtjS66ys7PK2jRRfbquZdAWG
	ecNN1K9aq7WedMLUdn4hUQQYUvjZcU24=
X-Gm-Gg: AfdE7cmwTBEIFAugKrEHV4aWUM3XCyOGaYRohbAYtDMezoqc6NayqKe4SAVwQ2f+KDP
	FtIS+lbJwIiP74CJaNEfH60h8C/2PzOZm2A45K5+CsMXiARDVUqr+5oJ6sps/qcUZi7tjpdMST2
	/PB9i72kRWV1+q69M3ipMNsh2hLP5KzwEo4NkttW86r+vNt9+qnrPoVkgsVl+huHAU85MEFE89G
	Z/qbzmpzEPzMbIDBBOhlaEx/IJVNbYNUqBZYqJIvyPweXEhtVZqETpFOOdHy5HbYxhKpk5kFfgm
	E4cFM67bp01Objkguro=
X-Received: by 2002:a05:6214:519e:b0:8ef:91c5:8edb with SMTP id
 6a1803df08f44-90778317727mr136554496d6.10.1784526998142; Sun, 19 Jul 2026
 22:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718224455.38acd927@jic23-huawei> <20260718235203.73699-1-zoone.rupert@gmail.com>
 <20260719231131.2a6b2364@jic23-huawei>
In-Reply-To: <20260719231131.2a6b2364@jic23-huawei>
From: Rupert Zoone <zoone.rupert@gmail.com>
Date: Mon, 20 Jul 2026 08:56:26 +0300
X-Gm-Features: AUfX_myb4XNahC_ISc2MXzP0gJOBdUb9Vw41nYpNd5UMnW5OUsfp_Y7A_F3EExI
Message-ID: <CABpb+S4Pkn7FEqbSVPW8pM3kc+en15Ewo-nGuOLxiwdUmhN1ZQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio: pressure: dps310: add triggered buffer support
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Petre Rodan <petre.rodan@subdimension.ro>, 
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Akhilesh Patil <akhilesh@ee.iitb.ac.in>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jul 2026, Jonathan Cameron wrote:
  > Ah... This wasn't what I meant.  I was expecting to see the fifo
  > stuff but coupled with use of buffers.
  > ...
  > I think what would make sense for this device would be
  > that fifo mode is used when a trigger is not provided, but disabled whe=
n
  > one is.

  Thanks for the detailed review, and sorry for taking the FIFO suggestion
  in the wrong direction. I'm happy to carry the triggered-buffer support
  forward and build toward the design you describe, FIFO used when no
  trigger is attached, disabled when one is.

  Before I rework, one scope question :) would you prefer the FIFO and
  external-trigger support in a single series (with the fifo-vs-trigger
  selection as one patch), or is it OK to land the triggered-buffer support
  first -> reworked per your comments -> and add the FIFO/watermark path as=
 a
  follow-up? Either is fine by me, just wanted to structure easiest
for you to review.

  Either way I'll fold in the review comments:

  > Just have local instances on the stack.
  > + the discussion with Andy, that __aligned(8) isn't doing anything.
  Will move the scan buffer to a stack local and drop the __aligned(8).

  > Given temperature and pressure are effectively independent sequences I
  > think you would be better off not providing available_scan_masks()
  Makes sense - I'll drop available_scan_masks and push only the enabled
  channels (still reading temperature internally for pressure compensation)=
.

  > Look at the ACQUIRE stuff in iio.h
  > And similar ACQUIRE stuff for this one.
  Will switch claim_direct and the mutex to the ACQUIRE()/guard() scoped
  helpers, so the release-in-every-path handling goes away.

  > Maybe wrap this up in a little helper given sharing with PROCESSED.
  Will factor the shared read-and-calculate into a helper for the RAW and
  PROCESSED cases.

  > Would it make sense to provide a version of these calls that doesn't ta=
ke
  > the lock then take it here to avoid bouncing it?
  Sure will add lock-free inner helpers and take the lock once in the
  trigger handler rather than per call.

  > Can you make sure to add some comments around the chan spec about this.
  > I don't want it copied into other drivers!
  Will add a comment on the pressure channel explaining the raw+scale choic=
e
  and it's relevancy to this driver.

  Thanks,
  Rupesh

On Mon, Jul 20, 2026 at 1:11=E2=80=AFAM Jonathan Cameron
<jonathan.cameron@oss.qualcomm.com> wrote:
>
> On Sun, 19 Jul 2026 02:51:58 +0300
> Rupesh Majhi <zoone.rupert@gmail.com> wrote:
>
> > Add triggered buffer support so pressure and temperature can be capture=
d
> > into a buffer instead of only through one-shot sysfs reads.
> >
> > Pressure is a processed value in kPa computed from a non-linear
> > calibration polynomial. To keep full resolution in the buffer without
> > disagreeing with the sysfs unit, add raw and scale attributes for
> > pressure (raw in Pa, scale 1/1000 to kPa), following bme680; the existi=
ng
> > processed attribute is kept for ABI compatibility.
>
> Hmm. That is unfortunate.  Ideally in original driver we'd have only
> output RAW (even though somewhat processed) then this would be the
> same.   Agreed that given the constraints, this is the way we'll have to =
go.
> Can you make sure to add some comments around the chan spec about this.
> I don't want it copied into other drivers!
>
> > Temperature is already
> > a full-resolution value in its base unit (millidegrees Celsius) and sta=
ys
> > a processed channel.
> >
> > Pressure compensation depends on a temperature reading, so both channel=
s
> > are always captured together. The device already runs in continuous
> > background mode, so no buffer setup ops are needed. Sysfs reads and
> > reconfiguration return -EBUSY while the buffer is enabled, as they shar=
e
> > the capture path's raw values and configuration.
> >
> > Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> https://sashiko.dev/#/patchset/20260718211727.39752-1-zoone.rupert%40gmai=
l.com
>
> Some stuff in there to check. I haven't looked closely beyond checking
> for usual false positives (none of those).
>
> > ---
> > Changes in v3:
> >  - Rework from just enabling the FIFO into proper IIO triggered buffer
> >    support, as suggested by Jonathan.
> >  - Buffer the pressure and temperature values; add raw + scale for
> >    pressure (bme680-style) so buffered pressure keeps full resolution
> >    and stays consistent with the sysfs unit.
> >  - Drop the unused FIFO enable/flush/read helpers.
>
> Ah... This wasn't what I meant.  I was expecting to see the fifo
> stuff but coupled with use of buffers.  It may not make sense to support
> triggered buffer for that case.  Often doesn't for FIFO equiped parts whe=
re
> the read out of a fifo is not reading just one 'scan' but many and where
> timestamps are either not provided or are the subject of non trivial
> interpolation of interrupt timings.
>
> So does supporting an external trigger (what this does) actually make
> sense for this device?  There are drivers where we do both but I would
> expect to see that in one patch set as the mechanism for choosing fifo
> (and watermarks interrupt) vs direct reads and a trigger is the complex
> corner.   I think what would make sense for this device would be
> that fifo mode is used when a trigger is not provided, but disabled when
> one is.
>
> Anyhow I've given this a quick review based on the fact we might
> want to carry forward triggered buffer support as part of the solution.
>
> >
> > v2 was a resend that still contained the v1 FIFO-enable code.
> >
> > Note: this touches dps310_probe() near the separately-sent fix "iio:
> > pressure: dps310: fix NULL pointer deref on ACPI probe". It was generat=
ed
> > on a plain base tree, so applying it after that fix needs a trivial
> > 3-way merge/rebase - happy to resend in whatever order or branch you
> > prefer.
> >
> >  drivers/iio/pressure/Kconfig  |   2 +
> >  drivers/iio/pressure/dps310.c | 141 ++++++++++++++++++++++++++++++++--
> >  2 files changed, 136 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfi=
g
> > index 838a8340c4c0..cef8b90b9ae7 100644
> > --- a/drivers/iio/pressure/Kconfig
> > +++ b/drivers/iio/pressure/Kconfig
> > @@ -112,6 +112,8 @@ config DPS310
> >       tristate "Infineon DPS310 pressure and temperature sensor"
> >       depends on I2C
> >       select REGMAP_I2C
> > +     select IIO_BUFFER
> > +     select IIO_TRIGGERED_BUFFER
> >       help
> >         Support for the Infineon DPS310 digital barometric pressure sen=
sor.
> >         It can be accessed over I2C bus.
> > diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps31=
0.c
> > index f45af72a0554..967a2043550b 100644
> > --- a/drivers/iio/pressure/dps310.c
> > +++ b/drivers/iio/pressure/dps310.c
> > @@ -20,8 +20,11 @@
> >  #include <linux/module.h>
> >  #include <linux/regmap.h>
> >
> > +#include <linux/iio/buffer.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> >
> >  #define DPS310_DEV_NAME              "dps310"
> >
> > @@ -90,6 +93,12 @@ struct dps310_data {
> >       s32 pressure_raw;
> >       s32 temp_raw;
> >       bool timeout_recovery_failed;
> > +
> > +     /* Buffer to hold a scan; timestamp is naturally aligned */
> > +     struct {
> > +             s32 chan[2];
> > +             aligned_s64 timestamp;
> > +     } scan __aligned(8);
>
> See below.  No reason to have this in this structure. Just have local
> instances on the stack.  + the discussion with Andy, that __aligned(8)
> isn't doing anything.
>
> >  };
> >
> >  static const struct iio_chan_spec dps310_channels[] =3D {
> > @@ -98,15 +107,38 @@ static const struct iio_chan_spec dps310_channels[=
] =3D {
> >               .info_mask_separate =3D BIT(IIO_CHAN_INFO_OVERSAMPLING_RA=
TIO) |
> >                       BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >                       BIT(IIO_CHAN_INFO_PROCESSED),
> > +             .scan_index =3D 0,
>
> Andy mentioned this.  I'd generally prefer an enum used for this
> as then anywhere else we can clearly see which scan_index we are working =
with.
>
> > +             .scan_type =3D {
> > +                     .sign =3D 's',
> > +                     .realbits =3D 32,
> > +                     .storagebits =3D 32,
> > +                     .endianness =3D IIO_CPU,
> > +             },
> >       },
> >       {
> >               .type =3D IIO_PRESSURE,
> >               .info_mask_separate =3D BIT(IIO_CHAN_INFO_OVERSAMPLING_RA=
TIO) |
> >                       BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > -                     BIT(IIO_CHAN_INFO_PROCESSED),
> > +                     BIT(IIO_CHAN_INFO_PROCESSED) |
> > +                     BIT(IIO_CHAN_INFO_RAW) |
> > +                     BIT(IIO_CHAN_INFO_SCALE),
> > +             .scan_index =3D 1,
> > +             .scan_type =3D {
> > +                     .sign =3D 's',
> > +                     .realbits =3D 32,
> > +                     .storagebits =3D 32,
> > +                     .endianness =3D IIO_CPU,
> > +             },
> >       },
> > +     IIO_CHAN_SOFT_TIMESTAMP(2),
> >  };
> >
> > +/*
> > + * Pressure compensation needs a temperature reading, so the trigger
> > + * handler always captures both channels; keep them enabled together.
> > + */
> > +static const unsigned long dps310_scan_masks[] =3D { GENMASK(1, 0), 0 =
};
> > +
> >  /* To be called after checking the COEF_RDY bit in MEAS_CFG */
> >  static int dps310_get_coefs(struct dps310_data *data)
> >  {
> > @@ -583,8 +615,14 @@ static int dps310_write_raw(struct iio_dev *iio,
> >       int rc;
> >       struct dps310_data *data =3D iio_priv(iio);
> >
> > -     if (mutex_lock_interruptible(&data->lock))
> > +     /* Don't reconfigure the sensor while a buffered capture is runni=
ng */
> > +     if (!iio_device_claim_direct(iio))
> > +             return -EBUSY;
>
> Look at the ACQUIRE stuff in iio.h
> > +
> > +     if (mutex_lock_interruptible(&data->lock)) {
>
> And similar ACQUIRE stuff for this one.  Given both are
> release in all paths just before return it should simplify the flow a lit=
tle.
>
> > +             iio_device_release_direct(iio);
> >               return -EINTR;
> > +     }
> >
> >       switch (mask) {
> >       case IIO_CHAN_INFO_SAMP_FREQ:
> > @@ -625,6 +663,7 @@ static int dps310_write_raw(struct iio_dev *iio,
> >       }
> >
> >       mutex_unlock(&data->lock);
> > +     iio_device_release_direct(iio);
> >       return rc;
> >  }
> >
> > @@ -735,6 +774,23 @@ static int dps310_read_pressure(struct dps310_data=
 *data, int *val, int *val2,
> >               *val2 =3D 1000; /* Convert Pa to KPa per IIO ABI */
> >               return IIO_VAL_FRACTIONAL;
> >
> > +     case IIO_CHAN_INFO_RAW:
> > +             rc =3D dps310_read_pres_raw(data);
> > +             if (rc)
> > +                     return rc;
> > +
> > +             rc =3D dps310_calculate_pressure(data, val);
> > +             if (rc)
> > +                     return rc;
>
> Maybe wrap this up in a little helper given sharing with PROCESSED.
> Will make that a little more visually obvious.
>
> > +
> > +             return IIO_VAL_INT;
> > +
> > +     case IIO_CHAN_INFO_SCALE:
> > +             /* Raw pressure is in Pa; scale to kPa per IIO ABI */
> > +             *val =3D 1;
> > +             *val2 =3D 1000;
> > +             return IIO_VAL_FRACTIONAL;
> > +
> >       case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> >               rc =3D dps310_get_pres_precision(data, val);
> >               if (rc)
> > @@ -804,12 +860,10 @@ static int dps310_read_temp(struct dps310_data *d=
ata, int *val, int *val2,
>
> ...
>
> > +static int dps310_read_raw(struct iio_dev *iio,
> > +                        struct iio_chan_spec const *chan,
> > +                        int *val, int *val2, long mask)
> > +{
> > +     struct dps310_data *data =3D iio_priv(iio);
> > +     int rc;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +     case IIO_CHAN_INFO_PROCESSED:
> > +             /*
> > +              * Reading a sample uses the same raw values as the buffe=
red
> > +              * capture path, so only allow it outside of buffered mod=
e.
> > +              */
> > +             if (!iio_device_claim_direct(iio))
> > +                     return -EBUSY;
>
> Maybe add scope and use an ACQUIRE here similar to suggested above.
> It is more marginal but might make sense to use it for consistency.
>
> > +
> > +             rc =3D dps310_read_channel(data, chan, val, val2, mask);
> > +             iio_device_release_direct(iio);
> > +             return rc;
> > +
> > +     default:
> > +             return dps310_read_channel(data, chan, val, val2, mask);
> > +     }
> > +}
> > +
> >  static void dps310_reset(void *action_data)
> >  {
> >       struct dps310_data *data =3D action_data;
> > @@ -843,6 +923,46 @@ static const struct iio_info dps310_info =3D {
> >       .write_raw =3D dps310_write_raw,
> >  };
> >
> > +static irqreturn_t dps310_trigger_handler(int irq, void *p)
> > +{
> > +     struct iio_poll_func *pf =3D p;
> > +     struct iio_dev *iio =3D pf->indio_dev;
> > +     struct dps310_data *data =3D iio_priv(iio);
> > +     int rc, pressure, temp;
> > +
> > +     /*
> > +      * Don't hold data->lock across these calls: the read helpers tak=
e it
> > +      * themselves and the mutex is not recursive (dps310_calculate_pr=
essure
> > +      * also grabs it with mutex_trylock to refresh the temperature).
>
> Would it make sense to provide a version of these calls that doesn't take=
 the
> lock then take it here to avoid bouncing it?
>
> > +      */
> > +     rc =3D dps310_read_pres_raw(data);
> > +     if (rc)
> > +             goto out;
> > +
> > +     rc =3D dps310_read_temp_raw(data);
>
> Given temperature and pressure are effectively independent sequences I th=
ink
> you would be better off not providing available_scan_masks() but instead =
reading
> only the ones that are enabled. Lots of examples of how to do that
> in tree.
>
> > +     if (rc)
> > +             goto out;
> > +
> > +     rc =3D dps310_calculate_pressure(data, &pressure);
> > +     if (rc)
> > +             goto out;
> > +
> > +     rc =3D dps310_calculate_temp(data, &temp);
> > +     if (rc)
> > +             goto out;
> > +
> > +     data->scan.chan[0] =3D temp;      /* millidegrees Celsius */
> > +     data->scan.chan[1] =3D pressure;  /* Pascals */
> > +
>
> Drag the scan in here as a local variable. It's fairly small and there
> is nothing stopping you having it on the stack given no DMA to it
> or anything like that.
>
> > +     iio_push_to_buffers_with_ts(iio, &data->scan, sizeof(data->scan),
> > +                                 pf->timestamp);
> > +
> > +out:
> > +     iio_trigger_notify_done(iio->trig);
> > +
> > +     return IRQ_HANDLED;
> > +}
