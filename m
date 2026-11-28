Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795838566;
	b=QvX8nLqYcLhKoRk9eduFxuv1OMZpC8GFRGkgY2CARuN3Oq16qlL+4TTvpv9DneDujk9e
	 oX2csgssW3de8ZVUE98dmG6LcvowCuWnh8RC5jgeoTbgNMYQOA0YOSFaMFZhAMeC3Vn2H
	 dv+IJGNuuOQdej24PM/7W1xidiwWUESS/yMM+XgzW6KAgOuyOTA5CLhcDD3YkfsmOO3iw
	 Gcp+5uv6ThG+9+fBEziyBaM+I2sy13Cy8+4oedQS0PUt44XzEzC513LgZ+NB3Eaavvd0J
	 Q8IcwpVRlhV1+XBdPByxDQGgpVYw1YcaHz5LktA6Sp6AtlBG1Bl9KTXYDPFegvj7lzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795838566;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lL67QpjIVLrhBwIVxCrZcbSnY3SDt6gcSgX5YAl/A5Y=;
	b=pO9VoTlq5JH2CV1OMomjvCkZC2ptTIGx0G0qo+VY4zutYG8gg/hzDe3HuTUVX2tSjcfZ
	 iyfqPNceHtrHQoX0bA6BARm76oKYsOogFlyoJlpnY4Ug656ZDmDdBklhmeaLNI66yqLg2
	 Zaky2spY+b8oargeda/ISFSDOIpQNcTc7EOrrZqr6bI0b9gWdBBo3gIs9luQJUQW8jVzQ
	 VP7EVg2FSr2ehDJpGQIOMxbwGw1W+dL8ZfdXTc57h9Sh14ipXTJqxvZ1rjUQBhLGu1Uo0
	 PdfMkMUjqFsDywEDsZAhzfXDb39mLGCSZiMBiMbm284DhpRIBOlxI30IL/HSiS0nnyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N6MU/lik";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A43F606A31C;
	Sat, 28 Nov 2026 04:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6MU/lik
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFD81F000C1;
	Sat, 28 Nov 2026 04:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795838566;
	bh=lL67QpjIVLrhBwIVxCrZcbSnY3SDt6gcSgX5YAl/A5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N6MU/likB5C2Qo0gvPJX4f+DJEaafNXS/W32PK2q80ORleQ46qIklS6UVqFMk7f9E
	 Xlnhndz68cWPd0G7+pdSkECxiQ1k9x/AttEUFw8+739DK+2V8kdcZOf4SMimoM7rcK
	 NK6JxBQ2yvTtoJFgyaJKSv/KYiu0eq2p5x8xj7COgVA6W8fcKP2r/qMqClZN06w1Y3
	 hdxIY7UMh+h6HGaC//mmigzdxMniOo4BdscZD0CCb4K+whO2CnY+Ngh1oCu3hkxA2i
	 ZdARg9vJWxVr1fA49zFevOebEBLPa4ORXfpWZcdhEMr1VLK8soQOKgGUfznW04qokh
	 Ms2ACc7K5bF4Q==
Date: Sat, 28 Nov 2026 04:02:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Vaibhav Chahar <vaibhav.chahar26@gmail.com>, Marius Cristea
 <marius.cristea@microchip.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: palmas_gpadc: Use guard(mutex) to
 manage locks
Message-ID: <20261128040241.00305137@jic23-hlaptop>
In-Reply-To: <0a01f11c-86d3-437d-977f-dd5978542b86@kernel.org>
References: <20261126114433.20674-1-vaibhav.chahar26@gmail.com>
	<20261126114433.20674-3-vaibhav.chahar26@gmail.com>
	<0a01f11c-86d3-437d-977f-dd5978542b86@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Nov 2026 14:26:21 +0100

> >  static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
> > @@ -739,19 +725,18 @@ static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
> >  {
> >  	struct palmas_gpadc *adc = iio_priv(indio_dev);
> >  	int adc_chan = chan->channel;
> > -	int old;
> > -	int ret;
> >  
> >  	if (adc_chan >= PALMAS_ADC_CH_MAX || type != IIO_EV_TYPE_THRESH)
> >  		return -EINVAL;
> >  
> > -	mutex_lock(&adc->lock);
> > +	guard(mutex)(&adc->lock);
> > +
> >  	switch (info) {
> > -	case IIO_EV_INFO_VALUE:
> > -		if (val < 0 || val > 0xFFF) {
> > -			ret = -EINVAL;
> > -			goto out_unlock;
> > -		}
> > +	case IIO_EV_INFO_VALUE: {
> > +		int old;
> > +
> > +		if (val < 0 || val > 0xFFF)
> > +			return -EINVAL;  
> 
> Not introduced by this patch (I sound like Sashiko :) ), but -ERANGE is preferred.
> 
> This could be tweaked whilst applying though.
Backlog too large for this sort of thing today.

So will leave it for now. 

Series applied to the testing branch of iio.git.

Thanks,

Jonathan

> 

