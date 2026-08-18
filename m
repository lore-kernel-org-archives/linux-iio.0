Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A7B23E325;
	Tue, 18 Aug 2026 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070001; cv=none; b=e7bbzjxLtTf2/48+87kM7C447sDySaJZhY8qeETmJIAbLdu8DKHqzwMNIYP7OhufrhWM0WTeKth5IZPSwcAVwlMGoNkReMQN3z5NNt0X9+qJi3gdMZAKeWPIXHfEbCTdsmGHN0JrOBkD/WfnmlELtrhxUAsf09hmgSt9xaoqHUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070001; c=relaxed/simple;
	bh=y5h6mK7CtKVKjkN4gt/lK4HUJe8D2dbsrnY6lN8l2e4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpff9MlKz7KEoRohwtb1cJXHeVhpMd9JfMEWdfeGNZPVcc2gFBK1TyzIKILMt9b+7uIczSgzQw2RUF/GA4hldtt4GLkGiQcbs5sxU3od6YU5bH3r8skldW/d15JGKyPwWkZhVohETlD4pr0tnBsxHBcGQTQqJddMthyzl1gpiQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sjo41oEG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sjo41oEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953D11F000E9;
	Tue, 18 Aug 2026 16:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787070000;
	bh=kl03MkweFlWLrXXQCCMxD8zBZf/qbyPepMg6LsXbjXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Sjo41oEGe9oBAQfe2/0u4q1RcX9d3sIyF9Dk+96lE1clmx8kGKoJuxe+ODVLtnUK7
	 qmU46z+a0WDI69xU5Z7EbTpr+KwohKcSZ1lYS0pZI/w+fYLkWUMiiCv0bYiR/aX2tv
	 GLbaYp0jtHbmRDpLlXcSJa5Spsbo+4rK6X9Hg2Y6V67o4xjKZ+0IsbVSslS5ozTdPh
	 N/6+oQRTMSkI7ND+7E6TOpB2LvZMR2R4v9zxmdPUWsTdlIq8NCqrrG2wgJCWKkcaWM
	 NFTTgxFWN+UFP4V09ytTqG2ok/zPabM4g9Blo4+ujTfAAy1YMPRUlZTTI2mYr/k/S4
	 VwPbMTKoHbCXw==
Date: Tue, 18 Aug 2026 17:19:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, siratul.islam@linux.dev,
 u.kleine-koenig@baylibre.com, linux@roeck-us.net, joshua.crofts1@gmail.com,
 ciprian.hegbeli@analog.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <20260818171953.4dd76b83@jic23-huawei>
In-Reply-To: <aoR94S2qknBVQrT3@ashevche-desk.local>
References: <20260818142928.8244-1-stefan.popa@analog.com>
	<20260818142928.8244-3-stefan.popa@analog.com>
	<aoR94S2qknBVQrT3@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> ...
> 
> > +static const struct iio_chan_spec max40080_channels[] = {
> > +	{
> > +		.type = IIO_CURRENT,
> > +		.indexed = 1,  
> 
> > +		.channel = 0,  
> 
> No need

True, but I'd keep it because it is paired with indexed and looking
for both together is common.

> 
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> > +		.info_mask_shared_by_all_available =
> > +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> > +	},
> > +	{
> > +		.type = IIO_VOLTAGE,
> > +		.indexed = 1,  
> 
> > +		.channel = 0,  
> 
> Same, it's default.
> 
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +				      BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> > +		.info_mask_shared_by_all_available =
> > +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> > +	},
> > +};  
