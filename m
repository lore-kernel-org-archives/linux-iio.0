Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A989C46D550
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711215; cv=none; b=fwYIgkRvrs8HkT4ydvUMrdyJ6NOJpxbOwE/HhqYOf9EhSroesRjUUWdnyjQHyOXKLYntGpTmdyzC1QT+Fs/np1zQHA77r/uWwq8c1bzgU6qLUtC0N+Di7gneeTOe1pBHGMGCRJll7vSGTNYI8cgMcew3ln79Bqki7qpnDOJGWPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711215; c=relaxed/simple;
	bh=PsFY0WziBF1KBAuDomLHhQaIPPfCJGqq2yclMngPbNc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctiC6aZfeYBlc2Krhx3o1URm2wtNA5lpIlylxwFpmGmzQonMD2d44KoG95fvkHvcqIH4GVniO/AR/iApgtUzzeMiyrgSgbT1YhqprMpGwXpEvHi7Z0rHTGRGYgB8IADadVARVokjggad4+SgrMOwgZ8HJN9p7S4UadXRsqsTFe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=1OReM5Uz; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="1OReM5Uz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786711193; x=1786970393;
	bh=pZD5lIxLmPdWultn1GJ3K9k0IJVAmpMUzSo+UV94PD8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=1OReM5UzWFd2tTjy4QBCRTRgajvcgnxIwV6cowHKCNIRz3aXYX2AkE/b6r6sNd8MK
	 +/s5bgj/w+RWU2p5ZFkVDXDwnEqfrFnDVILT5JAd3dBeDyoYBeXoTSgVMUJf0VS0bh
	 4M+O6V3qBkVQSCly3VhRSR9r4q+BS5b2CWs+mxmfWIE9jZwJZHhTbSBWMtKcvD9RK+
	 RqMNbtQuKT6VRxuxPhVmYi0d+KgJfoBDvNRmoXb0PkBXEBVbuSEdAVg0YYR5vmMxF9
	 JnK3+6grDpMHbCcsrgnK2lnYDUwt0as80/xlrbdOu17Er+snx9DhJS8tgZx8Mj/C/n
	 9p1m1Tg9TWM7w==
Date: Fri, 14 Aug 2026 12:39:45 +0000
To: Rob Herring <robh@kernel.org>
From: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry <maslovdmitry@seeed.cc>, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>, Yangtao Li <frank.li@vivo.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: iio: light: ltr501: Add ltr329 compatible
Message-ID: <XeCYlALgHXbzL0UzP7ZhcC4MRGGmwC0X9sYvmf87CaI3Ujj-CG9DObxsJlzi5t0QjFVTG3Xh9AdLudKIWOU53oaKaa1FJeyV4ECORK325Vw=@geanix.com>
In-Reply-To: <tpb0KaOIsxWHbx0VIdiP5udap2Qu9DAIOdN6iBaAbpWnGqMfGOgZwRQQlJOddirF99RdD6n1FVMxlSKmrRJW8lLo7pqKKAXwN9MUBT9DKAU=@geanix.com>
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com> <20260810-liteon-ltr329-v4-3-8bd3dfd15280@geanix.com> <20260810155006.GA1815611-robh@kernel.org> <tpb0KaOIsxWHbx0VIdiP5udap2Qu9DAIOdN6iBaAbpWnGqMfGOgZwRQQlJOddirF99RdD6n1FVMxlSKmrRJW8lLo7pqKKAXwN9MUBT9DKAU=@geanix.com>
Feedback-ID: 133791852:user:proton
X-Pm-Message-ID: c47d8146d88087c47217c5cef0b539fee03ebbdc
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, August 14th, 2026 at 08:18, Esben Haabendal <esben@geanix.com> w=
rote:

> On Monday, August 10th, 2026 at 17:50, Rob Herring <robh@kernel.org> wrot=
e:
>=20
> > On Mon, Aug 10, 2026 at 09:11:13AM +0200, Esben Haabendal wrote:
> > > LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, bu=
t
> > > without interrupt support.
> > >
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > > Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linu=
x.intel.com>
> > > Signed-off-by: Esben Haabendal <esben@geanix.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > sashiko issue should be addressed.
>=20
> What about the suggestion about adding `proximity-near-level: false` to t=
he condition. I am thinking something like this is more correct
>=20
> properties:
>   proximity-near-level: false
>=20
> allOf:
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - liteon,ltr501
>               - liteon,ltr559
>     then:
>       properties:
>         proximity-near-level: true
>=20
> As it is only valid for those two chips, and it seems more logical to do =
a white-list than the opposite.

I hope it is okay to do this change in a follow-up series to this one, so w=
e can get it merged sooner rather than later.

/Esben
