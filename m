Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C684329827E;
	Thu,  7 May 2026 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169411; cv=none; b=NLJXnkkzQWF3AJ9w9dVDBtOUSeYEZuxeznX/5pNM4mS0jNTxirRYm/F1Ph3ckWI2WgBKAQQyXXKW7jy8L7fu/yBFIGS1WradQHzbntshIHsTWBqIfH/01uasb97hPY0D1w09lQSdEq4jb7yGtlP5qWmLbKQ0pAlqJuLHxm2wXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169411; c=relaxed/simple;
	bh=I2n8h81Jor1e1Le0Q/vHNqK+ntgyBEt2vJ14SQ+9niM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcYP0wSOKSqi/ss8enMqaarT0gjCKaQvU0PhTgVLYQ9sUtHaL1G7S+1hxdSFH6Mskm5D3J8dh/ZBVZqqkDUfvt66pwAzjaTeiN8J5RG2xCVwk/bl0H+cf2lSnzYpHcykTw95Hofrjs9Lslqt2nUEMocLlZ0TelnjViO6b8WbtU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAZ2fiBd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAZ2fiBd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9EFC2BCF6;
	Thu,  7 May 2026 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169411;
	bh=I2n8h81Jor1e1Le0Q/vHNqK+ntgyBEt2vJ14SQ+9niM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tAZ2fiBdJPFcPBlbCkRK9hMv90eBg7tZ4GYxNHuNXwd5rKt2MKh2S4eZ85UeBxK0o
	 9dkmlPOHcsf5v3OKIqYfP0GOEja5/UfmR4sm9kII8kD/QXiBx8NqsMxnCoGzX8Lhtv
	 ZnhbgueWZsGQVdFg4AxvRJ6BJKAMtp3230Z8Y1qJ6AyFiAG7GoVZinConztI1Ao9LT
	 AeY+FDxfbURwUwLsdFylzykvExRdri0b0jeUNTFFKXynXrscGzFt8Jhs8M9jMWSgBr
	 tQqcoNTviVu6ZyldonMHhpGRLMOjCEpvQx/8BNnFxAbN8gzFgkhrpyCrUEw4tEehFB
	 eVe36qbppQixQ==
Date: Thu, 7 May 2026 16:56:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v11 07/11] iio: frequency: adf41513: driver
 implementation
Message-ID: <20260507165636.13890766@jic23-huawei>
In-Reply-To: <5rzmlzst6m2ewcheblimqbv5c64umfhb4mlx34ak65sxpotqgy@jzzmw6cb2vyc>
References: <20260506-adf41513-iio-driver-v11-0-2b7e99cfe8f2@analog.com>
	<20260506-adf41513-iio-driver-v11-7-2b7e99cfe8f2@analog.com>
	<5rzmlzst6m2ewcheblimqbv5c64umfhb4mlx34ak65sxpotqgy@jzzmw6cb2vyc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > +static int adf41513_pm_suspend(struct device *dev)
> > +{
> > +	return adf41513_suspend(dev_get_drvdata(dev));
> > +}  
> 
> 	Is it safe to call adf41513_suspend() without acquiring st->lock?
> 	This function modifies the shared software register cache and executes SPI
> 	writes. It seems this could race concurrently with sysfs reads/writes or
> 	IIO core accesses.
> 
> Is this a real concern?

Sadly I think this is correct. Nothing stops suspend racing with an ongoing sysfs access.

> 
> ...
> 
> > +static int adf41513_probe(struct spi_device *spi)
> > +{  
> 
> ...
> 
> > +	st->chip_enable = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(st->chip_enable))
> > +		return dev_err_probe(dev, PTR_ERR(st->chip_enable),
> > +				     "fail to request chip enable GPIO\n");  
> 
> ...
> 
> > +	ret = adf41513_setup(st);  
> 
> 	Is a delay needed between asserting the chip_enable GPIO and sending the first
> 	SPI command in adf41513_setup()?
> 	Hardware PLLs typically require a wake-up or stabilization time for internal
> 	regulators. Without a usleep_range(), could the initial SPI commands be
> 	dropped by the hardware?
> 
> I havent see the need for this, mostly because a lot seems to be happening before the
> first SPI write and after the chip enable goes high, so I will ignore this.

If we do have a documented time it would be better to sleep just to be sure.

> 
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret, "failed to setup device\n");
> > +
> > +	ret = devm_add_action_or_reset(dev, adf41513_power_down, st);  
> 
> 	If adf41513_setup() returns an error, the probe function aborts before
> 	devm_add_action_or_reset() registers the adf41513_power_down action.
> 	Since chip_enable is acquired with GPIOD_OUT_HIGH, devres will disable the
> 	regulators but leave the GPIO high. Could this cause the host processor to
> 	backpower the unpowered synthesizer IC through its ESD diodes?
> 
> Another good point, will separate the reset actions for sw powerdown and chip enable
> gpio.
> 

