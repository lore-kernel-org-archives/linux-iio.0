Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636920DD51;
	Sun, 14 Jun 2026 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781457894; cv=none; b=XjnipfExDpAKI3o3+MZ6mk6QDL7xVM8NKP7Y3ae7rY8Yg2cYNVQsFS4VRBNQC+cE0laQi6Ck/reqkTAo+t1X3S7tH0xGH+dTNtUuUV3E15B14m7fN5SHLtiKtC1rfbsDmWKZ9ga1bvgVn0cv64fIVQtVn5LqhrhRtNhNJZdqq4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781457894; c=relaxed/simple;
	bh=QA/436eo+ecpTsVmt0bTElTge+gcRX9yDbstW6OAtWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVTHiK51KlFsnBzu9oyjE5mp269owvNlOMrrxr0+J/UgIYHVvkrlRFHoj+4K3T7UHoDAWI81oaDeUrTFyMaI/omyDskhcvGm7SOa3TVwVdBrP+PzRRrAYLfddIAUnyLLSELFutpx98pVwUrATE2RKcTBf+t9Vt5dgKm0fPtGGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjzDQ56I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjzDQ56I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A151F000E9;
	Sun, 14 Jun 2026 17:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781457893;
	bh=RJi9QJfxorJP9QCZGwJuiZhiOTN85VWaAY+FxK7wlpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KjzDQ56IfDPdB5ALDkfwJw0SKXlATrQJVN8aZfOcb+dAioUkKf6vAvtOCI5h4YYhl
	 LkdA8hhEvCwlJ/nkvob0tNJcWNU8l6XOlgo41wldxEWe6dTZY/pF+Y5h77bYYud7JI
	 N8/gfurm0/aJUBwnvZa5DoFTKe3hGKgn0IfGnxaIOe1o3q8QMI7bawwFPRuHs3gEUm
	 oqvwrxTgWo7eVzL7QFW8KNcujCFVzJIJgraqEsLdAsdf1ByGhtM3zh2b/QlxjSxCMr
	 zXSIMfb6fS22V5OnG6CvKef4KKWC8ycwyUFfD6lLaSc+hAker5IfQp4fIgeNiLjdDI
	 mJjvPdNLLEsXg==
Date: Sun, 14 Jun 2026 18:24:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Conor
 Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 02/12] dt-bindings: iio: dac: ad5696: rework on power
 supplies
Message-ID: <20260614182444.5329cc22@jic23-huawei>
In-Reply-To: <20260609-manhunt-napkin-04b11606ea49@spud>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
	<20260609-ad5686-new-features-v2-2-70b423f5c76d@analog.com>
	<eduvmlupbcxlskscx6xphd7ipbwug3kqxjqtcewk6n6f2eqzo4@2avqjjrdem2v>
	<20260609-manhunt-napkin-04b11606ea49@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Jun 2026 17:12:29 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Jun 09, 2026 at 12:40:08PM +0100, Rodrigo Alencar wrote:
> > On 09/06/26 10:28, sashiko-bot@kernel.org wrote: =20
> > > Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> > > - [High] Adding `vdd-supply`, `vlogic-supply`, and unconditionally re=
quiring `vref-supply` breaks backward compatibility for existing device tre=
es.
> > > - [Medium] Making `vlogic-supply` unconditionally required forces dev=
ice trees to document a non-existent hardware connection for single-channel=
 devices.
> > > --
> > >=20
> > > commit 8357cd3efa5f819678f24f0cbf0a39208f4078bc
> > > Author: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > Subject: dt-bindings: iio: dac: ad5696: rework on power supplies
> > >=20
> > > This commit reworks the power supply bindings for the ad5696 DAC seri=
es. It
> > > adds vdd-supply, vlogic-supply, and vref-supply, deprecates vcc-suppl=
y, and
> > > updates the required properties.
> > >  =20
> > > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.y=
aml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> > > > index 2dcc049f30e91..e5fbaec4adf71 100644
> > > > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml =20
> > >=20
> > > [ ... ]
> > >  =20
> > > > @@ -55,8 +65,21 @@ properties:
> > > >  required:
> > > >    - compatible
> > > >    - reg
> > > > +  - vdd-supply
> > > > +  - vlogic-supply =20
> > >=20
> > > [Severity: High]
> > > Does adding vdd-supply and vlogic-supply to the global required list =
break
> > > backward compatibility for existing device trees? Older device trees =
that
> > > omitted these will now fail dtbs_check. =20
> >=20
> > Yes, for correctness, it breaks the dtbs_check. In the driver side
> > we would rely on the dummy/stub regulator in case those are not declare=
d. =20
>=20
> Ye I wouldn't be overly worried here. Sashiko has particular difficulty
> with these kinds of changes.
>=20
> >  =20
> > > [Severity: Medium]
> > > Does making vlogic-supply unconditionally required force device trees=
 to
> > > document a non-existent hardware connection? Single-channel devices i=
n this
> > > family (such as adi,ad5693, adi,ad5693r, and adi,ad5311r) physically =
do not
> > > have a dedicated VLOGIC pin. =20
> >=20
> > VLOGIC does exist for those parts. However, as mentioned before, for so=
me
> > tiny packages it is internally connected to VDD:
> >=20
> > - 10-Lead MSOP package for AD5693R/AD5691R exposes the VLOGIC pin
> > - 8-Lead LFCSP package for AD5693R/AD5692R/AD5691R/AD5693 does NOT expo=
se the VLOGIC pin
> >=20
> > I think we agreed to make it required and user can just repeat the vdd-=
supply
> > value or not have it at all. Driver would rely on the dummy/stub regula=
tor. =20
>=20
> Yeah, I dunno. I think this is just a judgement call, and maybe worth
> having a comment in the binding for to explain it.

Yes. A breadcrumb type of comment that just says that it may be internally =
wired
in which case set it to same as the other one.

>=20
> >   =20
> > > > =20
> > > >  allOf:
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            anyOf:
> > > > +              - const: adi,ad5693
> > > > +              - const: adi,ad5694
> > > > +              - const: adi,ad5696
> > > > +    then:
> > > > +      required:
> > > > +        - vref-supply =20
> > >=20
> > > [Severity: High]
> > > Does unconditionally requiring vref-supply break older device trees t=
hat
> > > correctly utilized the formerly valid vcc-supply?
> > >=20
> > > To preserve DT ABI compatibility, should the schema allow either vcc-=
supply or
> > > vref-supply to satisfy the reference voltage requirement? =20
> >=20
> > Same here. For correctness, it breaks DT ABI.
> >  =20
> > > --=20
> > > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-ad56=
86-new-features-v2-0-70b423f5c76d@analog.com?part=3D2 =20
> >=20
> > --=20
> > Kind regards,
> >=20
> > Rodrigo Alencar =20

