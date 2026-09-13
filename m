Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11365369D67;
	Sun, 13 Sep 2026 23:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789342704; cv=none; b=Noz+k8Jwuqy8UA/MrsbnOEBuyVN9X70Zo49Wi437njUnI34/Q4i3SLIuSa87UBfnZjHCOzxDCfqX5OKFZJgOkO8T72PAn93xGQH+I3B4loygHPRjhk3afIK6Don4HTS8H5A9AcECUjzcRw2OJUEI2Wc8l7+sHUL3su5LevbQRLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789342704; c=relaxed/simple;
	bh=inGaolwHloMOR3u6P73LuW5iEIIePFs7XujOh9tfzH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6IVeip2Z2lNy+o/dqFFnQ+7mSIXu3+iUv5KWmYkjYGVtWkTIwSsv1eawM9bw855KqoUbjR016U61N0/Fh54fI6esmG7glP6iJhTC+3yE1uGB73Bcn/C6f4L+Ob5i2gIIiyIfb9nTQYMy6vlAI3EikeZcyM8M3H+LAVhVg6qUeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeRCA2CK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeRCA2CK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC161F000FF;
	Sun, 13 Sep 2026 23:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789342702;
	bh=VuBPIQk1iccU5ziTydcwNOhmuNqxIHNKYNlCSb8p8Xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oeRCA2CKok6Dk5UPpDvauQJIJvlAXSxXOvzE9HXHgL7lGo/bF7oDNpXPmKD/KAW64
	 btWMxe5oPDawAsfiyDulh96nm+OYlPNeiumxQpWr1s2eE86qY4LJbTAImTD0/bIOu3
	 1Mz1xlETDbfvsCn8vg/THdgIA+z4eYay4g0ZZyxxGMJhjjU8d+cuOl0l2ylyGexgdk
	 PB7ePHjJ8FTKLDH7NFP0XdP6L1323654uotp3uKA44tDoSkHXn6fT4tQvSOeXbJ/4X
	 A1ERw+/+mpHsmUQk0g+Nqee3FDvIVunXTyqn0oddz3nb6CSiETDoVmVKDljMaE+vBc
	 Fhyw+/aQ0+mZA==
Date: Mon, 14 Sep 2026 00:38:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrei Stancovici <andrei.stancovici@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: adc: ltc2497: add 2x conversion speed mode
Message-ID: <20260914003817.760214ab@jic23-hlaptop>
In-Reply-To: <aqFniZF6CrYXnPjz@ashevche-desk.local>
References: <20260909082755.366269-1-andrei.stancovici@analog.com>
	<20260909082755.366269-4-andrei.stancovici@analog.com>
	<aqFniZF6CrYXnPjz@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 17:04:57 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Sep 09, 2026 at 11:27:52AM +0300, Andrei Stancovici wrote:
> > The LTC2499 can convert at twice the output rate by disabling the offset
> > auto-calibration.  Expose it through sampling_frequency and
> > sampling_frequency_available on the voltage channels.  The part ignores
> > the setting while measuring temperature, so the temperature channel does
> > not carry the attribute.
> > 
> > The wait before a result is read is keyed on the conversion currently in
> > flight, whose duration is fixed by the mode that was active when it
> > started rather than by the mode just selected.  Otherwise the first read
> > after a 1x -> 2x switch can reprogram the part while a 1x conversion is
> > still running, which the part NACKs.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> > +LTC2497_DEFINE_CHANNELS(ltc2497core_channel_samp_freq,
> > +			BIT(IIO_CHAN_INFO_SAMP_FREQ));  
> 
> I believe having this on a single line is fine.
> 
Tweaked.

I've taken the somewhat (currently) unusual step of picking up 2 and 3, but
not patch 1.  In the past I've always been one to pick up whatever is ready
but since that started confusing sashiko I stopped doing so.
Here it doesn't matter as patch 1 is independent anyway!

So patches 2 and 3 are on the testing branch of iio.git.

Thanks,

Jonathan

