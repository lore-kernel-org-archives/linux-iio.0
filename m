Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A358C421A08
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516077; cv=none; b=HtOeP92yYnXNjYVroi/yZg7//8oNN5cpaTjk126Lf1yyT/9DYxkxHZIhHhhZMVDj5e3t0rvH9jqYNg6cKX2l3KbnZn1nBVbDbJZTM8UmqdUCRDJrDZt8k2bjs5BhB+eEieGNYnO8HVD0oO5+cjg2ocLAWdaHRgTj7Wi98+386Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516077; c=relaxed/simple;
	bh=80pay/2ipIAvDAUucyPpRn2iab0KL7au6husHHAN2dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RC+huxmCaPjuHyjfF+uzxGxRwcAx4lotV+1wWtpoC6QTpj6vTaxXMchViou1fsrihA9seF/c+YAJ4ySEGKIOzJmQvKCaUPCBtorjEmusz8MOiRBeVHw89PUKfboAvgX5/cReyxXiOCa9j5sMa2qP4FaEWv9yAMDgO9GkltYhlmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LM6QnrpK; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LM6QnrpK"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bd0209f25c1so161962366b.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516074; x=1779120874; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F+7ufCvHaincl/08d06IYH8ZtdB93yuOU1JiWdWwv/I=;
        b=LM6QnrpKaz3gHFkTEYh9NLNVWpkkbvK9i9lKATX5TU3TZeZsrK5cQD4grMBlLvprfO
         3wuRJCqjK5JIG1s4rG6l1URfbbNNo5bejR4WSh3oKXFOg6P5ySmcizsqCqLSdFBwgeMR
         gknXQ53IszY4leDlNdbls8EqLbPZ8KT3SWFDmptuodQUeBi00gHHoCkaRGtr+wIxC3D4
         N2OJEIOL6YXKcvh09f86PCIeMiKvgVwbcf9JZgVEFbSgNwjLVSOtRoRKAKjNFcknTWLJ
         JCj0o/8arUpHjw1KVAxui8aG0i1tNoI9k/84wmq+T/OqpDhU05fKyoa+LRYC3Yx6Gw/P
         8mHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516074; x=1779120874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+7ufCvHaincl/08d06IYH8ZtdB93yuOU1JiWdWwv/I=;
        b=RbVt9ChpRG4uDpKYMBX/UYB1ptflhmqmL8JJHk/DLqiUgF1sQ4lZVCe3Mo/CQ1l3AN
         19NSwA/BkG61q4IKK9vX1jF2z42PnUxBv9FybgUcQ7d7apSgobxF8BtB9ZCdXkglkMGd
         pp2Hojt7KIkj55kDbYiRCNTkvnUL/G0iunPgAGOSaDV0+HCedsGjaQ+BJS+p+nhVVXuK
         OWmoeyR9whChTD//RstzbXuZwgtbnietLn+MGuUzhCqCvnGfJ4dA25ErBJyvflWbCDWM
         h5Xi4g1pdV3nEGoN5gdw1F4DETJOP8KIH1vdYlSw6pJSC+NZ8p7VAdWpFlBJ+uMQccf+
         Y24Q==
X-Gm-Message-State: AOJu0YyASLUaxhvR0XlTpcdx2dOiQWg4aQ6Gc1syzJnVz3W8spMKdfqN
	ceS4cuwJqK82Rgk6aIqiUoM4jwvVc5jx7sz31FTpB3F3q5dGXj0kMHEw
X-Gm-Gg: Acq92OE+TM1dJtsY/8JIKl89FZY4SYL583rYf7Rx0LGaJhPuq1Q5cXPiO7OkAg26FdU
	biQPO5GeTIsK3cDexIe6n34s7AvVZW7DwHjtbrirZGUL9hmD1ZO6vI0WQTMnopwc27BkHL40SOP
	jnHmNYTyj9iY9pKoTf8y4SNmXAZY2PdNSVgKDHJOQIL2glGqoSKS7+/XOWiZwpWY9NfkX38LkkM
	R9hqFLW/P5OW8Lk97nWfmuvavfFxyIXu8g17yw+DIw/QAK/+cqRgRP2xJeKxYozUKFUmEGJggI5
	I3KpTB/mkyv3K9Km9SVInAvynlrZUwI0ol3PVgxCKya3mocK3cY+1EDN3RiaxWAbnfg56NyUD9N
	HiawUqL3d8hs4fC8ajYAGO6FMAzB3G4JZDox9XVojyC/aor50QR4T1sztRO7JRwCQXQDCfMRJ6Q
	oxo/6lstLN4wPp2DaEKq7DrqlFj/c=
X-Received: by 2002:a17:907:3cd6:b0:bb8:fd89:4a74 with SMTP id a640c23a62f3a-bc56b12645cmr1423080766b.14.1778516073521;
        Mon, 11 May 2026 09:14:33 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcba5feb124sm439815566b.24.2026.05.11.09.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:14:33 -0700 (PDT)
Date: Mon, 11 May 2026 18:14:31 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC 2/4] iio: light: add support for APDS9999 sensor
Message-ID: <agH21np2adVhhXRY@gmail.com>
References: <cover.1778491503.git.azpijr@gmail.com>
 <b272d93898a67baf7b4b8d02ba0061321906db6e.1778491503.git.azpijr@gmail.com>
 <20260511140644.42eb8edb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511140644.42eb8edb@jic23-huawei>

On Mon, May 11, 2026 at 02:06:44PM +0100, Jonathan Cameron wrote:
> On Mon, 11 May 2026 12:14:47 +0200
> "Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:
>
> > Add IIO driver for Broadcom APDS9999 ambient light sensor.
> >
> > The APDS9999 is a digital proximity and RGB sensor with ALS
> > capability. This driver implements the ALS/Lux functionality using the
> > green channel.
> >
> > Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
>
> Hi Jose,
>
> For an RFC I'd normally expect to see a question list or other statement
> of why it's an RFC rather than a formal submission.  One thing to note
> is many reviewers won't even look at an RFC that doesn't have such
> a list of questions.
>
> Various comments inline but so far looks like a fairly standard light
> sensor driver so all minor stuff.

okay. I should've done a better research before submiting the RFC, I'll
add questions to the v2 cover letter.

> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/light/apds9999.c | 325 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 325 insertions(+)
> >  create mode 100644 drivers/iio/light/apds9999.c
> >
> > diff --git a/drivers/iio/light/apds9999.c b/drivers/iio/light/apds9999.c
> > new file mode 100644
> > index 000000000000..cf44c3003415
> > --- /dev/null
> > +++ b/drivers/iio/light/apds9999.c
> > @@ -0,0 +1,325 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * IIO driver for Broadcom APDS9999 Lux Light Sensor
> > + *
> > + * Uses the green channel (ALS) which approximates human eye spectral
> > + * response for ambient light sensing (lux). RGB and proximity (PS)
> > + * functionality not yet implemented.
>
> I'd not mention what is todo twice. That just makes churn in patches
> adding them!

I'll remove the duplicate.

> > + *
> > + * Copyright (C) 2026
> > + * Author: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> > + *
> > + * TODO: proximity and color sensor
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/math64.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +
> > +/* Registers */
> Ideally a set of defines should be self describing enough to
> not need 'section' comments.  These comments have a nasty habbit
> of becoming wrong over time!
>
> > +#define APDS9999_REG_MAIN_CTRL		0x00
> > +#define APDS9999_REG_LS_MEAS_RATE	0x04
> > +#define APDS9999_REG_LS_GAIN		0x05
> > +#define APDS9999_REG_PART_ID		0x06
> > +#define APDS9999_REG_MAIN_STATUS	0x07
> > +#define APDS9999_REG_LS_DATA_GREEN_0	0x0D
> > +
> > +#define APDS9999_PART_ID		0xC2
> > +
> > +/* MAIN_CTRL */
> > +#define APDS9999_MAIN_CTRL_LS_EN	BIT(1)
>
> I would keep these with the registers addresses above.
> A nice trick to make them look visually different is to use some
> additional indenting.  e.g.
>
> #define APDS9999_REG_MAIN_CTRL		0x00
> #define   APDS9999_MAIN_CTRL_LS_EN	BIT(1)
>
> #define APDS9999_REG_LS_MEAS_RATE	0x04
> #define APDS9999_REG_LS_GAIN		0x05
> #define APDS9999_REG_PART_ID		0x06
> #define APDS9999_REG_MAIN_STATUS	0x07
> #define   APDS9999_MAIN_STATUS_LS_DATA	BIT(3)
> #define APDS9999_REG_LS_DATA_GREEN_0	0x0D

okay, I'll remove section comments and use indent to look visually
different. thanks for the trick!

> > +
> > +/* MAIN_STATUS */
> > +#define APDS9999_MAIN_STATUS_LS_DATA	BIT(3)
> > +
> > +/* LS_MEAS_RATE */
> > +#define APDS9999_LS_RES_SHIFT		4
> Define a mask instead then use FIELD_PREP() / FIELD_GET()
> That combines ensuring no overflow with a single representation of
> the register field.

I'll address it in v2.

> > +
> > +/*
> > + * ALS gain options (register value -> factor)
> > + */
> Where it fits use single line comments
> /* ALS gain options (register value -> factor) */

okay, i used a shortcut and didn't notice that. I'll change it to a
single comment.

> Given they are specific register values, it may make sense
> to use defines or an enum then explicit initialization

> > +static const int apds9999_gains[] = {
> > +	1, 3, 6, 9, 18,
> 	[ADPDS9999_GAIN_X1] = 1,
> 	[ADPDS9999_GAIN_X3] = 3,
>
> Then if you are initializing defaults etc you can use the register
> value define directly.  Similar to you've done for RES.

noted.

> > +};
> > +
> > +/*
> > + * ALS resolution / integration time
> > + * Resolution bits [6:4] set both the ADC bit-width and the
> > + * integration time used in the lux conversion formula
> > + * Value: integration time in microseconds
> > + */
> > +enum apds9999_resolution {
> > +	APDS9999_RES_20BIT,	/* 400 ms */
> > +	APDS9999_RES_19BIT,	/* 200 ms */
> > +	APDS9999_RES_18BIT,	/* 100 ms (default) */
> > +	APDS9999_RES_17BIT,	/*  50 ms */
> > +	APDS9999_RES_16BIT,	/*  25 ms */
> > +	APDS9999_RES_13BIT,	/*  3.125 ms */
> > +	APDS9999_RES_NUM,
> No trailing comma as that has to be last one.
> For the others I'd use explicit assignment e.g.
> 	APDS9999_RES_20BIT = 0,
> etc so it is clear they are actual register field values not
> just an enum where any unique values are enough.

I'll add explicit register values to the resolution enum.

> > +};
> > +
> > +static const int apds9999_itimes_us[APDS9999_RES_NUM] = {
> > +	[APDS9999_RES_20BIT] =   400000,
> > +	[APDS9999_RES_19BIT] =   200000,
> > +	[APDS9999_RES_18BIT] =   100000,
> > +	[APDS9999_RES_17BIT] =    50000,
> > +	[APDS9999_RES_16BIT] =    25000,
> > +	[APDS9999_RES_13BIT] =     3125,
> > +};
> > +
> > +#define APDS9999_DEFAULT_RES		APDS9999_RES_18BIT
> > +#define APDS9999_DEFAULT_GAIN_IDX	1	/* 3x */
> > +#define APDS9999_DEFAULT_RATE		2	/* 100 ms */
>
> Give defines for the actual register values.  Then use them in init()
> rather than 'DEFAULT magic values.

okay. I'll address it in v2.

> > +
> > +struct apds9999_data {
> > +	struct i2c_client *client;
> > +	struct mutex lock;
> Locks must have a comment saying what data they are protecting.

noted.

> > +	int als_gain_idx;	/* index into apds9999_gains[] */
> > +	int als_res;		/* index into apds9999_itimes_us[] */
> > +	int als_rate;		/* LS_MEAS_RATE[2:0] register value */
> > +};
> > +
> > +/*
> > + * Hardware init, write default register values and enable ALS
> > + */
> > +static int apds9999_init(struct apds9999_data *data)
> > +{
> > +	struct i2c_client *client = data->client;
> > +	u8 reg;
> > +	int ret;
> > +
> > +	mutex_lock(&data->lock);
> As below - guard() helps in simple cases like this.

okay, noted.

> > +
> > +	reg = (APDS9999_DEFAULT_RES << APDS9999_LS_RES_SHIFT) |
> > +	      APDS9999_DEFAULT_RATE;
>
> FIELD_PREP() for both of them so we won't need to figure out if they
> are shifted or not.

okay, I'll address it for both fields.

> > +	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_LS_MEAS_RATE, reg);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_LS_GAIN,
> > +					APDS9999_DEFAULT_GAIN_IDX);
>
> As mentioned above, actual define for that index rather than a default one.
> The only place I expect to see what chosen defaults actually are is what
> is passed to calls in this function.
>
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL,
> > +					APDS9999_MAIN_CTRL_LS_EN);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	data->als_gain_idx = APDS9999_DEFAULT_GAIN_IDX;
> > +	data->als_res = APDS9999_DEFAULT_RES;
> > +	data->als_rate = APDS9999_DEFAULT_RATE;
> Given you don't unwind any of these written before an error (which is fine)
> it makes more logical sense to assign these caches are each write is known
> to succeed - that is spread them out in the function above.

I'll move the cached value assignments right after each successful
write, not al the end of the function.

> > +
> > +out:
> > +	mutex_unlock(&data->lock);
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Read the 3-byte green-channel ADC value from 0x0D..0x0F
> > + * Waits for LS_DATA_STATUS to be asserted (up to ~2x integration time)
> > + */
> > +static int apds9999_als_read(struct apds9999_data *data, u32 *counts)
> > +{
> > +	struct i2c_client *client = data->client;
> > +	u8 buf[3];
> > +	int ret, tries;
> > +
> > +	mutex_lock(&data->lock);
> Use guard(mutex)(&data->lock); and direct returns in error paths given no need
> to get to the unlock once it is happening on leaving the scope of the function.
>
> Make sure to also included cleanup.h for that.

noted.

> > +
> > +	/*
> > +	 * Poll MAIN_STATUS for new data.  Timeout: ~2 integration periods
> > +	 * plus margin.  Each try sleeps 20 ms
>
> Do we have no way of having a better idea of how long we might need
> to sleep?

poll will sleep for half the integration time per try... the minimum
floor will still be applied via max()

> > +	 */
> > +	tries = (apds9999_itimes_us[data->als_res] * 2) / 20000;
> > +	if (tries < 2)
> > +		tries = 2;
> 	tries = max(2, tries);
> Maybe combine with line above.

noted.

> > +
> > +	while (tries--) {
> > +		ret = i2c_smbus_read_byte_data(client,
> > +						APDS9999_REG_MAIN_STATUS);
> > +		if (ret < 0)
> > +			goto out;
> > +		if (ret & APDS9999_MAIN_STATUS_LS_DATA)
> > +			break;
> > +		msleep(20);
>
> fsleep() probably appropriate.

right. I'll change it.

> > +	}
> > +
> > +	if (tries < 0) {
> > +		ret = -ETIMEDOUT;
> > +		goto out;
> > +	}
> > +
> > +	/* Block-read all 3 bytes of LS_DATA_GREEN */
> > +	ret = i2c_smbus_read_i2c_block_data(client,
> > +					     APDS9999_REG_LS_DATA_GREEN_0,
> > +					     3, buf);
> sizeof(buf)
> > +	if (ret < 0)
> > +		goto out;
> > +	if (ret != 3) {
> sizeof(buf)
> > +		ret = -EIO;
> > +		goto out;
> > +	}
> > +
> > +	*counts = buf[0] | ((u32)buf[1] << 8) | ((u32)(buf[2] & 0x0F) << 16);
> Smells like get_unaligned_le24() & GENMASK(20, 0)
> or something like that.

will switch to get_unaligned_le24(buf) & GENMASK(19, 0) in v2.

> > +	ret = 0;
> > +
> > +out:
> > +	mutex_unlock(&data->lock);
> > +	return ret;
> > +}
> > +
> > +static int apds9999_read_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int *val, int *val2, long mask)
> > +{
> > +	struct apds9999_data *data = iio_priv(indio_dev);
> > +	int gain, itime_us;
> > +	u64 scale_nano;
> > +	u32 counts;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = apds9999_als_read(data, &counts);
> > +		if (ret < 0)
> > +			return ret;
> > +		*val = (int)counts;
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		/*
> > +		 * Scale (lux per count) = 54 / (gain * integration_time_ms)
> > +		 *
> > +		 * The constant 54 is derived from the datasheet table:
> > +		 *   at gain = 3x, itime = 100 ms → 0.180 lux/count
> > +		 *   → C = 0.180 * 3 * 100 = 54
> > +		 *
> > +		 * Expressed as IIO_VAL_INT_PLUS_NANO.
> > +		 * Uses itime_us directly to avoid truncation for
> > +		 * sub-millisecond integration times (e.g. 3.125 ms).
> > +		 */
> > +		gain = apds9999_gains[data->als_gain_idx];
> > +		itime_us = apds9999_itimes_us[data->als_res];
> > +
> > +		/* scale_nano = 54e12 / (gain * itime_us) nano-lux/count */
> > +		scale_nano = div_u64(54000000000000ULL,
> > +				     (u32)(gain * itime_us));
> > +		*val = (int)(scale_nano / 1000000000);
>
> NANO rather than making a reviewer count 0s ;)

sorry for that. I'll use NSEC_PER_SEC.


> > +		*val2 = (int)(scale_nano % 1000000000);
> > +		return IIO_VAL_INT_PLUS_NANO;
> > +
> > +	case IIO_CHAN_INFO_INT_TIME:
> > +		*val = 0;
> > +		*val2 = apds9999_itimes_us[data->als_res];
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct iio_chan_spec apds9999_channels[] = {
> > +	{
> > +		.type = IIO_LIGHT,
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
>
> Given this is mainly an RGB sensor I'd want to see the IIO_INTENSITY
> channels there as well for an initial submission.  Understood
> that you've sent this RFC for early feedback.

okay, I'll add it.

> > +	},
> > +};
> > +
> > +static const struct iio_info apds9999_info = {
> > +	.read_raw = apds9999_read_raw,
> > +};
> > +
> > +static int apds9999_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct apds9999_data *data;
> > +	struct iio_dev *indio_dev;
> > +	int ret, part_id;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	data->client = client;
> > +	mutex_init(&data->lock);
> 	ret = devm_mutex_init(&data->lock);
> 	if (ret)
> 		return ret;
>
> The advantage this brings for lock debugging is pretty minor but it's
> also cheap so for new code always use it.

noted.

> > +
> > +	part_id = i2c_smbus_read_byte_data(client, APDS9999_REG_PART_ID);
> > +	if (part_id < 0) {
> > +		dev_err(dev, "failed to read PART_ID: %d\n", part_id);
> > +		return part_id;
> > +	}
> > +	if (part_id != APDS9999_PART_ID) {
> > +		dev_err(dev, "unexpected PART_ID 0x%02x (expected 0x%02x)\n",
> > +			part_id, APDS9999_PART_ID);
>
> We don't fail on missmatched IDs - it's fine to bring an info message but
> not more than that.  The reason is fallback compatibles in device tree.
> If a future device is fully compatible with this (it may have more features
> and typically has a different part ID) we want the driver from
> an old kernel to support it.  That only works if we don't error out on
> failure to match IDs.

okay, I'll change to dev_info() and continue with probe on mismatch.

> > +		return -ENODEV;
> > +	}
> > +
> > +	dev_dbg(dev, "APDS-9999 detected, PART_ID=0x%02x\n", part_id);
> > +
> > +	ret = apds9999_init(data);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to initialize device: %d\n", ret);
> > +		return ret;
> As below - return dev_err_probe()

all error paths in probe will use dev_err_probe() then.

> > +	}
> > +
> > +	indio_dev->name = "apds9999";
> > +	indio_dev->info = &apds9999_info;
> > +	indio_dev->channels = apds9999_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(apds9999_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	ret = devm_iio_device_register(dev, indio_dev);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to register IIO device: %d\n", ret);
> > +		return ret;
>
> For all error messages in probe() or functions called from probe() use
> 		return dev_err_probe(dev, ret, "failed to register IIO device\n");
> which handles deferred probing, drop unnecessary prints such as those on memory
> failure, pretty prints the return value and usefully is more compact.

noted.

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Disable the light sensor on driver removal
> > + */
> > +static void apds9999_remove(struct i2c_client *client)
> > +{
> > +	/* Set MAIN_CTRL to 0 → LS_EN cleared, sensor enters standby */
> > +	i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL, 0);
> This looks to me like you will be doing tear down in a different order to
> setup. For example the userspace interfaces will not be removeed until
> after you've put the sensor in stand by.
>
> There are two solutions to this (1st preferred)
> 1. Use devm_add_action_or_reset() to register the standby write here
>    in a driver specific callback that is cleaned up in the right place.
>    That might be registered in adps9999_init() rather than directly in probe.
>    Once you've done that drop the remove() callback as no longer needed.
> 2. Stop using devm_ registration calls from whereever in probe this matches
>    up with.
>
> Basically you mustn't mix and match devm and non devm based cleanup.

noted. I won't mix devm/non-devm cleanup.

> > +}
> > +
> > +static const struct i2c_device_id apds9999_id[] = {
> > +	{ "apds9999", 0 },
> The , 0 doesn't add anything so drop it
> 	{ "apds9999" },

I'll drop it.

> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, apds9999_id);
> > +
> > +static const struct of_device_id apds9999_of_match[] = {
> > +	{ .compatible = "brcm,apds9999" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, apds9999_of_match);
> > +
> > +static struct i2c_driver apds9999_driver = {
> > +	.driver = {
> > +		.name = "apds9999",
> > +		.of_match_table = apds9999_of_match,
> > +	},
> > +	.probe = apds9999_probe,
> > +	.remove = apds9999_remove,
> > +	.id_table = apds9999_id,
> > +};
> > +
> Common convention to tightly compule this macro with the struct i2c_driver
> by not having a blank line here.

I'll remove the blank line in v2.

> > +module_i2c_driver(apds9999_driver);
> > +
> > +MODULE_AUTHOR("Jose A. Perez de Azpillaga <azpijr@gmail.com>");
> > +MODULE_DESCRIPTION("APDS-9999 Lux Light Sensor IIO Driver");
> > +MODULE_LICENSE("GPL");
>

--
jose a. p-a
