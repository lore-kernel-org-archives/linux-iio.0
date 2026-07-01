Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9824D20E334;
	Wed,  1 Jul 2026 00:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865727; cv=none; b=GMqnECuRdLoCpFSp7BCPuv1rEzOSYCXgQZEMq/VnhmtldkE47/tUUVZpsLxHZYk3oKqZsHpfzATGy+yzxmUso4ijCq8IQLqP4V2Cms9CU4kX0zXpDijcnmaCXhXQM2MN3Jkt361p+n/3QQnTsEzswigQm87CBiDeHD3F2heMqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865727; c=relaxed/simple;
	bh=zWxjksPIfxoI6uHdScDSIU4oTXVlyl8ziOx0gjJqN+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLTK+aJ2/Bqv9Uh1KGearNeynO0MZIHORhdi0gvCegWF26l4uP/jLujqgK7hXQo1npTOu2ALiw7sYnJgF4R3QomYP3r+bnHBiOUkNsz8v0upwMXnoWpHsLB03AffT3dnA486dIbriezWlnvFaSjBWmLvffaueIoqSKeWHmU+gY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhD0ATVJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhD0ATVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2C31F000E9;
	Wed,  1 Jul 2026 00:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782865726;
	bh=5vTPIgjR+M1/x2HvzngY6H3y5OMxpG+8Ki8k0FRaUHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OhD0ATVJnBZCxf+wKTX9dVdgks5geXSblUQHQxcgwWg13sf+IhLCebyn5FAluaEqT
	 Vz95yuu2Dl9ts5YcjRCSpbKG6iSzMKZP0rpsOGJjReHUbGG9XT0vQXOecfZC/iC2YQ
	 JN3CgwzAQIynxghnmeNoTWzR9e4LrfZb4T+1lPP3M3sCZd9xVTKOxfrulofHPLH7rN
	 UR97Q5ynoDswAxeqbOMLFEScGzrR3zCNRBYFvNF0Trw/mpv7/NpypVBFjI9W9NaC8V
	 q61rMN5Gpbwlz7KHYfaoacdzD2Sls5UiGjJoE3joDyWm56oN6+8ActlGH4Tss+C6V7
	 y228S945NN9Jw==
Date: Wed, 1 Jul 2026 01:28:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: iio: adc: Add TI ADS126x ADC family
Message-ID: <20260701012842.16272045@jic23-huawei>
In-Reply-To: <2a0a9fe9-b3b5-49a0-bf58-5035655fc16d@baylibre.com>
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
	<20260628-ads126x-v2-1-4b1b231325ba@gmail.com>
	<946a30c9-01e9-42f1-bd2b-b7934fda85cf@baylibre.com>
	<DJKX600ONL4O.1YUTCD1L9FU8F@gmail.com>
	<a16f61fb-4e98-4c30-8d4f-da084e27ebeb@baylibre.com>
	<DJLOAISPZLG7.VZYX8B16QU4K@gmail.com>
	<22e1e1c2-659c-4991-857c-b38d66769c7e@baylibre.com>
	<DJMJX5FGSZ9X.1GQK24K6CI60X@gmail.com>
	<2a0a9fe9-b3b5-49a0-bf58-5035655fc16d@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 13:38:30 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/30/26 12:14 PM, Kurt Borja wrote:
> > On Mon Jun 29, 2026 at 11:43 AM -05, David Lechner wrote:  
> >> On 6/29/26 11:27 AM, Kurt Borja wrote:  
> >>> On Mon Jun 29, 2026 at 9:21 AM -05, David Lechner wrote:  
> >>>> On 6/28/26 2:12 PM, Kurt Borja wrote:  
> >>>>> On Sun Jun 28, 2026 at 10:45 AM -05, David Lechner wrote:  
> >>>>>> On 6/28/26 12:36 AM, Kurt Borja wrote:  
> >>>>>>> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
> >>>>>>> integrated PGA, internal reference, excitation and burn-out current
> >>>>>>> sources for sensor biasing and diagnostics. The ADS1263 adds a second,
> >>>>>>> 24-bit delta-sigma ADC (ADC2) for background measurements.
> >>>>>>>  
> >>>>
> >>>> ...
> >>>>  
> >>>>>>> +
> >>>>>>> +patternProperties:
> >>>>>>> +  "^channel@[0-9]+$":
> >>>>>>> +    $ref: /schemas/iio/adc/adc.yaml#
> >>>>>>> +    unevaluatedProperties: false
> >>>>>>> +
> >>>>>>> +    properties:
> >>>>>>> +      reg:
> >>>>>>> +        maxItems: 1
> >>>>>>> +  
> >>>>>>
> >>>>>> If we want to allow single-ended/pseudo-differential inputs, then we should
> >>>>>> also allow single-channel (positive pin) and common-mode-channel (negative
> >>>>>> pin) properties.
> >>>>>>
> >>>>>> This will also require additional common-mode-<N>-supply properties to allow
> >>>>>> for the negative pin connected to something other than GND.  
> >>>>>
> >>>>> Ah interesting. Why the N though? wouldn't a single supply connected to
> >>>>> AINCOM be enough here?  
> >>>>
> >>>> In theory, any AINx could be a common mode input by connecting it to
> >>>> a constant voltage supply.  
> >>>
> >>> Technically yes, but there is a pin named AINCOM intended for this
> >>> purpose. Can we do a simplification here? I propose having
> >>>
> >>>   common-mode-channel:
> >>>     /* AINCOM pin */
> >>>     const: 10
> >>>
> >>> That way we would only need one common-mode-supply. Would that be okay?
> >>>  
> >>
> >> Ideally, we shouldn't limit how the chip can be wired up in the devicetree
> >> bindings. It doesn't mean that we have to implement everything in the driver
> >> though.  

I'm a bit confused on this.  Arguably you could wire up any side of a differential
pair to a common mode signal, but we haven't had this binding applied more generally
than cases where their is a setup where the intent is a shared common (shielding
on cable in some cases IIRC). 

So why is this case special? I see AIN_COM can be wired up to an internal vbias
but other than that it looks like any other AINX input.

Jonathan

> > 
> > Makes sense.
> > 
> > I just have a doubt: In the ADS112c14 bindings, is there a specific
> > reason why you didn't describe common-mode-<N>-supply?
> >   
> 
> For singled-ended inputs on ADS112c14, there is an internal
> connection to GND, so it isn't possible to have a pseudo-
> differential input like that. I guess technically, it could
> still be possible, but wasn't a typical wiring described in
> the datasheet like it is on ADS1263.
> 

