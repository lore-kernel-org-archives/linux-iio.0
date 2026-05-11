Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D3A42B736;
	Mon, 11 May 2026 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515604; cv=none; b=ika6fa173cL1eB9MxJSPLf0GN8MNG7llDywZKSn8r1nbpQzvnwUJCscsC9OyVQsR9O/Zra+3YstYzQ419qxwQYihNuqe03ezVV2zVhQGe5f3CbY6BkSPudpAOXn3Ez3v0ML0q611+GpERevnKlMsILMGohatIsH/1K3nrmBbpZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515604; c=relaxed/simple;
	bh=MFu5kyNHAjvhRdKnpSg4dwGBGsjHQSJa6B+mXY5NfBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqAHNGKDCTl9ivXAr9rebaS0Y6ndGaAXFewcuraZ9VfMcQJVg9x4blQwjU9cc+OmvqoH488TdUqcdbnZr8wLziTiew4IwYLHov4azp4d9EWUBqkjjYqiDrPzL81XbZWWImi9+lXhWXRJXWvUX/4P7uGssy30UyO8q0OZjSNqCZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odtiOl86; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odtiOl86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8A3C2BCF5;
	Mon, 11 May 2026 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778515604;
	bh=MFu5kyNHAjvhRdKnpSg4dwGBGsjHQSJa6B+mXY5NfBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=odtiOl86rA1tvN7Xa9l2YvaYh9kt90TtESzaoEgTF0F6hSLARQ945LhWZZKvZwVix
	 g9A5L5BY5V+5oQ+MhfWJLbXIajbMwgDk0qsSI7Rf3DEBd0e47dCVMFsTAyMHOMDBZD
	 cRcgZxrnvTFf15zsFzUr8ueIBlE+oQ0MTMIoA2C+pLt0YkqGMw62nAHvccWGLHlZG8
	 HiKoali05KCMCq0rT6H5/5669GmWHFZvg0iqkrsp2krFyr0J02Mf+IkZAvvlrDxpZ5
	 iWrGzZtpyQJin7+nGeiYJqGR7OVCiVh4F8sbn0nZUPurmioIUWbch7zkqDSnw0+vx5
	 aeBudWMsIkz3g==
Date: Mon, 11 May 2026 17:06:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, mike.looijmans@topic.nl, nuno.sa@analog.com,
 andy@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH v4 3/3] iio: adc: ti-ads1298: Remove unnecessary CONFIG2
 write during init
Message-ID: <20260511170635.4dd3fdc9@jic23-huawei>
In-Reply-To: <7ff89e1f-f5ef-461c-83af-18360ad5dab0@baylibre.com>
References: <20260509151959.3475-1-shofiqtest@gmail.com>
	<20260509151959.3475-4-shofiqtest@gmail.com>
	<7ff89e1f-f5ef-461c-83af-18360ad5dab0@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 May 2026 15:36:19 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/9/26 10:19 AM, Md Shofiqul Islam wrote:
> > The driver was enabling the internal test signal (INT_TEST), double
> > amplitude (TEST_AMP), and fast frequency (TEST_FREQ_FAST) bits in
> > CONFIG2 during initialization. These bits activate an internal square
> > wave generator intended for device testing and calibration, not normal
> > ECG operation.
> > 
> > CONFIG2 defaults to having only the RESERVED bit set after reset, which
> > is the correct value for normal operation. Remove the write entirely
> > since it would just be writing the reset default value.
> > 
> > Suggested-by: Mike Looijmans <mike.looijmans@topic.nl>
> > Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> > ---
> >  drivers/iio/adc/ti-ads1298.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> > index 186bda3087..8957e873e1 100644
> > --- a/drivers/iio/adc/ti-ads1298.c
> > +++ b/drivers/iio/adc/ti-ads1298.c
> > @@ -615,15 +615,6 @@ static int ads1298_init(struct iio_dev *indio_dev)
> >  	if (!indio_dev->name)
> >  		return -ENOMEM;
> >  
> > -	/* Enable internal test signal, double amplitude, double frequency */  
> 
> This is why comments should say why and not what. If the original author
> had a plan for this, we don't know what it was.
> 
Mike, any recollection?

Anyhow I'm going to apply it anyway given Mike suggested it and fairly 
sure it was Mikes' code ;)

Applied.
> I look at the datasheet and the driver. Seems OK since the test signals
> aren't used anywhere in the driver right now. 
> 
> > -	ret = regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
> > -			   ADS1298_MASK_CONFIG2_RESERVED |
> > -			   ADS1298_MASK_CONFIG2_INT_TEST |
> > -			   ADS1298_MASK_CONFIG2_TEST_AMP |
> > -			   ADS1298_MASK_CONFIG2_TEST_FREQ_FAST);
> > -	if (ret)
> > -		return ret;
> > -
> >  	val = ADS1298_MASK_CONFIG3_RESERVED; /* Must write 1 always */
> >  	if (!priv->reg_vref) {
> >  		/* Enable internal reference */  
> 

