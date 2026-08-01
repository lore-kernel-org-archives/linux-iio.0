Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFC53B9D9D;
	Sat,  1 Aug 2026 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785618762; cv=none; b=IXpd2PiFjiLv+c20KkvARPVIWDsvgasyrJ4SR0i6iPA7jq3Ijy73t40232JdX2320cbwj2f+yrPfNdWvWOqdtm5sWweOB3dT9fFDJw6N66auAPKMnEDeJwYBxF8PYCVy6a/r5z1oN3docBm2/Ix2OeYi1AEI4QA3uOwEp7QlqO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785618762; c=relaxed/simple;
	bh=Y0j3huWyH69Yd8AT4hwX8NfNzRum0j7gqSiacjr117g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6L6Cqn4nCeENFfVUW/1knF90ucSBmhDoUAT+Zk61ry9G9Jm+Y/b3cTb0KHbhOofLqEd2SnPj3N04s58W6LmNPJ0oOr/qJ0Eh0Cnaa5bqOqxXvxR3lo5F6Tjwcn/yA/f9bcVD02tX7CuhSDwbTm5Bjd7QWgeu5Vh9N6YiKlZNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeUJT6Yt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeUJT6Yt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766BC1F00AC4;
	Sat,  1 Aug 2026 21:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785618761;
	bh=VTmEEMG7q1jUBwom+54FxcU6cI6YJWwoxTYuyOT3yoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TeUJT6YtEWILgeAPQRkdRZvwPdWX48Ia7gCS4KpCvGojMdEHOEmPNlolp8oNu+oMB
	 8GpClCG40A8Q1bSTxx1iY8jItRcIT0Kl8uJnBkQEoykGcPdUWHqj+7WhXjKdC5//LE
	 CB2/VWN6KKMVqhT0OYaD+dXb7zEia3+zAjfFXMH1+6raJa8rUQH3lvGzvccZeLGlaR
	 Y0M4VwX2ty76TbstlROBYLaUXm3M55D1fNf4JIYeSFSoofaLRJO+dZDe1L9758pRyg
	 lB0YOs/ErXd6P6y8bmTofjsDqNj2vXe66fBa7lMrqeKiRjtXd/6DL4NGYd9CLyFDfG
	 Hq/c5nZdStG0g==
Date: Sat, 1 Aug 2026 22:12:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 5/6] iio: adc: ltc2378: Add support for LTC2338-18
Message-ID: <20260801221236.6c07fa49@jic23-huawei>
In-Reply-To: <amiqwmIHsgO7v8zC@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1785186980.git.marcelo.schmitt@analog.com>
	<39f2ff86cf736ff97286d6451fcc45fdba6732f9.1785186980.git.marcelo.schmitt@analog.com>
	<20260727214022.C81191F000E9@smtp.kernel.org>
	<amiqwmIHsgO7v8zC@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jul 2026 10:12:34 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 07/27, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Low] Declaring a variable immediately after a switch case label with=
out a block statement causes a compilation error.
> > --
> >=20
> > --- Patch [5]: [PATCH v9 5/6] iio: adc: ltc2378: Add support for LTC233=
8-18 ---
> > commit 29728b1d34f34b2970657e2d83536de22940ee2e
> > Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> >=20
> > iio: adc: ltc2378: Add support for LTC2338-18
> >=20
> > This commit adds support for the LTC2338-18 ADC to the existing ltc2378
> > driver. It extends the driver to handle the internal voltage reference =
and
> > input signal attenuation specific to this part.
> >  =20
> > > diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> > > --- a/drivers/iio/adc/ltc2378.c
> > > +++ b/drivers/iio/adc/ltc2378.c =20
> >=20
> > [ ... ]
> >  =20
> > > @@ -383,7 +395,10 @@ static int ltc2378_read_raw(struct iio_dev *indi=
o_dev,
> > >  		return IIO_VAL_INT;
> > >  	}
> > >  	case IIO_CHAN_INFO_SCALE:
> > > +		struct u32_fract fract =3D st->info->internal_div; =20
> >=20
> > [Severity: Low]
> > Does this declaration cause a build error? =20
> No, at least not when I built with clang/llvm-22.
Maybe but given we still stick to declarations at top of scope (if not
strictly required) makes me want add scope here anyway.

So I tweaked it to add the {}

Series applied to the testing branch of iio.git.

Thanks,

Jonathan


>=20
> > Declaring a variable immediately
> > after a switch case label without a block statement is not a valid stat=
ement
> > in C and usually causes a compiler error. Could this case be wrapped in=
 a
> > block to scope the variable, or the declaration be moved to the top of =
the
> > function?
> >  =20
> > >  		*val =3D st->ref_uV / MILLI;
> > > +		if (fract.numerator && fract.denominator)
> > > +			*val =3D mult_frac(*val, fract.numerator, fract.denominator);
> > >  		/*
> > >  		 * For all LTC2378-like devices, the amount of bits that express
> > >  		 * voltage magnitude depend on the polarity / output code format: =
=20
> >=20
> > --=20
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.178518698=
0.git.marcelo.schmitt@analog.com?part=3D5 =20
>=20

