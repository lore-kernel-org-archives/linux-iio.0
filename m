Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34656330317;
	Sun, 18 Oct 2026 23:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792367590; cv=none; b=dlzSszA2g2eT2rqWYrNR6T6cWm461ruAqtngdRCw+7UQxvTa6FVXmTsVB9jwEWBXohRTw4ANNNm0PFhMp2xmdOLitspPMoa5656Ec5LYnSWZ7PoDkBZ5SR+uoXW9MJV7bxajmhbvPVPsMj9WS6F58jQRxyzHz4A+lEMCUt2AZ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792367590; c=relaxed/simple;
	bh=vWVfXnVtb+RLPbdYrUd8wdVdcR6YHuqCtIwmL/FyM0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HM0vqoP0kxIrpbaJi/i/Uv8KfICxJjmZxd6i1oIrR564OWKVTNLTbBVXPJ6s8NmKmO4kpcT3DG7El75NteT4HastowiW7XeXR49JlXPer+JexqJH3uBl+TGcwogYxXMh2j4JtSfhnmyVlOHWAXFPwVdHINRwGnj7mZbHPt4SmWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/nVyYnV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/nVyYnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC8E1F000C4;
	Sun, 18 Oct 2026 23:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792367588;
	bh=h0aXcmO0faLAmKib2W5GOX2aVwLENR3V3ioGerhQSYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R/nVyYnVVPwA+plchdNBTWL/QGLLWk5YcNByuz+kPS9GtNlE+FwIfiUI/lkzgejdG
	 BT+QvvVc5mVPd7FrOsA79r3GeusLTV1eAJetehF1/3bdIDATLDXuOLxkNcP8m7K+rD
	 IsSvitbiY8GKskg7XJxwg1hqd5WulEYff//0H1Ly/LuC7T47pAkcQJWeHrfOgunwqt
	 AMBp+d34ZnDka2tD7egsuciHHxgN2ouMrU6D7xLMen8yFYjr+9Rt2BbylZMR6WiWrR
	 NuSB5a0TWtWa1k491FiaU5E8peP9zjrNZJXNsjr0PC9IoELdSuuTQIF2pn3AR5irB6
	 x7tzkOhTqZk7g==
Date: Mon, 19 Oct 2026 00:53:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: nuno.sa@analog.com
Cc: cdcp206@gmail.com, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Liviu Stan <liviu.stan@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH v2] iio: temperature: ltc2983: pass leak detector type
 explicitly
Message-ID: <20261019005302.3c04a27a@jic23-hlaptop>
In-Reply-To: <asy9jo0BRDlpM24s@nsa>
References: <20261002-iio-ltc2983-fix-string-compare-v2-1-b0a5ba847790@gmail.com>
	<asy9jo0BRDlpM24s@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Oct 2026 12:00:18 +0100
nuno.sa@analog.com wrote:

> On Fri, Oct 02, 2026 at 11:44:50AM -0500, Carlos Casadiego via B4 Relay w=
rote:
> > From: Carlos Casadiego <cdcp206@gmail.com>
> >=20
> > __ltc2983_custom_sensor_new() uses propname both to select the firmware
> > property to read and to determine whether the custom sensor is a leak
> > detector.
> >=20
> > Pass this information explicitly from the caller instead of deriving
> > the sensor type from the firmware property name. This keeps propname
> > limited to identifying the property and preserves the existing
> > conversion behavior.
> >=20
> > As a side effect, this also avoids the -Wstring-compare warning reported
> > by the kernel test robot for callers where GCC can determine that the
> > property name cannot match "adi,custom-leak-detector".
> >=20
> > Fixes: 3dd0c048409e ("iio: temperature: ltc2983: Add support for ADT760=
4")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202609120045.OxEsKLIn-lkp=
@intel.com/
> > Signed-off-by: Carlos Casadiego <cdcp206@gmail.com>
> > --- =20
>=20
> Looks to me this is the one to apply. So:
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.  I considered dropping the fixes tag but in the end just elected
to leave it (otherwise the closes gets confusing) but apply this to my
slow tree for next merge window (the one in 3 months time).

Hope that works for everyone.

Thanks

Jonathan

>=20
> > Changes in v2:
> > - Reframe the change around passing the leak detector type explicitly,
> >   with the compiler warning as a side effect.
> > - Drop const qualifiers from bool parameters as suggested by Andy
> >   Shevchenko.
> > - Link to v1: https://patch.msgid.link/20260929-iio-ltc2983-fix-string-=
compare-v1-1-d67d612d6ddd@gmail.com
> >=20
> > To: Nuno S=C3=A1 <nuno.sa@analog.com>
> > To: Jonathan Cameron <jic23@kernel.org>
> > To: David Lechner <dlechner@baylibre.com>
> > To: Andy Shevchenko <andy@kernel.org>
> > To: Liviu Stan <liviu.stan@analog.com>
> > Cc: linux-iio@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/iio/temperature/ltc2983.c | 20 +++++++++++---------
> >  1 file changed, 11 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperatur=
e/ltc2983.c
> > index 6efb5252a773..6abaf64c8498 100644
> > --- a/drivers/iio/temperature/ltc2983.c
> > +++ b/drivers/iio/temperature/ltc2983.c
> > @@ -471,8 +471,9 @@ static int __ltc2983_chan_custom_sensor_assign(stru=
ct ltc2983_data *st,
> > =20
> >  static struct ltc2983_custom_sensor *
> >  __ltc2983_custom_sensor_new(struct ltc2983_data *st, const struct fwno=
de_handle *fn,
> > -			    const char *propname, const bool is_steinhart,
> > -			    const u32 resolution, const bool has_signed)
> > +			    const char *propname, bool is_steinhart,
> > +			    const u32 resolution, bool has_signed,
> > +			    bool is_leak_detector)
> >  {
> >  	struct ltc2983_custom_sensor *new_custom;
> >  	struct device *dev =3D &st->spi->dev;
> > @@ -545,7 +546,7 @@ __ltc2983_custom_sensor_new(struct ltc2983_data *st=
, const struct fwnode_handle
> >  			 * to =C2=B5K so __convert_to_raw() produces the correct hardware
> >  			 * encoding: P + 273.15 K.
> >  			 */
> > -			if ((index % 2) !=3D 0 && !strcmp(propname, "adi,custom-leak-detect=
or"))
> > +			if ((index % 2) !=3D 0 && is_leak_detector)
> >  				temp =3D temp * 1000000 + 273150000;
> > =20
> >  			if ((index % 2) !=3D 0)
> > @@ -836,7 +837,7 @@ ltc2983_thermocouple_new(const struct fwnode_handle=
 *child, struct ltc2983_data
> > =20
> >  		thermo->custom =3D __ltc2983_custom_sensor_new(st, child,
> >  							     propname, false,
> > -							     16384, true);
> > +							     16384, true, false);
> >  		if (IS_ERR(thermo->custom))
> >  			return ERR_CAST(thermo->custom);
> >  	}
> > @@ -950,7 +951,8 @@ ltc2983_rtd_new(const struct fwnode_handle *child, =
struct ltc2983_data *st,
> >  	if (sensor->type =3D=3D LTC2983_SENSOR_RTD_CUSTOM) {
> >  		rtd->custom =3D __ltc2983_custom_sensor_new(st, child,
> >  							  "adi,custom-rtd",
> > -							  false, 2048, false);
> > +							  false, 2048, false,
> > +							  false);
> >  		if (IS_ERR(rtd->custom))
> >  			return ERR_CAST(rtd->custom);
> >  	}
> > @@ -1068,7 +1070,7 @@ ltc2983_thermistor_new(const struct fwnode_handle=
 *child, struct ltc2983_data *s
> >  		thermistor->custom =3D __ltc2983_custom_sensor_new(st, child,
> >  								 propname,
> >  								 steinhart,
> > -								 64, false);
> > +								 64, false, false);
> >  		if (IS_ERR(thermistor->custom))
> >  			return ERR_CAST(thermistor->custom);
> >  	}
> > @@ -1184,7 +1186,7 @@ ltc2983_copper_trace_new(const struct fwnode_hand=
le *child, struct ltc2983_data
> >  						 "adi,custom-copper-trace is required for >1 ohm copper trace\n"=
);
> > =20
> >  		ct->custom =3D __ltc2983_custom_sensor_new(st, child, "adi,custom-co=
pper-trace",
> > -							 false, 2048, false);
> > +							 false, 2048, false, false);
> >  		if (IS_ERR(ct->custom))
> >  			return ERR_CAST(ct->custom);
> > =20
> > @@ -1275,7 +1277,7 @@ ltc2983_leak_detector_new(const struct fwnode_han=
dle *child, struct ltc2983_data
> >  					 "adi,custom-leak-detector is required for leak detectors\n");
> > =20
> >  	ld->custom =3D __ltc2983_custom_sensor_new(st, child, "adi,custom-lea=
k-detector",
> > -						 false, 16, false);
> > +						 false, 16, false, true);
> >  	if (IS_ERR(ld->custom))
> >  		return ERR_CAST(ld->custom);
> > =20
> > @@ -1488,7 +1490,7 @@ static struct ltc2983_sensor *ltc2983_temp_new(st=
ruct fwnode_handle *child,
> >  					 sensor->chan);
> > =20
> >  	temp->custom =3D __ltc2983_custom_sensor_new(st, child, "adi,custom-t=
emp",
> > -						   false, 4096, true);
> > +						   false, 4096, true, false);
> >  	if (IS_ERR(temp->custom))
> >  		return ERR_CAST(temp->custom);
> > =20
> >=20
> > ---
> > base-commit: d2f2868d2f487b418f68db2ef5bd7cf41722ee68
> > change-id: 20260929-iio-ltc2983-fix-string-compare-c919244f019d
> >=20
> > Best regards,
> > -- =20
> > Carlos Casadiego <cdcp206@gmail.com>
> >=20
> >  =20

