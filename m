Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4E41EFF8D
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781274027; cv=none; b=sXBGc+QGLPBd5/10gger81cTiFBzPtg5EmNipDaplTDh2DxS2OUL2tNGnuP/SctyzrHo4q60KSHlAl+HACyvDfsG4J0ZqQMXROL0s/vWDEiZjnUOElN2ile5qCUHjbT45PSpbJuqWFp/7EppfEv1j9G+D0FwcKfBTKW2m61mIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781274027; c=relaxed/simple;
	bh=05SzSIhmec1vYum/QuUYcoahUkFRku0YR7VdVJLeRrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKadGlNMgC/0E8BPbcirw9abLb5okcVHV1C+69rk6deGr/tPsHg1ZvnbrZAfNhpVlSMzar3Hh+5G1t4CRIZJP3wCOHkrt66NKCevpNnbQihe2wH8rxjXLLK1MfbYahSrtLV8ASvasyc9y+/l5wAhnhN1PM2Hq+D+a3Qp5KoKfss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OulnVE3S; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OulnVE3S"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4908b92904fso10624515e9.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781274024; x=1781878824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rnn28gbZCz0SaMYa5efxwyT+RWvFK1XWj+GFBYp/9bc=;
        b=OulnVE3STMwh01r0qSOldmdv6w04bAfirf5+9XwmrWO1FMAA4bhpm8KooNha/Sj4sb
         VooBe0ARBgLq9FJ7Sz5JCRitqiKt0VLTopU0BVLbt4IkH2iS6wZhhF3TyCxXw2x4DwN/
         Z2s7s0FwWR/Sv58UjcOcz6HricV05qmpnd268rc02Rkmx9kNWSy7jr/Y+1ILcx7/ZjdY
         /00uYiIXEF4FZ7Ym2CARkxCkZUN8VExUFuk9bmgmxXNa3egNXmKYVxx3DE5z14Dg/mnY
         MW/8YiHjwAQnZp1RM7xdZOqb9jcFOhZkGIkp7HytOoRqyGWaWnANbGtClEX4oc54NYmM
         sPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781274024; x=1781878824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rnn28gbZCz0SaMYa5efxwyT+RWvFK1XWj+GFBYp/9bc=;
        b=qCQY7nCSGoaflTkSOGFMkWluoTqX5pxia8d7Zga+8yVys6SJ3GZg5HNlKUbvcTqRwt
         zSWxP3VH6PYgiJHLTuFrHhy1n5V++1yTB42Za3OeuX3gExa5Uhi9+YcZD8xs6uX239W2
         Qv4K3syX4D3Kk7d3ZWmaqU2nMBJgmSiUKuNBRoILJpWkfv4N1nHnTlRRVmEdkzapPWCG
         NKOe122pKld2wdgy+nB3RyQaAC+z949eLOETVlfmwaOQoG5xLwGAHdGj7ccjy9qaptrs
         imRyyZXKyaaKZ8rHbWzWyxPHeAwVNHlfoKLAaBrj4KQ6jQl14Wc5oMZjzFq0vuvamla2
         l/yQ==
X-Gm-Message-State: AOJu0Ywqo8Y/bYqDF8JAWlprBj5LwaMeIrY/o5zcJxrRfoFMAzwmwX8I
	Vz2yDUTALFUM9GIq0VeQ4mj/O3nytWx0ftxHODc9J4O94cAenmmt/ZwXSq7hnA==
X-Gm-Gg: Acq92OFGtpS1n41aHKGRDNi72aaucMkl6CCxid8w+CP9rv5nC1SGRBg8w628//aqh+q
	DuFf+k/RWgZGSF5ulrVUvEkzMlKGgYYs02vYVgeCqZqyO8c6OXzvECXi+n7rHXq+JBSz9wCWJ77
	4Cj6ApsAvEV0znNW/7Cd6hT48sl9z4iEuTg5IbTF3QPyfma6ROUekj+JaCjhv+db9anQn/0GvGb
	Y/OnOD8zvwQN8nFRZ/c6vCKwnpIt5nWSPbXTiWQtHqEFeaBjCL3HTr9nYtv+g+2W9WO5hqV8+JV
	puv6KF8H1x4MvMIvbHvvVQs7UGTJXBs2Q7sgRIuomk5bJo/TjU9NgoY4ayDBR/rBcxNKtJqN/0P
	gmDlokp2Wg14zpNmnAdmc2NSA/saZTU5qWVafjt6rbFqTLyrNnEcLb6gDNOzD+EJSLz+l1AyTdn
	k9DEkg8SWctiI8YanR1yMyf+I1dtuSxZFeM4oW/jpQeyFbaNP2V+Zr4BkWQvTvZj23MsN+yA0lY
	9IrFayDuG/Yhk5jfH0nM/RFvnNMdJGLpVR8+xlmndEMs05FnUSGl+UNWGlZHgSwwJEuHeohEUcY
	PGGBXSxMtaGF4mz/KuPK1Eb4Anoc1X9PQktkZelTWJ4Blgr3GxccYeCVTs9/rf50PQ==
X-Received: by 2002:a05:600c:3422:b0:490:c682:e37d with SMTP id 5b1f17b1804b1-490ec5214d6mr25639545e9.32.1781274023713;
        Fri, 12 Jun 2026 07:20:23 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea7c871dsm80064205e9.5.2026.06.12.07.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 07:20:23 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:20:22 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Marcin Bis <marcin@bis-linux.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: dac: ad5337: Add driver for the AD5337 DAC
Message-ID: <20260612162022.00003e66@gmail.com>
In-Reply-To: <20260612133125.196208-1-marcin@bis-linux.com>
References: <20260612133125.196208-1-marcin@bis-linux.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 15:31:21 +0200
Marcin Bis <marcin@bis-linux.com> wrote:

> Add driver for the AD5337 dual 8-bit I2C voltage-output DAC.
> This part uses the pointer-byte protocol and is not compatible with
> the AD5337R nanoDAC+ driver (adi,ad5337r).
> 
> Signed-off-by: Marcin Bis <marcin@bis-linux.com>
> ---
>  MAINTAINERS              |   5 ++
>  drivers/iio/dac/Kconfig  |  12 ++-
>  drivers/iio/dac/Makefile |   1 +
>  drivers/iio/dac/ad5337.c | 159 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 176 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/dac/ad5337.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e035a3be797c..614589b6efa4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -438,6 +438,11 @@ W:	http://wiki.analog.com/AD5398
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	drivers/regulator/ad5398.c
>  
> +AD5337  ANALOG DEVICES INC AD5337 DAC DRIVER
> +M:	Marcin Bis <marcin@bis-linux.com>
> +S:	Maintained
> +F:	drivers/iio/dac/ad5337.c

Once you reorder your patches, this should go into the (first)
dt-binding patch.

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices AD5337 I2C DAC driver
> + *
> + * Copyright 2017 Marcin Bis <marcin@bis-linux.com>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>

You're definitely missing array_size.h, types.h, mod_devicetable.h
and err.h.

> +#include <linux/iio/iio.h>
> +
> +#define AD5337_NUM_CHANNELS	2
> +#define AD5337_RESOLUTION	8
> +/*
> + * AD5338 - 10bit, AD5339 - 12bit
> + */

This comment can just be on one line.

> +
> +#define AD5337_PTR_DAC_A	0x01
> +#define AD5337_PTR_DAC_B	0x02
> +
> +struct ad5337_state {
> +	struct i2c_client *client;
> +	struct mutex lock;

Add a comment on why you need a mutex.

> +	unsigned int vref_mv;
> +	u8 cache[AD5337_NUM_CHANNELS];
> +};
> +
> +static int ad5337_write_dac(struct ad5337_state *st, int channel, u8 value)
> +{
> +	u8 buf[3];
> +	int ret;
> +
> +	if (channel)
> +		buf[0] = AD5337_PTR_DAC_B;
> +	else
> +		buf[0] = AD5337_PTR_DAC_A;
> +
> +	/* PD1=0, PD0=0, CLR=1, LDAC=0, D[7:4] */
> +	buf[1] = 0x20 | (value >> 4);
> +	buf[2] = (value & 0x0f) << 4;

You should definitely use FIELD_GET/FIELD_PREP macros from the 
<linux/bitfield.h> header, it improves readability by a lot!

Also, use macros instead of just defining magic numbers like this.

> +
> +	ret = i2c_master_send(st->client, buf, 3);

Use sizeof(buf) instead of just hardcoding the size.

> +
> +	return (ret < 0) ? ret : (ret == 3 ? 0 : -EIO);

I'd definitely abandon using a terniary operator and just break it into
if statements, on first glance this is really hard to read.

> +}
> +
> +static int ad5337_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct ad5337_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*val = st->cache[chan->channel];
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref_mv;
> +		*val2 = AD5337_RESOLUTION;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad5337_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ad5337_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	if (val < 0 || val > ((1 << AD5337_RESOLUTION) - 1))
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);

Consider using the guard(mutex)() macro from cleanup.h, it saves lines
and prevents future developers from accidentally forgetting to release
locks (don't forget to add the header as well though)!

> +	ret = ad5337_write_dac(st, chan->channel, val);
> +	if (!ret)
> +		st->cache[chan->channel] = val;
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static const struct iio_info ad5337_info = {
> +	.read_raw = ad5337_read_raw,
> +	.write_raw = ad5337_write_raw,
> +};
> +
> +#define AD5337_CHANNEL(_chan) {						\

A very tiny nitpick, but you don't need to align your backslashes when defining
a macro.

> +	.type = IIO_VOLTAGE,						\
> +	.indexed = 1,							\
> +	.output = 1,							\
> +	.channel = (_chan),						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +}
> +
> +static const struct iio_chan_spec ad5337_channels[] = {
> +	AD5337_CHANNEL(0),
> +	AD5337_CHANNEL(1),
> +};
> +
> +static int ad5337_probe(struct i2c_client *client)
> +{
> +	struct ad5337_state *st;
> +	struct iio_dev *indio_dev;

Very much a nit, but swap these lines.

> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->client = client;
> +	mutex_init(&st->lock);

Use devm_mutex_init().

> +
> +	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vcc");
> +	if (ret < 0 && ret != -ENODEV)
> +		return ret;

Return dev_err_probe() here.

> +
> +	st->vref_mv = ret > 0 ? ret / 1000 : 3300;

More magic numbers. If you're converting units, consider using
macros from <linux/units.h>.

-- 
Kind regards

CJD
