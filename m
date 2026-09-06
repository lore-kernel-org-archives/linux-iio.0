Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC51C36196D
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788725850; cv=none; b=diuxjxzt3i+O8LI6LFMZrmYfMGVE5bIOjZ871R+KkGHSxFIHWgxNQl/G7NaV6cxzdKZy5xEwoB8Q3ypi86rYaH7+9behp64JIsi0H6Wvrbl4CezqE1tSwVJLqc7xFgzod+ZjPCoo7TEjOGFnywpmD4ucW4qkhUHZw7sj3HL+pqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788725850; c=relaxed/simple;
	bh=wkLEf7Cce830x5+Op1r9rQeBFGWbFYN1zMc56AIdU6s=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=AC8sGklmfNxe28K5U0WWpXsCr4RXatujDDWYQAk1EvKsfHrFFqgF4GYYY2/KRDJmbhUeEnT97Ahdk9zkAu3W0Q8UDkAooITTsaQaWGzzabqJ/faFnm4TI/biU9IBDyEfO/FTT2lg4RnD3MNTiiBvgwMO9kuHlglMyko3e6mSNI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVooxfDe; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVooxfDe"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso1282640e0c.1
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788725847; x=1789330647; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OtM9+DOyHnsUttC9flbAkQXpB58f1zzxgUqWVtOHupk=;
        b=UVooxfDeMcQgvySEvZXD7l3XJjMxV+iDzW5i0HQZE8b6f5P3xAHJ2CaCILmEvonO5I
         xdRcz4MC/4iV+KqBG3ctHowfoSDI7EQzWZYg2JbNLJStzLjpUVAmk29Hi5Kzpz2JW7Dh
         IGmlRn+wM375TKkLJjW46lDcU3jXG3+8BMKvOY3UX8rjnXh0kBN5mA/aGKNB/Lwyqq+Z
         RoJcuuxiJJCP8Yy5FpNog0Z5CPdoA84rUB04JaZzSWD2V3JVy4+9cg5CRCbp6Pi4qvQV
         OXXj5IhWtT6ZbBTSjVWalL3fywCf5IrrhuDXpx7EyIF6zr29mEmKNeHM4LIVN99BDl1h
         s94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788725847; x=1789330647;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OtM9+DOyHnsUttC9flbAkQXpB58f1zzxgUqWVtOHupk=;
        b=kTnOoyGumf39Odq2gZIpzjF1GpRrES3kBCO7kdaHuwSIj64/oO+0SDYyohU34fV9Ua
         b1TcY1h65y7QJUY+8X46SclVdQaYpsaMqfvMWEtuNhbnnoKoBcG2mhpzrxMj+S+PCv+u
         VvuFsaYMFFqlErIfwXqQVuCbXkRSA8zTaFHQhaEM0JthPJYgHMjIL63hHoLc5Yk8V+iA
         CybkrJqk55/3I/uDrJoMYXGocEf2s/SHQ8B3RFuukVOpgak6WT0lfh29bFdjGFjINUHy
         6lT5kZKM95w5Gy9V+DooUVwTrpfM1yhVllv0gD4c/TRiJM8ZhuuxnWs6986xIUpNQF1w
         K1YA==
X-Forwarded-Encrypted: i=1; AKwUvBy2a9qjxx0sR+cb7wzxr3pjZTJnPnaLGqa0BHsHo9VcAsZ4MJ1/UwNu+ysI5HNjDmtMvmB2vgx+2GY=@vger.kernel.org
X-Gm-Message-State: AFuF++nJ/yk9bUPdf5DR2IRBBQYw/m4OfP/GWTB6rJqUId0aeLomGeUu
	rd7Gs3blgJ4n3o73F3RPMqiyJR1skt23R++6bkxXUWtCIT/hh0SBpKtl
X-Gm-Gg: AYBFou0t3BtS8HY9K4mI/mU16yGfjiGai1j/qzg+Vwxz9ggNw2SnF/kVL2VHzsoFiGf
	sj+z0I3GvdqTf2mReVeSga/k2sLRaZ2T3Qw49NO4G1zz4tPtpluqdggCohTipJpIHhqvvwrhOT/
	Ipcelj3SreB5fy6ehTKEYEyfrsCfv7JvPMFwmK4OzKjZVycnz+gYteyeWd/inyUjeHq6aHVPn0S
	eN3z+Bz4ptNXSVccDqNJS8pJYhiE3kCOK/mssa7pTL762JcRE64d0KemqW+DSZjL/zCo8JI3bYP
	ioKSXBw0rXsikCpQ1mnWpE7rngNLKibFSmcJ9xyny/+L4bfHLmairmL1Ha4Wnc5sV/jXyubSPSj
	MZL+67dGtGSY6mWw+2/+AXjHtIcg6rgmDJCwawyFytcKJRg1S2bDmBvcJmf0cez5LtO+dv5JCf/
	vpE7/pMzuADldS6lUgwbhR8jQfHrr0UdtIflyMEMPs1MuXbZfw+g==
X-Received: by 2002:a05:6122:da0:b0:5c7:ae9a:a056 with SMTP id 71dfb90a1353d-5c7ed457809mr7449250e0c.8.1788725846519;
        Sun, 06 Sep 2026 13:17:26 -0700 (PDT)
Received: from localhost ([2800:40:44:f1f5:f400:4c49:91c1:9905])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec219c12sm6402922e0c.8.2026.09.06.13.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2026 13:17:26 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 17:17:21 -0300
Message-Id: <DL8IE3OUIUZ4.2SND39L7P03VL@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/10] iio: adc: add the ti-ads1262 driver
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
 <20260828-ads126x-v4-3-1dc27e9c0260@gmail.com>
 <bc00d888-9944-4a22-88e3-8f4d7384d037@baylibre.com>
In-Reply-To: <bc00d888-9944-4a22-88e3-8f4d7384d037@baylibre.com>

On Mon Aug 31, 2026 at 5:22 PM -03, David Lechner wrote:
> On 8/28/26 1:38 AM, Kurt Borja wrote:
>> Add the ti-ads1262 driver with initial support for the primary ADC
>> (ADC1). The ADS1263 auxiliary ADC (ADC2) is handled by a separate driver
>> and interoperability considerations were taken into account.
>>=20
>
> ...
>
>> +#define ADS1262_FW_CHANNEL_COUNT		16
>> +#define ADS1262_MON_CHANNEL_COUNT		4
>> +#define ADS1262_REGMAP_WRITE_SZ			8
>> +#define ADS1262_MONITOR_ADDR_OFFSET		100
>
> Where does this offset come from? I would make the address the value that
> gets written to MUXP/MUXN. But it looks like we are using the same value
> for the .channel, so setting .address to that would be redundant.

I'm using .address to map the firmware 'reg' to channels in
fwnode_xlate. That's why I would need to move the monitors forward. More
on this discussion below.

>
>> +
>> +#define ADS1262_ADC1_RESOLUTION			32
>> +
>> +struct ads1262 {
>> +	struct spi_device *spi;
>> +	struct regmap *regmap;
>> +	struct gpio_desc *start_gpiod;
>> +	/* protects concurrent SPI transfers */
>> +	struct mutex xfer_lock;
>> +	/* protects channel state */
>> +	struct mutex chan_lock;
>> +	struct completion drdy;
>> +	unsigned long clk_rate;
>> +	u8 dev_id;
>> +};
>> +
>> +static const char * const ads1262_device_id_to_name[] =3D {
>> +	[ADS1262_DEV_ID] =3D "ads1262",
>> +	[ADS1263_DEV_ID] =3D "ads1263",
>> +};
>> +
>> +static const struct iio_chan_spec ads1262_monitor_chan_specs[] =3D {
>> +	{
>> +		.type =3D IIO_TEMP,
>> +		.channel =3D ADS1262_INPMUX_TEMP,
>> +		.channel2 =3D ADS1262_INPMUX_TEMP,
>
> Since these are the same, I would just not set .channel2 and later say
> MUXN =3D spec->differential ? spec->channel2 : spec->channel. Same applie=
s
> to others below.
>
>> +		.address =3D ADS1262_MONITOR_ADDR_OFFSET + 0,
>> +		.scan_type =3D {
>> +			.format =3D IIO_SCAN_FORMAT_SIGNED_INT,
>> +			.realbits =3D ADS1262_ADC1_RESOLUTION,
>> +			.storagebits =3D 32,
>> +			.endianness =3D IIO_BE,
>> +		},
>> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
>
> Where is SCALE and OFFSET?

Missing.

I'm pretty sure I tested this channel though so maybe there's something
wrong in my tests.

>
>> +	},
>> +	{
>> +		.type =3D IIO_VOLTAGE,
>> +		.channel =3D ADS1262_INPMUX_AVDD,
>> +		.channel2 =3D ADS1262_INPMUX_AVDD,
>> +		.indexed =3D 1,
>> +		.address =3D ADS1262_MONITOR_ADDR_OFFSET + 1,
>> +		.scan_type =3D {
>> +			.format =3D IIO_SCAN_FORMAT_SIGNED_INT,
>> +			.realbits =3D ADS1262_ADC1_RESOLUTION,
>> +			.storagebits =3D 32,
>> +			.endianness =3D IIO_BE,
>> +		},
>> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
>> +	},
>> +	{
>> +		.type =3D IIO_VOLTAGE,
>> +		.channel =3D ADS1262_INPMUX_DVDD,
>> +		.channel2 =3D ADS1262_INPMUX_DVDD,
>> +		.indexed =3D 1,
>> +		.address =3D ADS1262_MONITOR_ADDR_OFFSET + 2,
>> +		.scan_type =3D {
>> +			.format =3D IIO_SCAN_FORMAT_SIGNED_INT,
>> +			.realbits =3D ADS1262_ADC1_RESOLUTION,
>> +			.storagebits =3D 32,
>> +			.endianness =3D IIO_BE,
>> +		},
>> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
>> +	},
>> +	{
>> +		.type =3D IIO_VOLTAGE,
>> +		.channel =3D ADS1262_INPMUX_TDAC,
>> +		.channel2 =3D ADS1262_INPMUX_TDAC,
>
> Hmm... a differential where channel =3D=3D channel2 usually means a short=
ed
> input. TDACP and TDACN can be controlled indepedantly, so really are two
> separate channels.

They can be controlled independently but the user would have to define a
common mode channel for that. I went with this because its only a test
channel and we making these channels static. Otherwise we would have to
allow the TDAC channel in devicetree. Would that be preferable?

>
>> +		.indexed =3D 1,
>> +		.differential =3D 1,
>> +		.address =3D ADS1262_MONITOR_ADDR_OFFSET + 3,
>> +		.scan_type =3D {
>> +			.format =3D IIO_SCAN_FORMAT_SIGNED_INT,
>> +			.realbits =3D ADS1262_ADC1_RESOLUTION,
>> +			.storagebits =3D 32,
>> +			.endianness =3D IIO_BE,
>> +		},
>> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
>> +	},
>> +};
>> +
>
> ...
>
>> +static int ads1262_channel_read(struct iio_dev *indio_dev,
>> +				const struct iio_chan_spec *spec, __be32 *val)
>> +{
>> +	struct ads1262 *st =3D iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
>> +		return -EBUSY;
>> +
>> +	ret =3D ads1262_set_runmode(st, ADS1262_RUNMODE_PULSE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D ads1262_channel_enable(st, spec);
>> +	if (ret)
>> +		return ret;
>> +
>> +	reinit_completion(&st->drdy);
>> +
>> +	ret =3D ads1262_dev_start_one(st);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D ads1262_wait_for_conversion(st);
>> +	if (ret)
>
> Since wait is interruptable, do we need to do something to stop the
> conversion here?

The conversions are already stopped by ads1262_dev_start_one(). I
believe there is no way to cancel the current conversion. The only
downside here would the stale data stuff pointed out by Sashiko.

>
>> +		return ret;
>> +
>> +	return ads1262_dev_read_by_cmd(st, ADS1262_OPCODE_RDATA1, val);
>> +}
>> +
>
> ...
>
>> +static int ads1262_fwnode_xlate(struct iio_dev *indio_dev,
>> +				const struct fwnode_reference_args *iiospec)
>> +{
>> +	/* REVISIT: the auxiliary ADC (ADC2) is currently not supported */
>> +	if (iiospec->nargs > 1 && iiospec->args[1])
>> +		return -EINVAL;
>> +
>> +	if (!iiospec->nargs)
>> +		return 0;
>> +
>> +	for (unsigned int i =3D 0; i < indio_dev->num_channels; i++) {
>
> Won't this include the timestamp channel?

Yes, I'll fix it.

>
>> +		if (indio_dev->channels[i].address =3D=3D iiospec->args[0])
>
> I don't think .address is the right thing to use here (it is coming from
> reg in the devcietree). I would expect channel. Otherwise consumers in th=
e
> devicetree have to be away of how channels were assigned rather than pick=
ing
> the datasheet channel number.

I was very confused about what approach should I take here. All channels
in this chip are actually differential. In that case should I make
#io-channel-cells =3D 3 i.e. positive, negative and ADC?

>
> And the devicetree bindings should mention the monitor channel numbers (1=
1 - 14).
>
>> +			return i;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>
> ...
>
>> +static int ads1262_spi_probe(struct spi_device *spi)
>> +{
>> +	struct device *dev =3D &spi->dev;
>> +	struct iio_dev *indio_dev;
>> +	struct ads1262 *st;
>> +	unsigned long rate;
>> +	struct clk *clk;
>> +	int irq;
>> +	int ret;
>> +
>> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +	indio_dev->info =3D &ads1262_iio_info;
>> +
>> +	st =3D iio_priv(indio_dev);
>> +	st->spi =3D spi;
>> +	init_completion(&st->drdy);
>> +
>> +	ret =3D devm_mutex_init(dev, &st->chan_lock);
>> +	if (ret)
>> +		return ret;
>> +	ret =3D devm_mutex_init(dev, &st->xfer_lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D ads1262_parse_channels(indio_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret =3D ads1262_supply_setup(st);
>> +	if (ret)
>> +		return ret;
>> +
>> +	clk =3D devm_clk_get_optional_enabled(dev, NULL);
>> +	if (IS_ERR(clk))
>> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get external clock=
\n");
>> +
>> +	rate =3D clk_get_rate(clk);
>> +	if (clk && !rate)
>> +		return dev_err_probe(dev, -EINVAL, "failed to get clock rate\n");
>> +	st->clk_rate =3D rate ? rate : ADS1262_NOMINAL_CLK_RATE;
>> +
>> +	st->start_gpiod =3D devm_gpiod_get_optional(dev, "start", GPIOD_OUT_LO=
W);
>> +	if (IS_ERR(st->start_gpiod))
>> +		return dev_err_probe(dev, PTR_ERR(st->start_gpiod),
>> +				     "failed to get start GPIO\n");
>> +
>> +	st->regmap =3D devm_regmap_init(dev, &ads1262_regmap_bus, st,
>> +				      &ads1262_regmap_config);
>> +	if (IS_ERR(st->regmap))
>> +		return PTR_ERR(st->regmap);
>> +
>> +	ret =3D ads1262_dev_configure(st);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to configure device\n");
>> +
>> +	indio_dev->name =3D ads1262_device_id_to_name[st->dev_id];
>
> Not so sure about this. Almost always, this is coming from the compatible
> match data. So unless we plan on trusting the device ID returned by the
> chip over the devicetree when we add more to the device id tables and loo=
king
> up per-chip behavior from there instead of the compatible, I would go wit=
h
> the traditional approach. That way the name userpace sees match the drive=
r
> behavior that goes with the other chip-specific match data that is likely
> to be added in the future.

You're right. I'll revert this.

>
>> +
>> +	/*
>> +	 * REVISIT: This chip has software polling capabilities, which could b=
e
>> +	 * used to stop depending on the DRDY signal.
>> +	 *
>> +	 * Additionally, the MISO pin also can be used as a DRDY IRQ, in which
>> +	 * case the interrupt would be named 'doutdrdy', but requires extra
>> +	 * timing and synchronization considerations to be reliable.
>> +	 */
>> +	irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "drdy");
>> +	if (irq < 0)
>> +		return dev_err_probe(dev, irq,
>> +				     "the 'drdy' IRQ is currently required for operation\n");
>> +
>> +	ret =3D devm_request_irq(dev, irq, ads1262_irq_handler, IRQF_NO_THREAD=
,
>> +			       indio_dev->name, st);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}
>> +

--=20
Thanks,
 ~ Kurt
