Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48AB31E83D;
	Sat, 15 Aug 2026 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786757962; cv=none; b=C7dxBwP0RYuuCE5g/wpEcsf1I3V+G5DbPcUge1BKGZic+GN8ZOASLR1+XRr8tRMEY7R4Z6nKvqEHHUkhyc9WbLeIrxc6RSpp7QmXXIAE2UQw653ADVbYR34jRiwDN9LcHWmHZgc+Mny8Nk4Cd8NMcmifLQPnisA+X1we99fuSDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786757962; c=relaxed/simple;
	bh=VGKh7Y2uTGPv+Bqx1/FNG4EIXk/YfozmmsiYrcqw9VM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJ4AwJmbLhKPL5AoMTlvVO7brHAoGt1ofcyqWLiY7IFB49PacB5tu7DS9d19QrvxjWS4MQSjHZ5WJdSQZCiAVAkSSTOhZcGjnlZWV3AXOj1JKK5Z0Hc8s30ot30IpUVJddOqk9WeOOfDktaaeST5KSArOXryTmcYVMy9LLuMBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjUwTaK5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjUwTaK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE55F1F000E9;
	Sat, 15 Aug 2026 01:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786757961;
	bh=jTdN+B5hSCNhKbsIP5r52sVZ5ixNeRV1nXZ5gyVhTFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RjUwTaK5ku1vrjV5oexqRhKilppS9d27d/nDbOxYlzEIUY/RqOPxujxg78Dwpx6m4
	 8gIRQ2qpgp9y0tucKXNUOYwwc5fKLXmUQJruzh1B9x99UQwb2/WZPAYaMGdxcBWZYv
	 onhtwHvGK8SuUiCAfH65ZrKK6OMQiFLKKMoDHAOSg8+TxrEpeDShSeTI8cUu8WXwkZ
	 PV79kfe1mAEFM9jhgQKrAz3S6vGYRNMUdGxPF0ij4g1ZjhUIwmqNWAKbXcsBNi1rCc
	 dUNajh+tIykQikE9x19PVKCLlLDVwgc3M8/Ocg3+g56EDzhKW4IgkNSijvhvkR7T2c
	 /KjOVpgFv0Z+g==
Date: Sat, 15 Aug 2026 02:39:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 julianbraha@gmail.com
Subject: Re: [PATCH v9 6/6] iio: ABI: Encourage differential voltage ABI
 usage
Message-ID: <20260815023908.093a1fc8@jic23-huawei>
In-Reply-To: <any6pe6PBSR1uCZV@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1785186980.git.marcelo.schmitt@analog.com>
	<959734dd1111f76c5928515b82dd17f3a9dff5c8.1785186980.git.marcelo.schmitt@analog.com>
	<20260812050051.4313cd91@jic23-huawei>
	<any6pe6PBSR1uCZV@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 15:25:41 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 08/12, Jonathan Cameron wrote:
> > On Mon, 27 Jul 2026 18:32:18 -0300
> > Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> >   
> > > So far, parts that could only do differential voltage measurements were
> > > only required to have a consistent labeling of their channels by complying
> > > either to voltageY or to voltageY-voltageZ ABI. Over time, code maintainers
> > > came to the conclusion that the voltageY-voltageZ ABI is better suited for
> > > differential-only chips as it provides a simple indication to users that
> > > the channels measure the difference of two inputs.
> > > 
> > > Adjust the ABI documentation to recommend using the voltageY-voltageZ ABI
> > > for chips that do only differential voltage measurements.
> > > 
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>  
> > Hi Marcelo
> > 
> > Whilst looking at another series, I noticed we did something different
> > again in the devicetree bindings for those devices that have
> > restrictive muxes that means the positive and negative lines
> > always change together.  For those we let
> > 
> > diff-channels = <1 1> 
> > which tends to map to
> > 
> > in_voltageX-voltageX_raw  
> 
> Hmm, that sounds awesome. Probably a much more accurate way of presenting the
> channel(s) to user space. Wish I had realized that earlier.
> 
> > 
> > I'm not sure if we want to explicitly call that out as an option.
> > There is nothing in your new text saying we can't do that.  
> 
> I'd say probably best to mention the voltageX-X case. These fully differential
> inputs (that have the positive and negative lines changing together) are not uncommon.
> Sure, let me write something more comprehensive.
> 
> It would also be best to use that notation for ltc2378. IIRC, it's okay to not
> specify the ADC channels in dt if all channels have the same properties so no
> need to update the dt-doc. For the IIO driver, we have the channel sysfs entries
> changing name. Will send v10 in case there's still any chance to get it updated.
> Also okay to wait for the next release cycle if possible.

Feel free to end an update and we'll sneak it in during the RCs as an 'abi' fix
(sort of) Stick a note asking me to do that under the --- so I don't forget.

Jonathan

> 
> > 
> > Worth also noting there are short circuit parts where you
> > really do connect both ends of the differential ADC to the
> > same input pin. I think it can be useful for testing / calibration?
> > 
> > Jonathan
> >   
> 
> Thanks,
> Marcelo
> 
> >   
> > > ---
> > > No changes in v9.
> > > 
> > >  Documentation/ABI/testing/sysfs-bus-iio | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > > index 5cc2e82c4997..7446e07b9ab2 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > > @@ -162,10 +162,11 @@ Contact:	linux-iio@vger.kernel.org
> > >  Description:
> > >  		Raw (unscaled) differential voltage measurement equivalent to
> > >  		channel Y - channel Z where these channel numbers apply to the
> > > -		physically equivalent inputs when non differential readings are
> > > -		separately available. In differential only parts, then all that
> > > -		is required is a consistent labeling.  Units after application
> > > -		of scale and offset are millivolts.
> > > +		physically equivalent inputs when non-differential readings are
> > > +		separately available. Even though differential-only parts had
> > > +		been merely required to have consistent channel labeling, this
> > > +		ABI is preferred over the non-differential one for those chips.
> > > +		Units after application of scale and offset are millivolts.
> > >  
> > >  What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_rms_raw
> > >  KernelVersion:	6.18  
> >   

