Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EC83F6603;
	Thu,  4 Jun 2026 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563794; cv=none; b=VLJR7zdSeedUmeGmJrkp8RvWtRoFB+QtM9Zd7slmdwfXDa3TwDXxoUsgSvyEwoyHG/OsFLZt00ZMDuQtHSA8uHbCPIlOkoW5ZfLkQfllijco9SviykiPRW5+7GonRC6GLDAqDhw/EMxhEKwFLc1svTU/1VqPvcAaHRWhqKajtg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563794; c=relaxed/simple;
	bh=c/piY+AY945C6/neUKktYurg8n7+r2eYl0yl1CQnH+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEdpx8zVgEIWWDx8vM3B72wTPrLkovgj3VX06RqShqtQrxFJ0foIWy+sb9QrZkAIeUDX5IXbGEcAmmNgWUPgwgl26oEq9uBNQPbfcjHaJlbSIPbn8/NbMvZOdRrlus2iEbChjk8v40Ak5VnGaCke1hDcR+lzzdqmVX6eRK8Pv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flmktFXU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flmktFXU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DEB1F00898;
	Thu,  4 Jun 2026 09:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780563793;
	bh=5NgVYz8mg529VbAbrxG2hIdI3hbwzt2cjoRa0F0fEfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=flmktFXURmioN/esLune5uS8HxjWqK/KZvGc3p1Qy3H5omOf1oseWeDh+16bIumE2
	 aROFv7IZZC8DMz5dbF2cZyqWFR1EBxPqI3uocNeCcshJqZuURJhpjoleCsdS5VXIEt
	 n6GGD9Bx48gkIZwYYXTwF5mjXi4GamjLfIBcTeECXczRXcGhHSK8XybkGMs0kFUSqG
	 NNYrWmMZhNqcGQVKJifAltYzbg9803MJSQSg3SvkbEf65OopYoOR/oYwEDlKP4SKYK
	 1Sfjmegfe+9xUaAQaUAnI13YSB/rv2EPyZ0ezLX90zinaCIroyAznDA1NevCHgaz1c
	 3o+mJ5m6oeZWA==
Date: Thu, 4 Jun 2026 10:03:04 +0100
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
Message-ID: <20260604100304.11d0e003@jic23-huawei>
In-Reply-To: <1dbd3ab3-de6c-44dd-8100-e8ee60f558c8@kernel.org>
References: <20260530205435.37326-1-wafgo01@gmail.com>
	<20260530205435.37326-3-wafgo01@gmail.com>
	<20260601-banana-narwhal-of-music-0b4d3a@quoll>
	<20260601150959.49bbf125@jic23-huawei>
	<1dbd3ab3-de6c-44dd-8100-e8ee60f558c8@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 16:29:10 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 01/06/2026 16:09, Jonathan Cameron wrote:
> > On Mon, 1 Jun 2026 13:53:23 +0200
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >   
> >> On Sat, May 30, 2026 at 10:54:31PM +0200, Wadim Mueller wrote:  
> >>> Document the bindings for the Sensirion SLF3S family of digital
> >>> liquid-flow sensors on I2C.  The family currently covers the
> >>> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.
> >>>
> >>> The driver auto-detects the variant from the product-information
> >>> register at probe time; the per-variant compatible strings exist
> >>> for documentation and dt_binding_check purposes.    
> >>
> >> Here...
> >>  
> >>> +description:
> >>> +  Family of digital liquid-flow sensors from Sensirion with I2C
> >>> +  interface.  All family members share the same register map; sub-types
> >>> +  differ only in the flow scale factor and the calibrated measurement
> >>> +  range, both of which are detected at probe time via the
> >>> +  product-information register.    
> >>
> >> And here...
> >>  
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - sensirion,slf3s-0600f
> >>> +      - sensirion,slf3s-1300f
> >>> +      - sensirion,slf3s-4000b    
> >>
> >> And here something else. Confusing. Didn't you say device variants are
> >> auto-detectable? So you have only one compatible sensirion,slf3s.  
> > 
> > And then future fallback compatibles can never work. 
> > Basically as far as I have ever been able to establish this is why
> > generic compatibles are almost always the wrong way to go.
> > 
> > If we get a future part with an unknown ID and don't have these existing
> > specific compatibles, then we have no way to specify which one it is  
> 
> But why would you have future part with unknown ID?

That's what manufacturers do on a very frequent basis.  They tweak something
that has no affect on the interface or channel scaling etc and release a new part
with a different ID.  Can be something like a part suited to different operating
conditions, or with a different supply tolerance.

> 
> The device is slf3s with variants. All of known variants have an
> interface to detect the actual variant. There is no indication that this
> won't work - why would company remove the ID register?

They won't remove the ID, but they will put other values in it to
indicate new revisions of a part - often entirely backwards compatible
- sometimes with extra features that we don't use until the driver is updated.


> 
> But even if this happens, then it would be change of device interface,
> thus you cannot use generic compatible and you will have a new dedicated
> compatible.

We've had this discussion a number of times for whether an ID register difference
alone makes a device non compatible, and the answer from DT review has always been
a firm no and that it is incorrect to reject an unknown ID if the dt-compatible
is known.  The compromise that people were happy with was an info print if
such a mismatch is detected as it might indicate an incompatible part replacement
and a broken DT.

Probably 80%+ of IIO bindings with fallback compatibles do not have
matching "who am I" register values.  This is incredibly common.

> 
> If the device is actually "slf3s-0600f" (because slf3s is a family),
> then I am fine with using that as the fallback. Specific front
> compatibles are also fine in such case.

Yes, it's a part in the family. Each of the compatibles here has a
separate datasheet:

https://sensirion.com/media/documents/C4F8D965/66F56F53/LQ_DS_SLF3S-0600F_Datasheet.pdf
https://sensirion.com/media/documents/6971528D/63625D22/Sensirion_Datasheet_SLF3S-1300F.pdf
etc

(wonderfully inconsistent file naming ;)

> 
> 
> 
> > compatible with.  Given these are providing scaling info that means we
> > can't realistically support such a future part with a fallback at all.
> > 
> > That would only be possible if there was feature level discovery. A single
> > whoami register with no structure to the value is useless for this.  
> 
> The whoami register defines all the features, no? What would feature
> discovery improve? ID register is simply logical OR of some feature set,
> still uniquely identifying the features set/variant.

Would be lovely if true. Sadly almost never true. They are typically just
the next number in a list of parts released. There is no direct information
on feature set encoded in that value, we have to have a look up table in
the driver to translate to feature set. (Not relevant here but sometimes
manufacturers forget to change the number and we get different feature
sets with the same ID and no discoverability)

If they were an OR of features that would be great.

The thing is a little structured in this case

0x07         Liquid flow sensor
0x  03       Product family (e.g. SLF3x)
0x    03     Subtype (e.g. SLF3S-0600F)
0x      02   Revision number (changes with minor firmware or hardware revisions)

But both the product family and subtype are numbers to feed into look up tables
(maybe revision number as well)

Jonathan


> 
> 
> Best regards,
> Krzysztof

