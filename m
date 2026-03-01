Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A16D7080E;
	Sun,  1 Mar 2026 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772368309; cv=none; b=lTBB5H8gTF7e7lxxjtZ+dQTsBlVabJpCoRKp0bq7GlkG3wZ7k/cJNtfc/+6e4oea/wUArbVqmR3rEXeEcKEYlvpjHGkHK3M2IUY+maRee5BMWww2dUC399JefLdU9G6NzAnYOKYZb307GZ98ShNrUFee7qbHNNgY7dthbAgMh10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772368309; c=relaxed/simple;
	bh=v9k3fDJCG0CKu0dnXzvu/BXRpg5iL3InveedgLyohXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tE5m5NYb8sqPsQwQX6wukC0BT3lTHCMecQQWzRBCRL8Z1+BAJ3iv1pV9RKh/IfxqLrBz7NQy3RkFOa+Ut4xemmHUJx3OrS28COR40BS2aN6foLZKV7Scs4kcfzVbtcsvcF7y03vL49CU8YIwu7CO7ZA5qsATnn9NW8gsO3X2Xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpK1djJw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpK1djJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA29C116C6;
	Sun,  1 Mar 2026 12:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772368308;
	bh=v9k3fDJCG0CKu0dnXzvu/BXRpg5iL3InveedgLyohXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tpK1djJwPgleQL84BNsexltPL2q3EUdlwXdGLEpDdVKoh9e8yCmkvHa+3yR7armcq
	 qbwpdo6/W2K1DwuCJhJA/ZVroM9gnMnAw5Zn698nrgqCvcWyWiRVeIQvGPIVYDgCaZ
	 C9zpmoF9T1BgosCzy4IXOAM6mXP9/aSfSnfQAzlMm5fOUvI5sLcLeASEPQBG/Aas9A
	 DdWeZe6aYFaBNBbaDGOtIlNi22nt+kKWEoo3LmmzNmqh9mI8lJOSKxqo+pYEpAo13a
	 TjhfPjKEgpO0R+G4HoY7Hdhpz0WJIAU26y7ztCB8b57Nx1eMprxgbc4RSvUtGR8Rvm
	 jlhr2eyE8/U+w==
Date: Sun, 1 Mar 2026 12:31:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <Ariana.Lazar@microchip.com>
Cc: <andy.shevchenko@gmail.com>, <dan.carpenter@linaro.org>,
 <andriy.shevchenko@intel.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>, <andy@kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] iio: dac: adding support for Microchip MCP47FEB02
Message-ID: <20260301123140.10f585b4@jic23-huawei>
In-Reply-To: <16614d1f875aa1e9923375dd3de0897de17791f5.camel@microchip.com>
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
	<aYXvP5FLA5BvkoVX@stanley.mountain>
	<aYX016NlTNkJzGdT@smile.fi.intel.com>
	<aYX7tlJ593KBDGW0@stanley.mountain>
	<aYYFba5-ZV8VuZHM@smile.fi.intel.com>
	<aYYJc2d5AwJbc_vV@stanley.mountain>
	<CAHp75VdhTEKu2tKC+UKJLs1DcE7079KEbPV0NTFfUAjADBEg_g@mail.gmail.com>
	<16614d1f875aa1e9923375dd3de0897de17791f5.camel@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Feb 2026 10:26:05 +0000
<Ariana.Lazar@microchip.com> wrote:

> On Fri, 2026-02-06 at 17:57 +0200, Andy Shevchenko wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > On Fri, Feb 6, 2026 at 5:32=E2=80=AFPM Dan Carpenter
> > <dan.carpenter@linaro.org> wrote: =20
> > > On Fri, Feb 06, 2026 at 05:14:53PM +0200, Andy Shevchenko wrote: =20
> > > > On Fri, Feb 06, 2026 at 05:33:26PM +0300, Dan Carpenter wrote: =20
> > > > > On Fri, Feb 06, 2026 at 04:04:07PM +0200, Andy Shevchenko
> > > > > wrote: =20
> > > > > > > drivers/iio/dac/mcp47feb02.c
> > > > > > > =C2=A0=C2=A0=C2=A0 712 static int mcp47feb02_init_scales_avai=
l(struct
> > > > > > > mcp47feb02_data *data, int vdd_mV,
> > > > > > > =C2=A0=C2=A0=C2=A0 713=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int
> > > > > > > vref_mV, int vref1_mV)
> > > > > > > =C2=A0=C2=A0=C2=A0 714 {
> > > > > > > =C2=A0=C2=A0=C2=A0 715=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct device *dev =3D
> > > > > > > regmap_get_device(data->regmap);
> > > > > > > =C2=A0=C2=A0=C2=A0 716=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 int tmp_vref;
> > > > > > > =C2=A0=C2=A0=C2=A0 717
> > > > > > > =C2=A0=C2=A0=C2=A0 718=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mcp47feb02_init_scale(data,
> > > > > > > MCP47FEB02_SCALE_VDD, vdd_mV, data->scale);
> > > > > > > =C2=A0=C2=A0=C2=A0 719
> > > > > > > =C2=A0=C2=A0=C2=A0 720=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (data->use_vref)
> > > > > > > =C2=A0=C2=A0=C2=A0 721=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_vref =3D vref=
_mV;
> > > > > > > =C2=A0=C2=A0=C2=A0 722=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 else
> > > > > > > =C2=A0=C2=A0=C2=A0 723=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_vref =3D
> > > > > > > MCP47FEB02_INTERNAL_BAND_GAP_mV;
> > > > > > > =C2=A0=C2=A0=C2=A0 724
> > > > > > > =C2=A0=C2=A0=C2=A0 725=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mcp47feb02_init_scale(data,
> > > > > > > MCP47FEB02_SCALE_GAIN_X1, tmp_vref, data->scale);
> > > > > > > =C2=A0=C2=A0=C2=A0 726=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 mcp47feb02_init_scale(data,
> > > > > > > MCP47FEB02_SCALE_GAIN_X2, tmp_vref * 2, data->scale);
> > > > > > > =C2=A0=C2=A0=C2=A0 727
> > > > > > > =C2=A0=C2=A0=C2=A0 728=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (data->phys_channels >=3D 4) {
> > > > > > > =C2=A0=C2=A0=C2=A0 729=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mcp47feb02_init_s=
cale(data,
> > > > > > > MCP47FEB02_SCALE_VDD, vdd_mV, data->scale_1);
> > > > > > > =C2=A0=C2=A0=C2=A0 730
> > > > > > > =C2=A0=C2=A0=C2=A0 731=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->use_vre=
f1 && vref1_mV <=3D
> > > > > > > 0) =20
> > > > > > > --> 732=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return dev_err_probe(dev, =20
> > > > > > > vref1_mV, "Invalid voltage for Vref1\n");
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > ^^^^^^^^
> > > > > > > vref1_mV is not a valid error code. =20
> > > > > >=20
> > > > > > Why not? When it's negative I believe the above statement is
> > > > > > not true. =20
> > > > >=20
> > > > > I saw this as just sanity checking the input.=C2=A0 vref1_mV is
> > > > > never
> > > > > actually negative.=C2=A0 I don't know if
> > > > > devm_regulator_get_enable_read_voltage()
> > > > > can return less than one millivolt. =20
> > > >=20
> > > > =C2=A0* In cases where the supply is not strictly required, callers
> > > > can check for
> > > > =C2=A0* -ENODEV error and handle it accordingly.
> > > > =C2=A0*
> > > > =C2=A0* Returns: voltage in microvolts on success, or an negative
> > > > error number on failure.
> > > >=20
> > > > What did I miss?
> > > >  =20
> > >=20
> > > drivers/iio/dac/mcp47feb02.c
> > > =C2=A0 1157=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(chip_features->have_ext_vref1) {
> > > =C2=A0 1158=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D
> > > devm_regulator_get_enable_read_voltage(dev, "vref1");
> > > =C2=A0 1159=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret > 0) {
> > > =C2=A0 1160=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 vref1_mV =3D ret / MILLI;
> > >=20
> > > Potentially, if ret is in the 1-999 range then vref1_mV could be
> > > zero,
> > > but it can't be negative. =20
> >=20
> > I see, thanks!
> >=20
> > So, it means that the validation should be moved here on ret < 0 and
> > ret < 1000 (if positive).
> >  =20
> > > =C2=A0 1161=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 data->use_vref1 =3D true;
> > > =C2=A0 1162=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > > =C2=A0 1163=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "using internal band
> > > gap as voltage reference 1.\n");
> > > =C2=A0 1164=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "Vref1 is
> > > unavailable.\n"); =20
> >=20
> > But... ret < 0=C2=A0 is checked here.
> > Hence the only one left is the range [0..999].
> >  =20
> > > =C2=A0 1165=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0 1166=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0 1167
> > > =C2=A0 1168=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D mcp47feb02_init_ctrl_regs(data);
> > > =C2=A0 1169=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(ret)
> > > =C2=A0 1170=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(dev, ret=
, "Error
> > > initialising vref register\n");
> > > =C2=A0 1171
> > > =C2=A0 1172=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D mcp47feb02_init_ch_scales(data, vdd_mV,
> > > vref_mV, vref1_mV);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0 ^^^^^^^^
> > >=20
> > > =C2=A0 1173=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(ret)
> > > =C2=A0 1174=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
> >=20
> >=20
> > --
> > With Best Regards,
> > Andy Shevchenko =20
>=20
>=20
> Hello Dan and Andy,
>=20
> Thank you for bringing to my attention this bug. I fixed it by storing
> voltages
> in microvolts instead of millivolts in order to avoid the [1, 999]
> case.
> I removed dividing by MILLI from the probe function and kept the
> computation of
> the scale values only in init_scale function.
>=20
> I will send a follow on patch.

Hi Ariana,

Just a reminder that this one still seems to be outstanding.
Maybe I missed a patch?

Thanks,

Jonathan

>=20
> Best regards,
> Ariana
>=20

