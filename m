Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BE9349CCA;
	Tue, 12 May 2026 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586921; cv=none; b=l0kktpnpbqtBZO8I/C3OI0mlyac8CzoOL6J49V9UiS7Hi0LXJdxwFeivcFpAUmX2HpH3GeNTp33JY8jJluiyw9w9eC4d63G16r2gjzURoR2PbdHpSi21l867FgdamqXxa+ElKBXU105/kC+Z1ZNzXw4opCIYL/hRnfTSun12BdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586921; c=relaxed/simple;
	bh=fswiufGYrNpPaT8jrpxSu7XF/ePr1DAq6rYJEl56Fao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECCteyOHHZiDoqZhvIGE86YMJwJLfBt9OKndLf/d7iap1RtOnvEngvGSu99ZvH1siHMYI4rNIe7LnpsDVN+4gFAWNCt09+Ui7nOv7oqzD2wXP5BVAvMGoJWzm9R1QKg4C9ElMRgRaHNtralN9m+SEi4UXrK6jxV/D0Nw8ymEbCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bRKxhjCP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bRKxhjCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CFAC2BCF5;
	Tue, 12 May 2026 11:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778586921;
	bh=fswiufGYrNpPaT8jrpxSu7XF/ePr1DAq6rYJEl56Fao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bRKxhjCPpAcqknJazCPoMcANxi5EQVfKJTW25qa6Ac5cvGPN82dM3K2vJijNcjLpI
	 rrI/6utFs0NMZ9bm/rEECyQpDAWsc38Q4puS8FRa2fPalFfr+Rdd2axPBvl5dfgem3
	 i1Z1vNlGWuG+ROIhOp6Yl4jnIMbz/QttnwxRqJ1QGrxVg8qMJgV9wYCkGk0lxkgklq
	 kdYKWNBTsGA3uN/KMXjQOgtRpfPO0kaVbHVC7dlW+RuKFHZIZb1q+k1GmqKdMa2XIu
	 TNm1ZovjB79dS7FBqPkQnqdL3Exu3xUE0sHiw3ScUnb1wMr1ANdkViQ7UkCkudPNyS
	 QtH4ExAQFA/Fw==
Date: Tue, 12 May 2026 12:55:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Alexandre Hamamdjian <azkali.limited@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, CTCaer
 <ctcaer@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Add ROHM BH1730FVC binding
Message-ID: <20260512125510.79c5298d@jic23-huawei>
In-Reply-To: <f05093df-663e-417b-a671-d627811e82de@gmail.com>
References: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
	<20260511-bh1730-v1-1-e0df1f499135@gmail.com>
	<92e2d1ab-c973-45a2-b0c4-d7c672c610e0@gmail.com>
	<00855a46-20f9-4b4c-8bec-bb64d9d8efe6@gmail.com>
	<20260511161429.6cae5b7b@jic23-huawei>
	<f05093df-663e-417b-a671-d627811e82de@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 07:42:46 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 11/05/2026 18:14, Jonathan Cameron wrote:
> > On Mon, 11 May 2026 13:43:56 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >  =20
> >> On 11/05/2026 11:22, Matti Vaittinen wrote: =20
> >>> Thanks for patches Alexandre!
> >>>
> >>> It's nice to see these upstreamed :)
> >>>
> >>> On 10/05/2026 21:09, Alexandre Hamamdjian wrote: =20
> >>>> From: CTCaer <ctcaer@gmail.com>
> >>>>
> >>>> Add a YAML binding for the ROHM BH1730FVC ambient light sensor.
> >>>> Documents the required compatible string, the als-vdd/als-vid
> >>>> regulators, and the rohm,integration-cycle, rohm,lux-multiplier,
> >>>> rohm,opt-win-coeff and rohm,gain-coeff calibration properties
> >>>> consumed by the driver. =20
> >>
> >> // snip
> >> =20
> >>>> +=C2=A0 rohm,opt-win-coeff:
> >>>> +=C2=A0=C2=A0=C2=A0 description:
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Optical-window calibration coefficie=
nts. Specified as a flat
> >>>> list of
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 triplets <rc cv ci>, one triplet per=
 window region, where rc is
> >>>> the
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 visible/IR ratio cutoff and cv/ci ar=
e the visible and IR weighting
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 factors used in that region.
> >>>> +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32-ma=
trix
> >>>> +=C2=A0=C2=A0=C2=A0 items:
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 3
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 3 =20
> >>>
> >>> I am not sure if I read the driver patch (2/2) correctly, but if I di=
d,
> >>> then these coefficients are used to compute Luxes out of the raw sens=
or
> >>> data. I believe it would help anyone integrating (or investigating) t=
his
> >>> sensor, if you added the actual formula here as a comment. If I read
> >>> this right, the formula is _somehting_ like:
> >>>
> >>>
> >>> Lx =3D (cv[win] * ch0_data - ci[win] * ch1_data) / gain / int_time
> >>>
> >>> Here the cv[win] and ci[win] are selected from the opt-win-coeff -tab=
le,
> >>> depending on the measured ch1_data/ch0_data ratio, right? =20
> >>
> >> One thing came to my mind. This 'window' -approach for lux calculation
> >> is not too unique. For example the rohm-bu27034.c uses similar approac=
h.
> >>
> >> The thing is that some of the sensors have more than 2 channels. (For
> >> example, the first version of BU27034 did. [That was BU27034NUC, which
> >> got cancelled when BU27034_A_NUC emerged]). These ICs may still may use
> >> similar approach of having light regions, determined by ratio of (2)
> >> channels. BUT, they may then have more than 2 coefficients / window.
> >>
> >> So, maybe this could be made generic enough so it could be re-used for
> >> such devices if needed? I am not sure if other manufacturers but ROHM
> >> does this in Lux computations - if yes, then it might be worth making
> >> this more generic and not just a ROHM property? Maybe Jonathan has some
> >> insight on other Lux computations. =20
> >=20
> > It used to be very common to have multiple sensor / window setups for
> > ambient light sensors - though perhaps less so on more modern devices
> > (we have one on list today where they just say use the green channel
> >   of an RGB sensor - so there are more windows but not relevant to
> >   illuminance measurement).
> >=20
> > Sometimes the window bit isn't well enough described in the datasheet
> > so we only dealt with the parts on the actual sensor package and those
> > were handled in driver rather than being in dt.
> >=20
> > What I'm not sure on here is how much of what is being described
> > is part of the 'chip' packaging - i.e. the bit that is constant for
> > all instances of this device and how much is part of the wider
> > device - i.e. the laptop / phone etc window infront of the sensor.
> >=20
> > The chip bit we shouldn't have dt, the other part we should and it
> > would indeed be interesting to work on a generalizing that description.=
 =20
>=20
> Hm. I kind of agree. The constant, 'common for all sensors'=20
> -coefficients should probably be hard-coded as sensor defaults. The=20
> BH1730 data-sheet seems to be describing a set of coefficients. I=20
> suppose that's what comes from the packaging(?)
>=20
> And just to contradict myself...
>=20
> I can imagine two reasons to alter these coefficients:
>=20
> 1.(st) being what Jonathan described. Eg. having something like a lens=20
> or a glass or whatever, on top of the sensor. That can alter the light=20
> entering the sensor, and require change to the coefficients. And indeed,=
=20
> it would make sense to only describe this in the DT, because the sensor=20
> is already described. That'd mean the DT should only contain the=20
> 'coefficient delta' caused by <add the cause here>.
>=20
> 2. In theory, there could also be another reason. I bet the sensors are=20
> all 'individuals' to some extent. So, for something requiring very high=20
> accuracy, there could be some kind of calibration process at device=20
> manufacturing. This might produce more accurate, device specific=20
> coefficients. Considering this use-case, I am not 100% convinced it's=20
> "wrong" to be able to give the device-specific coefficients from the DT.=
=20
> (Because, here the coefficients really are a property of the device=20
> itself and aren't added by some external part).

Agreed this happens - but you can't really put it in DT as every device
then has it's own DT - which probably means an early boot firmware patching
the DT based on something in ROM or similar.  Given that is usually impract=
ical
we have handled this via firmware files - if no file, use defaults.

>=20
> And, if we consider allowing describing (the more accurate) device=20
> coefficients from the DT (for case 2), then it would just be simpler to=20
> always provide the "full coefficients" from the DT, no matter if they=20
> are caused by the device packaging or added lens/glass/XXX. And, as the=20
> infamous, and not even existing rohm,dh2228fv device shows, people do=20
> use the simplest solutions even when it isn't really right ;)
>=20
> So, I am tempted to suggest we just go with the flow, and allow=20
> describing the coefficients from the DT, without separating the source,=20
> (lens/glass/device-packaging) which is what this patch does. (If I read=20
> it right.) However, I would like to see a property which can be re-used=20
> by other devices as this seems to be pretty common. Yeah, it's probably=20
> not _right_, but it feels practical.

I'm fine with doing that if we are sure the coefficients are incorporating
windows in front of the sensor.  I know that wasn't the case for some
of the previous devices we've covered - typically because they either
had pretty optically clear windows - or didn't have one at all.

>=20
> Well, this is just my 0.5 cents, and even I may change my opinion on=20
> this though :)

I thought that was just me ;)
>=20
> Yours,
> 	-- Matti
>=20

