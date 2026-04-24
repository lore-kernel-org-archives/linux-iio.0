Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B235AC16;
	Fri, 24 Apr 2026 10:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777025972; cv=none; b=e77yZgWdxo1ybqxfVLc/TujpkRpdByhcsONFz+oSIyg2bwRVaH+atqFI6XcRJ0Ch6TAYEgpP52MGjLd96NJaDwle3DCsXWEcdaPYG3SEda6PWm5LeH1mN8CsqUVkTYOVOTsIhjV3QdxPLC56oBYrNN6153IlpOD0iw+uXJlkY3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777025972; c=relaxed/simple;
	bh=P2pla1sM51CYkSlZsoqlf8hEG7bXgz8AtvubVSOWwW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neFB9STjP8+6jWfXGnUHRQNVL+avHbfK0UMFV1y5OmjLeG1YAv/JeKP9bru3vwXZgN7TMnWwjocpQqyjFifLeBSo+daPLMyqAn12EJFeWUSlxbvn5XDwSkABKjA38GqoHU/YpDBQJvVECtzaRBi4PBHEa6Azfmyl7QX65ex4hzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdmwKl/S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdmwKl/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5812AC2BCC7;
	Fri, 24 Apr 2026 10:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777025970;
	bh=P2pla1sM51CYkSlZsoqlf8hEG7bXgz8AtvubVSOWwW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VdmwKl/SmIyMDLoZHUgQrf7uqb9frBgjTrdA+fgJpzUGWC0QMVmn4OPZ8jISLcgAa
	 ZepPiRjDd7l4YaIIM3LHOtb11QNAGZtmm/fbJ0Kw2gVUnJgfqcBkIdAumd9Wu3tl4w
	 BmWwBUNMCs5bg+UAayYnw+OQyZjApTb5tbki0azV6kSdo3TlA2hh3uvjA8LUMSb5xg
	 P4YwGx4zSDPacgpzNVMDZaE2mCnqRe69qDj8gbQIkOouQNsUsMpF8R/cLD4Z0EeW26
	 5kmQR+100otBP5hXWBFvVH6QpbYUZkz1/t2Imu+KaKzgNQsoYL5r2+XhjUWzx79wgH
	 38TH8gK4R6Ihw==
Date: Fri, 24 Apr 2026 11:19:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Ariana.Lazar@microchip.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <robh@kernel.org>, <linux-kernel@vger.kernel.org>, <andy@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: dac: add support for Microchip MCP48FEB02
Message-ID: <20260424111920.61765602@jic23-huawei>
In-Reply-To: <f7f45b4327c9ce5c806cd878bd9b53e8fcbf7785.camel@microchip.com>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
	<20260212-mcp48feb02-v1-2-ce5843db65db@microchip.com>
	<20260215175857.4085bc2c@jic23-huawei>
	<f7f45b4327c9ce5c806cd878bd9b53e8fcbf7785.camel@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Apr 2026 08:01:17 +0000
<Ariana.Lazar@microchip.com> wrote:

> Hi Jonathan,
>=20
> > > +
> > > +static int mcp48feb02_init_ctrl_regs(struct mcp48feb02_data *data)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int i, vref_ch, gain_ch, pd_ch;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_read(data->regmap, MCP48FEB0=
2_VREF_REG_ADDR,
> > > &vref_ch);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_read(data->regmap,
> > > MCP48FEB02_GAIN_CTRL_STATUS_REG_ADDR, &gain_ch);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_read(data->regmap,
> > > MCP48FEB02_POWER_DOWN_REG_ADDR, &pd_ch);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 gain_ch =3D gain_ch & MCP48FEB02_GAIN_BITS_=
MASK;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 for_each_set_bit(i, &data->active_channels_=
mask, data- =20
> > > >phys_channels) { =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 struct device *dev =3D regmap_get_device(data->regmap);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 unsigned int pd_tmp;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 data->chdata[i].ref_mode =3D (vref_ch >> (2 * i)) &
> > > MCP48FEB02_DAC_CTRL_MASK;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 data->chdata[i].use_2x_gain =3D (gain_ch >> i)=C2=A0 &
> > > MCP48FEB02_GAIN_BIT_MASK;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * Inform the user that the current voltage reference
> > > read from the volatile
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * register of the chip is different from the one
> > > specified in the device tree.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * Considering that the user cannot have an external
> > > voltage reference connected
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * to the pin and select the internal Band Gap at the
> > > same time, in order to avoid
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * miscofiguring the reference voltage, the volatile
> > > register will not be written. =20
> >=20
> > Spell check comments.=C2=A0 misconfiguring
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * In order to overwrite the setting from volatile
> > > register with the one from the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * device tree, the user needs to write the chosen
> > > scale. =20
> >=20
> > I'm a little unsure of why we need this extra gate on updating things
> > to match
> > the device tree provided config.=C2=A0 Why should the volatile register=
 at
> > this point
> > match what DT says?=C2=A0 If it does seems to me we should be noisier
> > about it than dev_dbg()
> >=20
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 switch (data->chdata[i].ref_mode) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 case MCP48FEB02_INTERNAL_BAND_GAP:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->phys_chann=
els >=3D 4 && (i % 2) &&
> > > data->use_vref1) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "ch[%u]: was configured
> > > to use internal band gap", i);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "ch[%u]: reference
> > > voltage set to VREF1", i);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((data->phys_chan=
nels < 4 || (data- =20
> > > >phys_channels >=3D 4 && !(i % 2))) && =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 data->use_vref) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "ch[%u]: was configured
> > > to use internal band gap", i);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "ch[%u]: reference
> > > voltage set to VREF", i);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
> >  =20
>=20
>=20
> The device restores its EEPROM configuration (or writes default values
> for the part numbers without EEPROM) into the volatile registers at
> startup, so during probe we may have a valid Vref/gain state that does
> not match current DT. The driver should report any mismatch to the user
> because the Vref/gain selection is changed only through the scale
> attribute of each channel. The DT only describes available resources on
> the board for determining the available scales.
>=20
> I can update the messages to describe the behavior better and use
> dev_info() instead of dev_dbg().

The statement above about it not being possible to use the internal band gap
if a vref is wired leaves me with more questions about this.

I'm a bit concerned about cases like:

Vref is wired and eeprom is set for internal reference.   Should we
be very careful to not enable vref until that situation is resolved?
It might be on anyway but we can at least make sure we are reponsible
for turning it on.

Maybe the chip has sufficient protective elements to cope with that
though obviously it won't give sensible output whilst this is true.

If all those are fine, dev_info() makes sense to me.
I wonder if we should return -EBUSY for attempts to read the voltage
back whilst in this state as well?  Might provide some additional
indication something is mismatched and we don't expect the device to work
correctly.

Jonathan


> Best regards,
> Ariana
>=20
>=20

