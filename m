Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FE31D7E41;
	Wed,  1 Jul 2026 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865233; cv=none; b=T4Tav557yAbGgeDoWza9ijwcSMohB2+oxmxnulUvkoLBqKb/eFzFtzlqz7l2bZBSGra1bPrztRyR1foDzBpw96xD8zpJOTUF9jcCXifiluEZIhhfTDOee+/RRCMGOVbdNtFLMurPRdcPhlYJGPOIXzpjjEecfjOCHpSEhq4oqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865233; c=relaxed/simple;
	bh=Edq9hVGdfRDZEdeo39Z5Dzszy3lLc3HzHGLOJWdL520=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rETpfGCaf39hieTdN+sGsdfPaByn9Jm2dLu8H2XkthhhTjcWzGRmicLHULDp63RjLdrLfOgxrXKRg1Ks6jcD0fXy4hHfbIaNQHvn2fWMRGK6lzJ1yaWgs6cAiHSE5tonUQtO+VXK1BcQhDpmACI74NUm4sb5/ECsuAc+ctmB9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVC2eT6p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVC2eT6p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEFB1F00A3A;
	Wed,  1 Jul 2026 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782865232;
	bh=fzbK3CZfwstQk59q4a4I4eo3/RxJhs7GnxKnzeegaG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SVC2eT6psROZGlTVWqjxpbv6mzeL6MmsmGayhmxDBz1DZ3mxrxlrMb9ZHvrzIZAkf
	 TbBjd3SBZc/QHRJ/U4PrREl3yU45RiXQoCL6C+5BTe2SzQ07IJmkzJrYEzoAgdByHh
	 6/mrAXJ8gGoo2TrqB37+xMU/S1mqRJSJKSs5SvREeAZTRgaLCh5iIPFXncbPXZNYNR
	 hg34bRxLvY3qJUGVKtfp4GSEnlOTQKRs1df47DaBtH20MeQLYcV8UYAfKFNnbgcW5l
	 DSlAYN6t5gIO+M2qvTJCT55WwPNC6J7kE1EWoXzozqj9fNG+1UOnghiLjf/T2GRmRL
	 E3nLc8YnqYabQ==
Date: Wed, 1 Jul 2026 01:20:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] iio: adc: ti-ads1262: Add conversion delay
 support
Message-ID: <20260701012026.29f18bf4@jic23-huawei>
In-Reply-To: <d8fbab77-6cb4-435d-aac9-0d72cd4a59bc@baylibre.com>
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
	<20260628-ads126x-v2-5-4b1b231325ba@gmail.com>
	<20260630015027.3afdfc3a@jic23-huawei>
	<DJMK3NCDCHL8.1EHG93D5O7ROZ@gmail.com>
	<d8fbab77-6cb4-435d-aac9-0d72cd4a59bc@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 13:44:49 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/30/26 12:23 PM, Kurt Borja wrote:
> > On Mon Jun 29, 2026 at 7:50 PM -05, Jonathan Cameron wrote:  
> >> On Sun, 28 Jun 2026 00:36:06 -0500
> >> Kurt Borja <kuurtb@gmail.com> wrote:
> >>  
> >>> Expose the programmable conversion start delay as a per-channel
> >>> IIO_CHAN_INFO_CONVDELAY attribute.  
> >> Coversion delay was always a somewhere weird bit of ABI.
> >> What are the delays relative to in this case?
> >> Is this a device that does simultaneous sampling?  Pictures
> >> suggest otherwise, and convdelay is currently only defined
> >> in that case.  We might be able to extend it but it needs
> >> some thought.  
> > 
> > The chip has a configurable internal conversion delay to allow for
> > external settling effects. See datasheet section 9.4.3 if you'd like a
> > bit more details.  
> 
> Since this depends on external components, it sounds like it belongs
> in the devicetree. I have the same feature in the chip I am working
> on and was just looking at this and plan to add it to the ti,ads112c14
> devicetree patch.
> 
> This delay only applies to a "new conversion", i.e. when certain config
> registers change, and not every conversion, so isn't like the convdelay
> attribute.

See settling-time-us in adc.yaml.  I'd forgotten we had that ;)

> 
> > 
> > But you're right, I should at least also edit the ABI description of
> > this attribute. We can postpone this discussion for a future series.
> >   
> >>
> >> Jonathan  
> >   
> 

