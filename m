Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A6E3D091B;
	Wed, 20 May 2026 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270905; cv=none; b=kDcSiq2ZLYP7XvksrljRQo+a6WQB0iD8ts48vWuS2EQx4IGaYSrZ8+21A950mG2bEqXZpVqD/3x8PuVIrAGYC37vtw3jISKV1exRdh8rlEJUCb1KqdhyFJIqdP+zE5cHWrJmgKH4I3rSJ7SAwLSkEWuF3BXNSEBBPH6kB5zDI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270905; c=relaxed/simple;
	bh=W/ETVLQPiLWnEVzKK7qPp+AucWqlm4vH3u/jl9ung40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1F9ZmgLEuR9lZ35rDeQRCyMM02aM+8ThBLgf3jUsH/N/CIOpizzxrye4jWHrF4nSg1ZP35vDviMWp865M+TWv+gYAm4rZbu8fTTpn6xF/5OL8/kUlA8U1WbJwB/tSEntl43touSjZsgjs4XGyL7r1CMDX8B1GdJl6VAQC+/Rp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kubQ3jql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kubQ3jql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEB21F000E9;
	Wed, 20 May 2026 09:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779270903;
	bh=1rR11SLMve5z99TMpOCckaXfI3pjGLYjtT01yolVcVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kubQ3jqlcjIHtJBWJBC/to3LSIkAaMm0l7XhtMWuGGmjExiV5CkoCbKTUfd3BvVhj
	 eoS3nNKCqeYOwtIRPbX9yNtLX5Q0aMkyU0vxOdFjrnWPWo+D9A27XF+2A/bF71fC2/
	 qMKLiG3fY/sZZZLYyNuL/nsSrYJQz/eEtNKr1beBxg4CPz4j4HqGkkmPj8jXYWGYUi
	 +2s+wVVk70cgtJFgWGgQ9kcnhHkp+x97sWJ41S6cdb8sO5WKyo8D0cP2Cgy3VdKM9d
	 6eeeQIeBT3FHMyWMXtOcnlKqyxJmAtteMMhXQe0T3nJRFXcERFCpdBcykGgGXJ07Zv
	 k2yiMhfy9ywyQ==
Date: Wed, 20 May 2026 10:54:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 09/10] Documentation: ABI: testing: add docs for
 ad9910 sysfs entries
Message-ID: <20260520105450.7fae5de1@jic23-huawei>
In-Reply-To: <pkx5v4od3wkyyzxomfrjf4ei7leboadzth262xnl55fvu76pf3@yqrezmo6gtq7>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
	<20260508-ad9910-iio-driver-v4-9-d26bfd20ee3d@analog.com>
	<20260517155843.7f833658@jic23-huawei>
	<yrabhhhdkzmiuxlqzrrj6a47ftlzwvva7r2korzeszdy4yqrin@xl6obhhnnas4>
	<20260518144537.7c998308@jic23-huawei>
	<pkx5v4od3wkyyzxomfrjf4ei7leboadzth262xnl55fvu76pf3@yqrezmo6gtq7>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 16:27:23 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/05/18 02:45PM, Jonathan Cameron wrote:
> > On Sun, 17 May 2026 18:30:27 +0100
> > Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> >   
> > > On 26/05/17 03:58PM, Jonathan Cameron wrote:  
> > > > On Fri, 08 May 2026 18:00:25 +0100
> > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > >     
> > > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > > 
> > > > > Add custom ABI documentation file for the DDS AD9910 with sysfs entries to
> > > > > control Parallel Port, Digital Ramp Generator and OSK parameters.
> > > > > 
> > > > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>    
> > > > I'm fine with phase and frequency as defined, but for the scaling it made me wonder.
> > > > For outvoltage0 channels the assumption the value is the peak voltage so if
> > > > we know what input to be modulated by the ramp generator can we express them
> > > > in volts (well milivolts) rather than as a scaling multiplier?    
> > > 
> > > The DAC output is current-based and differential. Voltage conversion would happen
> > > outside the device...  
> > 
> > Why aren't we representing this as out_altcurrentX-Y_xxxx?  
> 
> Good point! altcurrent makes more sense than altvoltage if we want to use raw to
> control the output level rather than scale, which would be a constant to convert
> raw into current units (what is the one that is used in the sysfs ABI? Ampere, mA or uA?)

Same as non alternating version so mA (which is a historical design error we have
long been stuck with :()  The altvoltageY_raw docs don't give a unit either.
If you don't mind, please send a patch adding that whilst you are here.
Same mid to peak - hopefully that is what any users not modifying to RMS have
been doing!

Seems we either never had one or that particular bit of ABI doc is missing.
Please add an entry for altcurrentX_raw

> 
> Not sure about the benefits on setting "differential" in channel spec.. the name would
> become out_altcurrentX-altcurrentY_xxxxx...

Becomes a question of whether it is useful to represent that - maybe not
in this particular case.

> 
> Is there any modifier for amplitude/peak/envelope? I see IIO_MOD_RMS, which could be used
> if adding a 1/sqrt(2) factor to the fixed scale.

For altcurrent / altvoltage assumption is it's mid to peak.  Unless the modifier switches
it to RMS as you've noted.

> 
> Then, I would consider something like out_altcurrent_rms_xxxx as a good alternative.
> 
> "scale" would be a constant in the top-level phy channel
> 
> single tone profile channels would have:
> - frequency
> - phase
> - raw
> 
> drg ramp up/down channels:
> - frequency and frequency_roc
> - phase and phase_roc
> - raw and raw_roc
> 
> parallel port channel(s):
> - frequency_scale and frequency_offset (frequency destination)
> - phase_offset (polar destination)
> - offset (polar destination)
> 
> osk channel:
> - raw
> - raw_roc
> 
> raw_roc could be just roc, but that sounds like it carries the scale and refers to
> a current value? and maybe that breaks consistency with other destination attributes?
> I am fine with just roc if that refers to the raw value, not (raw * scale).

This is a good question.  We ran into ambiguity with events where we have to derive
if it is _raw or _processed for the thresholds based on whether the main attribute
is _raw or _processed.  Nice to avoid doing that again.

I'd be interesting in others views on this but to me raw_roc seems fine.

> 
> With all the above, still using altvoltage is not incorrect, just a matter on how
> we want to express the units.

Agreed - but to get to directly useable values we'd need to provide info on the
external circuit - and given we are dealing with AC signals that is tricky to do
in a compact way.


> Note that using raw instead of scale to control the
> amplitude is just another option to tackle the problem. I suppose that the
> important thing here is being technically corrent and consistent in terms of
> usage. Maybe out_altcurrent_rms_* is more clear in terms of amplitude level.

Agreed.  It is always (?) possible to switch between scale and raw.
For an ADC the distinction is clear as we can't control _raw. For a DAC it all gets
rather value as we can logically control both and for an AC type of DAC / DDS it
all gets less intuitive.  As you say, consistency is key.

I'd like us to at least be consistent across DDS devices. Perhaps we need some
general documentation on whatever the outcome of this discussion is to record
some of the logic behind those decisions.

> 
> > 
> >   
> > > using a resistor load or an op-amp transimpedance stage,
> > > and I am no expert on that, but that often requires impedance matching so voltage
> > > levels may depend on the frequency. Then, I suppose that voltage is not the right
> > > unit to use.  
> > 
> > Understood that it can get complex!  
> > > 
> > > The scale here controls the amplitude of the varying signal. Assuming the peak voltage
> > > (amplitude) is constant means we have a constant envelope, but that should not mean
> > > we can't control it or it should not mean that the hardware can have other ways to
> > > control it. That said, scale behaves as a "gain multiplier".  
> > Understood. Given it's the envelope then if scale happened to be 1 always it would
> > be presented as _processed. So this is consistent with other channel types.
> >   
> > >   
> > > > 
> > > > That seems to me like it fits better with the overall ABI.
> > > >     
> > > > > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_offset
> > > > > +KernelVersion:
> > > > > +Contact:	linux-iio@vger.kernel.org
> > > > > +Description:
> > > > > +		For a channel that allows amplitude control through buffers, this
> > > > > +		represents the value for a base amplitude scale. The actual output
> > > > > +		amplitude scale is a result with the sum of this value.
> > > > > +    
> > > >     
> > > > > +
> > > > > +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_roc    
> > > > 
> > > > Silly question perhaps but can work out how this related to millivolts/sec
> > > > That might make a more intuitive interface than scaling multiplier per sec
> > > > Perhaps the combination with offset makes this impossible though maybe that
> > > > could be a expressed as a voltage offset?  Afterall if the amplitude being
> > > > scaled is 5V then 5 * (offset + scale) = 5 * offset + 5 * scale
> > > >      
> > > > > +KernelVersion:
> > > > > +Contact:	linux-iio@vger.kernel.org
> > > > > +Description:
> > > > > +		Amplitude scale rate of change in 1/s for channels that ramp
> > > > > +		amplitude. This value may be influenced by the channel's
> > > > > +		sampling_frequency setting.    
> > > > 
> > > >     
> > >   
> >   
> 

