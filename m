Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF828EEBA;
	Tue, 30 Jun 2026 00:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782779582; cv=none; b=SlhzgJixJ3Dga0gqwOwn7xewaW6tbD0ZuYU2WelzqcQplfg6nIJywaP1hS0etozdz8WyGkoXKq43QvjR6b6bQwz8GgCWY5djhw+d86Nq+am3ssOTx9PMpCHqKEcJsQ9DlVL/ERlYXZFDi1UncxJsgrWijQ8GLIZ+ThFBUrMhdb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782779582; c=relaxed/simple;
	bh=bDqvfTDdtcZXiQl+wcwuU2kfU3kLukGmx3tdcj0bN1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzOnOcJwXXPnElMuULekmklgP2qQX8brCQqrXbI2VzV7G4p8lhl0VXbrcujYH6ubeQi7y54OVF1fQe0n59lGHQcb0s4g5dwPRw0ZbpnbDzURrf9suJdyOIyv53ts2MYSSwEidrGfK3tCjLS+jRQpn8fpi1WDYw7RAxdlCLEhQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI9FGEd2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI9FGEd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D418D1F000E9;
	Tue, 30 Jun 2026 00:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782779581;
	bh=IFGGAJiO6nzUWITmyjDgwz1yoRTjaLgVqf3oTtpltRk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QI9FGEd2qRzZ2JifMa8s7WMAx0QZLTdIpIuNU8hA9gk4naYpimG2dLHpPR2hkiA29
	 qz83HyNj+GgRVQKsiSGIjhXfFl7fuLmUwcJ0crmnc+CDGuz7JWQJTNFPXK3MQdCs9u
	 suNTQ91m63CiTTaA2Ajmm6oHnG99SDQhQJfjSQ9RJcuk2YXZA6ImyfoM55pCpSu6u5
	 +FpsTMqiBnJIr6Klm6zoET3U6RWintV2uX0XxN/r49dM0L+4x3+4zR5N9Qj3xyMhFS
	 lEk+eLJh7UK/yMnIzc1V1XILX/fqTI1PUzGQpQ0QCZfxKGe0pGCigJnU6CK7OgBs/k
	 3+3gfbcMEY6cA==
Date: Tue, 30 Jun 2026 01:32:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] iio: adc: Add ti-ads1262 driver
Message-ID: <20260630013255.3ed41e28@jic23-huawei>
In-Reply-To: <dba5ef4d-57e3-4016-842c-dad6990d7207@baylibre.com>
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
	<20260628-ads126x-v2-2-4b1b231325ba@gmail.com>
	<0d7a5a3b-dc11-472f-a09a-44df887d5147@baylibre.com>
	<DJKY6WN6KS2R.2ZF2TTJU7LBE3@gmail.com>
	<dba5ef4d-57e3-4016-842c-dad6990d7207@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 09:38:13 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/28/26 3:00 PM, Kurt Borja wrote:
> > On Sun Jun 28, 2026 at 12:15 PM -05, David Lechner wrote:  
> >> On 6/28/26 12:36 AM, Kurt Borja wrote:  
> >>> Add the ti-ads1262 driver with initial support for the primary ADC
> >>> (ADC1). The ADS1263 auxiliary ADC (ADC2) is handled by a separate driver
> >>> and interoperability considerations were taken into account.
> >>>  
> 
> ...
> 
> >>> +static int ads1262_read_raw(struct iio_dev *indio_dev,
> >>> +			    struct iio_chan_spec const *chan, int *val,
> >>> +			    int *val2, long mask)
> >>> +{
> >>> +	struct ads1262 *st = iio_priv(indio_dev);
> >>> +	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
> >>> +	u8 realbits = chan->scan_type.realbits;
> >>> +	__be32 raw;
> >>> +	int ret;
> >>> +
> >>> +	switch (mask) {
> >>> +	case IIO_CHAN_INFO_RAW:
> >>> +		ret = ads1262_channel_read(st, chan_data, &raw);
> >>> +		if (ret)
> >>> +			return ret;
> >>> +		*val = sign_extend32(be32_to_cpu(raw), realbits - 1);
> >>> +
> >>> +		return IIO_VAL_INT;
> >>> +
> >>> +	case IIO_CHAN_INFO_SCALE: {
> >>> +		guard(mutex)(&st->chan_lock);
> >>> +
> >>> +		ret = ads1262_channel_get_scale(st, chan, val, val2);
> >>> +		if (ret)
> >>> +			return ret;
> >>> +
> >>> +		return IIO_VAL_INT_PLUS_NANO;
> >>> +	}
> >>> +
> >>> +	case IIO_CHAN_INFO_HARDWAREGAIN: {  
> >>
> >> There is only one other ADC that uses "hardwaregain". Usually, we just make
> >> scale writeable to control the gain. I don't remember what the rules for
> >> that attribute are. Using it for in_voltage is not documented in the ABI.  
> > 
> > I went with hardwaregain because the scale loses too many significant
> > digits at high gain. With the internal reference and gain = 1, the scale
> > is at 0.000001164; then at gain = 32, the scale is at 0.000000036.
> > 
> > In this case I expect users to just calculate the scale themselves based
> > on the hardwaregain. Is this acceptable? If not I'll go with
> > scale_available.  
> 
> I'm pretty sure there is a series floating around that has proposed
> adding new fixed-point IIO_VAL_* types that could be another solution.
> We'll see what Jonathan says about this too.

Yup. That series should allow for easy representation of very small values.

It's in my testing branch already (see iio.git on kernel.org)
and IIO_VAL_DECIMAL64_PICO for most extreme case.

HARDWAREGAIN doesn't seem appropriate here, so please do the really
small scales instead.

Thanks,

Jonathan

