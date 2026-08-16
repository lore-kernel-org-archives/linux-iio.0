Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148AA3C7DEB;
	Sun, 16 Aug 2026 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786908954; cv=none; b=t3Wqlly44NbujuqROXVD/weJfaR/DKo/sRU9gkV0cT4I3iNuFGbOZlb/Tvf10oHpFz5GwUSR485uPOVzqNLDKyC874SH/kZox+OqhcGTQOd4nftXxFkzHBJPej0sG4/6R02PvuteDqI1XN1kKWcdsaLzUKnCt3sug187mkYfgKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786908954; c=relaxed/simple;
	bh=8hafBoy1jffPLboPg5OQ3zOOPTP/Dy/lJjzMQ+YJGwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxkUv0qRjIco31J9DKIvDf0SxFZ9Fy8OgYH3O4Sm4y5tpy9rMExOOetFy+F2ETBHwxb55R2cBpweJHqb3sRYy35dqb8bvaxzl/MgHpS0z4fJKHv/LdmPjJlDbame3e57GYpZaLSkphsCWWNrgoQssA8OTpZQ3xVuJJMTnvh3tNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+CpICr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+CpICr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2EC1F000E9;
	Sun, 16 Aug 2026 19:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786908952;
	bh=26LqJlarwP4xeCZaBJJbcUGO6FGjU2dAZv1ce830BDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C+CpICr7NXb/EOkmzjcGThO+r7IeXK7lko+/ubm97dwVE91R1ufjK+zJG13ddwJTO
	 ITh5mwRjT93EFa0j8XI/wEMiN2RyMTRj2AMZTQEZpjl1sMJSuTD/iYESn56lvI5tqA
	 UKdOJvfDrdeF4kaNKayiGSWQw6bRZNvbU3sNmz52Lrlt51YCdnaPJ3oT2FEQfZk/TJ
	 QB1OmvAb4zBjPtUYLlCdl+iOdjVgYsqajJZVjzXued4ZZy6HC61pMpoj/dbjco/dpO
	 4cZGZk+mX8LuEuF4ZJtpxvfiRJgMxUHZEPw2IuF2KHNAHXaIAGwrAuh6tJZL+NagwY
	 om9ixjhNbKUKg==
Date: Sun, 16 Aug 2026 20:35:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <jananisunil.dev@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v3 06/14] iio: adc: ad7768: Add configurable sampling
 modes
Message-ID: <20260816203546.6a83fcd8@jic23-huawei>
In-Reply-To: <20260813-ad7768-driver-v3-6-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
	<20260813-ad7768-driver-v3-6-cb554399ad26@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:56:59 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Derive the available output data rates from MCLK and expose per-channel
> sampling frequency and filter controls.
> 
> Select the fastest compatible power mode for the enabled channels and
> map matching sampling frequency and filter combinations onto the two
> hardware channel profiles. Configure the data clock divider and wait for
> the selected filters to settle before capture.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

A few things inline,

thanks,

Jonathan


> +static int ad7768_find_matching_mode(const bool *mode_used,
> +				     const unsigned int *mode_freq,
> +				     const enum ad7768_filter_type *mode_filter,
> +				     unsigned int freq,
> +				     enum ad7768_filter_type filter)
> +{
> +	unsigned int mode;
> +
> +	for (mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
	for (unsigned int mode = 0; ...

Look for other remaining cases of this as reviewers may only comment
on a few and expect you to carry the feedback through the whole series.

> +		if (!mode_used[mode] ||
> +		    (mode_freq[mode] == freq && mode_filter[mode] == filter))
> +			return mode;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad7768_apply_channel_modes(struct iio_dev *indio_dev,
> +				      const unsigned long *scan_mask)
>  {
>  	struct ad7768_state *st = iio_priv(indio_dev);
> +	unsigned int mode_freq[AD7768_NUM_CHANNEL_MODES];
> +	enum ad7768_filter_type mode_filter[AD7768_NUM_CHANNEL_MODES];
> +	bool mode_used[AD7768_NUM_CHANNEL_MODES] = { };
>  	unsigned int channel_mask;
>  	unsigned int standby_mask;
> +	unsigned int max_freq = 0;
>  	unsigned int c;
> -	int ret;
> +	int mode, ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = ad7768_set_lowest_noise_mode(st, scan_mask);
> +	if (ret == -EINVAL)
> +		return dev_err_probe(regmap_get_device(st->regmap), ret,
> +				     "No power mode supports all enabled channel frequencies\n");
> +	if (ret)
> +		return ret;
>  
>  	channel_mask = ad7768_all_channels_mask(st);
>  	standby_mask = channel_mask;
> +
>  	for (c = 0; c < st->chip_info->num_channels; c++) {
> -		if (test_bit(c, scan_mask))
> -			standby_mask &= ~ad7768_channel_mask(st, c);
> +		unsigned int mask;
> +
> +		if (!test_bit(c, scan_mask))
> +			continue;

	for_each_set_bit()?

> +static int ad7768_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(regmap_get_device(st->regmap), pm);

Why the IF_ENABLED variant?  I'd expect the driver to work fine without
the runtime PM stuff being enabled. Normally that just means leaving the power
turned on in probe.  

> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	if (info == IIO_CHAN_INFO_SAMP_FREQ)
> +		return ad7768_set_sampling_freq(indio_dev, val, chan->channel);
> +
> +	return -EINVAL;
> +}
> +
> +static struct iio_chan_spec_ext_info ad7768_ext_info[] = {
> +	IIO_ENUM("filter_type", IIO_SEPARATE,
> +		 &ad7768_filter_types_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE, &ad7768_filter_types_enum),
> +	{}

	{ } is the style choice I'm trying to push through IIO.


> +};


