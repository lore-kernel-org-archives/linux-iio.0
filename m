Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB8C370D7C;
	Fri, 22 May 2026 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474054; cv=none; b=ovuN6ooKtcihkjgHbVnelFXJzD7WJikp1ZnfHXfbrt+Lbbtj9Kn7cjsyWs67abMifQfGjBR+rQBQcd/fQ2PyYtEhRceHXyOw+rB6nBd7HqBdE4EegqzcNboSpL2PzgIc9C/my6Q31MMOpgttClWVCGfGwPM+skNyJ5Q4nfQLVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474054; c=relaxed/simple;
	bh=jffPhdDnLRAwzi8PUjK5KYDleGde9jnD2WMvaN6VDPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrxFL/EKgLMO60yEpBMUYghaTscj5lXLqs0j8OUPZHlK46f3SMFyy/x/A7tZ6UNk+A6HOUfj2C0WKV5sklp98btwmqlOmX5t7S+ib9zrxII/54t/0vOcFWmqgOLKMR4eUla0c6nw3+HjdeXHLhLPk04BUTvmFQaitz0SxNi6ZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOeLa3/+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOeLa3/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DED1F000E9;
	Fri, 22 May 2026 18:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779474052;
	bh=hSU9cBpoTFF2chOzFBP0yrEVoRs+PB2zWOHHQAxyuJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WOeLa3/+6uhtOB39yRrjL3yn8Whs13tqxJsoEVyKGuTnHRnG2kWK3NXWGxD9uYsbz
	 ZbnRXI6sx4dlK6X3OaUDESQXaZCC1zSgK9IkIt/mEivWgEQ0tZcOv8fSinLK2LhrSx
	 xc8sImMQvA7nClnv252vdOgIBGzi7LnWTpvQ0pU+cWDdGjr/1Hsod5hd0P+Gp0DbIE
	 JGYdrW3EinsLNF4ldrvxC9bUVdolk/H2mHGhwLsnqWTY6N8bZCLKJh3tMQAv5JP5j+
	 07K0pC+38GgiwV/pRkhpBIfaLCLuVHPAAKOebzgeI0ABI91a+DZRjwnbcgNBTj8tzH
	 1IEFmZRv5gV9A==
Date: Fri, 22 May 2026 19:20:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v5 12/13] Documentation: ABI: testing: add docs for
 ad9910 sysfs entries
Message-ID: <20260522192040.4e6b11eb@jic23-huawei>
In-Reply-To: <vqqvn2cgs3fbp5mq6xfac7iyosaqfrvgngqur4x355a3at7slo@ylrtd6fhi33a>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
	<20260517-ad9910-iio-driver-v5-12-31599c88314a@analog.com>
	<vqqvn2cgs3fbp5mq6xfac7iyosaqfrvgngqur4x355a3at7slo@ylrtd6fhi33a>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 19:47:25 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/05/17 07:37PM, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add custom ABI documentation file for the DDS AD9910 with sysfs entries to
> > control Parallel Port, Digital Ramp Generator and OSK parameters.  
> 
> ...
> 
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_offset
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		For a channel that allows frequency control through buffers, this
> > +		represents the base frequency value in Hz. The actual output frequency
> > +		is derived from this offset combined with the processed buffer sample
> > +		value.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_scale
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		For a channel that allows frequency control through buffers, this
> > +		represents the frequency modulation gain. This value multiplies the
> > +		buffer input sample value before it is added to a frequency offset.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase_offset
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		For a channel that allows phase control through buffers, this
> > +		represents the base phase value in radians. The actual output phase	is
> > +		derived from this offset combined with the processed buffer sample
> > +		value.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_offset
> > +KernelVersion:
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		For a channel that allows amplitude control through buffers, this
> > +		represents the value for a base amplitude scale. The actual output
> > +		amplitude scale is derived from this offset combined with the processed
> > +		buffer sample value.
> > +  
> 
> This will become just offset with altcurrent channels. I noticed we have a IIO_PHASE
> iio_chan_type, could we have a IIO_FREQUENCY too? Parallel port needs actual raw
> frequency values in that case to be written to the dma buffer.
> 
Sure to IIO_FREQUENCY.  I thought we already did but seems not!
The Phase one is a bit special given it's use in resolvers and distance sensors
but perhaps it is the right solution here.


> Then we may have buffer capable channels for the parallel port:
> 
> out_altcurrent120
> 	offset

So that's the amplitude envelope control.

> out_phase120
> 	offset

So this is the phase adjustment being controlled. 

> out_frequency120

And this is the frequency being controlled.

> 	scale
> 	offset

> 
> Problem is that the math for the actual frequency output is:
> 
> 	f_OUT = f_FTW + (f_RAW * FM)
> 
> where f_FTW is a base frequency (already scaled), FM is a
> modulation gain and f_RAW is the contribution from the parallel
> port, which is the already scaled:
> 
> 	f_RAW = RAW * f_SYSCLK / 2^32
> 	f_FTW = FTW * f_SYSCLK / 2^32
> 
> so the above becomes:
> 
> 	f_OUT = (FTW * f_SYSCLK / 2^32) + (RAW * f_SYSCLK / 2^32) * FM
> 	f_OUT = (FTW/FM + RAW) * f_SYSCLK * FM / 2^32
> 
> if I make:
> 
> 	SCALE = f_SYSCLK * FM / 2^32
> 	OFFSET = FTW/FM
> 	f_OUT = (OFFSET + RAW) * SCALE
> 
> That would work for a IIO_FREQUENCY channel type, problem is that both
> scale and offset would depend on the modulation gain (FM)... I suppose
> scale should be setting that and offset assumes it is constant to act
> only on FTW.

I'm not that concerned about the coupling - it's a bit of a useability 
issue I guess as not obvious which should be the fixed one.  Can we do
cache written values and try and compensate to get a pair that is nearest
to whatever we try to drive (in either order of setting them?)
> 
> I suppose we can keep altcurrent for other modes as phase and frequency
> can be attributes (knobs) for them. However, in parallel mode we are effectively
> pushing frequency, phase or amplitude values into the buffer.

Given that's the thing we are controlling. My Friday evening tired brain agrees
that it makes sense to use channel types rather than adjustments on something else.

I'll think some more on this.  We've never had continuous (well digital
so near continous) control of either phase or frequency before - it's just
be symbol stuff with a couple of points to set.


> 
> The polar destination is a corner case, but can be solved when both
> phase and altcurrent channels are enabled. When that happens we can
> change the scan_type with has_ext_scan_type = 1, so the 16-bit data
> bus is split between the two.
> 
For now I'll just nod at that!

> With the above, all of those *_offset and *_scale custom ABI can be dropped.
That is definitely attractive :)

Jonathan 
> 

