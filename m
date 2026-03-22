Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E6D35E95F;
	Sun, 22 Mar 2026 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774201167; cv=none; b=LmxWmUFXBP//4M8Cd1d3dQzhwV2RlZS090/rdegIoPmuhUKpW+rOtD8e2M+7eWlvgLKI3HaM7/FdQaGxnhoTTZg57T3iBSnAiDevTF8oDs835ICsR9+d4hji2nbf7VFoEmlODlJvoZbFZ1qCVESggaAeXaviEfHa5zZyu+UsOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774201167; c=relaxed/simple;
	bh=rGqoyqNhFMHPVA+bY2FxyFQo/Q2vXVxgKNZAjG66XwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMh1b8hK9wHBOgt1FH/4b07yNH19sEKn84AoHLN9hhRFh5qPWTN0o2F5heJ+tWOi+hoy15PeXF8/JbvUJsL9G6WR/HFqgCOQct8EciTP6u4ZN5Nu8EuWSU8VgscevwGF8PxrDsw67WbO83/+HcLV/iDCG4ZBTahhEfugnvGA2so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYa38JzD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYa38JzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF9FC19424;
	Sun, 22 Mar 2026 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774201166;
	bh=rGqoyqNhFMHPVA+bY2FxyFQo/Q2vXVxgKNZAjG66XwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CYa38JzDoTDeMANgMjx+JHX6sDcsvehICcGWNcpqkAQs/Rl5YfQ8nSCCc0ctnS+Ur
	 nu7C2WmTJl1MefIO3pnJN2U/+zDqUTLFSqRS82350t5K81DmkYveIKXbtNPRwNcCKw
	 qVMrJykjIUqtUF0ic3vb6nzH4gSEVRk5yGfrsYL8saVJseDbZhbMm+OXOzy9MJ7Bwx
	 EVqFvDbrZe9tIwI1n/i95Z4enOMffnx302mvcKAQtHysQ75qHcEa+yFvsgVy1Oeswv
	 ml6GV9GRTAa7uklaYuW+XkK93K3iUHUUxM1oqHndk7f1y2kjU+x0GV7k8xbNsO0Uqi
	 tDzbpjI6S8bfQ==
Date: Sun, 22 Mar 2026 17:39:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260322173916.0dba368d@jic23-huawei>
In-Reply-To: <CY4PR03MB339971AED25BA03A4E6947CC9B4AA@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20260321100154.1258-1-antoniu.miclaus@analog.com>
	<20260321100154.1258-5-antoniu.miclaus@analog.com>
	<20260321121806.3bc18f53@jic23-huawei>
	<CY4PR03MB339971AED25BA03A4E6947CC9B4AA@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 22 Mar 2026 16:26:58 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, March 21, 2026 2:18 PM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; David Lechner <dlechner@baylibre.com>;
> > Sa, Nuno <Nuno.Sa@analog.com>; Rob Herring <robh@kernel.org>; Krzysztof
> > Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> > Olivier Moysan <olivier.moysan@foss.st.com>; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v7 4/4] iio: adc: ad4080: add support for AD4880 du=
al-
> > channel ADC
> >=20
> > [External]
> >=20
> > On Sat, 21 Mar 2026 12:01:54 +0200
> > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> >  =20
> > > Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> > > integrated fully differential amplifiers (FDA).
> > >
> > > The AD4880 has two independent ADC channels, each with its own SPI
> > > configuration interface. The driver uses spi_new_ancillary_device() to
> > > create an additional SPI device for the second channel, allowing both
> > > channels to share the same SPI bus with different chip selects. =20
> >=20
> > Silly question - can we be sure that they both are on the same SPI bus?
> > I think it's reasonable to assume no one would burn pins to wire the
> > control interfaces up to separate busses. I'm not even sure how we'd
> > do a binding if they were on separate busses.
> >=20
> > Otherwise, a follow on from the 'is it one backend or two' question
> > on the binding.
> >=20
> > That long discussion between you and Andy has me looking at this a litt=
le
> > more closely. =20
>=20
>   Yes, both channels are on the same SPI bus with two chip
>   selects =E2=80=94 one per internal ADC die.

Can you give a reference for this?  The datasheet I'm looking at
has separate cs, sclk, sdi and sdo per channel.  So it would be
a board thing only that puts them on the same SPI bus.
=20
>=20
>   For the backend question =E2=80=94 as explained in my reply to the
>   binding patch, the FPGA uses two separate axi_ad408x IP
>   instances. The buffer is requested from back[0] because
>   the packer output feeds the DMA through backend A's clock
>   domain.

Ok. So given the packer part makes this really one FPGA IP
with two 'backend interfaces'.

Lets be clear about that in the comments etc.

Jonathan

>=20
> > Jonathan
> >  =20
> > >
> > > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > > Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > ---
> > > Changes in v7:
> > >   - Drop debugfs_reg_access for dual-channel AD4880 variant
> > >   - Pass struct device * to ad4080_properties_parse() instead of
> > >     using regmap_get_device(st->regmap[0])
> > >
> > >  drivers/iio/adc/ad4080.c | 231 ++++++++++++++++++++++++++++++----- =
=20
> > ---- =20
> > >  1 file changed, 181 insertions(+), 50 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> > > index 7cf3b6ed7940..8767eef418e9 100644
> > > --- a/drivers/iio/adc/ad4080.c
> > > +++ b/drivers/iio/adc/ad4080.c =20
> >  =20
> > > @@ -632,9 +752,10 @@ static int ad4080_probe(struct spi_device *spi)
> > >  	indio_dev->name =3D st->info->name;
> > >  	indio_dev->channels =3D st->info->channels;
> > >  	indio_dev->num_channels =3D st->info->num_channels;
> > > -	indio_dev->info =3D &ad4080_iio_info;
> > > +	indio_dev->info =3D st->info->num_channels > 1 ?
> > > +			  &ad4880_iio_info : &ad4080_iio_info;
> > >
> > > -	ret =3D ad4080_properties_parse(st);
> > > +	ret =3D ad4080_properties_parse(st, dev);
> > >  	if (ret)
> > >  		return ret;
> > >
> > > @@ -644,15 +765,23 @@ static int ad4080_probe(struct spi_device *spi)
> > >
> > >  	st->clk_rate =3D clk_get_rate(clk);
> > >
> > > -	st->back =3D devm_iio_backend_get(dev, NULL);
> > > -	if (IS_ERR(st->back))
> > > -		return PTR_ERR(st->back);
> > > +	/* Get backends for all channels */
> > > +	for (unsigned int ch =3D 0; ch < st->info->num_channels; ch++) {
> > > +		st->back[ch] =3D devm_iio_backend_get_by_index(dev, ch);
> > > +		if (IS_ERR(st->back[ch]))
> > > +			return PTR_ERR(st->back[ch]);
> > >
> > > -	ret =3D devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> > > -	if (ret)
> > > -		return ret;
> > > +		ret =3D devm_iio_backend_enable(dev, st->back[ch]);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > >
> > > -	ret =3D devm_iio_backend_enable(dev, st->back);
> > > +	/*
> > > +	 * Request buffer from the first backend only. For multi-channel
> > > +	 * devices (e.g., AD4880), all backends share a single IIO buffer
> > > +	 * as data from all ADC channels is interleaved into one stream.
> > > +	 */
> > > +	ret =3D devm_iio_backend_request_buffer(dev, st->back[0], indio_dev=
); =20
> >=20
> > So this is the interleaving bit.  Follows on from my question on the bi=
nding
> > and whether it is appropriate to represent it as two separate backends
> > vs a single one.  With a single one we'd need to make the control inter=
faces
> > take a parameter to say which 'front end' we were configuring - though =
it
> > kind of maps to channels in the particular case and we already have
> > a parameter for that.
> >=20
> > The other option might be to make the dt-binding take a phandle + index=
 to
> > say this backend, with this front end interface.
> >  =20
> > >  	if (ret)
> > >  		return ret; =20
>=20

