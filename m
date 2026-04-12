Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B643125A9;
	Sun, 12 Apr 2026 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776005486; cv=none; b=VSHjFIMova8bGzoLqPDDVu3CqSSz1/ojvxV+0ObLXzTfslyWOFbUH2BeKgMjmwQC0uVOVTetCZXjXN9xEU67mg4UpdTm2tA5vti/ulZvucYlEh3zA+ra26Iwm92oGZFMAOqKB6K0kX4JmkEkR3fDDYg+1EfLd2FiUbkmZllUmu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776005486; c=relaxed/simple;
	bh=lvYa7oWh1GwSJI6uRxzS53tioYb31LvQvCij/pmNvCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCKB39VkfGhEWVmJoH00uA2CI0bJhS0hkMBkbiCuMOAxJtTilNRR+VVzd5PjiRz42y0BjGjs7vwsGTvCbE29KQSXYfC5nbWBmINesVixI2yX4XgLZ1GX6NacsZRXAqpCzIWqjW9pqhLe9J0ssXJ5Iyh43SjfDjeywrReRLYcmmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsLlZ4Gx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsLlZ4Gx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F17AC19424;
	Sun, 12 Apr 2026 14:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776005486;
	bh=lvYa7oWh1GwSJI6uRxzS53tioYb31LvQvCij/pmNvCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JsLlZ4GxoDgppshs8MYfL3c7ggkVsPrgraSM52CSwMznHNeCIhS68dAJSvF0cR2fz
	 4gaorreSBkZupwBW9RGNDhle5wA8R7F+yaQxXWzvBcWpBqKPCEViOZ5YJKno4WaoSU
	 japh9BtPL3pKSE33lhZAjTHDzRgvXALG9FKrBsYHU4bxwWmPxCDIRSaYP03/L8EzJY
	 czIAKvkQTQP6wk9NnFJVR94/WFoqhY5ChSo2e2G0KlTI+I88cvBUVMKnOt4DfXUK1F
	 qnIsKMW0Y7O8ClXx6EqJCtvDp+nCMNlT/zJoPCoSiJrQcEJt0ZrscjZNfsq7RhN7CF
	 HzgUEgNNJH7sA==
Date: Sun, 12 Apr 2026 15:51:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFC v2 8/9] Documentation: ABI: testing: add docs for
 ad9910 sysfs entries
Message-ID: <20260412155115.2f7a83bf@jic23-huawei>
In-Reply-To: <mtqjtmsysz6ywvybeut6qzhee2o4qedwgvr5isbn4um7bwhjbe@sg2b7hwlszwd>
References: <20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com>
	<20260318-ad9910-iio-driver-v2-8-e79f93becf11@analog.com>
	<20260322172257.1681de69@jic23-huawei>
	<mtqjtmsysz6ywvybeut6qzhee2o4qedwgvr5isbn4um7bwhjbe@sg2b7hwlszwd>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 11:36:08 +0000
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/03/22 05:22PM, Jonathan Cameron wrote:
> > On Wed, 18 Mar 2026 17:56:08 +0000
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add ABI documentation file for the DDS AD9910 with sysfs entries to
> > > control Parallel Port, Digital Ramp Generator, RAM and OSK parameters.
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > ---  
> 
> ...
> 
> > > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_profile
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Read/write the active profile index [0, 7] from/to the physical
> > > +		channel. The AD9910 supports 8 profiles, each storing a complete
> > > +		set of single tone (frequency, phase, amplitude) and RAM playback
> > > +		parameters.  
> > 
> > This one is interesting.  Can we treat them as symbols that we are picking
> > between?  We have similar DAC ABIs for that already.  
> 
> The profile concept comes from the datasheet and defines sets of configuration
> for single tone and RAM control mode. I am not sure how we fit this idea into a
> "symbol"

Think of those tones as just different frequencies (the other stuff could be the same)
then this is FSK with 8 symbols.

> 
> > Is this picking between them for purposes of configuration or setting which one is
> > in being output currently?  
> 
> Well, this is being used for configuration and activating, then, yes, you can only configure
> an active profile, but I was not seeing that as an issue. I suppose that simplifies the
> ABI a bit.
If you are only configuring the one that is active, short of a small overhead
of having to configure more than one property why have this at all?

Just leave it in a profile and have userspace reconfigure everything it wants to.

However, I see that in some of them modes below this is more complex
as the profiles are cycled through - for ram playback anyway.
It may make sense to separate the ram case from tone ones.


> 
> ...
> 
> > > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_destination
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Read/write the digital ramp generator (DRG) or the RAM control
> > > +		destination parameter. Determines which DDS core parameter is to
> > > +		be modulated when the child mode channel is enabled.
> > > +
> > > +		Available values can be read from the corresponding
> > > +		out_altvoltageY_destination_available attribute.
> > > +
> > > +		Valid values: "polar" (only for RAM control), "frequency", "phase"
> > > +		and "amplitude"  
> > 
> > This is very device specific. Maybe we are better representing these as separate
> > channels each with their own controls for DRG.  No problem if changing one changes
> > another.  
> 
> You mean removing this generic Y there? Indeed, there are separate configs for each one.

No, I mean having more channels.  One for each of polar, frequency, phase and frequency for
each channel.  Then enables for which channel is turned on.  Might not work out,
but I'd like you to explore what problems that type of interface would bring.

The aim here is to add as little new ABI as possible as custom ABI is a real
pain for generic userspace.


> 
> ...
> 
> > > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_operating_mode
> > > +KernelVersion:
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Read/write the DRG or RAM control operating mode. For the DRG
> > > +		channel it controls the no-dwell behavior of the ramp.
> > > +
> > > +		Available values can be read from the corresponding
> > > +		out_altvoltageY_operating_mode_available attribute.
> > > +
> > > +		Valid values for DRG channel:
> > > +
> > > +		  - "bidirectional": Normal ramp generation (ramp up then
> > > +		    down, dwelling at limits).  
> > 
> > Some sort of trapezium wave?  Maybe this and continuous forms are combined
> > and we have a separate dwell time control?  
> 
> Yes, sort of. Dwell control is made by an external pin (DRCTL), often controlled
> by an FPGA to achieve certain required timings. I can say that software control
> is not really recommended, unless only a one-shot ramp is necessary.

So is it worth exposing this software control at all?  Maybe just make it a firmware
description problem as to whether that DRCTL is connected or not.

> 
> When adding the IIO backend support, extendend attributes will be added to
> support control of dwell times.
> 
> >   
> > > +		  - "ramp_down": No-dwell low; the ramp resets to upper
> > > +		    limit upon reaching the lower limit.
> > > +		  - "ramp_up": No-dwell high; the ramp resets to lower
> > > +		    limit upon reaching the upper limit.
> > > +		  - "bidirectional_continuous": Both no-dwell high and low;
> > > +		    the ramp continuously sweeps without dwelling.  
> > 
> > Triangle wave?  bidirectional continuous is a rather confusing term so maybe
> > we should rethink this one.  
> 
> Mostly yes, but not only that. Sawtooth can be achieved as well by changing
> the step sizes, also other weird patterns can be achieved by toggling DRCTL pin.

Sawtooth is kind of a special triangle wave with one very steep side.
Wikipedia even has: "It can also be considered the extreme case of an asymmetric triangle wave"
https://en.wikipedia.org/wiki/Sawtooth_wave

> This mode is the most useful when one does not have an FPGA and want to save
> resources on controlling the DRCTL pin. That mode name comes from the datasheet,
> so I suppose it was fine.

Let us see if we can get more opinions on this.  Whilst I can see the logic of
the datasheet naming, it's a bit obscure.

> 
> > > +
> > > +		Valid values for RAM control channel:
> > > +
> > > +		  - "direct_switch": start address defines fixed word to be used
> > > +		    by the selected profile.
> > > +		  - "ramp_up": One-shot ramp up through current profile's address
> > > +		    range.
> > > +		  - "bidirectional": Ramp up then down through PROFILE0 pin.  
> > 
> > Avoid specifics like this.  Can we call external control pin or something like that?
> >   
> > > +		  - "bidirectional_continuous": Continuous ramp up/down
> > > +		    through current profile's address range.
> > > +		  - "ramp_up_continuous": Continuous ramp up through
> > > +		    current profile's address range.  
> > 
> > I guess this goes back to start on finishing ramping up?  
> 
> Yes, any dwell time should be considered when loading the "waveform" into the RAM
> 
> >   
> > > +		  - "sequenced": Sequenced playback of RAM profiles up to
> > > +		    the active profile. Requires active profile > 0.  
> > Is this just running through each profile one after another? (other than profile 0)?  
> 
> for this, this would be the actions:
> - configure all desired profiles (0 up to X) 
> - Set the operating mode to sequenced (profile X would be active at this point)
> - Enable RAM mode
Ah. This reflects on the profile control above. As I mention there I'm not sure we
shouldn't separate the use of profile for tones (where it is symbol like) to that
for RAM addresses.

For the ram addresses I think I'd expose separate attributes for each (there aren't
that many) rather than a selector + controls.

Another option would be to push the control of this into the firmware files
(some sort of header).  Whether that is sufficient would depend on the usecases
for the device.  It would definitely make for an easier runtime configuration
though!

> 
> When RAM mode is enabled, it would trigger the execution of profiles 0 up to X,
> in sequence, according to the configured address range and sample rate for each profile.
> When one profile ends the next starts until profile X finishes.
> 
> > > +		  - "sequenced_continuous": Continuous sequenced playback
> > > +		    of RAM profiles up to the active profile. Requires
> > > +		    active profile > 0.  
> > Similar to above, maybe separate out dwell time if that's the difference between
> > sequenced and sequenced_continuous.  
> 
> The difference here is that when Profile X finishes, Profile 0 starts again.
> So the previous one is kind of an one-shot mode of multiple profiles in sequence

They had fun designing this didn't they!

Anyhow, I think we'll need to work through a few more versions of this to get
as extensible an interface as possible.

> 
> ...
> 

