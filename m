Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB74367B99;
	Sun, 21 Jun 2026 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782052901; cv=none; b=gP34jhoEN0GZ/K/rf6vNfGv3UBpw2fnMXJiZ87UUTy0vtkNeQcoyGXTs+akCKqV9p4EhUDyxpSe5XvvUVfK7IRKrnQOJPIIfkltNO7z7EitQTDj4lugQqeiMP0k4RRFUojYi+M6aOUeq0h9eP//bA7UYvJ1M84i1od64kg1zPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782052901; c=relaxed/simple;
	bh=yp+sIk9yALlIj+VKcGTGTjpa0RdGNUGktVaWhU6eVRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUr5o+5D8tuJTxrD2Yc8ALEgAJn23gyieV+SuandJmpw9Y/pmMzQxQiXN6PC3ji+WvFeqEbnJ6cZWYHDOclMa991oVfUxH2nShcb+41Z3z9a4F/YpWyphYIVjTiVdk9wsKJBlHo5Rga6zewWOahnf6JXxSi5OWspI7P8dg0dFtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8dVECjk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8dVECjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09281F000E9;
	Sun, 21 Jun 2026 14:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782052900;
	bh=F5LbvTecvbBdJ9yzQfjwuA/kQDxTfBSlE2s6Wv6K5ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n8dVECjknZCRt5ioje01CDUjJZHK/NPbTS4c1iChn/yh6be7FTCLJBc7nX+SGp0WL
	 Vmzdj6FawrC2GtFhiDJ5g4zkXV3T10KAelORUB9LF92Td+4BDKPDQS+UU0NR0Zrbs5
	 jAHFMYAs9U62ZDRr6j3X248U5jNbo3moIgU8kAECplGXp02ykPJNK5K2y/kcyEoS8i
	 aYxFp+xRrPzs2Tjczi75DY+zksDW89MCSkDD8UKvPodKNS0MtWN15eJXvNMQwFPI0T
	 kLTXlSLEZ3/kRt2qMsRqM8ytpj5wXhexRFavbHaIizgtIiFFSp6eX+lKQwRESklD+t
	 sC9GQbFbSUcCw==
Date: Sun, 21 Jun 2026 15:41:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Kurt Borja" <kuurtb@gmail.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Linus Walleij"
 <linusw@kernel.org>, "Bartosz Golaszewski" <brgl@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 5/5] iio: adc: Add ti-ads1263-adc2 driver
Message-ID: <20260621154129.30cf7d94@jic23-huawei>
In-Reply-To: <DJ92CLJIJ04T.3HSUHGGSF8EPG@gmail.com>
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
	<20260612-ads126x-v1-5-894c788d03ed@gmail.com>
	<20260613151047.57cd074f@jic23-huawei>
	<DJ92CLJIJ04T.3HSUHGGSF8EPG@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 15:43:49 -0500
"Kurt Borja" <kuurtb@gmail.com> wrote:

> On Sat Jun 13, 2026 at 9:10 AM -05, Jonathan Cameron wrote:
> > On Fri, 12 Jun 2026 17:46:23 -0500
> > Kurt Borja <kuurtb@gmail.com> wrote:
> >  
> >> The TI ADS1263 includes an auxiliary, 24-bit, delta-sigma ADC (ADC2).
> >> ADC2 operation is independent of ADC1, with independent selections of
> >> input channel, reference voltage, sample rate, and channel gain
> >> 
> >> Add support for this ADC as an independent IIO device, through the
> >> auxiliary bus API.  
> >
> > A few things inline.
> >  
> >> 
> >> Signed-off-by: Kurt Borja <kuurtb@gmail.com>  
> >  
> >> diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
> >> index b33505e7fdc7..1a4b2f934d43 100644
> >> --- a/drivers/iio/adc/ti-ads1262.c
> >> +++ b/drivers/iio/adc/ti-ads1262.c  
> >  
> >> +static int ads1262_aux_device_setup(struct ads1262 *st)
> >> +{
> >> +	struct device *dev = &st->spi->dev;
> >> +	struct ads1263_adc2_channel *chans;
> >> +	struct auxiliary_device *adev;
> >> +	struct ads1263_adc2_ctx *ctx;
> >> +	struct fwnode_handle *node;
> >> +	int id, ret;
> >> +
> >> +	node = device_get_named_child_node(dev, "adc");
> >> +	if (!node)
> >> +		return 0;
> >> +
> >> +	ctx = kzalloc_obj(*ctx);
> >> +	if (!ctx) {
> >> +		ret = -ENOMEM;
> >> +		goto out_node_put;
> >> +	}
> >> +
> >> +	id = ida_alloc(&ads1262_ida, GFP_KERNEL);
> >> +	if (id < 0) {
> >> +		ret = id;
> >> +		goto out_free_adc2;
> >> +	}
> >> +
> >> +	chans = kcalloc(st->num_channels, sizeof(*chans), GFP_KERNEL);
> >> +	if (!chans) {
> >> +		ret = -ENOMEM;
> >> +		goto out_free_id;
> >> +	}
> >> +
> >> +	for (unsigned int i = 0; i < st->num_channels; i++) {
> >> +		chans[i].negative_input = st->channels[i].negative_input;
> >> +		chans[i].positive_input = st->channels[i].positive_input;
> >> +	}
> >> +
> >> +	ctx->chip = st;
> >> +	ctx->num_channels = st->num_channels;
> >> +	ctx->channels = chans;
> >> +	ctx->enable = ads1263_adc2_enable;
> >> +	ctx->start = ads1263_adc2_start;
> >> +	ctx->stop = ads1263_adc2_stop;
> >> +	ctx->read = ads1263_adc2_read;
> >> +	mutex_init(&ctx->chan_lock);  
> > devm_mutex_init()  
> 
> I actually call mutex_destroy() on device .release.
> 
> I think it makes more sense that way, otherwise we would UAF?
It does indeed make more sense there.

Whether it ends up as a UAF will depend on how the mutex is used.
I 'think' you are fine either way because it is always in an
IIO callback which depending on call path is ether from sysfs
removed in the devm_iio_device_unregister() path or gated on
the iio_dev->info being set to NULL for in kernel users.

Handing over lifetime ownership to the device is absolutely fine
and a bit easier to reason about so ok to leave it like this.


> > 	},
> >  
> >> +	{ }
> >> +};
> >> +MODULE_DEVICE_TABLE(auxiliary, ads1263_adc2_auxiliary_match);  
> 
> Thanks for your feedback, Jonathan! Apologies if this version was a
> little rough... I'm a bit embarrased by the bugs found by Sashiko.
> 
Lol. We all have that problem - sometimes it is irritatingly good
at spotting silly mistakes ;)

