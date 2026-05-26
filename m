Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08DB3EBF07;
	Tue, 26 May 2026 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779798706; cv=none; b=GlQEwl6HWVCg3cqTDYLdmiSLC+50VWX//hgr2anDKDCypZjpQkOs31xuYUXXP6MrKhpsfxSt5vy2xG4Ero0e+9q0J0AgR5CrXYogpiy98IXgpNNwS+vUYUIaL0Oez5crTW75cDrORhUCnsJ6jJq5GkBlk65fchYex0v96/H+Xic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779798706; c=relaxed/simple;
	bh=iZoN6P/l0UYwgx95fag2yubo7AZ5CIuTvxPW7bNPDwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPt/jWnZPJcZIWVUAhSvkwjYXNMEr30ygLPxVfSJ66rP/CPRSjfk+vgX1VA4xXXhoo8PQClU+j0F5QXmtftLtaK28etqZ3oNIkumZsjmBsgRyUc6i4rC9k4Xc8yUmragUajlecVgO2ssnuPpe/Owu9DSVTW7MnHdo+vTxf4eZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB+Zcbj4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB+Zcbj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37311F000E9;
	Tue, 26 May 2026 12:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779798704;
	bh=/HECNH/4/PWP9X14GmPDFA1S/cBDhua+jdKrAz4lGaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RB+Zcbj42Te+0Hbp6SH4Njvz3bvtpPtXeZEKll3BIma8CTgFbNw81kgT7YEQfUheo
	 mgTg3RlMCcitdBgPUgaQSa+r95FMXx8PhJ3xPV1/+wBVW1l7ezwW95SaQux/gmciTH
	 7vCS2elNQVCdyeedv2G44zBrsDFAqxEXZT4w69X5rabFhj4o9yeUArPnJz3v35bstM
	 L+pioSP8NpllBl2FBIo7sC4/tuwoOMV0C6b6UXZ7vm5b8lGZ1qinFNcYY9ce76DrTF
	 sdsisp9dSAceUJGC/G+Y+bwiAD72roKhx691/5QdOTOyKYQWJvtC2QLjUAE2vgxlIO
	 C4HwHsdk0sTOg==
Date: Tue, 26 May 2026 13:31:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>, Andy
 Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 02/11] dt-bindings: iio: adc: hx711: add VSUP supply
 property
Message-ID: <20260526133135.318b3ded@jic23-huawei>
In-Reply-To: <CAMB+xka2uJqf3E69r7XhB0LEkT0bWy4XCW2rCztTST9JX+KYaA@mail.gmail.com>
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
	<20260518220228.63322-3-piyushpatle228@gmail.com>
	<20260520110948.167c8e14@jic23-huawei>
	<CAMB+xka2uJqf3E69r7XhB0LEkT0bWy4XCW2rCztTST9JX+KYaA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 24 May 2026 08:12:13 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> On Wed, May 20, 2026 at 3:39=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Tue, 19 May 2026 03:32:18 +0530
> > Piyush Patle <piyushpatle228@gmail.com> wrote:
> > =20
> > > Document the optional VSUP supply used by the HX711 on-chip regulator.
> > >
> > > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com> =20
> > See my reply to v8 around dvdd needing (I think) to be in this patch
> > for the hx711 not later in the series.
> > =20
> > > ---
> > > No change from v8. Already applied to iio.git testing branch.
> > >  Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yam=
l b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> > > index 1ea60dff98d5..a8eaa1f18de5 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> > > @@ -33,6 +33,10 @@ properties:
> > >      description:
> > >        Analog supply voltage (AVDD).
> > >
> > > +  vsup-supply:
> > > +    description:
> > > +      Supply voltage for the on-chip regulator (VSUP).
> > > +
> > >    clock-frequency:
> > >      description:
> > >        Controls the SCK bit-bang timing. The value is used to derive =
the =20
> > =20
> Acknowledged, and sorry for not acting on this in v9. In v10,
> I will add dvdd-supply in patch 02/11 alongside vsup-supply with a
> description that makes clear it is the digital input supply of the
> HX711 (and not just a bypass capacitor point).
>=20
> The description will read something like:
>=20
>    dvdd-supply:
>      description:
>        Digital supply voltage (DVDD). On the HX711 DVDD is a board-
>        supplied digital rail, distinct from VSUP; they may be tied to
>        the same supply or driven separately.

I'm not seeing a reason for this extra text.  The standard nature of a supp=
ly
being present covers all this. Otherwise we would not have it!

Fine to have a bit of this in the changelog for the series + maybe
briefly touch on it in the patch description.

Thanks,

Jonathan



