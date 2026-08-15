Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E4F282F20;
	Sat, 15 Aug 2026 03:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786764876; cv=none; b=O6ibqR22sMo2wFLPYaWj2Wg938HntYQ7NRHdpwDFQauEpQOvOx2dkRZUulNVY2WooVSRMZsy+x1P52wWrKUA1pYjMpN2UupMQKmQ9QTwryoekiTUN6SEGAJTxBnliRWBLVWFe1VrIUyrucUYoLfRzNac9k87CCyGNrDmodPl7Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786764876; c=relaxed/simple;
	bh=GsEiLvRDD2zvoQUQu19mwz3CdZOOABKdSgvG0H3jgQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvQUqAOv/SHaTmXuRTmes2pBFjhF4jRB0aPRz1fUll5UtqBF9koxUlhMIkJ9mbHnjG97qdhLie4plqmXy01PD6ZsbRW8Bt6J1/KqXzZoSWTbG2F/SfeP5oaBZw+Eprkozuqyu14SWsU0Kezl2hgQIGWw/O1ha/ghiEnXrz4gHug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMvHyoIM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMvHyoIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B801F000E9;
	Sat, 15 Aug 2026 03:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786764874;
	bh=C+Cu2InKNvasgremdCaOeAGY3Nd6alJVZKd7DcSoUa8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fMvHyoIMiZZk6SWVV4vVCbCfjREUZE2KddyMCnjWKauT8ESafagotvZ4QDia5J/3E
	 QFAhPXhXd6NfzfEozZm9uZ9sGZa/1qFuzSiw9Bu0mV4XxAV3WljWzBayXCbTONBoiJ
	 cr/MN2ejiyS+DRdgcV+dW9pRpqxhs0qXDtNVlbc5MTj/8pH7f5Oy8nuXnQ+CxAHSGR
	 ec3tOJGxcrIOvSC8AMmRcsKctgww5Agxl+AC7v6O4pNlcrSomJ+0s/72qRDXu3NCvz
	 UFhvVn95Y8TI7R79kxsu3a4d8i2nLpYwCOblNP9b5UKNdEBobuADvPDODJnOVduxlL
	 xQKLKcWOtXBCw==
Date: Sat, 15 Aug 2026 04:34:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Rob Herring <robh@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry
 <maslovdmitry@seeed.cc>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner
 <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>, Yangtao Li
 <frank.li@vivo.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: iio: light: ltr501: Add ltr329
 compatible
Message-ID: <20260815043403.07f9cc58@jic23-huawei>
In-Reply-To: <XeCYlALgHXbzL0UzP7ZhcC4MRGGmwC0X9sYvmf87CaI3Ujj-CG9DObxsJlzi5t0QjFVTG3Xh9AdLudKIWOU53oaKaa1FJeyV4ECORK325Vw=@geanix.com>
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
	<20260810-liteon-ltr329-v4-3-8bd3dfd15280@geanix.com>
	<20260810155006.GA1815611-robh@kernel.org>
	<tpb0KaOIsxWHbx0VIdiP5udap2Qu9DAIOdN6iBaAbpWnGqMfGOgZwRQQlJOddirF99RdD6n1FVMxlSKmrRJW8lLo7pqKKAXwN9MUBT9DKAU=@geanix.com>
	<XeCYlALgHXbzL0UzP7ZhcC4MRGGmwC0X9sYvmf87CaI3Ujj-CG9DObxsJlzi5t0QjFVTG3Xh9AdLudKIWOU53oaKaa1FJeyV4ECORK325Vw=@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 12:39:45 +0000
Esben Haabendal <esben@geanix.com> wrote:

> On Friday, August 14th, 2026 at 08:18, Esben Haabendal <esben@geanix.com> wrote:
> 
> > On Monday, August 10th, 2026 at 17:50, Rob Herring <robh@kernel.org> wrote:
> >   
> > > On Mon, Aug 10, 2026 at 09:11:13AM +0200, Esben Haabendal wrote:  
> > > > LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
> > > > without interrupt support.
> > > >
> > > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > > > Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > Signed-off-by: Esben Haabendal <esben@geanix.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
> > > >  1 file changed, 1 insertion(+)  
> > >
> > > sashiko issue should be addressed.  
> > 
> > What about the suggestion about adding `proximity-near-level: false` to the condition. I am thinking something like this is more correct
> > 
> > properties:
> >   proximity-near-level: false
> > 
> > allOf:
> >   - if:
> >       properties:
> >         compatible:
> >           contains:
> >             enum:
> >               - liteon,ltr501
> >               - liteon,ltr559
> >     then:
> >       properties:
> >         proximity-near-level: true
> > 
> > As it is only valid for those two chips, and it seems more logical to do a white-list than the opposite.  
> 
> I hope it is okay to do this change in a follow-up series to this one, so we can get it merged sooner rather than later.

Whilst this looks to be in a good state to merge, timing is such that
it is next cycle material anyway at this point unfortunately.
So if you don't mind tidying this up as part of your series, I'd
definitely prefer that.

Thanks,

Jonathan
> 
> /Esben

