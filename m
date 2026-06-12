Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885DE1D61B7;
	Fri, 12 Jun 2026 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781287550; cv=none; b=EfJIZJokMzyfW544vSZafEgv+dTw31qJhcm2J+QuyuKod/3nHESCuN/Mgk20MRdU4c4PUfVQKI2G6dhz28z1zI2y0lWYVmjwGFK9oTplBV83BslkcXfnuEHFtDN0y8xlTIgWIi/e/xkYWaBhJxME3GNNDc2CUamV8ueQRCyhZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781287550; c=relaxed/simple;
	bh=rzyUVhdnKI3cuw3sDHkyh2Nf+fYeMexo9/BsW/DFsDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+9weDC9vVrg4fgr/lluKQ24KUs3vXkZBQvZxKcdkCJgK71ffAnAa5CRTNz6cTEXAxqK0gSTUxAcXhF/xDO+ipIFDSgzsc4n3r62UuLpkqzha4SAJI6FS/oGrPCwF5bGAkO1XMQEYcc9Y1WXT+Q3kzxx+VzM8xunVjCZYqKdy28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyPTqbQu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyPTqbQu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE3C1F000E9;
	Fri, 12 Jun 2026 18:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781287549;
	bh=rlKAWtaO3uaUXKIY3jGJo6R5ZGfhVrWc+hm9+wCBlgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UyPTqbQuTxjjwyr5nkBA/+uQzIsay1d6TvIfgGaHSYolh7q6L5DeF36UDumYq051K
	 clKIPUtMONhkwR6CQhJb2uHArS36KhCruL2P+tZjFniM2PVBfwf0KHCpvj7e3W2Q/p
	 MeWERiYDWpBbXhEaKqcj+VPV/9wGDf/4Ni+eSVjCw+BjgjlEYDpiQAh2latpK3PbpV
	 310bRErke/zY0liwIjDQP4rPZGiCfPfgOIXd+Etx/Lk8P2dKwrCIuGx29grrWy06ZB
	 t7NGr91cM3w/0aj5AQgMSIMDT7oEECJ9H2Vcz3+ARsbaF3ANJ1GL40SSVKAv+YB/2o
	 mfy2NWG3p9Qeg==
Date: Fri, 12 Jun 2026 19:05:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wadim Mueller <wafgo01@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: flow: add Sensirion SLF3S
 liquid flow sensor
Message-ID: <20260612190543.34d90b87@jic23-huawei>
In-Reply-To: <20260607-quixotic-steel-puma-133410@quoll>
References: <20260530205435.37326-1-wafgo01@gmail.com>
	<20260530205435.37326-3-wafgo01@gmail.com>
	<20260601-banana-narwhal-of-music-0b4d3a@quoll>
	<20260601150959.49bbf125@jic23-huawei>
	<1dbd3ab3-de6c-44dd-8100-e8ee60f558c8@kernel.org>
	<20260604100304.11d0e003@jic23-huawei>
	<200a6c34-3321-4c2c-9746-52348e700cd9@kernel.org>
	<20260605132135.141422d8@jic23-huawei>
	<20260607-quixotic-steel-puma-133410@quoll>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Jun 2026 10:30:07 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Fri, Jun 05, 2026 at 01:21:35PM +0100, Jonathan Cameron wrote:
> > On Thu, 4 Jun 2026 13:22:17 +0200
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >   
> > > On 04/06/2026 11:03, Jonathan Cameron wrote:  
> > > > On Wed, 3 Jun 2026 16:29:10 +0200
> > > > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > >     
> > > >> On 01/06/2026 16:09, Jonathan Cameron wrote:    
> > > >>> On Mon, 1 Jun 2026 13:53:23 +0200
> > > >>> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > >>>       
> > > >>>> On Sat, May 30, 2026 at 10:54:31PM +0200, Wadim Mueller wrote:      
> > > >>>>> Document the bindings for the Sensirion SLF3S family of digital
> > > >>>>> liquid-flow sensors on I2C.  The family currently covers the
> > > >>>>> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.
> > > >>>>>
> > > >>>>> The driver auto-detects the variant from the product-information
> > > >>>>> register at probe time; the per-variant compatible strings exist
> > > >>>>> for documentation and dt_binding_check purposes.        
> > > >>>>
> > > >>>> Here...
> > > >>>>      
> > > >>>>> +description:
> > > >>>>> +  Family of digital liquid-flow sensors from Sensirion with I2C
> > > >>>>> +  interface.  All family members share the same register map; sub-types
> > > >>>>> +  differ only in the flow scale factor and the calibrated measurement
> > > >>>>> +  range, both of which are detected at probe time via the
> > > >>>>> +  product-information register.        
> > > >>>>
> > > >>>> And here...
> > > >>>>      
> > > >>>>> +
> > > >>>>> +properties:
> > > >>>>> +  compatible:
> > > >>>>> +    enum:
> > > >>>>> +      - sensirion,slf3s-0600f
> > > >>>>> +      - sensirion,slf3s-1300f
> > > >>>>> +      - sensirion,slf3s-4000b        
> > > >>>>
> > > >>>> And here something else. Confusing. Didn't you say device variants are
> > > >>>> auto-detectable? So you have only one compatible sensirion,slf3s.      
> > > >>>
> > > >>> And then future fallback compatibles can never work. 
> > > >>> Basically as far as I have ever been able to establish this is why
> > > >>> generic compatibles are almost always the wrong way to go.
> > > >>>
> > > >>> If we get a future part with an unknown ID and don't have these existing
> > > >>> specific compatibles, then we have no way to specify which one it is      
> > > >>
> > > >> But why would you have future part with unknown ID?    
> > > > 
> > > > That's what manufacturers do on a very frequent basis.  They tweak something
> > > > that has no affect on the interface or channel scaling etc and release a new part
> > > > with a different ID.  Can be something like a part suited to different operating
> > > > conditions, or with a different supply tolerance.    
> > > 
> > > and it will have a different, known that time ID. How could be "unknown"?  
> > 
> > Known to us, sure, know to old kernel (or other software), not so much.
> > For this sort of driver the main use of fallback compatibles is to work on
> > a not yet aware kernel.  
> 
> So you mean a case that sometime in the future, someone will write a DTS
> with sensirion,slf3s fallback for a sensirion,slf3s-WAHTEVER_NEW_MODEL, use
> old kernel and be surprised it does not work?

To me that is exactly what a fallback compatible is promising - if we have
any kernel / driver that supports the part that we are saying is a valid
fallback then we are saying we support at least the functionality of that
part (sure there may be extra stuff that doesn't work)

We had a long discussion a few years back on whether code that did

	if (read_reg_whoami() != EXPECTED_ID)
		return -ENODEV;

was correct. Someone (maybe Rob?) strongly argued that we must not
do that because it effectively made fallbacks pointless as we always
needed to upgrade the driver. I argued against this (on basis that
swapping in incompatible parts is annoyingly common) but was eventually
persuaded.

If that is not a valid reading of what fallback compatibles mean, is
there any documentation of the rules I can refer to?

> 
> Our goal is not to stop whatever poor code people can ever come up with.
> 
> Every future user wanting to the fallback MUST understand what the
> fallback means.

This is where we disagree.

This is not hard to support, it just means not using generic compatibles
when the device differ (and they are not self describing which these are
not).

Jonathan


> 
> >   
> > >   
> > > >     
> > > >>
> > > >> The device is slf3s with variants. All of known variants have an
> > > >> interface to detect the actual variant. There is no indication that this
> > > >> won't work - why would company remove the ID register?    
> > > > 
> > > > They won't remove the ID, but they will put other values in it to
> > > > indicate new revisions of a part - often entirely backwards compatible
> > > > - sometimes with extra features that we don't use until the driver is updated.
> > > > 
> > > >     
> > > >>
> > > >> But even if this happens, then it would be change of device interface,
> > > >> thus you cannot use generic compatible and you will have a new dedicated
> > > >> compatible.    
> > > > 
> > > > We've had this discussion a number of times for whether an ID register difference
> > > > alone makes a device non compatible, and the answer from DT review has always been
> > > > a firm no and that it is incorrect to reject an unknown ID if the dt-compatible    
> > > 
> > > True, but this is not the case here. That incompatible device would
> > > simply not use this compatible, thus it will not start the probe.  
> > 
> > Taking a rather extreme viewpoint: So fallback compatibles are pointless why do
> > we bother with them?  Note this ID register thing covers most IIO drivers that
> > have fallback compatibles today. This is not a rare corner case.  
> 
> Fallback would not be pointless. It would be used to match and bind the
> driver. Without fallback, driver would not match.
> 
> 
> >   
> > > 
> > >   
> > > > is known.  The compromise that people were happy with was an info print if
> > > > such a mismatch is detected as it might indicate an incompatible part replacement
> > > > and a broken DT.
> > > > 
> > > > Probably 80%+ of IIO bindings with fallback compatibles do not have
> > > > matching "who am I" register values.  This is incredibly common.
> > > >     
> > > >>
> > > >> If the device is actually "slf3s-0600f" (because slf3s is a family),
> > > >> then I am fine with using that as the fallback. Specific front
> > > >> compatibles are also fine in such case.    
> > > > 
> > > > Yes, it's a part in the family. Each of the compatibles here has a
> > > > separate datasheet:
> > > > 
> > > > https://sensirion.com/media/documents/C4F8D965/66F56F53/LQ_DS_SLF3S-0600F_Datasheet.pdf
> > > > https://sensirion.com/media/documents/6971528D/63625D22/Sensirion_Datasheet_SLF3S-1300F.pdf
> > > > etc
> > > > 
> > > > (wonderfully inconsistent file naming ;)
> > > >     
> > > >>
> > > >>
> > > >>    
> > > >>> compatible with.  Given these are providing scaling info that means we
> > > >>> can't realistically support such a future part with a fallback at all.
> > > >>>
> > > >>> That would only be possible if there was feature level discovery. A single
> > > >>> whoami register with no structure to the value is useless for this.      
> > > >>
> > > >> The whoami register defines all the features, no? What would feature
> > > >> discovery improve? ID register is simply logical OR of some feature set,
> > > >> still uniquely identifying the features set/variant.    
> > > > 
> > > > Would be lovely if true. Sadly almost never true. They are typically just
> > > > the next number in a list of parts released. There is no direct information
> > > > on feature set encoded in that value, we have to have a look up table in
> > > > the driver to translate to feature set. (Not relevant here but sometimes
> > > > manufacturers forget to change the number and we get different feature
> > > > sets with the same ID and no discoverability)    
> > > 
> > > I did not mean there is direct information. I meant that you can create
> > > such map, so basically it is defining all features.
> > >   
> > > > 
> > > > If they were an OR of features that would be great.
> > > > 
> > > > The thing is a little structured in this case
> > > > 
> > > > 0x07         Liquid flow sensor
> > > > 0x  03       Product family (e.g. SLF3x)
> > > > 0x    03     Subtype (e.g. SLF3S-0600F)
> > > > 0x      02   Revision number (changes with minor firmware or hardware revisions)
> > > > 
> > > > But both the product family and subtype are numbers to feed into look up tables
> > > > (maybe revision number as well)    
> > > 
> > > The values don't matter. What only matters is that each is unique, you
> > > can map it to a real device (and its datasheet) and features are
> > > decodable from the datasheet.  
> > 
> > Sure, but as above, that breaks the use of fallback compatibles for the incredibly
> > common case of otherwise identical parts that would work fine on an old kernel
> > but where we can't match them because the ID register differs.  
> 
> And it is not a problem. Every other case would not work either. If you
> have specific compatibles - such device would not work. If you have
> fallback with ID mapping to features - such device would not work.
> 
> In all cases device would not work.
> 
> Best regards,
> Krzysztof
> 

