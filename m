Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795828654;
	b=rdCtigr8aU1lDsHS53PLaJNm8cFfCpD/Kfx9p7xrC1c3CQ1nem+rCsGFf2NrQYCTcK8D
	 A8bNZ9vOOvTB1KrWBCENKrPGigUA0CWNvjWnM8k0XcHDYqe1bKUARJtvDTxCK599f1YfN
	 mXRfGi2PQkWzV4UEARhuO38dKFDXMyy/J7hczhx7ZuH/BcBsVoi3yt4wDsR4MzE7Qi4Q2
	 Ti05XrBBmi1CBakCCSnbcWX8kHtXQImR4WQ2AnxEzFz8pqLWXL/hHOJDlbvT42xYMpkTg
	 GW/8yaSCh8kF8Fgs3PRsd/isuI196JsWMYTbJKn1g/suimWhp61mm+FR/n8uDImGUOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795828654;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OSBwzpdqGrkNuDnhZM4boZGZHKeJDG3XgxYt1ZiYd2g=;
	b=Qxtm72THzojOmcjnzVdJ1p8nmCp0rqjBU79STSSB3u8OQ4fWQPHPmpd2JtC1wrFxAjlh
	 HqGzehpYsFRtAGhTvGB40Ph331cepj+8uR+bi6wUj+b66BLXe4Cd9zfTVEZqFaJoDAvg5
	 k43iNgeEWwHeldtsJQQ20oTo09PdgXc7+M6smDv7MbPNrDE9BJyDez8tEjxNd7bXzpPWZ
	 /Xt6IdoR6hsTHtWyn1vJRfd1l8o9qWYV+YBBEP5n058G8Qo9ol027LTWXtYy6EthCV7zB
	 NkKVOaCFF0vah0nSUOda9QYYJkobjSVRi05Xr9usN+F3JWX+m5Pqibx91zIbQvNvnbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwFQFO9O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83D606A31C;
	Sat, 28 Nov 2026 01:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwFQFO9O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8E11F0089B;
	Sat, 28 Nov 2026 01:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795828654;
	bh=OSBwzpdqGrkNuDnhZM4boZGZHKeJDG3XgxYt1ZiYd2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YwFQFO9ORRWN227/l0GCnmRpWQK2NbB7lShlcN7s9QtxxMtBiY5L+V9/8GYTxgvzC
	 UHigp8GPJoqdqmze5EQz1rPCz97pFahvKRDxLZSS6i9SxC823lGpxDbn4Rbeyh0Okt
	 TR/QF7EdGsyb4iX9xEema999kED+0qHOXTSC/zd9W6SqwEk9t6Tq7kV9VRLpw/2ULX
	 lZDU+LXHYelHhnbJYShr7VmPhRuzE46TyOGynMxiWc9nAwYPf08wj+7j5tMlEebMPw
	 La/jbPw8aTHKVyNuWkmLIdCrY4HKAU0JGcs7rf3I0ZFJY3TUwn7hzwnRpX1wHag7fv
	 vSZXRK6okGcuw==
Date: Sat, 28 Nov 2026 01:17:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: robertijtsma@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: add ams OSRAM TCS3430 XYZ and
 ambient light sensor driver
Message-ID: <20261128011727.297d2a27@jic23-hlaptop>
In-Reply-To: <awnB1KT-oJQoPjOM@ashevche-desk.local>
References: <20261127-iio-tcs3430-v3-0-e191a40a4ae9@gmail.com>
	<20261127-iio-tcs3430-v3-2-e191a40a4ae9@gmail.com>
	<awnB1KT-oJQoPjOM@ashevche-desk.local>
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

On Fri, 27 Nov 2026 19:45:56 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Nov 27, 2026 at 09:12:50AM +0100, Robert Ijtsma via B4 Relay wrote:
> > 
> > Add an IIO driver for the ams OSRAM TCS3430 ambient light and CIE 1931
> > XYZ tristimulus color sensor (found at I2C address 0x39 on devices such
> > as the Microsoft Surface Pro X).
> > 
> > Unlike the older TAOS RGBC drivers (tcs3414, tcs3472) that use the 0x80
> > COMMAND-bit SMBus protocol and RGBC channels, and unlike the banked
> > MAZeT/JENCOLOR as73211 driver, the TCS3430 uses ams's direct-addressed
> > 0x80..0xdd register map and exposes Z, Y, IR1, and X tristimulus channels.
> > 
> > The driver exposes:
> > - Illuminance (photopic Y channel) with raw counts and lux scale
> > - Modified intensity channels for X, Y, Z, and IR1
> > - Selectable scale and integration time via the IIO GTS helper across
> >   1x/4x/16x/64x/128x gain and 50.04/100.08/200.16/400.32 ms integration
> >   time settings
> > - Regulator management and system sleep suspend/resume support
> > 
> > Tested on Microsoft Surface Pro X SQ2 (SC8180X).  
> 
> 
> There are a couple of nit-picks below, but overall LGTM, after addressing them
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> > +config TCS3430
> > +	tristate "ams OSRAM TCS3430 ambient light and CIE 1931 XYZ sensor"  
> 
> This doesn't scale, but okay, I don't expect this kind of compatible devices
> appear in a volume, we may rephrase this later on.
> 
> > +	depends on I2C
> > +	select IIO_GTS_HELPER
> > +	select REGMAP_I2C
> > +	help
> > +	  If you say yes here you get support for the ams OSRAM TCS3430
> > +	  ambient light and CIE 1931 XYZ tristimulus color sensor.  
> 
> Usually when it starts with more that a single vendor line of the devices
> the list of them is better as it's easier to tweak later on:
> 
> 	  If you say yes here you get support for the following sensors:
> 	  - ams OSRAM TCS3430 ambient light
> 	  - CIE 1931 XYZ tristimulus color

Agree with general statement and perhaps only know this because of
a history with colour spaces: That second bit is a colour space in which
the ams OSRAM sensor presents its data, not another sensor.

Jonathan
