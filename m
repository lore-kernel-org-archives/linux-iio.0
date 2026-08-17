Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B42D7DFE;
	Mon, 17 Aug 2026 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786934224; cv=none; b=Bsk2+ZDfkbnaL9OawVMZ6hXsfPboLSdmUNLhl4ppKy4JF8LwerjIVpdJXgCwXwUqzgjv66ZdFXFN/om3+ryWe9E0fRvpR7XERwD7nUVqvkfdaJLEhAdRsX+NeDEpaUWzazoru7wZG0Jhh2GnDQkRrVGG812J9kDx60t+Sw4+Rrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786934224; c=relaxed/simple;
	bh=HqPCr4TOc4nJdRkL2mU5i3+UhAWftQDkt/6uHGtTWXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pLVhlEY1RjUd6SbgoyrxacehggjqZrGeHBqLjMgAqzSpE0uE6lRzCc553bPFo30PqfIu4OT4JVQIAP9nfaNEDxoBhvV0bZLyeN8ja+vhgO31KwxxpdtNVUTm/aT/6ypExgeR3Xa4sKblTfYTbDcM7MMHQUkATXWE2PRl4q4n2z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPHHPB7P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPHHPB7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0684B1F000E9;
	Mon, 17 Aug 2026 02:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786934222;
	bh=XPNqvSZxGeC64enPzL9Vkyy9pzKJ5fE+ts/fL+EuMQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MPHHPB7PMogL6POZYrIgFTBU7MDFBiy+wtqwhtjai+v8vSDg5YEralhPtm48F+nMH
	 CtWg36qPc5Rh0P/NyHWRhOeFGyMXeA2dqPeSitE0XSId+bP5BiEHAtT8mori3dw/qm
	 4V3tM4GC/rPiJ1SPys75vb5/J/0LhpnyxXRbSNa0jmVL9arrsWg+bhLaaoQnSMTCeL
	 FlLswmn1M7tDF3r2RkHKWxR165T0A28DuO7r1KW/eDFFN1xB2p9lWjQYh6yYdQp+/X
	 28SSZndfrXCjSjyiIwfQJB/UdUePEGTmqtRPnC7GYATztUIjpkcDrcb2qG4Z3TzGd/
	 Gr4X4L1lnPYdQ==
Date: Mon, 17 Aug 2026 03:36:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "David Lechner" <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/4] iio: light: veml6031x00: add support for events
 and trigger
Message-ID: <20260817033657.4767671f@jic23-huawei>
In-Reply-To: <DKNTPHF7K5G7.AJEIRCWO8FAM@gmail.com>
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
	<20260812-veml6031x00-v6-4-7eef6e4ce290@gmail.com>
	<20260813022436.41a28d64@jic23-huawei>
	<DKNTPHF7K5G7.AJEIRCWO8FAM@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 14:43:26 +0200
"Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:

> Hi Jonathan, thank you for your review to the series.
> 
> On Thu Aug 13, 2026 at 3:24 AM CEST, Jonathan Cameron wrote:
> > On Wed, 12 Aug 2026 22:27:43 +0200
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >  
> >> The device provides a shared interrupt line for to notify events and
> >> data ready, which can be used as a trigger. The interrupt line is not a
> >> requirement for the device to work. Implement variants for the cases
> >> whether the interrupt line is provided or not.
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >> @@ -549,11 +948,78 @@ static int veml6031x00_buffer_postdisable(struct iio_dev *iio)
> >>  	return 0;
> >>  }
> >>
> >> +static int veml6031x00_set_trigger_state(struct iio_trigger *trig, bool state)
> >> +{
> >> +	struct iio_dev *iio = iio_trigger_get_drvdata(trig);
> >> +	struct veml6031x00_data *data = iio_priv(iio);
> >> +	int ret;
> >> +
> >> +	guard(mutex)(&data->irq_lock);
> >> +
> >> +	if (state == data->trig_en)
> >> +		return 0;
> >> +
> >> +	ret = veml6031x00_set_interrupt(data, state);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* The AF bit must be updated before updating AF_TRIG */
> >> +	ret = regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
> >> +				 VEML6031X00_CONF0_AF,
> >> +				 FIELD_PREP(VEML6031X00_CONF0_AF, state));
> >> +	if (ret) {
> >> +		veml6031x00_set_interrupt(data, !state);
> >> +
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
> >> +				 VEML6031X00_CONF0_AF_TRIG,
> >> +				 FIELD_PREP(VEML6031X00_CONF0_AF_TRIG, state));
> >> +	if (ret) {
> >> +		regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
> >> +				   VEML6031X00_CONF0_AF,
> >> +				   FIELD_PREP(VEML6031X00_CONF0_AF, !state));
> >> +		veml6031x00_set_interrupt(data, !state);  
> >
> > This dance vs a goto is I guess due to the mutex.  I'd clean it up
> > by using a helper function for the stuff done under the guard(). The
> > helper can do goto based cleanup and avoid repetition plus reduce chance
> > of missing cleaning something up on error.  The outer function can
> > still use guard().
> >  
> 
> Yes, that was the reason why some code was duplicated. I will add a
> helper function with the __must_hold() annotation and
> lockdep_assert_held().
> 
> >> +
> >> +		return ret;
> >> +	}
> >> +
> >> +	data->trig_en = state;
> >> +
> >> +	return 0;
> >> +}  
> >  
> >>
> >> +static int veml6031x00_setup_irq(struct i2c_client *i2c, struct iio_dev *iio)
> >> +{
> >> +	struct veml6031x00_data *data = iio_priv(iio);
> >> +	struct device *dev = regmap_get_device(data->regmap);
> >> +	int ret;
> >> +
> >> +	data->trig = devm_iio_trigger_alloc(dev, "%s-drdy%d",
> >> +					    iio->name, iio_device_id(iio));
> >> +	if (!data->trig)
> >> +		return -ENOMEM;
> >> +
> >> +	data->trig->ops = &veml6031x00_trigger_ops;
> >> +	iio_trigger_set_drvdata(data->trig, iio);
> >> +
> >> +	ret = devm_iio_trigger_register(dev, data->trig);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	iio->trig = iio_trigger_get(data->trig);  
> >
> > Sashiko is correct that we loose a reference here on error and right now
> > there is no IIO core infrastructure to solve this
> >
> > Why are we setting a default trigger?   Userspace tools should be
> > fine looking for a data ready trigger, or choosing a different one if they
> > would prefer. Added advantage of not setting it here is the reference count
> > issue goes away :)
> >  
> 
> I will drop iio->trig = iio_trigger_get(data->trig) for v7.
> 
> I added it because it is (or at least, it was) a common practice in many IIO
> drivers to assign their own trigger, and in the end it is by far the most
> common use case. Of course, we're not going to touch existing drivers to
> remove that, but is it then something to be advised against in the future
> unless there is a good reason for it?

It makes sense if they also 'require' that trigger - but generally if 
a driver has dealt with the potential extra complexity of allowing other
triggers that is because they want to use them. As such a default has
no particular benefit.

I probably let a few defaults in over the years where this wasn't
the case though :(

Jonathan

> 
> Thanks and best regards,
> Javier

