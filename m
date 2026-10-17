Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331914CF475;
	Sat, 17 Oct 2026 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792280370; cv=none; b=aNa3mrCFxT9VslJ8S4vrRWpquPNJEqqLbJ7fXyQvUDUk1tIFHh4Y6xM8bxYGOow9SXJGF3Ktph8C0MrfVhH1JZ53MQUdmYRuvm7ZtWdMLj0LZVOKaS9wOheDGwnsnrrEsPJCJp31Y5ni09jtZ4ixQTMK89CerVaegHuzbfkCFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792280370; c=relaxed/simple;
	bh=b4tofApa6bBuTygWn1M/otrv/bLpzsWtlZuk3fFRN00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHv/Gk9FBrOLqFBSd0hV3XAm16BRBmimpFtm9JQeLLO5SOUTiafdIBkLjKdWCoaWkCP0SCkXlBX5yu0PxYIGHckJb9/ioAosYHCf+nx1eYSwapQ/y2myB6S1d2ODwmxdIpq1+GVReAmDWD246WOEAdMiDSA0qO6A6lO9o2ARAmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO7qSp+u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO7qSp+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCD21F000C4;
	Sat, 17 Oct 2026 23:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792280368;
	bh=yM3BRXkIucsqneyeNQdMSy7smcgS/u8SKMcxzocLOKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WO7qSp+uPQLMMDoCaop+a/o/7EXndAW3s7lVTAX54XejLt2/8xZjXBz8H5Vv7FN1w
	 y3gY42xDEG5fV+tK8Q/0PyIH4Y0QI+0XLtpfQJxE+nj3ss7qJUvpIRk6NEvEz2hEbK
	 aKR84IX+gzr/EwQNb3/7/zigM4PgEoyzmSgEQCMmQUTZ49239SAFY8G45IybYHPvs7
	 mkUNEJ+YZZJMnqjJ1SfDFgCppT3/tXRxRER6xsOnTIDrUCd2B9rkFMqwLIKgqlorXg
	 78cpYmOuNib06uMi6Osh1Sozor/sSaoCa/9dixVgPWiA4T1ZZAl2n6Js/b+yoCLhtY
	 0giWuTtXAxLSg==
Date: Sun, 18 Oct 2026 00:39:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Marcelo
 Schmitt <marcelo.schmitt@analog.com>, Radu Sabau <radu.sabau@analog.com>,
 Janani Sunil <janani.sunil@analog.com>, Salih Erim <salih.erim@amd.com>,
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, Jakub Szczudlo
 <jakubszczudlo40@gmail.com>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: iio: adc: adi,ade9000: add adi,ade9039
 compatible
Message-ID: <20261018003921.73269ab8@jic23-hlaptop>
In-Reply-To: <20261012154652.00004ed4@gmail.com>
References: <20261012111342.48040-1-antoniu.miclaus@analog.com>
	<20261012111342.48040-3-antoniu.miclaus@analog.com>
	<20261012154652.00004ed4@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Oct 2026 15:46:52 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 12 Oct 2026 14:13:38 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > The ADE9039 is a polyphase energy metering device from the same family =
as
> > the ADE9000. It is register compatible with the ADE9000 for everything =
the
> > driver uses, provides the same on-chip dip/swell detection, and shares =
the
> > full-scale codes of the ADE9078.
> >=20
> > It computes only fundamental reactive power and has no total reactive p=
ower
> > register, which is noted in the description. Like the ADE9078 it suppor=
ts a
> > maximum serial clock frequency of 10 MHz rather than 20 MHz, so extend =
the
> > existing spi-max-frequency constraint to cover it.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  .../bindings/iio/adc/adi,ade9000.yaml         | 29 +++++++++++--------
> >  1 file changed, 17 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml=
 b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> > index bcc166aad713..70106dd052ce 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> > @@ -5,26 +5,28 @@
> >  $id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> > =20
> > -title: Analog Devices ADE9000/ADE9078/ADE9430 High Performance, Polyph=
ase Energy Metering
> > +title: Analog Devices ADE9000/ADE9078/ADE9430/ADE9039 High Performance=
, Polyphase Energy Metering
> > =20
> >  maintainers:
> >    - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > =20
> >  description: |
> > -  The ADE9000, ADE9078 and ADE9430 are highly accurate, fully integrat=
ed,
> > -  multiphase energy and power quality monitoring devices. Superior ana=
log
> > -  performance and a digital signal processing (DSP) core enable accura=
te energy
> > -  monitoring over a wide dynamic range. An integrated high end referen=
ce ensures
> > -  low drift over temperature with a combined drift of less than =C2=B1=
25 ppm/=C2=B0C
> > -  maximum for the entire channel including a programmable gain amplifi=
er (PGA)
> > -  and an analog-to-digital converter (ADC). The ADE9078 and ADE9430 do=
 not
> > -  provide the on-chip dip/swell detection available on the ADE9000, an=
d the
> > -  ADE9430 has no on-chip digital integrator (it uses an external analog
> > -  integrator for Rogowski coils).
> > +  The ADE9000, ADE9078, ADE9430 and ADE9039 are highly accurate, fully
> > +  integrated, multiphase energy and power quality monitoring devices. =
Superior
> > +  analog performance and a digital signal processing (DSP) core enable=
 accurate
> > +  energy monitoring over a wide dynamic range. An integrated high end =
reference
> > +  ensures low drift over temperature with a combined drift of less than
> > +  =C2=B125 ppm/=C2=B0C maximum for the entire channel including a prog=
rammable gain
> > +  amplifier (PGA) and an analog-to-digital converter (ADC). The ADE907=
8 and
> > +  ADE9430 do not provide the on-chip dip/swell detection available on =
the
> > +  ADE9000 and the ADE9039, and the ADE9430 has no on-chip digital inte=
grator
> > +  (it uses an external analog integrator for Rogowski coils). The ADE9=
039 only
> > +  computes fundamental reactive power and has no total reactive power =
register.
> > =20
> >    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ADE9000.pdf
> >    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ADE9078.pdf
> >    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ADE9430.pdf
> > +  https://www.analog.com/media/en/technical-documentation/data-sheets/=
ADE9039.pdf =20

Numeric order preferred.

>=20
> That is a very short datasheet :)
>=20
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
>=20

