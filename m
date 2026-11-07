Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794092976;
	b=lDULafNse0PC7kMwTrRUkDssbuW6bbVBBt/f9lZBjkEBFeU4sSruDHCBF6reik+boBsr
	 wQNj4SOJwZ57G7Hd4ds83mShgC7xXlWTIJDdb7YupsszOvRJM4++izxY2WnhkpkNEa93u
	 zwCpdAs8QjySNJrrp0AmOkuHEuLFKJDmUCQz59uL5ag89ZfUbU3riSn6qTrrVEvKDdnRv
	 IznJK5CbEUOjNczmRZceaVw/Egr4tIwPNIVkwYEuXFFHC8gEKLT0OVWOpiHGArU+arpEx
	 KWsK4WO7Mw8gJK/EbMxVT3tV837xSXC4jODgdUEJ1AluakHdsR1bm9ZDSmLyOHxVzxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794092976;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UWZ2710KGldVZ422EboYiVGcI5Q0MFdr5WPNaQURoWs=;
	b=JFVmFRvQaryn4HIHTf1L6zEC0J683TLtdj9Y4JcZXusaHAz8gX8j/2jhUfcGiaBcb64i
	 vzyDn+Oslc2U5ItLtJBdDQmCTAGSTEN1YbDUXXdR8dOW1FocWZtpAK9EbYz8ZdxZEIs+h
	 QGkpizeCjBHHZWfC67sLW/FftIAtFRCzC1R/r2SDq2/hvjl2NMoss40L3ZfZfOhplu3Rm
	 MdtvumkQSoeyUlaT9hZke6gamoPYBry91kYF1iT4iUjeQ/EnP9t2S04R3o1c5cmBg1quz
	 hUkuNGBgdiiMe8e0qzLCfeScOZVoDxZrBJ6myJynfNDXiJmVfpbmheN7gTCVsPaTwMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHGRokPF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C5606A326;
	Sat,  7 Nov 2026 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHGRokPF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E5B1F0089F;
	Sat,  7 Nov 2026 23:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794092975;
	bh=UWZ2710KGldVZ422EboYiVGcI5Q0MFdr5WPNaQURoWs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nHGRokPFdXKP4VKEz39RSj4rgQD58824xstc5ytKYGQ/vFZCfH+18iyvjQ63nowXP
	 gdz02PZvMWrUiyPbcbMKn9NFyNujMZq0egH/UulgsHNYka28WTfPpg+DR77iDUKMnj
	 uoHm+eESHIWH274yZdJh3n2QlE4nX4fUCxkJI12HC2iYuUooDCtCaC7u8JplXOt/UH
	 TBluEKLEUvJVdYWJSMJ7bPFdamUBAIHyOH/BmQ9E8jjamkd+AQASn4eM1cR6QQQubS
	 5KzV7YeEDdIW5T7JzN7U2BQoFTsm+s7kd/DM1fcm1Npk1CU/8XW8sOxKj5k5eb6KKH
	 rcwhP/k7QjN8g==
Date: Sat, 7 Nov 2026 23:09:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux@analog.com, Conor Dooley <conor.dooley@microchip.com>, Marius Cristea
 <marius.cristea@microchip.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 0/3] iio: adc: add support for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20261107230925.5e66b234@jic23-hlaptop>
In-Reply-To: <01fe2a71-ba6f-470b-b6bf-e536a1013b09@linaro.org>
References: <20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c@linaro.org>
	<20261104021700.14e69abb@jic23-hlaptop>
	<01fe2a71-ba6f-470b-b6bf-e536a1013b09@linaro.org>
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

On Wed, 4 Nov 2026 09:45:02 +0100
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Hi,
> 
> On 11/4/26 03:17, Jonathan Cameron wrote:
> > On Mon, 02 Nov 2026 15:49:03 +0100
> > Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >   
> >> The MAX34417 is a specialized current and voltage monitor used to
> >> determine power consumption of portable systems. The driver supports
> >> getting the channels voltage, average power and accumulated average
> >> power and energy over an I2C/SMBUS serial interface.  
> > https://sashiko.dev/#/patchset/20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c%40linaro.org
> > 
> > Sashiko had views and the dt one at least checks out.  
> 
> I'll fix the bindings one.
> 

These are a bit tricky to interpret without context.

> But for the other reports:
> - [Medium] iio: adc: max34417: shared accumulators clobbered on CAM power/energy read
> 
> This is a tough one, today if either we read power or energy, we erase the accumulated
> power+count in the context, the context accumulator is only here to make sure we don't
> loose data from other channels, like if we had a single HW channel.
> This simulates this, if we had a single HW channel, at each UPDATE we would get back
> to 0 in hardware anyway if we did read the power or energy.


I'm only half understanding this.  Let me see...

I'd expect userspace to see accumulated values since we enabled the channel
rather than since last read.  I think that's the final suggestion from
sashiko. 

> 
> - [Medium] iio: adc: max34417: missing 1 ms delay between UPDATE commands
> 
> It's unclear if we need to wait 1ms in CAM mode, I think we should but should we block
> from the read if we are under the 1ms ?

I'll go with probably?

> 
> - [Medium] iio: adc: max34417: scale truncation and mJ unit in max34417_read_raw()
> 
> Ok this one may be real, should we return Joules or milliJoules ? If so we could
> fix our precision issue.

Units in the ABI are joules, so if you want to return in millijoules you will need
scale to incorporate the extra factor of 1000.  Hmm. The comments suggest
that today it is using milijoules?  If so that needs fixing.

Our units are a bit messy as many years ago I started with what hwmon had before
concluding they were tricky to keep insistent. So what the base units are tends
to be dependent on when the channel type was added.  More recent ones are the SI
unit in most cases.


> 
> - [Medium] iio: adc: max34417: missing UPDATE before CAM in max34417_setup_cam_mode()
> 
> It's highly improbable, but I'll fix it.
> 
> - [Low] iio: adc: max34417: reuse max34417_reset_smm() in max34417_trigger_smm()
> 
> I'll check if it's worth it
> 
> Thanks,
> Neil

