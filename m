Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AE928690;
	Thu, 10 Sep 2026 02:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789008191; cv=none; b=gGkMFBCL/fJapoG9GcWQduyUWnWJ/9fszx/42eDNl49UpV0R9XIdfuh/kyUDF1AQtcLQqk1ra6CCR86d/rsmyn+hRmjrSqd7Xzq98ZRME4r9VK3BkAb5CPw4DmT/gaQHSL641u/1YlW/aXocr8zXsa4WSceGxppncPuGvw//NGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789008191; c=relaxed/simple;
	bh=fKf/QBb+LITuiHPZXp3Qro9ZwEB/0+3+XQLVHfk/Ero=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebS6BTodlq07D/s7h2qkn140baavA2JNE3VOwxxuazElYqLACsWTzYtimjZ8ZmVuPsRRzBK2jsQbWLGvE//7SNGgIsFf5jk5cgh8c2oiGuSH6EV9lW8klEaNRqenIhnQYuggHsFc3KneIR8w4AKozPSKasRIXKJfNXEnkHPTtGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYxInFyx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYxInFyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681EF1F000FF;
	Thu, 10 Sep 2026 02:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789008190;
	bh=3gut7UUTC5vjMT8I1hinUrwudxv9IOPVa99ZXCw9dDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PYxInFyxvkNTA6/xxrJrjRWfIm0RSfGqN5voJYrM1AIdk6x3jmwVP6M3Mj9tgdj3O
	 gQ17SN0V0yBej42OpBea56DJr9YbiHmhBmqgeJjMbKIh7dNsqCmJtTBrXVXtl81S1Z
	 Z5n/03a1nlmZJeubq4ododH03kIce8f60Smzq/ETgROlgEIsUACtGUNEcLOYxtQCO4
	 fFBg4g64UTbocYqX/zNbyobv/V2D/x2OWG4rgNsGTjBhtHXPRVllZF96M5gxyb66Ap
	 f9hVgAq+xdBGeWianou6I4yJUuYxhnKXwAjpPGriTyEHU/RDEbjqTnniEP1sORCFyt
	 IBkCiPBL+hMUg==
Date: Thu, 10 Sep 2026 03:43:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Kurt Borja" <kuurtb@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/10] iio: adc: add the ti-ads1262 driver
Message-ID: <20260910034305.7ac409ca@jic23-hlaptop>
In-Reply-To: <DL8IE3OUIUZ4.2SND39L7P03VL@gmail.com>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
	<20260828-ads126x-v4-3-1dc27e9c0260@gmail.com>
	<bc00d888-9944-4a22-88e3-8f4d7384d037@baylibre.com>
	<DL8IE3OUIUZ4.2SND39L7P03VL@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


...

> >> +static int ads1262_fwnode_xlate(struct iio_dev *indio_dev,
> >> +				const struct fwnode_reference_args *iiospec)
> >> +{
> >> +	/* REVISIT: the auxiliary ADC (ADC2) is currently not supported */
> >> +	if (iiospec->nargs > 1 && iiospec->args[1])
> >> +		return -EINVAL;
> >> +
> >> +	if (!iiospec->nargs)
> >> +		return 0;
> >> +
> >> +	for (unsigned int i = 0; i < indio_dev->num_channels; i++) {  
> >
> > Won't this include the timestamp channel?  
> 
> Yes, I'll fix it.
> 
> >  
> >> +		if (indio_dev->channels[i].address == iiospec->args[0])  
> >
> > I don't think .address is the right thing to use here (it is coming from
> > reg in the devcietree). I would expect channel. Otherwise consumers in the
> > devicetree have to be away of how channels were assigned rather than picking
> > the datasheet channel number.  
> 
> I was very confused about what approach should I take here. All channels
> in this chip are actually differential. In that case should I make
> #io-channel-cells = 3 i.e. positive, negative and ADC?

Yes. Given the flexibility that makes sense.
You would need to sanity check the channel is actually present that
matches those choices though.

> 
> >
> > And the devicetree bindings should mention the monitor channel numbers (11 - 14).
> >  
> >> +			return i;
> >> +	}
> >> +
> >> +	return -EINVAL;
> >> +}
> >> +  
> >
> > ...

