Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794695784;
	b=lGcSZ+V6a8nilcjts7CJ5ncO3GcJXoDdt7Y3w88NmwHKlR+j7Y7X4ILlRdcFXTUVkJUh
	 GQv4nJi781E93GKnDPxLKREUICly9ZTdIO5kR0uqfMEjTJRuIOkXUUbT9L9DA4+I5D5NY
	 hxzb2oY5X7SKy1Uq+7cH61/KcV6dva8Cu2Kxj2Ss0czC67qGumNcyio3IWC8emSSNtTbk
	 6VbyW75zr+W+5k2Y/GhFjxeaQ1Vsvbi49q74eMBNgwoWa++Z12ODQtwHTyunMJ1QyLB4M
	 zOTZc66bSo3aFoKZWnuU7TBfPFhqNMfuas50+pN4eTi5wa1E1X6zIXgr3G//C1U+Kaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794695784;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3GmTsvjjjRsfQjR1vcZ3unJ9njwZivv6RzYb6ZLaEf0=;
	b=qMHrIuNYryk3MWhNaxfMIoBhoLm19qJCjgaxiG3LyGlP/UfQSEQ4ReiLdbix5fvQVo1N
	 JTdzNKCpA4nVvG3I70ekvCfCQ6j2ELo5B07rahe9kSkezOT1I8r6jwiutyd7szavD+q2o
	 3qRg0oogZmRw4VmstIlN00TL9Bp4ckKmlktlyr6a9oII2/H5upOM1HEtn62b7/Me2qcKe
	 REhyCu16TvGjVbXGNrstIRPmjn0TGr0RvzVvQRJGk621Dg6ur/jBxNM5zMaBb9tcRvAYD
	 2Z5OxtZiSGuXR8lA0qQgAI8/RHe4F26ZJ8LdikfMvoZiCH/GCGQm4HGz5bAeuqU6CPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etu7sIX7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A874E606A32D;
	Sat, 14 Nov 2026 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etu7sIX7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34E81F000C4;
	Sat, 14 Nov 2026 22:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794695784;
	bh=3GmTsvjjjRsfQjR1vcZ3unJ9njwZivv6RzYb6ZLaEf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=etu7sIX78tdNEHeI12jq7NSVQLwtjxc2JaUBQ4xEVov0jaTQEg7SfT0wrVXLqV3ri
	 jCR84N3aORvehPgyEOgIgsmm85N4hNssjG6EO+c1QtS6bjQK45AcIiAm5ifVYzDFc9
	 xPw3JYarNc8+Cw+8CqhL9kFLr3euhSaeGEdxoxUucIOTJdWOoVMRrcYRZGAUemhLvt
	 9IHgYitQfBiASIYi5er76daXtf42hlUyrHiDG+xSYzbezO8byD0fm6fXDhLo8NZQOw
	 RmcNKnaeSvxj23XvUKkMAwO6I3I7CI2tKvYwo0kc/gQ93g3IZt90eTgsIX3X3EhkWl
	 33RZSB5lX8tbQ==
Date: Sat, 14 Nov 2026 22:36:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, "Trevor Gamblin"
 <tgamblin@baylibre.com>, Joshua Crofts <crofts@kernel.org>, "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/7] pwm: axi-pwmgen: report the waveform step
Message-ID: <20261114223614.59e796e6@jic23-hlaptop>
In-Reply-To: <20261109140607.36418-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261107014755.364d4729@jic23-hlaptop>
	<20261109140607.36418-1-Nicolae-daniel.Deaconescu@analog.com>
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

On Mon, 9 Nov 2026 16:06:07 +0200
Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com> wrote:

> Hi Jonathan,
> 
> On Sat, 7 Nov 2026 01:47:55 +0000, Jonathan Cameron wrote:
> >  
> > > index b40522f01002..6b15244efabf 100644
> > > --- a/drivers/pwm/pwm-axi-pwmgen.c
> > > +++ b/drivers/pwm/pwm-axi-pwmgen.c
> > > @@ -136,6 +136,18 @@ static int axi_pwmgen_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_de
> > >  	return 0;
> > >  }
> > > +static int axi_pwmgen_get_waveform_step(struct pwm_chip *chip,
> > > +					struct pwm_device *pwm,
> > > +					struct pwm_waveform_step *step)
> > > +{
> > > +	struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
> > > +
> > > +	step->clk_rate_Hz = ddata->clk_rate_hz;
> > > +	step->clk_cycles_per_step = 1;  
> >
> > Given the only known user sets cycles_per_step to 1, what evidence
> > do we have that part of the interface is actually useful?
> >
> > I can theorise that some device might need a couple of clocks
> > but can also theorise someone might use both edges of the clock as possible
> > state transition points for a PWM.
> >
> > Note my PWM knowledge is minimal so this may be entirely garbage!  
> 
> None yet. axi-pwmgen is the only provider and reports 1. The field is there
> because Conor's v1 review said the code would fail if someone used a PWM
> provider with a mandatory divider. It keeps the consumer from assuming
> one clock cycle per step.
> 
> If you prefer to add it when a provider needs it, I can drop it. struct
> pwm_waveform_step then keeps only clk_rate_Hz.

I'm fine with sticking with this as you have it.  Thanks for the extra info.

Jonathan

> 
> Thanks,
> Daniel

