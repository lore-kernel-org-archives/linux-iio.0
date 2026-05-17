Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B0135C1A6;
	Sun, 17 May 2026 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779018638; cv=none; b=ZlpAILy11jhvtDFkMDkYjCKGxwngHxBnkZmmFBItLSdiB8S3Iw/dFtwS1PDPWdZFwXWkRL2pFBv5aLzw1X2mFZjx36g7Z3CisAtqd+rsL5afokwz5CL2AMto688m6Rk+C7xWJ7RGRtZnnr+a780D0MfHywxsQWCFmmYFcLyF3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779018638; c=relaxed/simple;
	bh=V5vESRkTHrLGwYdUEZeADW1gPFwePL/yONSoXT7tIDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4w3I+2G/wEO0vpk8G4fbDt261sYUL68CXhHTDYeVEqlyBu+zX6lLGtXNnHtYEWDkdjHhHBiEYqX13yvLDNMHJkCAanItO/GhMtoq7sQBqeLBhUjdmJ1it4NxIfdXp0L1RYw2910sTAXj1ZSl4329Hyk2sB2DeoCr/ADHEjcKMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsavGW8A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsavGW8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E31C2BCB0;
	Sun, 17 May 2026 11:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779018637;
	bh=V5vESRkTHrLGwYdUEZeADW1gPFwePL/yONSoXT7tIDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GsavGW8Axkv8Q4Rt46SvmegpriigAL3R265puuka1mdG9JEF/XgFcM91ZO4Yn6kbv
	 Ti+KY8zp+Y2X00DdH1GFjB8U45cGnWAG73uuGxG6h0EWFsNexRLHwPNaJ7L6DlJdEp
	 GrLPUu+1Qa41MjHqNymD5+kRXW5nsi0R029qP3UN7fo/VMyQdlNfuPYu9GpZvW5hkC
	 WfkIFrBH4i/tuggfOtlhVad571TsxBjZgXKSwlRDJNofBbLuTx30bcetHp7btGeAG8
	 CH9dgR55QEE9qVEAgEuFKZxVuGfuQPnN9Pgkt7Lm6I2LidAobKEcKsrw1DL3L2gTxZ
	 WiyRNaeJMPOLA==
Date: Sun, 17 May 2026 12:50:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v11 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <20260517125024.1bade029@jic23-huawei>
In-Reply-To: <0696b662-f478-4d1a-95e0-0338bbdb719e@baylibre.com>
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
	<20260515-ad4692-multichannel-sar-adc-driver-v11-2-eab27d852ac2@analog.com>
	<0696b662-f478-4d1a-95e0-0338bbdb719e@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 May 2026 12:11:16 -0500
David Lechner <dlechner@baylibre.com> wrote:

> > +static int ad4691_probe(struct spi_device *spi)
> > +{
> > +	struct device *dev = &spi->dev;
> > +	struct iio_dev *indio_dev;
> > +	struct ad4691_state *st;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st = iio_priv(indio_dev);
> > +	st->info = spi_get_device_match_data(spi);
> > +	if (!st->info)
> > +		return -ENODEV;  
> 
> We've recently standardized on not checking return value
> of spi_get_device_match_data().

There is a wrinkle in that plan.  It's still possible to bind these
drivers to a different ID via driver_override and that will land
us in a NULL dereference.

Until we've closed that out (Andy and others are working on it)
we should probably keep these in.   Once that's in place we can
cycle back to clean them out + potentially backport that feature
to ensure drivers that are currently not checking are fine.



> 
> > +
> > +	ret = devm_mutex_init(dev, &st->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->regmap = devm_regmap_init(dev, NULL, spi, &ad4691_regmap_config);
> > +	if (IS_ERR(st->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> > +				     "Failed to initialize regmap\n");
> > +
> > +	ret = ad4691_regulator_setup(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad4691_reset(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad4691_config(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->name = st->info->name;
> > +	indio_dev->info = &ad4691_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	indio_dev->channels = st->info->sw_info->channels;
> > +	indio_dev->num_channels = st->info->sw_info->num_channels;
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}

