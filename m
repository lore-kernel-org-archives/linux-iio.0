Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398F938E8A0
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781968535; cv=pass; b=H7NlYydtKok0pMBHSIjsZsOoVbUqQk0quXPf9Rmw5Zo8jkaabshe0/tmIOIm/l63+oU/NU0GK1X0gvbSu7yl8ufeVFiNbx+nE/7thq8pzz7HrnAS1AI0Q3K4nypb1TZirjNEcPF2dtTnpe0CJhmkBj/EOn3XfVNrisL+oJEwKRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781968535; c=relaxed/simple;
	bh=voUGKn1kwkr35JjtSbFiOfaYj3b3dz7+sDFcj4+OCxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnnJDRf6+4Nai8tL6s9838oyF9L1liyN5N22oiEwRSBRMW3Ogx9AHe7swaghSwZhwMn6ukve3ckS31T1MZdEs5jbNF6bKDfBMGEZ6jCnQeIw5G3hEBs8MR62pFtJnrAietHbw+bdeoLCEs4m9N3vQ/qJMIC6vRE/wzAsU4I2xqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB36RibH; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB36RibH"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7fe8bc0a01bso28601127b3.1
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 08:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781968533; cv=none;
        d=google.com; s=arc-20240605;
        b=ZNQpsM9t1oK9KyK4vbDijdHTqyIFeAEwbJtZOCmiW9jmWXdvoPBFmk5Q9FxSdMnZSY
         Z02R93pNYAa0F9WZ7ndS2Z13F/JSVjKrLMfGdejTqc2y+la+cHgenik0Nc9rO+T9JXxi
         1V6XPxqWcGIISCSixHmik3MqH3s61E4qwFrKZ/ivqIhQCoeJdGQjnc7lRx6tyAuNvDuY
         cXLiRYOMt0bd5Yq5PQ2PrbBTYgvQmJJ7eGVQu4AQ+ZXhofP+v1LiDXWeYWD8JiBmtNUO
         nyZKFv+PwGJ33NUrutmpFYn/dkwcI25PmoKUz7gG+m0ULWwp8qS8Vte8DiQ1c06u28K8
         lzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=auwPm3OvisImI6MUxCT5+ZrF+goA+v1DqyU5w8mEumA=;
        fh=Lg8XWGL9zsHJYR1zbBdjuO2fkQQYBzVSphvLgcAfd/Y=;
        b=j9ICVTvsH+S/AGtAzvLYu23g4kVGeDw4Mfx++4kC0ryeLAzY+mLjdn0XeXCPLCXB2T
         8PL2DNvYKmKoO1h904Gz1S9Xooe6FGUDjOMWBs/gE0MZTwqy/YHAwFOmH/5woLh5aTWG
         1fiQ5V1VzXASxl1uBIgySThQ0faPcUm+XkpBIuuXTDm2HfxlHTAyp0kLQ2uGsAKo4Hpu
         gPJAdoxWJ+dyNhYk6uyIVuTlWKBE7OQbO1PCGa0tls4AcsEg0DRWzC/Z11rUID+nWwd7
         064qBtsVwCQvB642JOa3PaoEBcQKNPb/BK5memzvDI1U0ng4YYxks89rYthSA9N1+1M/
         6+sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781968533; x=1782573333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auwPm3OvisImI6MUxCT5+ZrF+goA+v1DqyU5w8mEumA=;
        b=gB36RibHsZoqTnXbi41PfSIw459wne1cMl9SeWCQnA8VOWVsWAj9j9YHGpVrK84Jfb
         X6apjjEUm1wpcjFvcN2o3l8GjgjH5UK+ukltb5bczS7GRbBkViukzqna7DLD5RemQi46
         e085Rqj2B2FaYG4ikxml/F/U2xuKXCLg8tdF+VhQupFgvBCpjIf4XnzYB8a5z81xz0BO
         dnJDgVyK+Fk5j4s8syQCR3IZ0mmn4WCn0F1fkK1SIFXxaNws3h5BW+nNrJPrNYQ7x91g
         0Aribmo0TyQ/EBeEk0MiEVe3XgYLvcHOOshktl+J12LAhMq+cf7/ZX60/rP91i8CdLVH
         j0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781968533; x=1782573333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=auwPm3OvisImI6MUxCT5+ZrF+goA+v1DqyU5w8mEumA=;
        b=N+oXv+bAZ4G9UNO/8zrg8K7y+zAUSQ6pNoI1uNOJli1I+dd5MyTQKha2hQqOw1bUPq
         d2G3JAmTcs9xHraMp8+jO2wExXgrsigqao5QZ0X35lmvud7DrO4LkFKgpeFsQjh8U8/Y
         aDzBbFxkTq1EjAuxkMmN8vIvWULopWoMDAxVGzTgSqc59Xvy94g8DqLtD3BU1eNe/VV6
         nGunDOAzlTqwvuzQ74l7KbLKngaaeNigWtr2HFRAryaKrAOPMZwYwdakIjetopXK2Iw7
         7JlaK1WhQ7clwWgysw0BjLkT9cdzE+9YpqJCw4mxkQ7ma3pOzlGwXSPK50aJeXN/uCnQ
         7NTw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4XGhQ/MvNtpXxiEFvwnW90fax/dG8/8fkrnRpGF8f64c1H1OZM7TGMH+8EZfAJqHQAvL1T1V/efM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiWxLr1L0tsxRjDAq7CG4q1fhH+qNLJZDGuue4LPPTNXxNrBdz
	Zc+vzK1QHKa6bjGxmN69Mdxy/EqdU/dM49It3TD75jbMF6wCreqH1dtdURAJbZeRGvhi+kJkrl+
	doNGsu4by+lSu45/B1bp7IHp1DUz2x5I=
X-Gm-Gg: AfdE7ckBB2cEQbX+4OGcSAk3n74EMMv+Je71aS1yp3zXgnERyLZwGg8DhWPQ8jA+2i3
	NEFGvEnqGTboX/U05fk05X0J7uEfjb6bNA4FxvplyM1k87w6KFC0Axlbp7lFGcUG+yMXbw8W9P4
	o5+hUkn41YSjCwJn/Vs7fHX0f7tkkuR2d/WooE3hjp5OTx3+H42IUeAmfBapDNZnyuMNm60smvM
	QHP8vRwFENhNxnevwfj9oOtHyO7UrbOkW3ws7TEbuBmAgm5Ogi/gkvtm5+uuhRxYwrZeg==
X-Received: by 2002:a05:690c:4b09:b0:7ff:1399:7e69 with SMTP id
 00721157ae682-80137a6ca4emr80001337b3.25.1781968532759; Sat, 20 Jun 2026
 08:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620044010.1082621-1-m32285159@gmail.com> <20260620044010.1082621-3-m32285159@gmail.com>
 <20260620094317.4e503b7d@systembl0wer>
In-Reply-To: <20260620094317.4e503b7d@systembl0wer>
From: Maxwell Doose <m32285159@gmail.com>
Date: Sat, 20 Jun 2026 10:15:22 -0500
X-Gm-Features: AVVi8CdRnIFuGs8OJ7cGVREwgwXJ4qg_mdEGMlZAKc953mBObX9PJhNVEZcbdUw
Message-ID: <CAKqfh0Fe_9VQ0kLRDZdJvCsiT8cBY83iJ1CuSEY8=SJ4SjkUxQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] iio: temperature: Add STS30 temperature sensor driver
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joshua,

Sorry about the bugs, this is my first driver submission.

On Sat, Jun 20, 2026 at 2:43=E2=80=AFAM Joshua Crofts <joshua.crofts1@gmail=
.com> wrote:
>
> Hi Max,
>
> comments inline, some nits, some more serious, some Sashiko reviews.
>
> Josh
>
> On Fri, 19 Jun 2026 23:40:06 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2026 Maxwell Doose
> > + *
> > + * Sensirion STS30 temperature sensor driver
> > + *
> > + * Datasheet: https://sensirion.com/media/documents/1DA31AFD/65D613A8/=
Datasheet_STS3x_DIS.pdf
> > + *
> > + * Author: Maxwell Doose <m32285159@gmail.com>
>
> Nit, but this is probably unnecessary since you already have
> the copyright statement above.
>

Fair, will remove.

> > + */
> > +
>
> You're missing array_size.h, as used in probe.
>

Nice catch, I didn't see that in my final compilation.

> > +#include <linux/bits.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/crc8.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/export.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/types.h>
>
> Move the IIO specific headers below the generic linux headers
> and group them separately.
>

Will do.

> > +#include <linux/i2c.h>
> > +#include <linux/kernel.h>
>
> Don't use kernel.h for new entries, you should include what

Righty oh, will remove. I guess that's why it compiled fine on my end
because it's a catch-all.

> you actually use instead of relying on this. (there is a tool
> that can help with this, it's called `iwyu-tool`).
>

I've heard of iwyu-tool, I just don't know how to configure it :(

> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/types.h>
> > +#include <linux/unaligned.h>
> > +
> > +/* Amount of bytes received from the STS30 after a read command */
> > +#define STS30_MEAS_SIZE 3
> > +
> > +#define STS30_COMMAND_READ_HIGH_REPEAT 0x2C06
> > +#define STS30_COMMAND_READ_MED_REPEAT 0x2C0D
> > +#define STS30_COMMAND_READ_LOW_REPEAT 0x2C10
> > +
> > +/* Soft reset command */
>
> No point in having a comment if your macro is sensibly named.
>

Fair point, I'll see about renaming it and removing the comment in v2.

> > +#define STS30_COMMAND_RESET 0x30A2
> > +
> > +/*
> > + * sts30 includes a CRC8 checksum at the end of its i2c responses. The=
 polynomial
> > + * is used to generate the CRC8 table and the seed is the starting val=
ue.
> > + */
> > +#define STS30_CRC8_POLYNOMIAL 0x31
> > +#define STS30_CRC8_SEED 0xFF
> > +
> > +DECLARE_CRC8_TABLE(sts30_crc_table);
> > +
> > +enum sts30_read_delays {
> > +     STS30_REPEAT_LOW =3D 4500,
> > +     STS30_REPEAT_MED =3D 6000,
> > +     STS30_REPEAT_HIGH =3D 15000
> > +};
> > +
> > +/**
> > + * struct sts30_data - data structure for STS30 driver
> > + *
> > + * @client: underlying i2c client data structure
> > + * @lock: mutex for serialized communication on the i2c bus
> > + * @delay: measurement duration for the current repeatability mode
> > + */
>
> I'd remove this comment altogether and just add a comment on why
> you need a mutex.
>

Alright then.

> > +struct sts30_data {
> > +     struct i2c_client *client;
> > +     struct mutex lock;
> > +     /*
> > +      * sts30 has three potential repeatability/measurement durations.=
 We need to
> > +      * account for them while reading the i2c bus.
> > +      *
> > +      * See section 2.2 in the datasheet for more info on processing t=
imes.
> > +      */
> > +     enum sts30_read_delays delay;
> > +};
> > +
> > +static int sts30_verify_crc8(struct sts30_data *data, u8 buf[STS30_MEA=
S_SIZE])
> > +{
> > +     int crc;
> > +
> > +     crc =3D crc8(sts30_crc_table, buf, 2, STS30_CRC8_SEED);
>
> Please use sizeof() instead of hard coding the buffer length.
>

I suppose that we can do sizeof(buf) - 1 since we know the last byte
in the buffer has to be the checksum.

> > +     if (crc !=3D buf[2]) {
> > +             dev_err(&data->client->dev, "Expected CRC8 value of 0x%02=
x, got 0x%02x\n",
> > +                     buf[2], crc);
> > +             return -EIO;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int sts30_read(struct sts30_data *data, u16 command, u16 *val)
> > +{
> > +     u8 tmp[2];
> > +     u8 buf[STS30_MEAS_SIZE];
>
> Reverse christmas tree order.
>

Sounds good.

> > +     int ret;
> > +
> > +     put_unaligned_be16(command, tmp);
> > +
> > +     ret =3D i2c_master_send(data->client, tmp, sizeof(tmp));
> > +     if (ret < 0)
> > +             return ret;
> > +     if (ret !=3D sizeof(tmp))
> > +             return -EIO;
> > +
> > +     fsleep(data->delay);
>
> Adding Sashiko's comment:
>
> Will sending a STOP condition here abort the measurement? Since
> i2c_master_send() issues a STOP condition rather than a Repeated START,
> this sequence violates the protocol for the Clock Stretching Enabled
> commands (0x2Cxx) defined above.
> Should this use the "Clock Stretching Disabled" commands (e.g., 0x2400)
> instead, or alternatively use a single i2c_transfer() with a Repeated STA=
RT?
>

Yea, I accidentally mixed up the commands, I saw this on sashiko when
I submitted it last night. It seems like a five minute fix in any case
though.

> > +
> > +     ret =3D i2c_master_recv(data->client, buf, sizeof(buf));
> > +     if (ret < 0)
> > +             return ret;
> > +     if (ret !=3D sizeof(buf))
> > +             return -EIO;
> > +
> > +     *val =3D get_unaligned_be16(buf);
> > +
> > +     ret =3D sts30_verify_crc8(data, buf);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
>
> ...
>
> > +static int sts30_reset(struct sts30_data *data)
> > +{
> > +     int ret;
> > +
> > +     guard(mutex)(&data->lock);
> > +
> > +     ret =3D sts30_write(data, STS30_COMMAND_RESET);
> > +     if (ret)
> > +             return ret;
> > +
> > +     fsleep(1500);
>
> Add a comment or change this to a macro to explain why 1500
> specifically.
>

Alright. Can also explain here:
Datasheet dictates that maximum soft reset time is 1.5ms or 1500us. We
fsleep() here to ensure that the device is ready before we continue.

> > +
> > +     return 0;
> > +}
> > +
> > +static int sts30_read_raw(struct iio_dev *indio_dev,
> > +                       struct iio_chan_spec const *chan, int *val, int=
 *val2,
> > +                       long mask)
> > +{
> > +     struct sts30_data *data =3D iio_priv(indio_dev);
> > +     int ret;
> > +     u16 tmp;
> > +
> > +     guard(mutex)(&data->lock);
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             switch (data->delay) {
> > +             case STS30_REPEAT_LOW:
> > +                     ret =3D sts30_read(data, STS30_COMMAND_READ_LOW_R=
EPEAT, &tmp);
> > +                     break;
> > +             case STS30_REPEAT_MED:
> > +                     ret =3D sts30_read(data, STS30_COMMAND_READ_MED_R=
EPEAT, &tmp);
> > +                     break;
> > +             case STS30_REPEAT_HIGH:
> > +                     ret =3D sts30_read(data, STS30_COMMAND_READ_HIGH_=
REPEAT, &tmp);
> > +                     break;
> > +             default:
> > +                     dev_warn(&data->client->dev, "Repeatability state=
 corrupted, got: %d\n",
> > +                              data->delay);
>
> Do we need this warning? Returning -EINVAL is sufficient
> enough.
>

Since this is read_raw() the warning might help the user resolve the
error rather than just getting "Invalid argument".

> > +                     return -EINVAL;
> > +             }
> > +
> > +             if (ret)
> > +                     return ret;
> > +
> > +             *val =3D tmp;
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_OFFSET:
> > +             /*
> > +              * We use this constant -16852 as calculated using the fo=
rmula
> > +              * in the datasheet. See section 4.12 in the data sheet f=
or more
> > +              * info.
> > +              */
> > +             *val =3D -16852;
>
> Okay, this would definitely be better if it were a macro. I'd even
> be tempted to add the formula in a comment for safe keeping.
>

At this point I agree, it's probably a good idea to put our constants
at the top of the file as macros and put the formula there :/

> ...
>
> > +static const struct i2c_device_id sts30_id[] =3D {
> > +     { "sts30" },
> > +     { "sts31" },
> > +     { "sts35" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, sts30_id);
>
> Move the struct i2c_device_id struct after probe(). Additionally,
> use the `.name` named initializer when defining the IDs (this reflects
> on Uwe Kleine-Konig's effort in IIO).
>

Right. When I was first writing up the driver I'd ended up using
i2c_match_id() but after removing it I'd forgotten to put it back at
the bottom. Will fix (alongside the named initializers).

> > +
> > +static int sts30_probe(struct i2c_client *client)
> > +{
> > +     struct iio_dev *indio_dev;
> > +     struct sts30_data *data;
> > +     int ret;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     indio_dev->name =3D client->name;
> > +     indio_dev->info =3D &sts30_info;
> > +     indio_dev->channels =3D sts30_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(sts30_channels);
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +     data =3D iio_priv(indio_dev);
> > +     data->client =3D client;
> > +     data->delay =3D STS30_REPEAT_HIGH;
> > +
> > +     ret =3D devm_mutex_init(&client->dev, &data->lock);
> > +     if (ret)
> > +             return ret;
> > +
> > +     i2c_set_clientdata(client, indio_dev);
> > +
> > +     ret =3D sts30_reset(data);
>
> You're not checking ret here.
>

Also saw that from sashiko, and will fix.

--=20
best regards,
max
