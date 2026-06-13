Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A72D7D59;
	Sat, 13 Jun 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781359600; cv=none; b=NWzfU7x3A8s5L6I2ZzlR89/xiEeH7vsLL2D/WAh+MZB5jhSqSEprBGmRZnJUJv6EbRfT47+R9QImXwBIw6/BRmbsS4Cz0Y4AGA34Ur9gD7aPKLzZqW/29osKmsBR4W2XBPOMFk84EyFSvQRn6SdmSnYFCk7e9Gh6LPMdMvtapiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781359600; c=relaxed/simple;
	bh=XKfpxlRn1tTHF4IatoVwyeK78OYpu52Yx1NBvHFRFNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6kF0kU1ItKn4/e5dX7mNrG7HZw+M6PMU75uaxZ1LryAzvv1hWqTEvfAPjeEFIryZy6meccpf0dXMAORr4C5Vcs3pkA4oEpIDMXgWwqONzVxa9R/AI/ZsthYyXdEzrNJSHo7m+u44RKBSBifeVFuVR2N6YQNjpg+52zIhfVZT5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Apuxhaca; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Apuxhaca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAE71F000E9;
	Sat, 13 Jun 2026 14:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781359599;
	bh=+8bBAMX6vKJfF5EfKeHvtPhAZlrJ15UIYFCzm2FZ+gg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ApuxhacaqN7D7HW+gNshGd2ze4fnvIZjfiZCByRz56+/7ni4x59Z27usFgK11JeKX
	 bKcuOLjcFy4hS6WnrhMdpBpEvuQXFuagYtudg9xFF6YpgZqnus/l86OI7gph54FUJl
	 4qIHoRZLI8lDz16QMuSOAH89zfAS0yn2twmuRHr/gGgR7/hRiAta5S5uHjCL164yXW
	 GplrwjK6K8A84u123pWwuiVQM1uimDwn2yVmDSX6R0BeX7mqpQt6r4+lbk/MEeYjZR
	 Sxm2/09ruWnGVLaKe0MiIzh8+XzsmtjPKFusXKh2SOHOQtbMen8+a8VJLulUYBWIM3
	 oWJ4Nwh0/XsVA==
Date: Sat, 13 Jun 2026 15:06:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: adc: Add ti-ads1262 driver
Message-ID: <20260613150629.26914a16@jic23-huawei>
In-Reply-To: <20260613144544.0594a7f0@jic23-huawei>
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
	<20260612-ads126x-v1-2-894c788d03ed@gmail.com>
	<20260613144544.0594a7f0@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> > +static int ads1262_channel_hot_reload(struct ads1262 *st,
> > +				      const struct iio_chan_spec *chan)
> > +{
> > +	unsigned int weight;
> > +	unsigned long i;
> > +	int ret;
> > +
> > +	/*
> > +	 * Hot reloading is only required on buffer mode and if only one channel
> > +	 * is enabled.
> > +	 */
> > +	if (!iio_device_try_claim_buffer_mode(st->indio_dev))
> > +		return 0;  
> 
> Look at IIO_ACQUIRE_DIRECT_MODE()
obviously that comment is garbage  - so please ignore!

> 
> That should let you simplify the error paths in here.
> I see you used it elsewhere.
