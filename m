Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0261A9B58;
	Tue, 30 Jun 2026 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782779342; cv=none; b=I0pVBs+TUy56/QIxT+oB6syNp+AsJVEkKt5Tcg4fQPUvs96XNEHa0BM7GjqZtLgZsIry8u5xXCWNRcr5ngNDvvRu/orkg5DYZlUykxD2nodbzQo7h95UkeHVfcp96bDwoLzI/DwpLw4IU7JZkv02f0lg1Fbo2Oz350b2dwUZfA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782779342; c=relaxed/simple;
	bh=w0btAhFN+fAdK7JEhwsJheXcRqfQ76pQ3xQfhXV4Bio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2M/Yf9464FqpZUHPaeG+gzDmB0yZ6N+Su6006R4hPHErohSRXaQ+J7CTbtM0jPtbK4erapLrF1WoABNhMrBB1TztkiwsPxgqrxnbgnDSBASpOuQCqfFKqyJUb8YcgteaKJCG4CmPP7355odraLwzWN/lxOjr2Y8vRyDMNqhYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fo5apw7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fo5apw7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F381F000E9;
	Tue, 30 Jun 2026 00:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782779341;
	bh=Lyce1sEosfKnoswWU3Rbe6M/I72zbpqKVcPFHrJW7/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Fo5apw7wi+m12+bc5oIOSnh1bsP+byT4qMntjz+HvupDIwLCjtQrb6Ycg8ffHq9gi
	 /Okbs8/jm1KrJtLXAbzAAWcFMcE435IkiaEqJ6vbCIR8mX20boAJay2OA9P/VNyRov
	 +/FEJJ99HXpHDZaS50Pt5IORj1qV/vQCcd11gF23W2DtGanLNfkmgSzeDw9RE2EYUj
	 Zx50FYi7PvlKP8jD4T5rmv+wBWrjsIqeWWZTchJMWX+28LFM39hsmfxkaOq9wbeXW5
	 Gm3g5oXTcTEvVQIo8rWyfQuzcdF6QxYHaU9YWczDzt6h0bClopECmRub/vIDQxGy4e
	 QI8EXJCiXWAWQ==
Date: Tue, 30 Jun 2026 01:28:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] iio: adc: Add ti-ads1262 driver
Message-ID: <20260630012855.4b47b548@jic23-huawei>
In-Reply-To: <0d7a5a3b-dc11-472f-a09a-44df887d5147@baylibre.com>
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
	<20260628-ads126x-v2-2-4b1b231325ba@gmail.com>
	<0d7a5a3b-dc11-472f-a09a-44df887d5147@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > +static int ads1262_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan, int *val,
> > +			    int *val2, long mask)
> > +{
> > +	struct ads1262 *st = iio_priv(indio_dev);
> > +	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
> > +	u8 realbits = chan->scan_type.realbits;
> > +	__be32 raw;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = ads1262_channel_read(st, chan_data, &raw);
> > +		if (ret)
> > +			return ret;
> > +		*val = sign_extend32(be32_to_cpu(raw), realbits - 1);
> > +
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SCALE: {
> > +		guard(mutex)(&st->chan_lock);
> > +
> > +		ret = ads1262_channel_get_scale(st, chan, val, val2);
> > +		if (ret)
> > +			return ret;
> > +
> > +		return IIO_VAL_INT_PLUS_NANO;
> > +	}
> > +
> > +	case IIO_CHAN_INFO_HARDWAREGAIN: {  
> 
> There is only one other ADC that uses "hardwaregain". Usually, we just make
> scale writeable to control the gain. I don't remember what the rules for
> that attribute are. Using it for in_voltage is not documented in the ABI.

Roughly speaking it should only be used when the gain is no affecting
the thing being measured (so we can't do it with _scale).
Examples are things like the gain on a time of flight sensor - it
affects how likely we are to get a measurement, not what the measurement is.

Hmm. The one ADC using is the ina2xx - that's a weird device so it
would take some digging to try and figure out why that one go through
review.

> 
> > +		guard(mutex)(&st->chan_lock);
> > +
> > +		*val = ads1262_pga_gain_avail[chan_data->gain];
> > +
> > +		return IIO_VAL_INT;
> > +	}
> > +
> > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> > +		guard(mutex)(&st->chan_lock);
> > +
> > +		*val = ads1262_data_rate_avail[chan_data->data_rate][0];
> > +		*val2 = ads1262_data_rate_avail[chan_data->data_rate][1];
> > +
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	}
> > +
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
