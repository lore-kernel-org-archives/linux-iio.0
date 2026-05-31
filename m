Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F20385D69
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780231146; cv=pass; b=GxeBqUNAMF2HsovNA1sskF/gZBamh5RwHySqqXftci7HZgH6AR/UVTLhIO3XcSKInMKvgXbOpDnxflMDTkJaGCZQXbI//I6Y1qFmFe5uUHrDtsW3dClbRJwTjo8KNv5TgFvXmLsSFnFtR5BToPyb7DluWVlc2TvO732ftFgZ610=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780231146; c=relaxed/simple;
	bh=2OZDPXFYs4jiJNgdp1ffT7ShDq56e80aP32Ung71qqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCxxy7nPw5XB4NfXvHPzemZhT1ZIki8oGaGtZWrWyRe2mOa2RHPMlA+9ffytEnw9hEWGRF3mIv3bss0lFTKS7UAJDuAzf9Wd4ZcHuPFdyG2lVcz5fT2xTt4BQqwFVHj4o3/aVapfd7oaXcEyYeaZtGXHS293XfxMR9sFYdfF/0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3kFe3ez; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3kFe3ez"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa68cfc182so362126e87.0
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 05:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780231143; cv=none;
        d=google.com; s=arc-20240605;
        b=jOGv7GEKtHl6Fhh6WXO4Xq2XHJ23sBp4rolbp8iMhYDMtR7uiHlbWJA8fkrtHY/gby
         BcKZ5/Xji1LoyD5UwmPL8Ty8Ex9TWzaTRboa8IwvcHqBGbuVkstCQSmzAksnFXDsg96l
         EyI4KfMTQGLJKivou+ycETHRO5SinipIwqeq9Vlc6pEZZ96LwYdrotp1bsx+jOjmmEMB
         vjzo4NTGaPaaMb+E5wK3oTQzja6rYVfliGdQ39U1ZXyPpjbHaMRN9fN7IrmoKX60447L
         B7+UgwFPh2o5HNUMdiP4V5f9b9OR/+nTOtwWLz6G6ckeCGJm8kpe//oX/l3T7WmtJTZW
         HtBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ehfLg/8cA5jYFyJ8eK7zstuVr331pF3pCUVEUtMzQak=;
        fh=A3z2rN7xef3lpwTgp2hum70VXOnVemaHLjfQJyh+hjs=;
        b=cilQBCQ01juUE+2Qi6EToOFdLHsf+B0DgBHQZxPklxo9tqFI5MqIQvCW+d+9qH2JmP
         ePOUpAP6GWrU5uP8jRFQosHfmfe8McMFjLlzntx+M7QEohszl92cRJXsWHgK2mjNs0dH
         TwIIC7h6oceoqlpTEp6RXVq634NpuRZgFwbPdxnY0WjaErynYmUcv9kk5VvPqY8mts4m
         hzu+jEDrXvTi18QsnTrU0rN1c3tKFJS3Kv7UWjpGc9D3WLH9hvLuDHhdj8RUNJakD4gb
         Gp1gfkyhHhqfDdHYJ+nAYcakfvVFlXkm5lZ9km6w+3ED1zPq2auxG/jWMjc0IckHa97G
         K9WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780231143; x=1780835943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehfLg/8cA5jYFyJ8eK7zstuVr331pF3pCUVEUtMzQak=;
        b=k3kFe3ezv1T/2uxWHI0tddJBkk5kyS7MDzkpPgZpkblgeyySMVDGbnOnWBXmJWv8Al
         j2wZA0Ez0uHxHDlkJK3OUIGfCm8sfLZQr/X6d/jlHr5TXLh68Y4QLqPW6zTbwMCuJHvp
         BkXuKpG1vAd7w22TF3uezeWhhngn7krOc0Hw6O45B+BCE5ajvPn0iBRi9JZzvctO7GJo
         RwI9aW0Lu5yqvcTxic6DA8SPUNreruUd1Gp8P/Wo33g4z+PgI6yqiR449uPdLVKi3Iqx
         UUzPCDOZ5ybHt2qDxajS6LHNANl5uOvXJgJo3kZq0jQ/+Jcmw05S5ZdZLu/DTYww1Fx9
         lRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780231143; x=1780835943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ehfLg/8cA5jYFyJ8eK7zstuVr331pF3pCUVEUtMzQak=;
        b=JpeD9hciDysZH2DgKKiGAqZnxG9W2UvrEaeYj+EZ3UhfwOe7k4EntyT3v2XmaSOOGg
         uMJlIAWg0oMdgVAsWj4AsvHc4UUtdKNfLefnRjQIVqExMi2bYc52qCXUw8b74cCtPcgG
         yddWDhEVXPQGKcF0HnIHJHoWF9kdQzNHm/jGUdFHyM6zATGe9t1g42W/S3tdZlhHw7gh
         eJh5X5z3IC8T+mBeCtoYrPqdFgOG/2xuJw1c3S1oAloMOy1QU6jIXJLdD3dga19sOwOm
         hmILqyFs8ZF3PUkkZT4cEbMa59MgFV8/WRPHF1ARxRWP5uFPqmuyn/9DGduVi9DgvgYs
         ojyA==
X-Gm-Message-State: AOJu0YzJARXA1314PpFpN+/btRv1/estYU09xpN/r1ck6ktzJUCFOoq/
	i8hfH35uJtoxoa1fEaxdPrPsWmVERUsX2mPaxVi7wbwGli0NDq+278AgWktm2J98D6z8fcKdJfa
	644WfaIydGc494Oo9srEH6d3g1HUjagY=
X-Gm-Gg: Acq92OFJOGI/jScYi7QpAJJbT0muqvL3g8rI86AErheLJgE3t91cJ5Pd4+GYY6VeYXq
	Uf/E8nY81TC/OmtUNheRom9XperXSOMnPlBNEQJ9nIdtwM6mFuSma5sNnOJwRXvA8dLvYmZhw5b
	CavjxoOwK+c8x4iIGYll7At4Ju3VnI4Ij8x+9nGjL7rOM2jmFKM1poi3X9XYCwPn4/mbmxxOFLB
	OeTQU8SSEAOJ+7g1ier6/r/4YTplcIlHKESNfg5rVtm3PxxRAIxYZkIecvJBEKAyIjzvM6zr/QG
	z1aYy8HF3pUI4Z11v0HoD8c0E0dsB9IqzBswipnnRzXlKW1Lww==
X-Received: by 2002:a05:6512:150f:10b0:5a8:9988:f1d5 with SMTP id
 2adb3069b0e04-5aa608f7f43mr1472189e87.24.1780231142164; Sun, 31 May 2026
 05:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530113938.171540-1-suunj1331@gmail.com> <20260530113938.171540-5-suunj1331@gmail.com>
 <20260530170534.11f8e7f7@jic23-huawei>
In-Reply-To: <20260530170534.11f8e7f7@jic23-huawei>
From: SeungJu Cheon <suunj1331@gmail.com>
Date: Sun, 31 May 2026 21:38:48 +0900
X-Gm-Features: AVHnY4IA1OzfOKzo1cwWjda6xbVuzhJ-g0PyjwMkraZvEoCXPsDVsKaEk64TfcI
Message-ID: <CAGwK=3qU2VsgoSAtC7+LFps-qG4Yrjsdw=AWxJ0cpzt7EymHiQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: pressure: mpl3115: add hardware FIFO support
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, apokusinski01@gmail.com, me@brighamcampbell.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sat, 30 May 2026 01:05 ... Jonathan Cameron wrote:
> Note that even though you've had a couple of quick reviews wait at
> least a few days / 1 week to see if others have review comments
> before doing a new version.

Will do. I'll hold v2 for a week or so to let any further comments
come in.

> > +#define MPL3115_FIFO_SAMPLES_PER_READ 6U
>
> comment on why 6.

Will add a comment explaining the 6.

> > +     return i2c_smbus_write_byte_data(data->client, MPL3115_F_SETUP,
> > +                     f_setup);
>
> Align after ( Or just go a bit long and put it one line.

Will put it on one line.

> > +     while (remaining > 0) {
>
> Don't think this can got negative. I'd make that explicit as !=3D 0

Will change to !=3D 0.

> > +             ret =3D i2c_smbus_read_i2c_block_data(data->client,
> > [...]
>
> Given this is reading up to 6 samples, it feels odd to just keep
> reading without pushing any of them to the buffer. I'd rework the
> logic so for each iteration of the fifo we push the data we have.
> That will reduce the storage requirement quite a bit.

Good point. I'll push samples as I read each batch instead of
buffering them all first, which also shrinks fifo_buf considerably.

> > +     u8 buffer[MPL3115_BUF_SIZE] __aligned(sizeof(s64)) =3D { };
>
> This is only used in the loop below. Declare it down there with
> an appropriate struct (see reply I sent to Andy's review)

Will move it into the loop as a struct with __be32/__be16 fields and
an aligned s64 timestamp.

> > +     unsigned int sample_count, i;
> > +     int ret;
> > +     bool overflow;
> > +     s64 ts;
>
> When no other reason for ordering, reverse xmas tree preferred in
> IIO.

Will reorder.

> > +     if (sample_count =3D=3D 0)
>
> Add a comment on what overflow with no samples means. That seems
> unusual.

Will add a comment for the overflow-with-no-samples case.

> > +     ts =3D iio_get_time_ns(indio_dev);
>
> This data is coming from a fifo. How is the time grabbed here
> relevant?
> Timestamp + fifo handling is hard. See how the invensense IMU
> drivers do it. For 1st version of this you may have to just fail the
> buffer enable if the timestamp is turned on. I'd revisit timestamps
> after the rest is upstream (or at least as additional patches).

Agreed, stamping FIFO samples with the current time isn't ideal. For
v2 I'll reject buffer enable if the timestamp channel is on, and leave
proper FIFO timestamping (along the lines of the invensense drivers)
to a follow-up once the rest is in.

> Maybe worth introducing an enum for those bits (use in the
> iio_chan_spec array elements as well)
> > +     0,
> No comma (Andy got this already)

Will drop the comma and introduce an enum for the scan indices, reused
in the channel specs.

> > +             if (flush_ret < 0)
> > +                     goto err_reset_fifo;
> > [...]
> > +err_reset_fifo:
> > +     scoped_guard(mutex, &data->lock)
>
> So this is technically not a bug but it runs into the basic argument
> that if you are using automatic cleanup you shouldn't be using gotos
> in the same function [...]
> Hmm. This is trickier given fifo_reset is called in fifo_flush.
> Maybe a wrapper and guard() The none guard version would typically
> use __mpl3115_fifo_reset() naming.

Makes sense. I'll push the locking into the functions and use guard()
there, with a __mpl3115_fifo_reset() helper for the already-locked
caller, so the handler no longer mixes scoped_guard() with a goto.

> It's hard to retrofit a fifo and not end up with a weird control
> interface. We can't remove the triggered buffer because that will be
> a regression for existing users.
> So the trick we have done in the past is to enable the fifo whenever
> a trigger is not set, but the buffer enabled.
> [...]
> Do this unconditionally. It will register a kfifo so we can use that
> anyway, but will also have the interface we can't remove [...]

Understood. I'll drop the use_fifo gating and keep the triggered
buffer registration unconditional, then select the FIFO path from
postenable when no trigger is configured. I'll try option (A) by first
making the triggered capture always read both channels, so the FIFO
path can avoid introducing available_scan_masks.

Thanks very much for the detailed review.

On Sun, May 31, 2026 at 1:05=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 30 May 2026 20:39:38 +0900
> SeungJu Cheon <suunj1331@gmail.com> wrote:
>
> > Add support for the MPL3115A2 hardware FIFO.
> >
> > The device provides a 32-sample FIFO with configurable
> > watermark interrupts, allowing buffered data acquisition
> > with reduced interrupt and CPU overhead.
> >
> > Use a kfifo-backed IIO buffer when a DRDY interrupt and
> > SMBus block reads are available, falling back to the
> > existing triggered buffer implementation otherwise.
> >
> > When enabled, the driver configures the FIFO in circular
> > mode and drains accumulated samples on watermark
> > interrupts.
> >
> > Overflow conditions are handled by flushing available
> > samples before resetting the FIFO, avoiding unnecessary
> > data loss.
> >
> > The hardware always captures pressure and temperature
> > samples together, so FIFO operation requires both channels
> > to be enabled.
> >
> > Register cache updates are performed only after successful
> > I2C writes to keep cached and hardware state consistent.
> >
> > No functional change for non-buffered operation.
> >
> > Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
>
> Various comments inline to add to what Andy pointed out.
>
> Note that even though you've had a couple of quick reviews wait at least =
a few
> days / 1 week to see if others have review comments before doing a new ve=
rsion.
> Any discussion will probably have finished by then.
>
> (I can't speak for Andy, but in the UK it's too hot to do much outside
> today - so I'm bored!)
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/pressure/mpl3115.c | 266 +++++++++++++++++++++++++++++++--
> >  1 file changed, 256 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3=
115.c
> > index 90e83e34ec43..26b6490c8c4c 100644
> > --- a/drivers/iio/pressure/mpl3115.c
> > +++ b/drivers/iio/pressure/mpl3115.c
>
> > +#define MPL3115_BUF_PRESS_OFFSET 0
> > +#define MPL3115_BUF_TEMP_OFFSET 4
> > +#define MPL3115_BUF_TS_OFFSET 8
> > +#define MPL3115_BUF_SIZE (MPL3115_BUF_TS_OFFSET + sizeof(s64))
> > +
> > +#define MPL3115_FIFO_SAMPLES_PER_READ 6U
> comment on why 6.
> > +
> >  #define MPL3115_PT_DATA_EVENT_ALL GENMASK(2, 0)
> >
> >  #define MPL3115_CTRL1_RESET BIT(2) /* software reset */
> > @@ -63,8 +89,12 @@
> >  #define MPL3115_CTRL3_IPOL2 BIT(1)
> >
> >  #define MPL3115_CTRL4_INT_EN_DRDY BIT(7)
> > +#define MPL3115_CTRL4_INT_EN_FIFO BIT(6)
> >  #define MPL3115_CTRL4_INT_EN_PTH BIT(3)
> >  #define MPL3115_CTRL4_INT_EN_TTH BIT(2)
> > +#define MPL3115_CTRL4_ACTIVE_MASK \
> > +     (MPL3115_CTRL4_INT_EN_DRDY | \
> > +      MPL3115_CTRL4_INT_EN_PTH | MPL3115_CTRL4_INT_EN_TTH)
> >
> >  #define MPL3115_CTRL5_INT_CFG_DRDY BIT(7)
> >  #define MPL3115_CTRL5_INT_CFG_FIFO BIT(6)
> > @@ -94,6 +124,9 @@ struct mpl3115_data {
> >       struct mutex lock;
> >       u8 ctrl_reg1;
> >       u8 ctrl_reg4;
> > +     u8 watermark;
> > +     u8 fifo_buf[MPL3115_FIFO_SIZE * MPL3115_FIFO_SAMPLE_SIZE]
> > +             __aligned(IIO_DMA_MINALIGN);
> >  };
> >
> >  enum mpl3115_irq_pin {
> > @@ -101,6 +134,25 @@ enum mpl3115_irq_pin {
> >       MPL3115_IRQ_INT2,
> >  };
> >
> > +static int mpl3115_set_active(struct mpl3115_data *data, bool active)
> > +{
> > +     u8 reg;
> > +     int ret;
> > +
> > +     if (active)
> > +             reg =3D data->ctrl_reg1 | MPL3115_CTRL1_ACTIVE;
> > +     else
> > +             reg =3D data->ctrl_reg1 & ~MPL3115_CTRL1_ACTIVE;
> > +
> > +     ret =3D i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1=
,
> > +                                     reg);
> One line.  Or as Andy suggested split this in two, then the reg local
> variable isn't needed.
>
> > +     if (ret)
> > +             return ret;
> > +
> > +     data->ctrl_reg1 =3D reg;
> > +     return 0;
> > +}
> > +
> >  static int mpl3115_request(struct mpl3115_data *data)
> >  {
> >       int ret, tries =3D 15;
> > @@ -322,6 +374,109 @@ static irqreturn_t mpl3115_trigger_handler(int ir=
q, void *p)
> >       return IRQ_HANDLED;
> >  }
> >
> > +static int mpl3115_set_fifo(struct mpl3115_data *data,
> > +                         enum mpl3115_fifo_mode mode)
> > +{
> > +     u8 f_setup;
> > +
> > +     f_setup =3D FIELD_PREP(MPL3115_F_SETUP_F_MODE, mode) |
> > +               FIELD_PREP(MPL3115_F_SETUP_F_WMRK, data->watermark);
> > +
> > +     return i2c_smbus_write_byte_data(data->client, MPL3115_F_SETUP,
> > +                     f_setup);
>
> Align after (  Or just go a bit long and put it one line.
>
>
> > +}
> > +
> > +static int mpl3115_fifo_reset(struct mpl3115_data *data)
> > +{
> > +     int ret;
> > +
> > +     ret =3D mpl3115_set_fifo(data, MPL3115_F_MODE_DISABLED);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return mpl3115_set_fifo(data, MPL3115_F_MODE_CIRCULAR);
> > +}
> > +
> > +static int mpl3115_fifo_transfer(struct mpl3115_data *data,
> > +                              unsigned int sample_count)
> > +{
> > +     unsigned int remaining =3D sample_count;
> > +     unsigned int offset =3D 0;
> > +     unsigned int batch;
> > +     int ret;
> > +
> > +     while (remaining > 0) {
>
> Don't think this can got negative. I'd make that explicit as !=3D 0
>
> > +             batch =3D min(remaining, MPL3115_FIFO_SAMPLES_PER_READ);
> > +
> > +             ret =3D i2c_smbus_read_i2c_block_data(data->client,
> > +                                                 MPL3115_OUT_PRESS,
> > +                                                 batch * MPL3115_FIFO_=
SAMPLE_SIZE,
> > +                                                 &data->fifo_buf[offse=
t]);
> Given this is reading up to 6 samples, it feels odd to just keep reading =
without
> pushing any of them to the buffer. I'd rework the logic so for each itera=
tion
> of the fifo we push the data we have. That will reduce the storage requir=
ement
> quite a bit.
> > +             if (ret < 0)
> > +                     return ret;
> > +             if (ret !=3D batch * MPL3115_FIFO_SAMPLE_SIZE)
> > +                     return -EIO;
> > +
> > +             offset +=3D batch * MPL3115_FIFO_SAMPLE_SIZE;
> > +             remaining -=3D batch;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int mpl3115_fifo_flush(struct iio_dev *indio_dev)
> > +{
> > +     struct mpl3115_data *data =3D iio_priv(indio_dev);
> > +     u8 buffer[MPL3115_BUF_SIZE] __aligned(sizeof(s64)) =3D { };
>
> This is only used int he loop below. Declare it down there with
> an appropriate struct (see reply I sent to Andy's review)
>
> > +     unsigned int sample_count, i;
> > +     int ret;
> > +     bool overflow;
> > +     s64 ts;
> When no other reason for ordering, reverse xmas tree preferred in IIO.
>
>
> See below. I'd pull the guard() in here.
>
> > +
> > +     ret =3D i2c_smbus_read_byte_data(data->client, MPL3115_F_STATUS);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     overflow =3D FIELD_GET(MPL3115_F_STATUS_F_OVF, ret);
> > +     sample_count =3D FIELD_GET(MPL3115_F_STATUS_F_CNT, ret);
> > +     if (sample_count =3D=3D 0)
>
> Add a comment on what overflow with no samples means. That seems
> unusual.
>
> > +             return overflow ? mpl3115_fifo_reset(data) : 0;
> > +
> > +     ret =3D mpl3115_fifo_transfer(data, sample_count);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ts =3D iio_get_time_ns(indio_dev);
>
> This data is coming from a fifo. How is the time grabbed here relevant?
>
> Timestamp + fifo handling is hard. See how the invensense IMU drivers
> do it.  For 1st version of this you may have to just fail the buffer
> enable if the timestamp is turned on.  I'd revisit timestamps after the
> rest is upstream (or at least as additional patches).
>
> > +     for (i =3D 0; i < sample_count; i++) {
> > +             u8 *sample =3D &data->fifo_buf[i * MPL3115_FIFO_SAMPLE_SI=
ZE];
> > +
> > +             memcpy(&buffer[MPL3115_BUF_PRESS_OFFSET], &sample[0], 3);
> > +             memcpy(&buffer[MPL3115_BUF_TEMP_OFFSET], &sample[3], 2);
> > +
> > +             iio_push_to_buffers_with_ts(indio_dev, buffer, sizeof(buf=
fer), ts);
> > +     }
> > +
> > +     if (overflow) {
> > +             dev_warn_ratelimited(&data->client->dev,
> > +                                  "FIFO overflow, samples may be lost\=
n");
> > +             return mpl3115_fifo_reset(data);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int mpl3115_set_watermark(struct iio_dev *indio_dev, unsigned i=
nt value)
> > +{
> > +     struct mpl3115_data *data =3D iio_priv(indio_dev);
> > +
> > +     value =3D clamp_val(value, 1, MPL3115_FIFO_SIZE - 1);
> > +
> > +     guard(mutex)(&data->lock);
> > +     data->watermark =3D value;
> > +
> > +     return 0;
> > +}
> > +
> >  static int mpl3115_config_interrupt(struct mpl3115_data *data,
> >                                   u8 ctrl_reg1, u8 ctrl_reg4)
> >  {
> > @@ -348,6 +503,67 @@ static int mpl3115_config_interrupt(struct mpl3115=
_data *data,
> >       return ret;
> >  }
> >
> > +static int mpl3115_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +     struct mpl3115_data *data =3D iio_priv(indio_dev);
> > +     u8 ctrl_reg4;
> > +     int ret;
> > +
> > +     guard(mutex)(&data->lock);
> > +
> > +     ret =3D mpl3115_set_active(data, false);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D mpl3115_set_fifo(data, MPL3115_F_MODE_CIRCULAR);
> > +     if (ret) {
> > +             mpl3115_set_active(data, true);
> > +             return ret;
> > +     }
> > +
> > +     ctrl_reg4 =3D data->ctrl_reg4;
> > +     ctrl_reg4 |=3D MPL3115_CTRL4_INT_EN_FIFO;
> > +     ctrl_reg4 &=3D ~MPL3115_CTRL4_INT_EN_DRDY;
> > +
> > +     return mpl3115_config_interrupt(data,
> > +             data->ctrl_reg1 | MPL3115_CTRL1_ACTIVE, ctrl_reg4);
> > +}
> > +
> > +static int mpl3115_buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +     struct mpl3115_data *data =3D iio_priv(indio_dev);
> > +     u8 ctrl_reg1, ctrl_reg4;
> > +     int ret;
> > +
> > +     guard(mutex)(&data->lock);
> > +
> > +     ret =3D mpl3115_set_active(data, false);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D mpl3115_set_fifo(data, MPL3115_F_MODE_DISABLED);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ctrl_reg4 =3D data->ctrl_reg4 & ~MPL3115_CTRL4_INT_EN_FIFO;
> > +     ctrl_reg1 =3D data->ctrl_reg1;
> > +
> > +     if (ctrl_reg4 & MPL3115_CTRL4_ACTIVE_MASK)
> > +             ctrl_reg1 |=3D MPL3115_CTRL1_ACTIVE;
> > +
> > +     return mpl3115_config_interrupt(data, ctrl_reg1, ctrl_reg4);
> > +}
> > +
> > +static const struct iio_buffer_setup_ops mpl3115_buffer_ops =3D {
> > +     .postenable =3D mpl3115_buffer_postenable,
> > +     .predisable =3D mpl3115_buffer_predisable,
> > +};
> > +
> > +static const unsigned long mpl3115_scan_masks[] =3D {
> > +     BIT(0) | BIT(1),
> Maybe worth introducing an enum for those bits (use in the iio_chan_spec =
array elements
>  as well)
> > +     0,
> No comma (Andy got this already)
> > +};
> > +
> >  static const struct iio_event_spec mpl3115_temp_press_event[] =3D {
> >       {
> >               .type =3D IIO_EV_TYPE_THRESH,
> > @@ -409,10 +625,19 @@ static irqreturn_t mpl3115_interrupt_handler(int =
irq, void *private)
> >       if (ret < 0)
> >               return IRQ_NONE;
> >
> > -     if (!(ret & (MPL3115_INT_SRC_TTH | MPL3115_INT_SRC_PTH |
> > -                  MPL3115_INT_SRC_DRDY)))
> > +     if (!(ret & (MPL3115_INT_SRC_FIFO | MPL3115_INT_SRC_TTH |
> > +                  MPL3115_INT_SRC_PTH | MPL3115_INT_SRC_DRDY)))
> >               return IRQ_NONE;
> >
> > +     if (ret & MPL3115_INT_SRC_FIFO) {
> > +             int flush_ret;
> > +
> > +             scoped_guard(mutex, &data->lock)
> > +                     flush_ret =3D mpl3115_fifo_flush(indio_dev);
> > +             if (flush_ret < 0)
> So this is technically not a bug but it runs into the basic argument that=
 if you are
> using automatic cleanup you shouldn't be using gotos in the same function
> (says that in comments in cleanup.h - Linus was very explicit about this =
when people
>  1st starting using these functions!)
>
> With it pushed into the function though that doesn't matter.
>
> > +                     goto err_reset_fifo;
> > +     }
> > +
> >       if (ret & MPL3115_INT_SRC_DRDY)
> >               iio_trigger_poll_nested(data->drdy_trig);
> >
> > @@ -444,6 +669,11 @@ static irqreturn_t mpl3115_interrupt_handler(int i=
rq, void *private)
> >       }
> >
> >       return IRQ_HANDLED;
> > +
> > +err_reset_fifo:
> > +     scoped_guard(mutex, &data->lock)
>
> Hmm. This is trickier given fifo_reset is called in fifo_flush.
> Maybe a wrapper and guard()  The none guard version would typically use
> __mpl3115_fifo_reset() naming.
>
>
> > +             mpl3115_fifo_reset(data);
> > +     return IRQ_HANDLED;
> >  }
>
> >  static int mpl3115_trigger_probe(struct mpl3115_data *data,
> > @@ -723,6 +954,7 @@ static int mpl3115_probe(struct i2c_client *client)
> >       const struct i2c_device_id *id =3D i2c_client_get_device_id(clien=
t);
> >       struct mpl3115_data *data;
> >       struct iio_dev *indio_dev;
> > +     bool use_fifo;
> >       int ret;
> >
> >       ret =3D i2c_smbus_read_byte_data(client, MPL3115_WHO_AM_I);
> > @@ -762,17 +994,31 @@ static int mpl3115_probe(struct i2c_client *clien=
t)
> >       if (ret)
> >               return ret;
> >
> > +     data->watermark =3D MPL3115_DEFAULT_WATERMARK;
> > +
> >       ret =3D mpl3115_trigger_probe(data, indio_dev);
> >       if (ret)
> >               return ret;
> >
> > -     ret =3D devm_iio_triggered_buffer_setup(&client->dev,
> > -                                   indio_dev,
> > -                                   NULL,
> > -                                   mpl3115_trigger_handler,
> > -                                   NULL);
> > -     if (ret)
> > -             return ret;
> > +     use_fifo =3D data->drdy_trig &&
> > +        i2c_check_functionality(client->adapter,
> > +                                I2C_FUNC_SMBUS_READ_I2C_BLOCK);
>
> Hmm. So this is always a fun thing to work out how to handle.
> Gating on a particular i2c controller function isn't appropriate.
> More to the point existing code is relying on that being available.
>
> static int mpl3115_fill_trig_buffer(struct iio_dev *indio_dev, u8 *buffer=
)
> {
>         struct mpl3115_data *data =3D iio_priv(indio_dev);
>         int ret, pos =3D 0;
>
>         if (!(data->ctrl_reg1 & MPL3115_CTRL1_ACTIVE)) {
>                 ret =3D mpl3115_request(data);
>                 if (ret < 0)
>                         return ret;
>         }
>
>         if (test_bit(0, indio_dev->active_scan_mask)) {
>                 ret =3D i2c_smbus_read_i2c_block_data(data->client,
>                         MPL3115_OUT_PRESS, 3, &buffer[pos]);
>                 if (ret < 0)
>                         return ret;
>                 pos +=3D 4;
>         }
>
>         if (test_bit(1, indio_dev->active_scan_mask)) {
>                 ret =3D i2c_smbus_read_i2c_block_data(data->client,
>                         MPL3115_OUT_TEMP, 2, &buffer[pos]);
>                 if (ret < 0)
>                         return ret;
>         }
>
>         return 0;
> }
>
> It's hard to retrofit a fifo and not end up with a weird control
> interface. We can't remove the triggered buffer because that will be
> a regression for existing users.
>
> So the trick we have done in the past is to enable the fifo whenever
> a trigger is not set, but the buffer enabled.
>
> > +
> > +     if (use_fifo) {
> > +             indio_dev->available_scan_masks =3D mpl3115_scan_masks;
> Given other changes I'm suggesting we have nothing to gate that on.
> 2 options:
> A) take the view that's not that costly and optimize the exiting triggere=
d
>    capture for that case (as a precursor)
> B) Do manual data mangling so that you don't need this.  That is just
>    fill the buffer with enabled channels (that makes a mess of using a st=
ruct
>    though as the first channel type changes depending on what is enabled)=
.
>
> I'd do (A)
>
> > +             ret =3D devm_iio_kfifo_buffer_setup(&client->dev, indio_d=
ev,
> > +                                               &mpl3115_buffer_ops);
> Don't do this - instead...
> > +             if (ret)
> > +                     return ret;
> > +     } else {
> > +             ret =3D devm_iio_triggered_buffer_setup(&client->dev,
> > +                                                   indio_dev,
> > +                                                   NULL,
> > +                                                   mpl3115_trigger_han=
dler,
> > +                                                   NULL);
>
> Do this unconditionally. It will register a kfifo so we can use that
> anyway, but will also have the interface we can't remove (without it
> being an ABI regression) to set the trigger.
>
> > +             if (ret)
> > +                     return ret;
> > +     }
> >
> >       return devm_iio_device_register(&client->dev, indio_dev);
> >  }
>
