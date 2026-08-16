Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37F5146D5A;
	Sun, 16 Aug 2026 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786841405; cv=none; b=tTIBjnpSXjyhv6EZXP9UiT70UrDtr2rzOK4Pg5pEa1WzGPqAq6vC1GzXx4UcN9xhiELZaWoQYweDj1c/lNFv4fAowdJdCbo2urUsLsd5vlsbmLES0sJg6LuJdfZ2oRIedGrEmlUhcTg8IxusxvBpEwk1g32/xUpxA3U3xQ5KjxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786841405; c=relaxed/simple;
	bh=/qAvPMTMjyOZE7kV6Lmo9XjB5d8BapgHnr0awEjQikc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5KrAY1vShjrhlqNwjmZgl/HqZZpdy0RNCt0J8Whl9bko9o9+rRusbkEHc4DPH7XYf2LkSYBVuUcpij8ALBcd2YfL8GWGxGWAIEE2CRfwQ1o6JoNR+Y+boTo+kZmB0FaEfj+3MqIQmk+FnvZtUcgwGKU2ZElULmhFfMU6VrLrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dm/iZx7P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dm/iZx7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBDB1F000E9;
	Sun, 16 Aug 2026 00:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786841403;
	bh=wX25VOtp0mTKk/k7vLCdTA2N1UptvhRSJw8Sejqx3Q4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dm/iZx7P39EOQOx3dMNDwy/E6CJy8NXIad8C0rdG/STtqAvE89BkeAGS6d1Znf3Dc
	 SmgGHRJsMWnZqWgNVo4HF3iIBLvEVC11vtbLX4DmFjxB/1n2jfLxBeAKIRpCrheYXi
	 8YGa32afQV5vnRH4jBWYdWCqYvD1vGmBjC3JCXVGRhQO2OM7fi9HBKvgUJvF2ON+KO
	 Ov5lD6IQCcyVWHBDdiilOsTwOOSoEX0oRCKoW169Pbrfhul0efLkPsDMgjzJR/N6A7
	 Xsm098RekrJI+mMtvLJEdh9h/PeflMx+nxz1FSi9Ea3/w3nVjmc8Cbnrpl9ZgzCvJF
	 JmqoUjU2HxygA==
Date: Sun, 16 Aug 2026 01:49:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux@analog.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: accel: adxl367: add support for INT2
 interrupt pin
Message-ID: <20260816014959.18034ff6@jic23-huawei>
In-Reply-To: <178671050969.21598.13163934753300429850.b4-review@b4>
References: <20260813081452.4289-1-antoniu.miclaus@analog.com>
	<20260813081452.4289-4-antoniu.miclaus@analog.com>
	<178671050969.21598.13163934753300429850.b4-review@b4>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Aug 2026 13:28:29 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Thu, 13 Aug 2026 11:14:52 +0300, Antoniu Miclaus <antoniu.miclaus@anal=
og.com> wrote:
> > diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> > index 8c3de11a10a3..df385740b17b 100644
> > --- a/drivers/iio/accel/adxl367.c
> > +++ b/drivers/iio/accel/adxl367.c
> > @@ -1426,6 +1430,31 @@ static int adxl367_setup(struct adxl367_state *s=
t)
> >  	return adxl367_set_measure_en(st, true);
> >  }
> > =20
> > +static int adxl367_set_int_map_reg(struct adxl367_state *st)
> > +{
> > +	int irq;
> > +
> > +	irq =3D fwnode_irq_get_byname(dev_fwnode(st->dev), "INT1");
> > +	if (irq =3D=3D -EPROBE_DEFER)
> > +		return irq;
> > +	if (irq > 0) {
> > +		st->int_map_reg =3D ADXL367_REG_INT1_MAP;
> > +		return 0; =20
>=20
> sashiko point is sensible but I guess both INT ouputs are pretty much
> the same? So even even if there's a mismatch against spi/i2c I guess
> it is not problematic?

Sashiko has spotted a real problem here, be it one that won't
pass the binding restrictions which require INT1 to be first
if it is present at all.  Anyhow we should be checking for a dts
that provides bother interrupts but ordered as INT2 INT1 then
the i2c and spi layers will give us the irq associated with
the first element (so INT2) but the code here will see that
there is an INT1 and route the interrupts there.  Hence the miss.

If you are looking up interrupts by name you should use the
interrupt number retrieved.=20

return irq from adxl367_set_int_map_reg() on success then


	ret =3D adxl367_set_int_map_reg(st);
	if (ret < 0)
		return dev_err_probe(st->dev, ret, "Failed to get interrupt\n");

	irq =3D ret;
	ret =3D devm_request_threaded_irq(st->dev, irq, NULL,
					adxl367_irq_handler, IRQF_ONESHOT,
					indio_dev->name, indio_dev);
	if (ret)
		return dev_err_probe(st->dev, ret, "Failed to request irq\n");

Or pass it as a pointer so that adxl367_set_int_map_reg() can modify it
on matching by name.=20

Could argue that we should never see this but I think it's easy to harden
against, so why not.

Hmm. On a wide awake day I think I'd have spotted this, but not sure I woul=
d have
today!

Jonathan

>=20
> - Nuno S=C3=A1
>=20

