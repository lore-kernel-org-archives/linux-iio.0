Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28780311977;
	Mon, 11 May 2026 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512479; cv=none; b=JZ9O8KDlo0ALGsguqxwQyS8kwlrxnSoHt6OxdmHh+tyakHaExi9QzadnmRSzxC41O18UxqFJzKm8YMBDRnqpNrdIggA0niqqBnoe1CcUjKJ26T/g2xQOquYdwO2maGEjCfwHi5QzhtWU4s/ZTVisl4qHLkL17I0PWuKIL1HiRII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512479; c=relaxed/simple;
	bh=crVWr+28yBZGxL0/BvjDDHA8a8BhulirWvY6XRK9mi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPj458ep6Sr/4alRinWcuShhKiZPpqxEJQ8bOpoK8tZfe8aukGLhW26nyQF0dc0OpcXU/cJbRxsJcua2qfxJb8R8vrKX5QAzm2CK8hzK/0C1gFcSBjZN0Bj4WEQnZUORkS/Jmk/W6ceqSv3YqZS4gFOXX4glfi8SdJsQr4tJ0qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKSV38LI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKSV38LI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80938C2BCB0;
	Mon, 11 May 2026 15:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778512478;
	bh=crVWr+28yBZGxL0/BvjDDHA8a8BhulirWvY6XRK9mi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aKSV38LIMNnXA/E4GTrEu9JYHV6FxIMH09sutlIk3czUgDjDSF1Y5WZN375JnQTtL
	 8qxXL1aKPmnb8zhSqHe1lxpK7fKlVyqg+sllaK+UwFLZPTvyriyzL2rVqdlb1CvEMB
	 1x3ee6n6IL/VvdIpWJKnv+ZW3oXBgh/KSMkDsNFguAPxxmxDlNXF9GVU1au3MOR+S1
	 UcS03t2octOtlODJ6EM1PDc8U7yEZHWUsm8Dbx3rHKpkHMkFgqOWngihSI2ykFdJYu
	 JzcmD3h11RVXX1sNkMZsr9WlTt/X97Ke7zjM0KhG53Xw60GOtEPgEGF6S+1ifCgTDc
	 v4iq8+/a1HjAw==
Date: Mon, 11 May 2026 16:14:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Alexandre Hamamdjian <azkali.limited@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, CTCaer
 <ctcaer@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Add ROHM BH1730FVC binding
Message-ID: <20260511161429.6cae5b7b@jic23-huawei>
In-Reply-To: <00855a46-20f9-4b4c-8bec-bb64d9d8efe6@gmail.com>
References: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
	<20260511-bh1730-v1-1-e0df1f499135@gmail.com>
	<92e2d1ab-c973-45a2-b0c4-d7c672c610e0@gmail.com>
	<00855a46-20f9-4b4c-8bec-bb64d9d8efe6@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 13:43:56 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 11/05/2026 11:22, Matti Vaittinen wrote:
> > Thanks for patches Alexandre!
> >=20
> > It's nice to see these upstreamed :)
> >=20
> > On 10/05/2026 21:09, Alexandre Hamamdjian wrote: =20
> >> From: CTCaer <ctcaer@gmail.com>
> >>
> >> Add a YAML binding for the ROHM BH1730FVC ambient light sensor.
> >> Documents the required compatible string, the als-vdd/als-vid
> >> regulators, and the rohm,integration-cycle, rohm,lux-multiplier,
> >> rohm,opt-win-coeff and rohm,gain-coeff calibration properties
> >> consumed by the driver. =20
>=20
> // snip
>=20
> >> +=C2=A0 rohm,opt-win-coeff:
> >> +=C2=A0=C2=A0=C2=A0 description:
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Optical-window calibration coefficient=
s. Specified as a flat=20
> >> list of
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 triplets <rc cv ci>, one triplet per w=
indow region, where rc is=20
> >> the
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 visible/IR ratio cutoff and cv/ci are =
the visible and IR weighting
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 factors used in that region.
> >> +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32-matr=
ix
> >> +=C2=A0=C2=A0=C2=A0 items:
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 3
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 3 =20
> >=20
> > I am not sure if I read the driver patch (2/2) correctly, but if I did,=
=20
> > then these coefficients are used to compute Luxes out of the raw sensor=
=20
> > data. I believe it would help anyone integrating (or investigating) thi=
s=20
> > sensor, if you added the actual formula here as a comment. If I read=20
> > this right, the formula is _somehting_ like:
> >=20
> >=20
> > Lx =3D (cv[win] * ch0_data - ci[win] * ch1_data) / gain / int_time
> >=20
> > Here the cv[win] and ci[win] are selected from the opt-win-coeff -table=
,=20
> > depending on the measured ch1_data/ch0_data ratio, right? =20
>=20
> One thing came to my mind. This 'window' -approach for lux calculation=20
> is not too unique. For example the rohm-bu27034.c uses similar approach.
>=20
> The thing is that some of the sensors have more than 2 channels. (For=20
> example, the first version of BU27034 did. [That was BU27034NUC, which=20
> got cancelled when BU27034_A_NUC emerged]). These ICs may still may use=20
> similar approach of having light regions, determined by ratio of (2)=20
> channels. BUT, they may then have more than 2 coefficients / window.
>=20
> So, maybe this could be made generic enough so it could be re-used for=20
> such devices if needed? I am not sure if other manufacturers but ROHM=20
> does this in Lux computations - if yes, then it might be worth making=20
> this more generic and not just a ROHM property? Maybe Jonathan has some=20
> insight on other Lux computations.

It used to be very common to have multiple sensor / window setups for
ambient light sensors - though perhaps less so on more modern devices
(we have one on list today where they just say use the green channel
 of an RGB sensor - so there are more windows but not relevant to=20
 illuminance measurement).

Sometimes the window bit isn't well enough described in the datasheet
so we only dealt with the parts on the actual sensor package and those
were handled in driver rather than being in dt.

What I'm not sure on here is how much of what is being described
is part of the 'chip' packaging - i.e. the bit that is constant for
all instances of this device and how much is part of the wider=20
device - i.e. the laptop / phone etc window infront of the sensor.

The chip bit we shouldn't have dt, the other part we should and it
would indeed be interesting to work on a generalizing that description.

Jonathan


>=20
> Yours,
> 	-- Matti
>=20

