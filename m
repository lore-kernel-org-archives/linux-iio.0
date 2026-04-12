Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FB1125A9;
	Sun, 12 Apr 2026 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776005678; cv=none; b=HvRdYsNbUTb1RkSmVWKbh4X7kRUmzb23HDB1PLsn+depwfFjErWgGaIX1FPBI6kwhGwxu4TZnhETUgb5JUAeZ/3X80vv8NowSsKyjo9WragQILTw4iAM3QMPBREWh7xbpS4ymkFsuhd6ZPkj6h9xjJndh0ngf29sbkx2T6uXZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776005678; c=relaxed/simple;
	bh=NkiAtmo2ZMwCRO/bVg6izOjSdsiVk0fjZdPm96320zk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MItZ8C90rw+yKcRipZ+rfP5mBEWTcfO9RwJKkWI8mV1rb0eV47+f2pZS41cjwI6MAE0lRNLQKpCw8KqJ/w9nrTVA1Z69HMh4sJ8Vqt9Sfj4866NYQlyISq6OUfcDB5h5BjFSDPoM4/YBHbNgpQeIyYkApj8Ps08ruH2dRk/94jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTFzCcPw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTFzCcPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F190CC19424;
	Sun, 12 Apr 2026 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776005678;
	bh=NkiAtmo2ZMwCRO/bVg6izOjSdsiVk0fjZdPm96320zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CTFzCcPwyFiQsC4cPwTuFzGqemJQsRbhmiqyJX6kG/VNu1o2DvhQUT5LyV0R8Au1X
	 EiyyjUGtoEEdzYSwx2Suo7boWpVrxVzFSONq8JZMkRX7VIdP0P61xaVQGT1zPlyGnt
	 M/UNu+5pR9/gaUS3yTDU4CNnrkYwmn0aTQYkX0Bd48IMgwZLMmAyOCoMeaqcL/jc/5
	 Pc/eq41SvSXop3m0yGCslSPAtjO4Mn9bch8Dsa6e0lHnZZ1eJKU8JzVEvRbgLdjHD/
	 Hpa7fnGo01/lICo0yzfloYKJi1N4eumm+4c/bQ5DRXhLRDGlHEgjg7veVCDXi+3fOC
	 SsVPygl+k6G6g==
Date: Sun, 12 Apr 2026 15:54:27 +0100
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
Subject: Re: [PATCH RFC v2 9/9] docs: iio: add documentation for ad9910
 driver
Message-ID: <20260412155427.2f11ca63@jic23-huawei>
In-Reply-To: <g57xnbhtvu25dvzy5b5pz76yzalpcjpnyclob6dy6j7fphxqle@5vww7psogbv3>
References: <20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com>
	<20260318-ad9910-iio-driver-v2-9-e79f93becf11@analog.com>
	<20260322173434.23d2ee0d@jic23-huawei>
	<g57xnbhtvu25dvzy5b5pz76yzalpcjpnyclob6dy6j7fphxqle@5vww7psogbv3>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 11:58:53 +0000
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/03/22 05:34PM, Jonathan Cameron wrote:
> > On Wed, 18 Mar 2026 17:56:09 +0000
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add documentation for the AD9910 DDS IIO driver, which describes channels,
> > > DDS modes, attributes and ABI usage examples.
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>  
> 
> ...
> 
> > > +Channel hierarchy
> > > +=================
> > > +
> > > +The driver exposes the following IIO output channels, each identified by a
> > > +unique channel number and a human-readable label:
> > > +
> > > +* ``out_altvoltage100``: ``phy``: Physical output: system clock and profile control
> > > +
> > > +  * ``out_altvoltage110``: ``single_tone``: Single tone mode: per-profile
> > > +    frequency, phase, amplitude
> > > +
> > > +  * ``out_altvoltage120``: ``parallel_port``: Parallel port modulation: enable
> > > +    and offset/scale parameters
> > > +
> > > +  * ``out_altvoltage130``: ``digital_ramp_generator``: DRG control: enable,
> > > +    destination, operating mode
> > > +
> > > +    * ``out_altvoltage131``: ``digital_ramp_up``: DRG ramp-up parameters:
> > > +      limits, step sizes, ramp rate
> > > +    * ``out_altvoltage132``: ``digital_ramp_down``: DRG ramp-down parameters:
> > > +      limits, step sizes, ramp rate
> > > +
> > > +  * ``out_altvoltage140``: ``ram_control``: RAM playback: enable, destination,
> > > +    operating mode, address range
> > > +
> > > +  * ``out_altvoltage150``: ``output_shift_keying``: OSK: enable, amplitude
> > > +    scale, ramp rate, auto/manual control
> > > +
> > > +The ``phy`` channel is the root of the hierarchy. Changing its
> > > +``sampling_frequency`` reconfigures the system clock (SYSCLK) which affects all
> > > +other channels. The ``profile`` attribute on this channel selects the active
> > > +hardware profile (0-7) used by the single tone and RAM channels.  
> > I asked out this profile thing in one of the other patches.  Key to me is
> > that how we write non active profiles?  The most similar thing we've seen
> > in the past has been setting other frequencies for FSK or phases for PSK or
> > more mundane DC DAC output that are symbol based. (often an external signal)  
> 
> Yes, not allowing to configure a non-active profile at this point.
> Initially was not seeing this as a problem, but would you think different
> channels for each profiles should be created? e.g.:
> 
> - out_altvoltage111 ... out_altvoltage118 for single tone profiles; and
> - out_altvoltage141 .. out_altvoltage148 for RAM profiles
> 
> That would not remove the need for something like the profile attribute.
Yes. I'm thinking it would be something along those lines. 

I think the tone and RAM profiles end up with totally different controls
so this should make it clear they aren't related.

> 
> > For those we have added an additional index so we can see which symbol we
> > are changing parameters for.  Here it might need to be done in the channel
> > numbering. I'm not sure.
> >   
> > > +
> > > +All mode-specific channels (parallel port, DRG, RAM, OSK) have an ``enable``
> > > +attribute. The DRG and RAM channels additionally have ``destination`` and
> > > +``operating_mode`` attributes that configure which DDS core parameter is
> > > +modulated and how.  
> > 
> > I wonder if we flatten things out and have separate channels for each type
> > of modulation. Might lead to a more standard looking interfaces. We don't really
> > have a standard path to control one type of thing feeding another, whereas
> > we do have simple 'enable' interfaces.  
> 
> ...
> 
> > > +RAM mode
> > > +--------
> > > +
> > > +The AD9910 contains a 1024 x 32-bit RAM that can be loaded with waveform data
> > > +and played back to modulate frequency, phase, amplitude, or polar (phase +
> > > +amplitude) parameters.
> > > +
> > > +RAM control channel attributes
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > +.. flat-table::
> > > +   :header-rows: 1
> > > +
> > > +   * - Attribute
> > > +     - Unit
> > > +     - Description
> > > +
> > > +   * - ``out_altvoltage140_en``
> > > +     - boolean
> > > +     - Enable/disable RAM playback. Toggling swaps profile registers between
> > > +       single tone and RAM configurations across all 8 profiles.  
> 
> ...
> 
> > > +   * - ``out_altvoltage140_address_start``  
> > Do we need this flexibility to set the start?  We needed a length, but
> > if we want different effective start can just load a different image.  
> 
> There is one image being loaded into the entire RAM and each profile may choose
> from wich sample it starts and ends its address ramp.
> The profiles can have those address ranges to overlap or not, then I suppose
> considering different images would just complicate things.

In the ABI docs discussion I raised the question on whether it makes more
sense to push this 'meta data' into the firmware image.  Depends a bit
on how costly loading the image is vs just updating this properties and whether
there are significant real use cases where tweaking what is run from the
image apply. I can easily conjecture some. I just have no idea if they are
real!

Thanks,

Jonathan

> 
> > > +     - integer
> > > +     - Start address for the active profile. Range [0, 1023]. Cannot be
> > > +       changed while RAM mode is enabled. If set above current end address,
> > > +       end address is automatically adjusted.
> > > +  
> 
> ...
> 

