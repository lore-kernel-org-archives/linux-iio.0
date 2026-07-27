Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4077429031;
	Mon, 27 Jul 2026 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187107; cv=none; b=na/SJwor4tM73Zk0AMm3xlA+fXZ8E7uL+6rVCSKQeseEBhDQb6wPtGtgt9iUY/QBr+sb3I0I3KQJRGt5Kzqpjl+v5MQUWwI42ex8XDZ0LcgMHWYxLoG/lUFPME/6v9UjtN2wYDpTP1in6dVLGOYNcZk2Bz6K7hjXn4XzcjX8LBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187107; c=relaxed/simple;
	bh=eojGo3FnreN/5bpzE/7yAjdAUZATXagKQ2yCRECnBEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODv//z/EKex1v5D5e9qDYyJXV8YtSXuucVHW9JZwnDHFHEAUQVxLOooWdV8/pPFG2B5xPt6PODO63lryqXevKKqdbPn6JBp/OIQtBEJhti4DghH50EJfcI7CPg/36e37KsTiseadtb0jH29GEEglNJj74MwdZhdPTMaXNF6yf/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtwNhNqC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtwNhNqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAF71F000E9;
	Mon, 27 Jul 2026 21:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785187106;
	bh=a9bnniewqncrY8DkkZ0DYiLEBAG6PSH+t23b/fiMIYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PtwNhNqCrnfFJlpJLOd/kC6gFPZ7iwVasrJPmD5xNbe/FpgwpeeTYdR9ZHvowzfte
	 mgHPc/CM1e5AIRZ+g4DuS4k5BDd7cGfUCOGlUlBmDCQA0I+qAMhn6kgnpTmCo7d42c
	 Ok8XLSVLh6KbTohHPV/igkVf8QYuqrgrZfXFLR87QHIOP/KFNIsOEdHrT2Q71vVJvT
	 n9DOu1qjMyys4GleReZCIRPkxSwOI2AzzW2NAnZhJYngWdZisccbq7AM12C/SpLcjp
	 2cJsAefdTfvC4JwvBWHoNNyNSeoytKUiZ+HAOQ390J94p+dtgYDot5hiiNdO8WCsXx
	 /m9WEIFHB7zqg==
Date: Mon, 27 Jul 2026 22:18:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-ads112c14: add continuous mode support
Message-ID: <20260727221822.554f7b4e@jic23-huawei>
In-Reply-To: <cf727776-07df-400f-a153-97297ecdbc5c@baylibre.com>
References: <20260724-iio-adc-ti-ads112c14-continuous-mode-v1-0-9eb0b7a4f020@baylibre.com>
	<20260724-iio-adc-ti-ads112c14-continuous-mode-v1-2-9eb0b7a4f020@baylibre.com>
	<20260727024559.513fadff@jic23-huawei>
	<cf727776-07df-400f-a153-97297ecdbc5c@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 08:45:57 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/26/26 8:45 PM, Jonathan Cameron wrote:
> > On Fri, 24 Jul 2026 15:13:11 -0500
> > "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> >   
> >> Add support for continuous mode in the TI ADS112C14 ADC driver. In this
> >> mode the ADC itself is starting each conversion, so we add a trigger
> >> based on the DRDY interrupt to read each sample. This mode is also
> >> limited in that only one channel can be enabled at a time since the
> >> chip does not have a sequencer or simultaneous sampling capability.
> >> Continuous mode will only be used when this new trigger is the current
> >> trigger.
> >>  
> 
> ...
> 
> >> +static int ads112c14_buffer_predisable(struct iio_dev *indio_dev)
> >> +{
> >> +	struct ads112c14_data *data = iio_priv(indio_dev);
> >> +	int ret, ret2;
> >> +
> >> +	if (!ads112c14_using_drdy_trigger(indio_dev))
> >> +		return 0;
> >> +
> >> +	guard(mutex)(&data->lock);
> >> +
> >> +	ret = regmap_write(data->regmap, ADS112C14_REG_CONVERSION_CTRL,
> >> +			   ADS112C14_CONVERSION_CTRL_STOP);
> >> +	ret2 = regmap_assign_bits(data->regmap, ADS112C14_REG_DEVICE_CFG,
> >> +				  ADS112C14_DEVICE_CFG_CONV_MODE,
> >> +				  ADS112C14_DEVICE_CFG_CONV_MODE_SINGLE_SHOT);  
> > 
> > This is odd looking code. Needs comments on why we should prefer returning
> > the error for the second call over that for the first.  
> 
> It is arbitrary, I just went with first error wins.

?  Looks like second error wins to me!

> 
> Other option would be to return early since the hardware is going to
> be in a broken state anyway.
I'd go for that.

> 
> >   
> >> +	if (ret2)
> >> +		return ret2;
> >> +
> >> +	return ret;
> >> +}  
> > 
> >   

