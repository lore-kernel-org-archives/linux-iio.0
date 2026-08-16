Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8FA3BE16E;
	Sun, 16 Aug 2026 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786905003; cv=none; b=UMfM5o4wAPypkHbuFd9oop9ENjtCxDo6N4FnoZ5xweO86EMsQvxcWdKEiwHmvUgwlOk9MWRmcIgC5oDRdnjAJMY7Uw+EwoKyuR344hZ1N+3yK/6etAz1OvuJoZQ8qbJ3HeqNrH5AN++K0+uhynaNtu5EdlSCLhjKOq7xYlC1330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786905003; c=relaxed/simple;
	bh=YBsNGaQjUZ6udcspzTFyrVrnx++wfVzaiqwjrGfc6rY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liR1/1KqqVGbO7CrYbTlXEJHHBkPcMRtQmJXdgteeuVTiX+G/4AZagO3XeDznbGZ5kI6K2mgS196bPAaFCmYnDWeTVBTnikma43pmh4A3JnCoQ1jPobDx/yArh7wN7UNqWcqadq9UHPM99yaM4mDOfKCHR8Y6j/woNVCewiw4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2Pg4Aj0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2Pg4Aj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EBD1F000E9;
	Sun, 16 Aug 2026 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786905000;
	bh=cWAN4ld+R8s9/E1GLH5plNepEOeHnrs1B5qaJx3BpVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C2Pg4Aj0p/DKGuAhOll5ChH7AaffVZT9QKZqI6NtmlIlJiXphd3DyI4W5jzrFjVz+
	 mV7fugw1Ql44lbgLzgDhhXtYKdFZP/CzvSanO9s0nbseJZyPPKESjUmdo12hGm6xNl
	 CHnOlbBUIsZv0R26eXBckej0sSc/1AeMQtQ9Bym6Ockdjq3c14ClD+1R+TA65NWVHZ
	 73uufEG3irooIWLKJjPr1e4BKka+NrCUd7brJD/ngmjqd9topNBw3RD1ldtUb/nT7G
	 Tn9oBRXXTCB6H2vDMESEROia5I421pGt/mRddp6QwvlsU/O/7rpUwDlZqoC4h3iH1l
	 NZX+v0JTkHlwA==
Date: Sun, 16 Aug 2026 19:29:53 +0100
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
Subject: Re: [PATCH v3 03/14] iio: adc: adi-axi-adc: Initialize state mutex
Message-ID: <20260816192953.38376b22@jic23-huawei>
In-Reply-To: <20260813-ad7768-driver-v3-3-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
	<20260813-ad7768-driver-v3-3-cb554399ad26@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:56:56 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> The AXI ADC register access paths serialize transactions with st->lock,
> but probe does not initialize it. Initialize the mutex before registering
> the backend.
> 
> Fixes: 7ecb8ee5c93b ("iio: adc: adi-axi-adc: support digital interface calibration")
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
Fixes come first.  In future move this up to start of series so it is
really obvious.

Given it's kind of critical, I'll apply it to the fixes-togreg branch now.

Note that branch won't go upstream until after rc1, but I think it won't
be too disruptive to have this series go through the slow togreg tree
in parallel with that.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/adi-axi-adc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 26b9c75bd4d8..b5e59b1871b6 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -684,6 +684,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
>  	if (!st)
>  		return -ENOMEM;
>  
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
>  	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> 

