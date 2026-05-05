Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5273E95A3;
	Tue,  5 May 2026 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997858; cv=none; b=ClhulN+uJ2ADp8qzuJrT0EtyPZNKv8Dl/5QhtUj+2JIsKh80DD48ELI3xsW5+XBR31rKR/Yg5tM/4EWqhm6bLJQ2PtVTwmh9rQMELiEveV+dkznkeAI/as3H+x9f84gi+Ptpd/oxYo9Hbfvi8behLHG2mMnh2De8sr9pG0BLsnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997858; c=relaxed/simple;
	bh=7M3AF7q+dZnICNvL/G6NPLScjPNthj9sH2v2XN2lfbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H+CFBoOwCojfsWdpwp7rRUn3PD0ji94k6thcnkQN9vqzbg7Ew1qxa/Bs+bz6KZVikKb3/qUXJ7i3jUggS/GFIxolFvYU+CihC3SNQpnCqh3h+LQSlJ7nvIlejoJvbuQsZenS25hJGLM7chiFbES1lneodPrIso2nWlsEJf7MTzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0eAoqAG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0eAoqAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDB0C2BCB4;
	Tue,  5 May 2026 16:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777997857;
	bh=7M3AF7q+dZnICNvL/G6NPLScjPNthj9sH2v2XN2lfbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b0eAoqAG4aFxn51HZEQ2sKQOfZGxQAk+IaGrUL6jDsOf/I6HU52o0IlfrhmLHW8fu
	 IQbyqNRG7D1HQVBqvgi7eo9EKRXogixw1YNLNmmd6ufrD0xsVQ1zuw5P+TOzY2p7Ep
	 j706/5ZxTByy2r+79h/Hwii9H0Wbpjj8Gi6dXGsOCBFvSdctNQ5a1BrNkE7JuhegmZ
	 BrAKOj5oaW6Z2kQurwnnCOiwIGx0oYITLCQAGbmy7ZkMPzXYsOGsg0eXblJrKL5vDc
	 JnY9splxPxjFlRcITMSDL8cRP7jJGINo2ORpzD9TqPoO3oEYWHCjxG+2HLE81yZWyR
	 uPZCrkk8bmLfA==
Date: Tue, 5 May 2026 17:17:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
 <linux-pwm@vger.kernel.org>, "linux-gpio@vger.kernel.org"
 <linux-gpio@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v9 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260505171723.390feb20@jic23-huawei>
In-Reply-To: <afoFjaUBcGXeuEzH@ashevche-desk.local>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
	<20260430-ad4692-multichannel-sar-adc-driver-v9-3-33e439e4fb87@analog.com>
	<afhReLCsEdaEOT_H@ashevche-desk.local>
	<LV9PR03MB841441B282275F8F36FD12C1F7312@LV9PR03MB8414.namprd03.prod.outlook.com>
	<20260505142640.49cde0ca@jic23-huawei>
	<afoFjaUBcGXeuEzH@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 May 2026 17:58:21 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, May 05, 2026 at 02:26:40PM +0100, Jonathan Cameron wrote:
> 
> ...
> 
> > > > > +	for (i = 0; i < ARRAY_SIZE(ad4691_gp_names); i++) {
> > > > > +		irq = fwnode_irq_get_byname(dev_fwnode(dev),
> > > > > +					    ad4691_gp_names[i]);
> > > > > +		if (irq > 0)
> > > > > +			break;    
> > > > 
> > > > This is problematic in case the above returns EPROBE_DEFER. Can you confirm
> > > > it
> > > > may not ever happen? (Note, I don't know the answer.)  
> > > 
> > > You are right, thanks for this!  
> > I'm missing something. Why is that a problem?  Driver will return
> > the error and a dev_err_probe() is used so it won't print anything.
> > So probe will fail which is exactly what we want.  
> 
> If there are two IRQs and the first one is probe deferred and second returns
> an error, we return that error instead of the deferral probe.
> 
> May be I missed something, but I have no idea how in this case it may return
> the first error code in such a case.
Ah. Indeed. I completely misread the code.  if (irq) would do the job to fix this.
J
> 

