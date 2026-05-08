Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD023E4C90
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248615; cv=none; b=MVZ6hAsXRKND7DxNwgRGKVy0+rZS+1Vk15lEh5gxEtntFnk/Gx6Zva+DKdYZQwtCwdgPUaYfixvqotSEUjKUdmnwDZkuVrmQWBO5+ogQkK4lPkWM5YCdgtLCekHw66plv8i73Nwdhon0210pG4pVtTudOPrhFwKNSorBN8ebSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248615; c=relaxed/simple;
	bh=xXjW0rxTZttjfgbmU8PIEyO3kFbGR5H+YArkcEaeRB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk4LaLWcorPdGzkXf8dUoTZpdnvjT5IwwfJ1fqUojqTD6Wl/A7+neRAHdtdqOtt7fv7QO+/dj/70siuboZl47AkFltl7ODvDt134AFFJ59y1+yQZINK0tGzV1d2pOgnlAHBSvpnn69x8XOUFKaNdpcZIaZLeKWLcJwJOi5WVUEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUxaemXJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUxaemXJ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488b0046078so17087205e9.1
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778248612; x=1778853412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+deEIU0l9TtgM3Ywz9NcRPLw/ihIQpBRtZF4kOZfpMk=;
        b=bUxaemXJmz+KiajyjMreDfZ8JJUGUQD3kbQDq8bP4vNpV5OTAIZREqPuXHrZis66/4
         VfUppwziFVpD/6IgX8N7zggKJOLcH01KLTXliT5hgdutnEmhEdP7QAFl/cs9W1xO1+Km
         mAoTAMqvGz+Mi90av30Y+8ygaVg0Xx9AlLcpvqfYXreM33TtINvxZjjcKQ+UDM/5cVsp
         IM61PQWqinnGBIN3SbngdB9lX1nE03TN6pNcJ1q0m9Xn0NgID4OgRchtCAzIpkCWlGKg
         D6oJp/Bg60LWHNoXgscDYqA5nmZUmMTTiJuq4P8rJ6iHvqlq4Pjj8kLxnUFwO9g939R9
         WjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778248612; x=1778853412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+deEIU0l9TtgM3Ywz9NcRPLw/ihIQpBRtZF4kOZfpMk=;
        b=DUjf020NyQJARcMPEnRZ2FJ3i25pLE4KYHxX8Xt55qPMW6KDhreO/wksFVzCRxf41d
         f7JH3mVlNYt7leFG5PvGhIAF8jWKpN6rx0e7SMhNp24feJzzf829Fy2YJFaM0MaeFT1O
         U2MkUs1Kl4q8X/4hwYb3a0C+iNYcGyyMXWRd+omqFYYKpClMTZlVG0H9qDhq9uJ603Ti
         yWq9q5l4VVutj2OYmaMlnDznHV2uvc9DTZpGNZqpfZ42VWtqfD9kEzu+U7xXQmXfZAQ3
         B7jETwT+kuuS8FFIu3shDd+DnLPVRSb4H67IWPSA0gcj7KFGIH2mHWPB7kyrBJL2HhPd
         5Irg==
X-Forwarded-Encrypted: i=1; AFNElJ+d4PNwyvmSrxH0hvIY8tdpAeS1ksF2jEEZ7KfIKt2C2sx/4Xb2nrwMQ+HfJl9mvaY2KuPl/cmOhzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqn9zxksatXIN1+C+TabJECsuprbxjX5bSqOe7Mmbq7AvDrsBC
	EPCK4BgwQ8JeJoIHOtREEPKnYQhnagEQi99hZv+56bYSuiBY6jNKSZRT
X-Gm-Gg: AeBDietsTqHQKR4waUSijyZc0XAHAqZTlVPrjIWbE/HspaLJyg8TMP6iP8JvFQLtI9c
	MACkUSoiUPTJL4NUm8fEVvZr59WVt0kzdmzLIxgYC7q5jJuBpAfuPOEHjVPOSkv/39WSumZ8O2B
	daIOFtkcA3YV4qF46540g1g0FFGENf6lhZ2ZUpHIDZ9uy0sltJ5NJ2LhRMbr5AU8WiUrAtjTgeG
	yhkAlEqe5ewezq6+h6NK1WTdE38mRCgg1L6eRFaTSR4IYkzo3B8GVHmv+05GbcMHVoZCgNa8UbE
	zi1cTFPRxMWF4nJHdZ+YdKNLbtiuiPbJb5cluv+/ObYNhXcPcoeS+HTr2VwNxkgtnIn/v6pxvn+
	vOfhoE6wibgoOpxphJDgRIHWyKtnJHh3FMymBTro3200IXpEib483FQLFyfUtGRmm6Mj2Eom/bP
	VChzohX4H+6K8LLOo=
X-Received: by 2002:a05:600c:3e8d:b0:48a:6268:18a9 with SMTP id 5b1f17b1804b1-48e51f32797mr215577655e9.13.1778248611581;
        Fri, 08 May 2026 06:56:51 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68f43d1fsm45519335e9.10.2026.05.08.06.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:56:51 -0700 (PDT)
Date: Fri, 8 May 2026 14:57:44 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>, 
	rodrigo.alencar@analog.com
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Add AD5529R
Message-ID: <af3o7l-dgOsz4Y1-@nsa>
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
 <20260508-ad5529r-driver-v2-1-e315441685d7@analog.com>
 <20260508134843.7646c4f5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508134843.7646c4f5@jic23-huawei>

On Fri, May 08, 2026 at 01:48:43PM +0100, Jonathan Cameron wrote:
> On Fri, 8 May 2026 13:55:47 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:
> 
> > Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
> > buffered voltage output digital-to-analog converter (DAC) with an
> > integrated precision reference.
> > 
> > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > ---
> >  .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 96 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  7 ++
> >  2 files changed, 103 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
> > new file mode 100644
> > index 000000000000..f531b4865b01
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
> > @@ -0,0 +1,96 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ad5529r.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD5529R 16-Channel 12/16-bit High Voltage DAC
> 
> How is one device bother 12 and 16-bit? That sometimes happens for
> ADCs where it is really reflecting oversampling or for device with hardware
> FIFOs where storage space is saved by using lower bit rate. I'm not sure either
> applies here.
> 
> > +
> > +maintainers:
> > +  - Janani Sunil <janani.sunil@analog.com>
> > +
> > +description: |
> > +  The AD5529R is a 16-channel, 12-bit or 16-bit, high voltage, buffered voltage output
> > +  digital-to-analog converter (DAC) with an integrated precision reference.
> > +  The device operates from unipolar and bipolar supplies. It is guaranteed
> > +  monotonic and has built-in rail-to-rail output buffers that can source or
> > +  sink up to 25mA.
> > +
> > +  Specifications:
> > +  * 16 independent 12-bit or 16-bit DAC channels
> > +  * Independently programmable output ranges: 0V to 5V, 0V to 10V, 0V to 20V,
> > +    0V to 40V, ±5V, ±10V, ±15V, and ±20V
> > +  * The device supports SPI communication with Mode 0 and Mode 3.
> > +  * 4.096V precision reference, 12ppm/°C maximum
> > +  * Built-in function generation: Toggle, Sinusoidal Dither, and Ramp waveforms
> 
> Interesting - so this is a DDS, be it a simple one. +CC Rodrigo who has been
> wrestling with one of those recently.  Rodrigo, can you take a look at this
> driver and see if it fits in the ABI etc you've been hammering out? Thanks!

Yes, this also crossed my mind. I only briefly looked into the datasheet
but this device seems to be similar to the ltc2688 for the toggle and
dither modes. Naturally ramp is something new.

Not really sure this one is a DDS as that typically means things like
NCOs. This device looks like a "plain" DAC.

So, devices like the one Rodrigo is working one combine DDS + DAC to do
things like synthesizing waveforms (in a very fast way).

We would need to do some auditing but I guess we tend to put above
devices in dac/ (because they do have a DAC internally) or even maybe in
frequency/ but maybe worth thinking about a new directory for those.

Having said the above the ABI might still matter for both devices.

- Nuno Sá
> 
> 
> > +  * Multiplexer for output voltage, load current sense and die temperature
> > +
> > +  Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad5529r.pdf
> > +
> > +properties:
> > +  compatible:
> > +    const: adi,ad5529r
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 50000000
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      GPIO connected to the RESET pin. Active low. When asserted low,
> > +      performs a power-on reset and initializes the device to its default state.
> > +
> > +  vdd-supply:
> > +    description: Digital power supply (typically 3.3V)
> > +
> > +  avdd-supply:
> > +    description: Analog power supply (typically 5V)
> > +
> > +  hvdd-supply:
> > +    description: High voltage positive supply (up to 40V for output range)
> > +
> > +  hvss-supply:
> > +    description: High voltage negative supply (ground or negative voltage)
> 
> I don't mind doing it this way but in some similar cases where 0 is something that
> can be considered the 'default' we've made the supply optional.  What was
> your reasoning for requiring it in this case?
> 
> dt-bindings should be as complete as we can make them - with that in mind...
> 
> There are some more interesting corners on this device the binding doesn't
> currently cover such as mux_out pin.  We'd normally do that by making the
> driver potentially a client of an ADC
> 
> Easier though is !alarm which smells like an interrupt.
> !clear probably a gpio. TG0-3 also GPIOs.
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> > +  - avdd-supply
> > +  - hvdd-supply
> > +  - hvss-supply
> 
