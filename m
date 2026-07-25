Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640A83A1C9;
	Sat, 25 Jul 2026 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785022320; cv=none; b=GE2YlNfmccIstqJanOrHaH7AAMpo0V3zETqc20aLLnwr5tCUsG8x+taCSPek5lPOHDcc3Mz4HsSEUI/0pcqe3qh/2fX3IHIv6Cxcbn+AY0DDbr2xxxglVD8ePrjGNap24IIuHideYVwWLH6gfXwNwL+KjoFkjGVzfWaxZHtwZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785022320; c=relaxed/simple;
	bh=aY1qNjDsB6k1qwUTIATswpYBPoOiWoNOA34+hdLN4i8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gopVh1diBrFMP1L+35glrTkpyeSfHkkPD3aHgJMMoGux89VuQk/YqOzBr0y7CrPX0Ip/ptVsg63NvhGeq2gICkB8bpYXGP+kMVRiYVV8AXnhk9tad3p0Ata0CrSCZUiZ7vQscEg2LVfB+O4zIYvAZCgOQ/cUKGMuwMko4WHGO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCJvO7J6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCJvO7J6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214A51F000E9;
	Sat, 25 Jul 2026 23:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785022319;
	bh=nKniyWVT5M6jxG4Y1dgkt+TX5tVQqlg1n4lifZmFS0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iCJvO7J6Ys/lcbOw6loRv/eIOtLZ6D26GbOziC9hUS7vPjEyK8Wo+0mMPneV0ATCv
	 P0NQpAjwf2DTF7WuFs3spKOSOz/NoZ5PZkHHFIYmLrR73KRJdpKzsn9QcGTz4NTZ81
	 2xsormCoS+PgZ2x/8qTXuS4556q2ITvLMujNhko+HBy1oJryPmoxcjDj4OxxR+9qMi
	 CiHtrInq8jTm01c7TFVK8PmnST7otLK3Z0wE9iqHPOmHJ0gH63EJoMpBi56TxxDgG9
	 a/ut12GbPJ+27Rr1QGV50CaXByzMfiquBDMFQYjjJktJ9tcIrtt1G2LWxsonaIOh5N
	 El248t/x+orPA==
Date: Sun, 26 Jul 2026 00:31:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Siratul Islam <siratul.islam@linux.dev>
Cc: Stefan Popa <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, ciprian.hegbeli@analog.com,
 u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: add maxim,max40080
Message-ID: <20260726003152.1d9f36d5@jic23-huawei>
In-Reply-To: <a79b2fd8d08d4594bbb472b005534d7c91d86e49.camel@linux.dev>
References: <20260723065036.2683075-1-stefan.popa@analog.com>
	<20260723065036.2683075-2-stefan.popa@analog.com>
	<a79b2fd8d08d4594bbb472b005534d7c91d86e49.camel@linux.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jul 2026 22:23:39 +0600
Siratul Islam <siratul.islam@linux.dev> wrote:

> On Thu, 2026-07-23 at 09:50 +0300, Stefan Popa wrote:
> > Add device tree bindings for the Maxim MAX40080 bidirectional
> > current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.
> >=20
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> > ---
> >  =20
> ...
> > +
> > +title: Maxim MAX40080 bidirectional current-sense amplifier
> > +
> > +maintainers:
> > +=C2=A0 - Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> > +=C2=A0 - Stefan Popa <stefan.popa@analog.com>
> > +
> > +description: |
> > +=C2=A0 The MAX40080 is a high-precision, bidirectional current-sense a=
mplifier with
> > +=C2=A0 an integrated 12-bit ADC and an I2C/SMBus interface. It measure=
s the voltage
> > +=C2=A0 across an external shunt resistor and the input bus voltage, an=
d stores the
> > +=C2=A0 results in an internal FIFO.
> > +
> > +=C2=A0 Datasheet:
> > +=C2=A0=C2=A0=C2=A0 https://www.analog.com/en/products/max40080.html =20
> This URL links to a product page rather than a datasheet as the tag sugge=
sts.
> Would be difficult to fetch using CLI tools.
> Were you supposed to use something like
> "https://www.analog.com/media/en/technical-documentation/data-sheets/MAX4=
0080.pdf"?

I think the argument for using product pages is that they are stable and da=
tasheet
paths sometimes change.

For ADI there is a neater form as well that is supposed to be stable (and
has been for last few years at least)
https://www.analog.com/max40080
Works for any product and takes you to the equilvalent product page to the
link above.

So whilst you make a good point I think we will have to let Analog decide
on a standard way to link to their product info / datasheets.  That is
on the perhaps optimistic basis they have more insight into stable choices
than we do!

>=20
> > +
> >  =20
> ...
> > +examples:
> > +=C2=A0 - |
> > +=C2=A0=C2=A0=C2=A0 i2c {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adc@20 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 com=
patible =3D "maxim,max40080";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg=
 =3D <0x20>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #io=
-channel-cells =3D <1>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shu=
nt-resistor-micro-ohms =3D <100000>;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > +=C2=A0=C2=A0=C2=A0 }; =20
>=20
> --
> Best regards,
> Sirat
>=20

