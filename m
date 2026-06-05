Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E44395AE6;
	Fri,  5 Jun 2026 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662106; cv=none; b=D6CDARlf5Y8oXZm72S6ZmhF4lziqXe3KBdr8hmIVacfCQcJ5a83ANxlhz2XS7kW092gncVARiQzvDr+IpWNDEjxPKjbIiN7YhirneI2qLuPfDZm4Qxk6FiIetrgbLpNafvjzdVX7d9JwEi4sidYWhy17XKbYH1jOzmFK4Rbg5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662106; c=relaxed/simple;
	bh=EzEe99BGdyE+IhKLX+p1ohqWbUKxgEYjpzUORcc5RaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJBiA8l5qnKo7i3Za7Vc1E8zifyuQ4JPX8ttt3i1U8uZq2/k1lx/vLFKixcJ8ajfI+p5lYH6/0AF0t984e/StDLT/CMDArZfShr0Ic0fYZ/jv6k0bOXIlFlqOAdmfQonHRMB2PfPWrT8EpozvPh7Lqs2EuxxbhukB8An2piWV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MY2qtI/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY2qtI/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308121F00893;
	Fri,  5 Jun 2026 12:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780662104;
	bh=7WAq7cf2ANmWbzJBA5YA+wI49o+hMb7RctwEcT8Zm50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MY2qtI/BwyQXzx4c+p5h8MrAksH2VWQGMM63IFqCu5gRygNQtjnLdq8B4xQx8zEBF
	 ei0FcbYgojKDNytvNBhm5VZ+wNfgi2biWbhtCpLtqAz69wIeDxR/a8kjmih1cNW8Rk
	 Kp/Cpzcp3I9KFXTCaPUYKgrvOT60P7gwPbXvlzvOwJNzsRo2OzK9VPegwTP3WuZu88
	 gqsuLzrtn106hoaqd6sYSG0qgJ/H6sS6NaNcHz1Q66GxQaR4aCmeKzhBPXH7Bth8qG
	 jExzEGiGw9QzYLVwYIqk/qe7MMOptGA7auFLmGl/PU4AYyDyWziKhCjKM5SX2u6PCt
	 o09Bu5B2BCnBw==
Date: Fri, 5 Jun 2026 13:21:35 +0100
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
Message-ID: <20260605132135.141422d8@jic23-huawei>
In-Reply-To: <200a6c34-3321-4c2c-9746-52348e700cd9@kernel.org>
References: <20260530205435.37326-1-wafgo01@gmail.com>
	<20260530205435.37326-3-wafgo01@gmail.com>
	<20260601-banana-narwhal-of-music-0b4d3a@quoll>
	<20260601150959.49bbf125@jic23-huawei>
	<1dbd3ab3-de6c-44dd-8100-e8ee60f558c8@kernel.org>
	<20260604100304.11d0e003@jic23-huawei>
	<200a6c34-3321-4c2c-9746-52348e700cd9@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 13:22:17 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 04/06/2026 11:03, Jonathan Cameron wrote:
> > On Wed, 3 Jun 2026 16:29:10 +0200
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >   
> >> On 01/06/2026 16:09, Jonathan Cameron wrote:  
> >>> On Mon, 1 Jun 2026 13:53:23 +0200
> >>> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>>     
> >>>> On Sat, May 30, 2026 at 10:54:31PM +0200, Wadim Mueller wrote:    
> >>>>> Document the bindings for the Sensirion SLF3S family of digital
> >>>>> liquid-flow sensors on I2C.  The family currently covers the
> >>>>> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.
> >>>>>
> >>>>> The driver auto-detects the variant from the product-information
> >>>>> register at probe time; the per-variant compatible strings exist
> >>>>> for documentation and dt_binding_check purposes.      
> >>>>
> >>>> Here...
> >>>>    
> >>>>> +description:
> >>>>> +  Family of digital liquid-flow sensors from Sensirion with I2C
> >>>>> +  interface.  All family members share the same register map; sub-types
> >>>>> +  differ only in the flow scale factor and the calibrated measurement
> >>>>> +  range, both of which are detected at probe time via the
> >>>>> +  product-information register.      
> >>>>
> >>>> And here...
> >>>>    
> >>>>> +
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    enum:
> >>>>> +      - sensirion,slf3s-0600f
> >>>>> +      - sensirion,slf3s-1300f
> >>>>> +      - sensirion,slf3s-4000b      
> >>>>
> >>>> And here something else. Confusing. Didn't you say device variants are
> >>>> auto-detectable? So you have only one compatible sensirion,slf3s.    
> >>>
> >>> And then future fallback compatibles can never work. 
> >>> Basically as far as I have ever been able to establish this is why
> >>> generic compatibles are almost always the wrong way to go.
> >>>
> >>> If we get a future part with an unknown ID and don't have these existing
> >>> specific compatibles, then we have no way to specify which one it is    
> >>
> >> But why would you have future part with unknown ID?  
> > 
> > That's what manufacturers do on a very frequent basis.  They tweak something
> > that has no affect on the interface or channel scaling etc and release a new part
> > with a different ID.  Can be something like a part suited to different operating
> > conditions, or with a different supply tolerance.  
> 
> and it will have a different, known that time ID. How could be "unknown"?

Known to us, sure, know to old kernel (or other software), not so much.
For this sort of driver the main use of fallback compatibles is to work on
a not yet aware kernel.

> 
> >   
> >>
> >> The device is slf3s with variants. All of known variants have an
> >> interface to detect the actual variant. There is no indication that this
> >> won't work - why would company remove the ID register?  
> > 
> > They won't remove the ID, but they will put other values in it to
> > indicate new revisions of a part - often entirely backwards compatible
> > - sometimes with extra features that we don't use until the driver is updated.
> > 
> >   
> >>
> >> But even if this happens, then it would be change of device interface,
> >> thus you cannot use generic compatible and you will have a new dedicated
> >> compatible.  
> > 
> > We've had this discussion a number of times for whether an ID register difference
> > alone makes a device non compatible, and the answer from DT review has always been
> > a firm no and that it is incorrect to reject an unknown ID if the dt-compatible  
> 
> True, but this is not the case here. That incompatible device would
> simply not use this compatible, thus it will not start the probe.

Taking a rather extreme viewpoint: So fallback compatibles are pointless why do
we bother with them?  Note this ID register thing covers most IIO drivers that
have fallback compatibles today. This is not a rare corner case.

> 
> 
> > is known.  The compromise that people were happy with was an info print if
> > such a mismatch is detected as it might indicate an incompatible part replacement
> > and a broken DT.
> > 
> > Probably 80%+ of IIO bindings with fallback compatibles do not have
> > matching "who am I" register values.  This is incredibly common.
> >   
> >>
> >> If the device is actually "slf3s-0600f" (because slf3s is a family),
> >> then I am fine with using that as the fallback. Specific front
> >> compatibles are also fine in such case.  
> > 
> > Yes, it's a part in the family. Each of the compatibles here has a
> > separate datasheet:
> > 
> > https://sensirion.com/media/documents/C4F8D965/66F56F53/LQ_DS_SLF3S-0600F_Datasheet.pdf
> > https://sensirion.com/media/documents/6971528D/63625D22/Sensirion_Datasheet_SLF3S-1300F.pdf
> > etc
> > 
> > (wonderfully inconsistent file naming ;)
> >   
> >>
> >>
> >>  
> >>> compatible with.  Given these are providing scaling info that means we
> >>> can't realistically support such a future part with a fallback at all.
> >>>
> >>> That would only be possible if there was feature level discovery. A single
> >>> whoami register with no structure to the value is useless for this.    
> >>
> >> The whoami register defines all the features, no? What would feature
> >> discovery improve? ID register is simply logical OR of some feature set,
> >> still uniquely identifying the features set/variant.  
> > 
> > Would be lovely if true. Sadly almost never true. They are typically just
> > the next number in a list of parts released. There is no direct information
> > on feature set encoded in that value, we have to have a look up table in
> > the driver to translate to feature set. (Not relevant here but sometimes
> > manufacturers forget to change the number and we get different feature
> > sets with the same ID and no discoverability)  
> 
> I did not mean there is direct information. I meant that you can create
> such map, so basically it is defining all features.
> 
> > 
> > If they were an OR of features that would be great.
> > 
> > The thing is a little structured in this case
> > 
> > 0x07         Liquid flow sensor
> > 0x  03       Product family (e.g. SLF3x)
> > 0x    03     Subtype (e.g. SLF3S-0600F)
> > 0x      02   Revision number (changes with minor firmware or hardware revisions)
> > 
> > But both the product family and subtype are numbers to feed into look up tables
> > (maybe revision number as well)  
> 
> The values don't matter. What only matters is that each is unique, you
> can map it to a real device (and its datasheet) and features are
> decodable from the datasheet.

Sure, but as above, that breaks the use of fallback compatibles for the incredibly
common case of otherwise identical parts that would work fine on an old kernel
but where we can't match them because the ID register differs.

Jonathan

> 
> Best regards,
> Krzysztof

