Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221813AA1BD
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782676831; cv=none; b=mKnAkZBnYRzeLQ3i5YuZscx6P1/mKTuVNrIo8XcENAiUP5/MZ4cHtSg/d+TDecHf4YJCwcD9kGI/I7Uwcl/9c7u/sbCC5fVUnKDmh8Zrir1CtllQQ4Ai6sPujyOQ1oLn6s447WZZa0CpqUWrLAcxXjf5RXbMzroIz8DLKSUuz2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782676831; c=relaxed/simple;
	bh=HNrLiwMj1ncdw9jIk/Fn3qDd4sl+SaP9oKzUmXn8gXU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=ct8kZAaxgtQ4/d3+/BV9xMg/ons56EkIfcf53ll1HIyZwADU5lo/2gi9ErPS0qE/WWnITgUoyuyMYoXdwQwE8wBLXh5uanYb5rbRowMg+Jfi31JN8WgBRjVQ1dZAVWOtrIYGu2PdIw0hCBuSOcBNrlZ9Hz6l73jedGNjSn6IW6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUGEtgJN; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUGEtgJN"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7353fc917e2so908741137.2
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 13:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782676829; x=1783281629; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJwRQGwvDEEvRXQsqTjFz9nKmAwUGnsyRjXWuMSZBlY=;
        b=nUGEtgJNr8MqUiyd581aftI3pC2ntgvW2lALP00lXgVDyoY1XJi95E/voX6NkKQhnq
         gBqGPmzaGoeGyZnrulonv7MZeIbj6askzVSgG9BnVHyzqihFyb7aBOxPCH5fkXtE/JEZ
         xGGFD/Kb5jAtMkKmGAl1UnKJX6ZuqKBt21c3/XGUZy2RtHjfNNMsZX8OLx4iDdq91KwN
         S05Qm8dDO3blTzO2jFOXzGxONclbDISbChO+igY6gQOIYVc7SKLD6r9uuZW57VR3eEVa
         GV1fwB7bSigObcET7ybHqU7CW0GhUEBu90qwtIWgOhp3d6AeOIIZuiY8bdDgxBgbGTM4
         QMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782676829; x=1783281629;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJwRQGwvDEEvRXQsqTjFz9nKmAwUGnsyRjXWuMSZBlY=;
        b=L+HEs/qig7I12h/C9wjcDapT2lqRQeup8ZVWU9c8gwPLe/VBnW1JnqRoo+K1xHihiv
         i3ljRnt9P/i2exZMjySrnCYtk/aOUViEHICuET1b2zIVIOsYptjpOjHJ8mEi3QklQJb2
         Z0lbqFuGoFa5hM1dLNNI8QIVVp6uGHxavQw2a1w2HZpD+VSFHm6B4pfaWd09E2/uICZv
         uMnDXje65nGwBgCBH4dlKC52Na3JrUIgkscEnY/J9zBFiIxpRik8aZbF55Rqdd/OIhjo
         N4wLByYiDUwP4eRF7mZ59zzUguzYTvONXYLByeS+Qw/gyhZ8FZ6dkK/8tN4s9eVL3j3b
         ZnJA==
X-Forwarded-Encrypted: i=1; AHgh+RoEY5Lbx7pwBK5cF8SZWlZnG10HhV2OSnCMn/CDSQuphqEz4soV3O7y9lfYkC8BoVyaca+UW4BzyZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4yHcnpo9++ZuooE4v6YbUJ4I1fmuOiFQMJOij52YBmBctUH4R
	lXq3T5og9PtCLImswAqyDS6mGXS5PYfy0qTA+criAAtTYvuhgZMNGOzW
X-Gm-Gg: AfdE7clzrJvWaFpFbpF+XNqIbvRCD0L+92flb/h/zunLkWb8ajTcsK//zmQSrA4czhn
	v9Z4M+1jtsrgtUYfdG7Ka3cWI6YNIV0Zb8L7APCtsn1F9+6zwlxmRKBo1+4ZcJOMYfcGPJxg6w7
	ifoEiVA92F7xNgt/tNE8Syorq5IDCwGwKxjYNd2f6IcKXMziaFaQqnQFGYYYt+z8X3usO5ab8P9
	aozkyDoRXBqEjgjbm90h10Qzl1hP8Hs0WNhy8B/dK8+ncaaLbQ3kRghj3dS8/9HO52A4nyn20l7
	CjFLzWrcvOLoAJkr1+Z+w8z0bXsC54EfV6LRrPQi7UClgqMoInWr2RZhvN8Vf6QbmtpalCcx2Wd
	903KA9zuK8Jhiz1MbJ1tVwkKvg4p3j/ZEwQ52Jjeag99VROF209pErrTV19UTxtJfSTuRS1morb
	kBqXI=
X-Received: by 2002:a05:6102:2b95:b0:728:68cf:c76 with SMTP id ada2fe7eead31-734364ba1e6mr6471180137.23.1782676828907;
        Sun, 28 Jun 2026 13:00:28 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-738f72b4cf2sm181543137.7.2026.06.28.13.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 13:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 28 Jun 2026 15:00:18 -0500
Message-Id: <DJKY6WN6KS2R.2ZF2TTJU7LBE3@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] iio: adc: Add ti-ads1262 driver
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
 <20260628-ads126x-v2-2-4b1b231325ba@gmail.com>
 <0d7a5a3b-dc11-472f-a09a-44df887d5147@baylibre.com>
In-Reply-To: <0d7a5a3b-dc11-472f-a09a-44df887d5147@baylibre.com>

On Sun Jun 28, 2026 at 12:15 PM -05, David Lechner wrote:
> On 6/28/26 12:36 AM, Kurt Borja wrote:
>> Add the ti-ads1262 driver with initial support for the primary ADC
>> (ADC1). The ADS1263 auxiliary ADC (ADC2) is handled by a separate driver
>> and interoperability considerations were taken into account.
>>=20
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  MAINTAINERS                  |    1 +
>>  drivers/iio/adc/Kconfig      |   13 +
>>  drivers/iio/adc/Makefile     |    1 +
>>  drivers/iio/adc/ti-ads1262.c | 1206 +++++++++++++++++++++++++++++++++++=
+++++++
>>  4 files changed, 1221 insertions(+)
>
> Ideally, an intial patch would be 1/2 this size. Over 1000 lines in
> a single patch make it take more than twice as long to review as
> if it was split into two patches (or you just don't get a detailed
> review). For example, sample rate and gain can be split out into
> seprate patches.
>
> I certainly don't have time to revew this plus an additonal 1000
> lines of more patches on top of it in a week.

Sure, I'll split it even more.

[...]

>> +static int ads1262_calculate_scale(struct ads1262 *st, u8 realbits, u8 =
gain,
>> +				   u8 pos_ref, u8 neg_ref, int *val, int *val2)
>> +{
>> +	u64 divd, divr, tmp, rem;
>> +	int pos_uV, neg_uV;
>> +
>> +	switch (pos_ref) {
>> +	case ADS1262_REFMUX_INTERNAL:
>> +		/* Internal voltage reference is 2.5 V */
>> +		pos_uV =3D 2500000;
>> +		break;
>> +	case ADS1262_REFMUX_AIN0_AIN1...ADS1262_REFMUX_AIN4_AIN5:
>> +		pos_uV =3D st->refp_uV;
>
> I don't think it is safe to assume the same reference is wired to all of =
these.

Yes, you're right. I'll add supplies for the other options.

[...]

>> +static int ads1262_channel_enable(struct ads1262 *st,
>> +				  struct ads1262_channel *chan)
>> +{
>> +	u8 mode0, mode2, inpmux, refmux;
>> +	int ret;
>> +
>> +	/* Avoid using guard() here to mitigate AB/BA deadlock warning */
>> +	mutex_lock(&st->chan_lock);
>> +	mode0 =3D FIELD_PREP(ADS1262_MODE0_INPUT_CHOP_MASK, chan->input_chop) =
|
>> +		FIELD_PREP(ADS1262_MODE0_IDAC_CHOP_MASK, chan->idac_chop) |
>> +		FIELD_PREP(ADS1262_MODE0_REFREV_MASK, chan->ref_reversal);
>> +	mode2 =3D FIELD_PREP(ADS1262_MODE2_DR_MASK, chan->data_rate) |
>> +		FIELD_PREP(ADS1262_MODE2_GAIN_MASK, chan->gain) |
>> +		FIELD_PREP(ADS1262_MODE2_BYPASS_MASK, chan->pga_bypass);
>> +	inpmux =3D FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, chan->input[1]) |
>> +		 FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, chan->input[0]);
>> +	refmux =3D FIELD_PREP(ADS1262_REFMUX_RMUXN_MASK, chan->reference[1]) |
>> +		 FIELD_PREP(ADS1262_REFMUX_RMUXP_MASK, chan->reference[0]);
>> +	mutex_unlock(&st->chan_lock);
>
> Why does lock not also include actually writing the bits?

Because we take the xfer_lock in that path. Later in the series, I'm
forced to take the xfer_lock first, so that would be AB/BA bug. But...

See the regmap answer below.

[...]

>> +static int ads1262_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan, int *val,
>> +			    int *val2, long mask)
>> +{
>> +	struct ads1262 *st =3D iio_priv(indio_dev);
>> +	struct ads1262_channel *chan_data =3D &st->channels[chan->scan_index];
>> +	u8 realbits =3D chan->scan_type.realbits;
>> +	__be32 raw;
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret =3D ads1262_channel_read(st, chan_data, &raw);
>> +		if (ret)
>> +			return ret;
>> +		*val =3D sign_extend32(be32_to_cpu(raw), realbits - 1);
>> +
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE: {
>> +		guard(mutex)(&st->chan_lock);
>> +
>> +		ret =3D ads1262_channel_get_scale(st, chan, val, val2);
>> +		if (ret)
>> +			return ret;
>> +
>> +		return IIO_VAL_INT_PLUS_NANO;
>> +	}
>> +
>> +	case IIO_CHAN_INFO_HARDWAREGAIN: {
>
> There is only one other ADC that uses "hardwaregain". Usually, we just ma=
ke
> scale writeable to control the gain. I don't remember what the rules for
> that attribute are. Using it for in_voltage is not documented in the ABI.

I went with hardwaregain because the scale loses too many significant
digits at high gain. With the internal reference and gain =3D 1, the scale
is at 0.000001164; then at gain =3D 32, the scale is at 0.000000036.

In this case I expect users to just calculate the scale themselves based
on the hardwaregain. Is this acceptable? If not I'll go with
scale_available.

[...]

>> +static int ads1262_alloc_channels(struct ads1262 *st,
>> +				  struct iio_chan_spec **channels)
>> +{
>> +	struct device *dev =3D &st->spi->dev;
>> +	struct ads1262_channel *chan_data;
>> +	struct iio_chan_spec *chans;
>> +	unsigned int i, num_channels;
>> +
>> +	/* Account for the timestamp channel */
>> +	num_channels =3D st->num_channels + 1;
>> +	chans =3D devm_kcalloc(dev, num_channels, sizeof(*chans), GFP_KERNEL);
>> +	if (!chans)
>> +		return -ENOMEM;
>> +
>> +	for (i =3D 0; i < st->num_channels; i++) {
>> +		chan_data =3D &st->channels[i];
>> +		chans[i] =3D (struct iio_chan_spec) {
>> +			.type =3D IIO_VOLTAGE,
>> +			.channel =3D chan_data->input[0],
>> +			.channel2 =3D chan_data->input[1],
>> +			.scan_index =3D i,
>> +			.scan_type =3D {
>> +				.format =3D IIO_SCAN_FORMAT_SIGNED_INT,
>> +				.realbits =3D 32,
>> +				.storagebits =3D 32,
>> +				.endianness =3D IIO_BE,
>> +			},
>> +			.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>> +					      BIT(IIO_CHAN_INFO_SCALE) |
>> +					      BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
>> +					      BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +			.info_mask_shared_by_type_available =3D
>> +				BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
>
> Gain available might make more sense as separate if there are restriction=
s
> on gain allowed due to other conditions.=20
>
>> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),
>
> Could be the same case with sampling frequency if filters can affect that=
.

Actually, sampling frequency takes precedence over the filter
configuration. Some rates cause the chip to ignore the filter
configuration.

>
>> +			.indexed =3D true,
>> +			.differential =3D true,
>
> These two make more sense closer to the top since they affect the
> channel naming along with type and channel.
>
>> +		};
>> +	}
>
> As mentioned in the DT bindings review, I would make the diagnostic
> channels fixed so that they don't have to be always specified in
> the devicetree.

I agree. I'll add the monitors here.

[...]

>> +static int ads1262_regmap_read(void *context, const void *reg_buf,
>> +			       size_t reg_size, void *val_buf, size_t val_size)
>> +{
>> +	struct ads1262 *st =3D context;
>> +	struct spi_transfer xfer =3D {
>> +		.tx_buf =3D st->tx,
>> +		.rx_buf =3D st->rx,
>> +		.len =3D reg_size + 1 + val_size,
>> +	};
>> +	int ret;
>> +
>> +	guard(mutex)(&st->xfer_lock);
>
> SPI bus and regmap both already have their own locking, so putting a lock
> here seems out of place. Instead, the lock should be for higher-level
> operations where there are mulitple register access in a single operation=
.

I agree. I can definitely move this one to a "higher level". But IMO,
because this also protects tx and rx buffers, it makes sense to have it
here too.

>
>> +
>> +	memset(st->tx, 0, reg_size + 1 + val_size);
>> +
>> +	memcpy(&st->tx[0], reg_buf, 1);
>> +	st->tx[1] =3D val_size - 1;
>> +
>> +	ret =3D spi_sync_transfer(st->spi, &xfer, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	memcpy(val_buf, &st->rx[2], val_size);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ads1262_regmap_gather_write(void *context, const void *reg_b=
uf,
>> +				       size_t reg_size, const void *val_buf,
>> +				       size_t val_size)
>> +{
>> +	struct ads1262 *st =3D context;
>> +	struct spi_transfer xfer =3D {
>> +		.tx_buf =3D st->tx,
>> +		.rx_buf =3D st->rx,
>> +		.len =3D reg_size + 1 + val_size,
>> +	};
>> +
>> +	guard(mutex)(&st->xfer_lock);
>> +
>> +	memset(st->tx, 0, reg_size + 1 + val_size);
>> +
>> +	memcpy(&st->tx[0], reg_buf, 1);
>> +	st->tx[1] =3D val_size - 1;
>> +	memcpy(&st->tx[2], val_buf, val_size);
>> +
>> +	return spi_sync_transfer(st->spi, &xfer, 1);
>> +}
>> +
>> +static int ads1262_regmap_write(void *context, const void *data, size_t=
 count)
>> +{
>> +	return ads1262_regmap_gather_write(context, data, 1, data + 1,
>> +					   count - 1);
>> +}
>> +
>> +static const struct regmap_bus ads1262_regmap_bus =3D {
>> +	.read =3D ads1262_regmap_read,
>> +	.gather_write =3D ads1262_regmap_gather_write,
>> +	.write =3D ads1262_regmap_write,
>> +	.reg_format_endian_default =3D REGMAP_ENDIAN_BIG,
>> +	.val_format_endian_default =3D REGMAP_ENDIAN_BIG,
>> +	/* The first two bytes of the buffer are reserved for the protocol */
>> +	.max_raw_read =3D ADS1262_XFER_BUFFER_SZ - 2,
>> +	.max_raw_write =3D ADS1262_XFER_BUFFER_SZ - 2,
>> +};
>
> Why do we need our own bus instead of using REGMAP_SPI?

Because the protocol is different. Read/write protocol for this chip is

	first reg + command | number of regs - 1 | reg values

while regmap_spi is

	first reg | reg values

I had a comment explaining this, but I forgot to restore it.

[...]

>> +static int ads1262_parse_firmware(struct ads1262 *st)
>> +{
>> +	struct device *dev =3D &st->spi->dev;
>> +	struct clk *clk;
>> +	u32 reg;
>> +	int ret;
>> +
>> +	/* Set the nominal clock frequency */
>> +	clk =3D devm_clk_get_optional_enabled_with_rate(dev, NULL, 7372800);
>
> This is quite unusual. Usually an external clock would be a fixed clock
> and therefore can't be set.

Really? It can be a crystal of course, but it also can be anything else.
Shouldn't I be trying to set the clock frequency in that case?

>
>> +	if (IS_ERR(clk))
>> +		return dev_err_probe(dev, PTR_ERR(clk),
>> +				     "Failed to get external clock\n");
>> +
>> +	ret =3D devm_regulator_get_enable(dev, "dvdd");
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to get dvdd regulator\n");
>> +
>> +	st->avdd_uV =3D devm_regulator_get_enable_read_voltage(dev, "avdd");
>
> We only need the voltage of avdd if it is actually used as a reference, w=
hich
> is probably quite rare. Not all regulators provide a voltage value.

Then I should just check for ENODEV here.

>
>> +	if (st->avdd_uV < 0)
>> +		return dev_err_probe(dev, st->avdd_uV, "Failed to get avdd regulator\=
n");
>> +
>> +	st->refp_uV =3D devm_regulator_get_enable_read_voltage(dev, "refp");
>> +	if (st->refp_uV < 0 && st->refp_uV !=3D -ENODEV)
>> +		return dev_err_probe(dev, st->refp_uV, "Failed to get refp regulator\=
n");
>> +
>> +	st->refn_uV =3D devm_regulator_get_enable_read_voltage(dev, "refn");
>> +	if (st->refn_uV < 0 && st->refn_uV !=3D -ENODEV)
>> +		return dev_err_probe(dev, st->refn_uV, "Failed to get refn regulator\=
n");
>> +
>> +	st->start_gpiod =3D devm_gpiod_get_optional(dev, "start", GPIOD_OUT_LO=
W);
>> +	if (IS_ERR(st->start_gpiod))
>> +		return dev_err_probe(dev, PTR_ERR(st->start_gpiod),
>> +				     "Failed to get start GPIO\n");
>> +
>> +	st->reset_gpiod =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LO=
W);
>> +	if (IS_ERR(st->reset_gpiod))
>> +		return dev_err_probe(dev, PTR_ERR(st->reset_gpiod),
>> +				     "Failed to get reset GPIO\n");
>
> This is currently never used.

It has to be de-asserted for the chip to be in an active state though.

[...]

>> +MODULE_DESCRIPTION("Texas Instruments ADS1262 ADC driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Kurt Borja <kuurtb@gmail.com>");

I agree with all other comments. Thanks a lot for the review!

--=20
Thanks,
 ~ Kurt
