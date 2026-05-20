Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0E3CF049;
	Wed, 20 May 2026 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270104; cv=none; b=f/hDA2DjptiMh61f+HnXNdeSaYkLpLQYTcB+n0gOCXmqAOzyJqGvHrEnEpy2SKZIEcgm+3fLk/pp8HL5Ho37vQAE5Zvh8FZYtpLuxitl7Mc8FbZzEyQQWxuhESN7+mcqGhA2Vb2iCPfTbFLU89APoPj194aLB7H2YIdc/TiY8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270104; c=relaxed/simple;
	bh=igeRWNg6IVtLdMLgIkGN99uIFttIbOmuORlcqnAfonI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGpu5n2pPSzuWq+GbpUHWPCjj+jxTCMFJIv1GbadnlJeVKbiVisNrpGBjXcLHLU346w0iL1DUNGjN1L6Et0aww5Y7YsvfQHwZfu39ca8DO6ldUCx5K5fRShtSpHfET935DzETvcG5BI2uNcrzbr5HSPYccqM5UXPHP5oT9f4xFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duYycovM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duYycovM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B491F000E9;
	Wed, 20 May 2026 09:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779270098;
	bh=QzScM81tzS6Eotxw9vObBZVuGOy7ADyFT+pJ4sgoFxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=duYycovM2OKOPuKU7rZixagilV6euM4g/2ojJ0cuFft9XMDjJtM3huVEJ1hmlgApm
	 k3XvuOLfjdQkyykd3fmLymKDapWRTuLZYsID/lDCGFp2ILGDhjLsvAtMs37M/pg7eV
	 qjs0OF3KP+ZjoUUjoEyQS0E4m/jCUBeyWTLSlItVoy0C1sxEsugTnsyqfHMxDLMgCl
	 o8YmC/3rDfy7xq+XRG2kbP00cSF+OGXUAoSO5UmqBn2/1n7WyW5fT2TVirXL7pDgy3
	 gVs3RQPZIz5rmSXCR7+t53LlghGlcu5UgbZk3ZBlpPo/6RPM8DbHvLcTFTnVyoGXhK
	 cnvZElzBhpmkA==
Date: Wed, 20 May 2026 10:41:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <jan.sun97@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Janani Sunil
 <janani.sunil@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 rodrigo.alencar@analog.com
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260520104126.22a04a79@jic23-huawei>
In-Reply-To: <e245de68-555a-42c8-900b-a4abbaa4ea3e@gmail.com>
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
	<20260508-ad5529r-driver-v2-1-e315441685d7@analog.com>
	<20260508134843.7646c4f5@jic23-huawei>
	<53d547ee-1ac3-42b9-92a6-e7f48b72fee3@baylibre.com>
	<e245de68-555a-42c8-900b-a4abbaa4ea3e@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 09:13:24 +0200
Janani Sunil <jan.sun97@gmail.com> wrote:

> On 5/16/26 21:25, David Lechner wrote:
> > On 5/8/26 7:48 AM, Jonathan Cameron wrote:  
> >> On Fri, 8 May 2026 13:55:47 +0200
> >> Janani Sunil <janani.sunil@analog.com> wrote:
> >>  
> >>> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
> >>> buffered voltage output digital-to-analog converter (DAC) with an
> >>> integrated precision reference.
> >>>
> >>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> >>> ---  
> > ...
> >  
> >>> +  * Multiplexer for output voltage, load current sense and die temperature
> >>> +
> >>> +  Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad5529r.pdf
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: adi,ad5529r
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  spi-max-frequency:
> >>> +    maximum: 50000000
> >>> +
> >>> +  reset-gpios:
> >>> +    maxItems: 1
> >>> +    description:
> >>> +      GPIO connected to the RESET pin. Active low. When asserted low,
> >>> +      performs a power-on reset and initializes the device to its default state.
> >>> +
> >>> +  vdd-supply:
> >>> +    description: Digital power supply (typically 3.3V)
> >>> +
> >>> +  avdd-supply:
> >>> +    description: Analog power supply (typically 5V)
> >>> +
> >>> +  hvdd-supply:
> >>> +    description: High voltage positive supply (up to 40V for output range)
> >>> +
> >>> +  hvss-supply:
> >>> +    description: High voltage negative supply (ground or negative voltage)  
> >> I don't mind doing it this way but in some similar cases where 0 is something that
> >> can be considered the 'default' we've made the supply optional.  What was
> >> your reasoning for requiring it in this case?
> >>
> >> dt-bindings should be as complete as we can make them - with that in mind...
> >>
> >> There are some more interesting corners on this device the binding doesn't
> >> currently cover such as mux_out pin.  We'd normally do that by making the
> >> driver potentially a client of an ADC
> >>
> >> Easier though is !alarm which smells like an interrupt.
> >> !clear probably a gpio. TG0-3 also GPIOs.  
> > also optional vref-supply for external vs internal reference  
> 
> I will add bindings for optional Vref supply in the next version.
> 
> Best Regards,
> Janani Sunil
Hi Janil

One of those process things.  Don't reply to a review to say you
are going to do something suggested - just save us all reading an email
by making that clear in the change log for the next version.

Lots of folk are over enthusiastic in replying like you have done initially.
They only begin to appreciate why this is a bad idea when they start trying
to keep up with the mailing list firehoses!

Jonathan

> 

