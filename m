Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF11370D7C
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 02:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786503361; cv=pass; b=PzzNy8b4N2LSwHya3YR4kdBxxyzjPdbWkYJbLSeXeygAEvKd1qoKD7GGKLzX41VLd6ya1ify84DQaaqaLV2HUvhS1SUauGDQSz1+SF6JL+oeFhUjEh0HnlvPF7bmFBnka/SnvpxY0fwqmxOtVTdw1KDU04xEYsbwR/m9onmK7Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786503361; c=relaxed/simple;
	bh=NFIn8l5JahWah2Qi3rHlkYb8ngaL0SqBhw78KSMbvL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twxYqceIb0vKiWGkGLQ6uAxFdJ0tEHvH9fdnDjMvX3PMoFzwArN7YMz/HrxKFlJPQAy8GRLrcYZ1zq2s0qaH0MRmrdNoBYHEC3dJiP8WRhaQ5bDgXiqlIS1XvnqxndjUh8TXi4TsWgDYqL1zRNkNzNAtUOiwS3okejKjModvyDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjBiw12j; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjBiw12j"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39da69c5ba3so6361391fa.1
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 19:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786503358; cv=none;
        d=google.com; s=arc-20260327;
        b=fgrTQNa3UMUGVxjD1tX6LafiMTZdZiIWXONMe9strn//fB6RcUR1vdjV8pPmwS3Mwb
         qeovDtCuB2HCmipbp7+5ukJKEdkA8qZPyF60w5jkSHdS2qgyaVAIS355c6NKz5wSGau9
         jS6ukzeLChk7ydlPF2KrFENwZZm5azOuRkIhqHbDZ3IxnPGgSYisVQVdJ3Mi4/D07m/x
         KMs0ry5F+iC4wAT9fKijuLw1TbxCNDSsdg8eBBlwXe7TGzhN7RIHcHwGMf0IhVSs8N16
         k5adnCYF9rKqry0L7fmzaO7jd87gMRly0qN6G0xU10prdiX7r9yEfZAGIxSDORDe00u9
         dGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+l8MlhCC2LweJ++LLqUpP5yq02ZNdRbuAhkjLfVGC+A=;
        fh=G+PZZjWu7pMQSEG+DxEfKE+C5+m8pTMxYvZHFyef1mg=;
        b=ljubiH2oy4rEuxPX13n0aDidPftyBXHc0km9mej6qA7L5DEzzgArjoYNouaSLNlIy/
         NC+M92/0NOR2YD4EdSsuG/11tz7YHvkZq9nl1at3nr8A8hPcJdmUMz17JdYyNTv/KDyh
         qbtK22Nh5IrSbQ5viAfPc155XVmdAj6aQq74tWP6LADOl9gCo18hHwsPPTocaicgLywb
         B6hx8zmwHG5EiHO0gfNr0d0rUIulbhCcg/7ztUQyeyt2X9LCQQiEtyps9D50xBzZZ7A8
         dtZPG3+AlC+bDahY8oBuivwNogHA7AARYmSXhp1oIf4z08mMA4kwfMDDJUc8CI/7PaIO
         LoQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786503358; x=1787108158; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+l8MlhCC2LweJ++LLqUpP5yq02ZNdRbuAhkjLfVGC+A=;
        b=jjBiw12jyqQsHEK4KxD02N0TwLPvMNmoZ2tuHnDEYXY29dCnf1bsPnOOxQqOJ3Ek6U
         YvdGWMYMwxLtqy9bJ7VenJZtZzYMREM6LPiuiEu37ksPGMsS91Zqq4FyVSjPnJZUcYI7
         U3C1NyQvoydmvfiVkrtF9lx1sxz/9bXhgqnGcQHoXD3lFDRa7I7Yd6h+CA60iPU2DeyO
         PJnlBdeDdXwYmo1OKGpUwlhKdsBMTkwC2eSPGMLpOcBeh1Rh00zT3pExHXumQbUgYhAp
         1XUeIMD9ifKx59YxhYdqdo+IqD6wLc3ylYnw6PJ22tykDjZmzO4R1HzBT7EJLUsC3A9q
         knRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786503358; x=1787108158;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+l8MlhCC2LweJ++LLqUpP5yq02ZNdRbuAhkjLfVGC+A=;
        b=ZUjYvg9ITtKS+hZolMwJlkwIes8sh1tQ7vN/vhvc/4wHzfY1t2V/3Y3qgAPuk1mYhX
         9GQoIQE1/dYB76V3/s2KIP9mmH1Cd78HS+9jaw8bkItK0/KdXQEjC4chWNAX9C8Zymgp
         rfGjnrxVtzxYHf4P/yI8fZxQrpzV/eWWk/Epzs6/Drm6NdXo/NSm+N01Pw1JdT+DYhdK
         48DfzfiQK/vXqAvhuij/0iYi066TH8OyvPobVzl6CJ9zPYOwBzw2nsvI29jcQLwByQH0
         DPjNHxOR98DVZr53r5fLJv83sZImV16bh6IXIa3vO9/gcQHKMVV7Z3i+1tuxDM54qDO8
         C0jQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrkqam8VdwuO6LiEZKwQ0R9dkHdbF2Bw8a20E/hWoEyuwIV1IjKjS25UzLN2PDU4xu9XlAZibqBuRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyotUNQoPHQSRcopc3FiVDlVUal2dsNtv+uFyE0++Gj3ylqaUBq
	mI0ycYPbtNyfapluZW+ZKZvgu78GdgVdUd3YudiFHfUtpAgVQJA116dhBvRasbP5EBZ6RUDocV1
	Sce5n8wr+N+Id0sdhxHwWppl/HyeYpkI=
X-Gm-Gg: AR+sD138sHsbvIT40/Ryv4QbsEoQrzy7xnd2Zm2lPVblUML797jULd0SZnDoG4wjrG/
	h0QthfYd7KT1XRewyRBhOqKRjvwYIDD+9QOqcYHuRGoFwiJP3Kp0MZenIPrrlLRtbqnk+9+r0uM
	z/4OMF6VnU5oP1kOfLD6AU0EigzV92NdQgyGsBqWrueync1KrY6ZNsaK5XCLb5Se6sB1DikAFkK
	sJFtWMkKivzbJXuradO/ao7lzoQTbnqixzANzGCvQ3pOZo8pLZmrmSBg0V/LLcuacmJrhdstDGl
	lwPUifmuKyLnoz8xSZ5sFODFUC5iK+R5rGNX8kCczFzmGKW3k169/LoN
X-Received: by 2002:a05:651c:555:b0:39b:8c6:a6c9 with SMTP id
 38308e7fff4ca-3a10d5f4954mr954201fa.25.1786503357666; Tue, 11 Aug 2026
 19:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-ti-ads112c04-driver-v4-0-ae704ac17241@gmail.com>
 <20260811-ti-ads112c04-driver-v4-2-ae704ac17241@gmail.com> <anrt5mJBz5h-a3OL@ashevche-desk.local>
In-Reply-To: <anrt5mJBz5h-a3OL@ashevche-desk.local>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 12 Aug 2026 10:58:48 +0800
X-Gm-Features: AUfX_mwOGwbRhjlHXgX6nvXNItYNCav6elhnDDRHlO9Hcf77HVaXjq3Bz_3YXng
Message-ID: <CAF7HswP7+79Y5M92PVoHJ_H_J6rU=Q0p5qWDm1gcA2mPfg0VDw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads112c04: Add support for TI ADS112C04
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thanks for the detailed review.

On Tue, Aug 11, 2026 at 5:39=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Aug 11, 2026 at 10:48:38AM +0800, Kyle Hsieh wrote:
> > Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
> > delta-sigma ADCs.
> >
> > The driver implements:
> > - Single-shot conversions using the IIO raw read interface.
> > - Dynamic parsing of single-ended and differential channels from
> >   device tree child nodes.
> > - Hardware interrupt support via the DRDY pin, falling back to
> >   software polling if no IRQ is provided.
> > - Scale calculation based on the internal 2.048V reference.
> > - Reference voltage scaling via the regulator subsystem (refp-supply),
> >   falling back to the internal 2.048V reference if not specified.
> >   refn-supply is not yet supported.
> > - Hardware reset fallback using GPIO.
>
> ...
>
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/property.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +#include <linux/units.h>
>
> ...
>
> > +static int ads112c04_wait_for_data(struct ads112c04_state *st)
> > +{
> > +     int ret, err;
> > +     u8 val;
> > +
> > +     if (st->client->irq > 0) {
> > +             /* Timeout is 100ms (slowest data rate is 20 SPS) */
> > +             ret =3D wait_for_completion_timeout(&st->completion,
> > +                                               msecs_to_jiffies(100));
> > +             if (!ret)
>
> In this case semantics of ret differs, that's why it's better to write as
>
>                 if (!wait_for_completion_timeout(&st->completion, msecs_t=
o_jiffies(100)))
>
> // and I would even dare to put on a single line.
>
> > +                     return -ETIMEDOUT;
> > +
> > +             return 0;
> > +     }
> > +
> > +     err =3D read_poll_timeout(ads112c04_read_reg, ret,
> > +                             (ret < 0 || (val & ADS112C04_CONFIG2_DRDY=
)),
> > +                             1000, 100 * USEC_PER_MSEC, false,
> > +                             st->client, ADS112C04_REG_CONFIG2, &val);
> > +
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return err;
>
> In this piece I would swap err and ret, so the ret is outer one and err i=
s
> the inner one. This will be consistent with other code pieces.
>
> > +}
>
> ...
>
> > +static int ads112c04_get_adc_result(struct ads112c04_state *st,
> > +                                 struct iio_chan_spec const *chan,
> > +                                 int *val)
> > +{
> > +     u8 new_config0;
> > +     int ret;
> > +
> > +     new_config0 =3D st->config0;
> > +     FIELD_MODIFY(ADS112C04_CONFIG0_MUX, &new_config0, chan->address);
> > +
> > +     if (st->config0 !=3D new_config0) {
> > +             ret =3D ads112c04_write_reg(st->client, ADS112C04_REG_CON=
FIG0, new_config0);
> > +             if (ret < 0)
> > +                     return ret;
> > +             st->config0 =3D new_config0;
> > +     }
> > +
> > +     reinit_completion(&st->completion);
> > +
> > +     ret =3D ads112c04_write_cmd(st->client, ADS112C04_CMD_START_SYNC)=
;
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D ads112c04_wait_for_data(st);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D ads112c04_read_data(st, val);
>
> > +     if (st->client->irq > 0)
> > +             enable_irq(st->client->irq);
>
> Why is it fine to leave IRQ enabled even in the error case?
>
> > +     return ret;
> > +}
>
> ...
>
> > +static int ads112c04_read_raw(struct iio_dev *indio_dev,
> > +                           struct iio_chan_spec const *chan,
> > +                           int *val, int *val2, long mask)
> > +{
> > +     struct ads112c04_state *st =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             mutex_lock(&st->lock);
> > +             ret =3D ads112c04_get_adc_result(st, chan, val);
> > +             mutex_unlock(&st->lock);
> > +
> > +             if (ret < 0)
> > +                     return ret;
>
> If IRQ is left enabled and we call it here, we end up with the unbalanced
> depth counting.
>
> > +             return IIO_VAL_INT;
> > +
> > +     case IIO_CHAN_INFO_SCALE:
> > +             *val =3D st->vref_mV;
> > +             *val2 =3D 15;
> > +             return IIO_VAL_FRACTIONAL_LOG2;
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
>
> ...
>
> > +static irqreturn_t ads112c04_irq_handler(int irq, void *private)
> > +{
> > +     struct iio_dev *indio_dev =3D private;
> > +     struct ads112c04_state *st =3D iio_priv(indio_dev);
>
> > +     disable_irq_nosync(irq);
>
> This is unconditionally called. Where is the guarantee that it becomes en=
abled
> once again?
>
> > +     complete(&st->completion);
>
> > +     return IRQ_HANDLED;
> > +}
>
> ...
>
> > +static int ads112c04_parse_channels(struct iio_dev *indio_dev)
> > +{
> > +     struct device *dev =3D indio_dev->dev.parent;
> > +     struct ads112c04_state *st =3D iio_priv(indio_dev);
> > +     struct iio_chan_spec *channels;
> > +     u32 num_channels, pair[2];
>
> > +     int ret, i =3D 0;
>
> Why is 'i' signed? And it's better to decouple definition and assignment,=
 so
> the assignment will happen closer to when it's really needed.
>
> ...
>
> > +             if (fwnode_property_present(child, "reference-sources")) =
{
> > +                     const char *ref;
> > +
> > +                     ret =3D fwnode_property_read_string(child, "refer=
ence-sources", &ref);
> > +                     if (ret)
> > +                             return dev_err_probe(dev, ret,
> > +                                                  "failed to read refe=
rence-sources\n");
> > +
> > +                     if ((!strcmp(ref, "external") && !st->has_refp) |=
|
> > +                         (!strcmp(ref, "internal") && st->has_refp))
> > +                             return dev_err_probe(dev, -EINVAL,
> > +                                                  "reference-sources d=
oes not match refp-supply\n");
> > +             }
>
> Reinvention of fwnode_property_match_property_string() ?
>
> ...
>
> > +             if (fwnode_property_present(child, "single-channel")) {
> > +                     ret =3D fwnode_property_read_u32(child, "single-c=
hannel", &pair[0]);
>
> I don't like the (partial) pair reuse here. It's semantically wrong. Just=
 add
> another temporary variable and let compiler to choose what to do with a s=
tack
> frame in such a case.
>
> > +                     if (ret)
> > +                             return dev_err_probe(dev, ret,
> > +                                                  "failed to read sing=
le-channel property\n");
> > +
> > +                     if (pair[0] > 3)
> > +                             return dev_err_probe(dev, -EINVAL,
> > +                                                  "single-channel must=
 be 0-3\n");
> > +
> > +                     spec->channel =3D pair[0];
> > +                     spec->address =3D 0x08 + pair[0];
> > +             } else if (fwnode_property_present(child, "diff-channels"=
)) {
> > +                     ret =3D fwnode_property_read_u32_array(child, "di=
ff-channels", pair, 2);
>
> ARRAY_SIZE()
>
> > +                     if (ret)
> > +                             return dev_err_probe(dev, ret,
> > +                                                  "failed to read diff=
-channels property\n");
> > +
> > +                     if (pair[0] > 3 || pair[1] > 3)
> > +                             return dev_err_probe(dev, -EINVAL,
> > +                                                  "diff-channels must =
be 0-3\n");
> > +
> > +                     spec->channel =3D pair[0];
> > +                     spec->channel2 =3D pair[1];
> > +                     spec->differential =3D 1;
>
> > +                     if (pair[0] =3D=3D 0 && pair[1] =3D=3D 1)
> > +                             spec->address =3D 0x00;
> > +                     else if (pair[0] =3D=3D 0 && pair[1] =3D=3D 2)
> > +                             spec->address =3D 0x01;
> > +                     else if (pair[0] =3D=3D 0 && pair[1] =3D=3D 3)
> > +                             spec->address =3D 0x02;
> > +                     else if (pair[0] =3D=3D 1 && pair[1] =3D=3D 0)
> > +                             spec->address =3D 0x03;
> > +                     else if (pair[0] =3D=3D 1 && pair[1] =3D=3D 2)
> > +                             spec->address =3D 0x04;
> > +                     else if (pair[0] =3D=3D 1 && pair[1] =3D=3D 3)
> > +                             spec->address =3D 0x05;
> > +                     else if (pair[0] =3D=3D 2 && pair[1] =3D=3D 3)
> > +                             spec->address =3D 0x06;
> > +                     else if (pair[0] =3D=3D 3 && pair[1] =3D=3D 2)
> > +                             spec->address =3D 0x07;
>
> I would do this as a 4x4 table
>
>         -1, 0, 1, 2,
>         3, -1, 4, 5,
>         -1, -1, -1, 6,
>         -1, -1, 7, -1,
>
> With that done you can even supported the swapped cases
>
>         -1, 0, 1, 2,
>         3, -1, 4, 5,
>         1, 4, -1, 6,
>         2, 5, 7, -1,
>
> (but I haven't studied the code if it's toughly relies on the pair[0]/pai=
r[1]
>  values to be in a strong order after the address being assigned).
I will apply your first 4x4 table for diff-channels - it maps directly to
the MUX encoding and is much more readable than the if-else chain.

I did not apply the second (swapped) table. Entries like [2][0] would
map to MUX value 1, which is AINP=3DAIN0/AINN=3DAIN2, i.e. the opposite
polarity, so it would silently return negated values. Supporting swapped
pairs properly would need a per-channel inversion flag and negation
after conversion, which I'd rather leave out of this initial minimal
implementation.
>
> > +                     else
> > +                             return dev_err_probe(dev, -EINVAL,
> > +                                                  "invalid diff-channe=
ls combination\n");
>
> > +             } else {
> > +                     return dev_err_probe(dev, -EINVAL,
> > +                                          "channel node must have sing=
le-channel or diff-channels\n");
> > +             }
> > +
> > +             i++;
> > +     }
> > +
> > +     indio_dev->channels =3D channels;
> > +     indio_dev->num_channels =3D i;
> > +
> > +     return 0;
> > +}
>
> ...
>
> > +#define ADS112C04_VREF_INTERNAL_MV   2048
>
> _mV
>
> ...
>
> > +     if (device_property_present(dev, "refp-supply")) {
>
> A dup property check. if (st->has_refp) should suffice, no?
>
> > +             ret =3D devm_regulator_get_enable_read_voltage(dev, "refp=
");
> > +             if (ret < 0)
> > +                     return dev_err_probe(dev, ret,
> > +                                          "failed to get refp voltage\=
n");
> > +
> > +             st->vref_mV =3D ret / (MICRO / MILLI);
> > +             st->config1 =3D 0x02;
> > +     } else {
> > +             st->vref_mV =3D ADS112C04_VREF_INTERNAL_MV;
> > +             st->config1 =3D 0x00;
> > +     }
>
> ...
>
> > +     /* Requesting OUT_HIGH asserts the active-low reset pin immediate=
ly */
> > +     reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HI=
GH);
> > +     if (IS_ERR(reset_gpio))
> > +             return PTR_ERR(reset_gpio);
>
> Why reset-gpio driver can't be used instead?
David suggested the reset controller framework on v1, but after I moved
to gpiod in v2 he suggested GPIOD_OUT_HIGH to simplify it, so I kept
gpiod. Switching now would mean changing the binding, which already has
a Reviewed-by - happy to do it if you both prefer.

Best regards,
Kyle Hsieh
>
> > +     if (reset_gpio) {
> > +             fsleep(1000);
>
> 1 * USEC_PER_MSEC
>
> > +             gpiod_set_value_cansleep(reset_gpio, 0);
> > +     } else {
> > +             ret =3D ads112c04_write_cmd(client, ADS112C04_CMD_RESET);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +
> > +     fsleep(1000);
>
> Ditto.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
