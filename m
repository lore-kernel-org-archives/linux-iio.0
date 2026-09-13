Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFEB370D41;
	Sun, 13 Sep 2026 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319855; cv=none; b=GzBPua05ut0OUInUTgkKpj3uM1YMjGgRYDccB0KWIPetRJbwURHupOtrWwB0ocUNhRmJBmygXMPKpeuJZwsybupQJ4SFENCz//Z5IyPG5f4JwpxvMMGFqpMpHhdg8ZYLhY7t/Rch0lZkZLjceXLCYh2LXHmyWEdDxTAsjf4IoVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319855; c=relaxed/simple;
	bh=7Uycex3LCN1FJ1tpM3J6AmnYLXeePVEr5yT34cOEJKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nY5PrG3O1kxnm3N115AxbRXbEbAyOajEukqshoAADIvmBARvDvaPHhNkJz+7Qu8iwxv/wJQlBOWFUqk1bghnwQPe7vycXEYPJLfY8GBk6BXBkKPrdUUludVhAr2G4lHDerMB1UuzjAtLkMsukiFAfcQJnhdRHbf1bGYbisTKTPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P91RrsZ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P91RrsZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843A41F000FF;
	Sun, 13 Sep 2026 17:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319853;
	bh=dmnvs32wn3SFLDnQCJhlmy4+ncYr398rO2qSAaucqP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P91RrsZ824GmYPi26b8v+I9Gz9HwYsYUhvHgZjehDPS9bHMPsPQxaOtw7SiMDq2ZW
	 GQrw70/IeYZEVCdyHyPOQ/Wy7KSJ5W+uLA7tciG632NXQ117+TDpsRXohV7ukZ1xVK
	 vCWMpJFx+av/hmeQowuevYcWwFjyeGX+7Bho4mqJ8rnHrjHXuiAxC69bNNvKHD2lGR
	 SzJfREIZr8dYNgbbxlqo49w+bbQ0jjkYaaonx3O42pQvGiOK5VMb3nZMxV0GAwolQ9
	 ACxRRRYXjBnzqKIag3DvaqU8sHA3UAh6lha3K9TpozB/EB4cMxakPnEoNZxFngmsx3
	 VkmCUQSgMVZZg==
Date: Sun, 13 Sep 2026 18:17:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Shi Hao <i.shihao.999@gmail.com>, "Jose A.
 Perez de Azpillaga" <azpijr@gmail.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <20260913181726.0e29c865@jic23-hlaptop>
In-Reply-To: <aqYiWwIkP1HQtRrk@gmail.com>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
	<20260912013912.51887-3-marcus.yu.56@gmail.com>
	<20260913034714.2fa2fcb5@jic23-hlaptop>
	<aqYiWwIkP1HQtRrk@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 21:11:07 -0700
Chang Yu <marcus.yu.56@gmail.com> wrote:

> On Sun, Sep 13, 2026 at 03:47:14AM +0100, Jonathan Cameron wrote:
> > On Fri, 11 Sep 2026 18:39:12 -0700
> > Chang Yu <marcus.yu.56@gmail.com> wrote:  
> > > +static int as7343_read_raw(struct iio_dev *indio_dev,
> > > +			   struct iio_chan_spec const *chan,
> > > +			   int *val, int *val2, long mask)
> > > +{
> > > +	struct as7343_data *data = iio_priv(indio_dev);
> > > +	unsigned int unused;
> > > +	struct regmap *map;  
> > 	struct regmap *map = data->regmap;
> > 	struct device *dev = regmap_get_device(map);
> > 
> > Neither is checked so no point in waiting until a few lines
> > later to initialize them.
> >   
> 
> I was trying to preserve the reverse christmas tree order and
> was unsure how the rules apply here. Is the following OK:
> 
>   struct as7343_data *data = iio_priv(indio_dev);
>   struct regmap *map = data->regmap;
>   struct device *dev = regmap_get_device(map);
> 
No line break
>   struct device *dev;
>   __le16 result;
>   int ret;

Yes this is fine.  Reverse xmas tree is just for when there are no
dependencies.

> 
> > ...  
> > > +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_RAW: {
> > > +		/* Wait until integration time passes for all 3 cycles. */
> > > +		msleep(160);
> > > +
> > > +		/*
> > > +		 * Reading ASTATUS latches all data registers to this read.
> > > +		 * We don't care about the returned saturation/gain status for
> > > +		 * now.  
> > 
> > Why do we care given only reading one channel and...
> >   
> > > +		 */
> > > +		guard(mutex)(&data->mutex);
> > > +		ret = regmap_read(map, AS7343_ASTATUS, &unused);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		ret = regmap_bulk_read(map, chan->address,  
> > .. it seems that if you read the low byte first (as this does) it is latched anyway.
> > There is a statement about this in the i2c intro part section 9.
> > 
> > so we get a consistent register pair.  Thus not needing the latch astatus
> > gives us.
> > With that in place reads can't stomp on each other as only
> > one regmap read is required, so the mutex isn't needed either.
> > It may be necessary once you add more features - hard to tell yet.
> >   
> When testing on hardware I discovered, for whatever reason, register
> values for other channels won't refresh unless I read ASTATUS or the
> FZ channel first. The only thing I can find in the datasheet pertaining
> to this is 10.2.7 page 41.
> 
> "Reading the ASTATUS register (0x94) latches all 36 spectral data bytes
> to that status read. Reading these bytes consecutively (0x94 to 0xB8)
> ensures that the data is concurrent."
> 
> My most charitable interpretation is that by "latches" they also mean
> "updates". I have no idea why reading FZ also works though. Could be
> a hardware bug since ASTATUS (0x94) and FZ DATA_0_L (0x95) are next
> to each other.
It is curious as if they are latched anyway what is the text about latching
if read from lower byte about.  Who knows!  This is definitely a less
than ideal datasheet but I don't think we have anyone active currently
upstream who works for AMS.

Jonathan


