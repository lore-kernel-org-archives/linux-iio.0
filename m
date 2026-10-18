Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8A38B133;
	Sun, 18 Oct 2026 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792363141; cv=none; b=b+EOpIB0xbV6XmYH67kllYgMMc6ZkXbUMa8BAuNG8pwPD2a1n3K928yw47J+Cj1o6H4jpUkNNU7ryBozunTp+xejOwZPgVMT37J7m3U1oUeaAdtDAQzpvEIAp+aSLLhrBxt/rX9mVs4MEQSiPyJXW2Xinyx7Qr8Zqp/jQIlRdL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792363141; c=relaxed/simple;
	bh=e2iQWmzu36pHADKAhdZzMhdTBsazvRRrWhPTn6aAapo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OnonN/RyqtZ2cOiCWCzWG8obOGwYZ2c6l+WbQDyMv43CFPC8ksQIwVRtoRPGOT2UsinlkjRE3tw2ci4dgMoFd5a1P+bPAriOD8bIjmXKmDvSF+h4qeTnA47LEMQPbLsemDtadv3eU+oDnQSjPqZz9C9CLc6AKjSVIpHJSoYyiBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeQT1mDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeQT1mDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FD11F000C4;
	Sun, 18 Oct 2026 22:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792363139;
	bh=U90NoANVniqeOCZKPoz7EbkJGj0t9m2VjW7Fq3PsPwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MeQT1mDi5RM3/t00z+dcDzsStrYg8vBkll5et5r1alZDxG+zM0JZXyWajgR45sJy5
	 KQ044yVfXaFaSGwF71ofLJzGlj7azRjKNmOKewONS1c1YCTVZgi+c7arClEMu5+KBm
	 hP8izkinkTlBvNiO5430ftxD1YSlkzpxekXUYNmn9ut75PkXK7dNojYBJ4Zjc34YFy
	 EcKxFPohVgKCJEg/Rqr99+0ELWq4svkz+7bN2tbr/dduRLrkKOyb5pHo8fauJ1PUxV
	 FeQhWKDS8ATG/byo4g7gmUH8mLci59EY4UBc0hD6gwcJGHc5kRo55WbdFZkQfE0xQO
	 vmejkVWNAKBBw==
Date: Sun, 18 Oct 2026 23:38:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Puranjay Mohan
 <puranjay@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@bootlin.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: temperature: tmp117: add support for HIGH and
 LOW alerts
Message-ID: <20261018233852.153dbc34@jic23-hlaptop>
In-Reply-To: <asuVzmd1L1hn_4ux@debian-BULLSEYE-live-builder-AMD64>
References: <20261005-add-tmp117-notif-v1-0-c6cef6fad64c@bootlin.com>
	<20261005-add-tmp117-notif-v1-2-c6cef6fad64c@bootlin.com>
	<asuVzmd1L1hn_4ux@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Oct 2026 10:57:34 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 10/05, Thomas Bonnefille wrote:
> > The TMP117/116/119 chips allow the user to set an alert if the
> > temperature reaches a HIGH or LOW limit.
> > 
> > Add support for setting the high and low alert limits.
> > An IIO event is generated when the temperature crosses either limit
> > thanks to an interrupt on the Alert pin.
> > 
> > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > ---  
> ...
> > +static int tmp117_read_thresh(struct iio_dev *indio_dev,
> > +			      const struct iio_chan_spec *chan,
> > +			      enum iio_event_type type,
> > +			      enum iio_event_direction dir,
> > +			      enum iio_event_info info,
> > +			      int *val, int *val2)
> > +{
> > +	struct tmp117_data *data = iio_priv(indio_dev);
> > +	s32 ret;
> > +	u8 reg;
> > +
> > +	switch (dir) {
> > +	case IIO_EV_DIR_RISING:
> > +		reg = TMP117_REG_HIGH_LIM;
> > +		break;
> > +	case IIO_EV_DIR_FALLING:
> > +		reg = TMP117_REG_LOW_LIM;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (info != IIO_EV_INFO_VALUE || type != IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +	ret = i2c_smbus_read_word_swapped(data->client, reg);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/*
> > +	 * Report the threshold in millidegrees Celsius as an exact fraction:
> > +	 * value = raw * TMP117_LIMIT_LSB_NUM / TMP117_LIMIT_LSB_DEN.
> > +	 */  
> The IIO temperature channel provides single-read data in (raw) device units
> (i.e. not scaled to mili degrees Celsius). Now, in contrast with the single-read
> interface, the event configuration being proposed reads/writes data in milli
> degrees Celsius. And, since the event ABI doesn't yet provide clear indication
> about IIO event data unit types, users might get confused when using the
> different interfaces.
> 
> There are two main options for avoiding/mitigating the potential interface mismatch:
> (1) provide/get raw device units in tmp117_read/write_thresh().

This one is my strong preference.

> 
> (2) add IIO_CHAN_INFO_PROCESSED to the IIO channel mask and implement the
> handling for the channel _input interface to provide single-read data in
> milli degrees Celsius units. Though, this option will also need an updated
> IIO event interface. Probably something like [1] or [2]. I'll respin on that
> next week. The event specs would be updated to something like
> 
> 
> +static const struct iio_event_spec tmp11x_obj_event[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.unit = IIO_EV_UNIT_PROCESSED,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.unit = IIO_EV_UNIT_PROCESSED,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	},
> +};
> +
> 
> 
> [1]: https://lore.kernel.org/linux-iio/cover.1768759292.git.marcelo.schmitt1@gmail.com/
> [2]: https://lore.kernel.org/linux-iio/e359fa003ebc61c8b0e37ba9810a04c70e5a300e.1791437050.git.marcelo.schmitt@analog.com/
> 
> With best regards,
> Marcelo
> 
> > +	*val = sign_extend32(ret, 15) * TMP117_LIMIT_LSB_NUM;
> > +	*val2 = TMP117_LIMIT_LSB_DEN;
> > +
> > +	return IIO_VAL_FRACTIONAL;
> > +}
> > +
> > +static int tmp117_write_thresh(struct iio_dev *indio_dev,
> > +			       const struct iio_chan_spec *chan,
> > +			       enum iio_event_type type,
> > +			       enum iio_event_direction dir,
> > +			       enum iio_event_info info,
> > +			       int val, int val2)
> > +{
> > +	struct tmp117_data *data = iio_priv(indio_dev);
> > +	s64 tmp;
> > +	u8 reg;
> > +
> > +	switch (dir) {
> > +	case IIO_EV_DIR_RISING:
> > +		reg = TMP117_REG_HIGH_LIM;
> > +		break;
> > +	case IIO_EV_DIR_FALLING:
> > +		reg = TMP117_REG_LOW_LIM;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (info != IIO_EV_INFO_VALUE || type != IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * The threshold is passed in millidegrees Celsius as
> > +	 * value = val + val2 / 1000000 (val2 holds the fractional part, with
> > +	 * the sign taken from val). Convert it back with the same LSB ratio:
> > +	 * raw = value / (TMP117_LIMIT_LSB_NUM / TMP117_LIMIT_LSB_DEN).
> > +	 */
> > +	tmp = (val < 0) ? (s64)val * 1000000 - val2
> > +			: (s64)val * 1000000 + val2;
> > +	tmp = DIV_ROUND_CLOSEST(tmp * TMP117_LIMIT_LSB_DEN,
> > +				(s64)TMP117_LIMIT_LSB_NUM * 1000000);
> > +	tmp = clamp_t(s64, tmp, S16_MIN, S16_MAX);
> > +
> > +	return i2c_smbus_write_word_swapped(data->client,
> > +					    reg, tmp);
> > +}
> > +  

