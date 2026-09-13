Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8AF35F184;
	Sun, 13 Sep 2026 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338013; cv=none; b=JK2t4nOxG/nZJchQ/B3H970bPtHQxRhVw8e3SvVYxToaHttWzwfbysnwsWwlEFk5GooQfeaWbf2AWEEHoDpBUEx/hQugGG3pxjQfdx+fznGf/rriWUuvC+60gyhMMo3dhJIgh7EOljwpXJlx08T5XiNPCVtCWhjoI/rpJbH+WIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338013; c=relaxed/simple;
	bh=RFOro6QVHDcunk2o3UnELuOAM6IKs+wwwzhPXU1/RA4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFa7JLwprm7no2G7iVhJsWA6QTUivVNNeAw5g3qbBE2vtvnnjoSUoyozMMfK5I4oFtowG/NN8QukQEKVLdcI6Pg9AcdDCFOOUVNZfDVXvKdfyj9QLusez4v+SE/eyRR9JfKZDHjatsYzK+YaP2dYNS0JUPFYM7/k5h3pz6k1CBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYVdDcQy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYVdDcQy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1041F000FF;
	Sun, 13 Sep 2026 22:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789338011;
	bh=5hemrtBh2CDtniobT5qNYSO4xDn8QKhb778zrAY+Yis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RYVdDcQynk8G+5gCitsNoMdUmsUqbB2cmT3zOnosm4sIpa+qSXfWKVYAFR2ftCcL1
	 3XEzNVz+Ck5O3H3cEGkM1Fe4nO+HGLOomXMXFR8G1S0KmR/2HmaC1rcfoTq1FWHiZF
	 tkhF+Scdqu59Q7nFPlC6vxSVP7QW4ooabJKlfOFDvb/JdUsH99KDLtOWDHPGtgNpRu
	 U0GXs3LMx5b8c1KviT6rq8hvcwueGG46J85Mkoy4LZf70PvqaNxmKeltOSHCEg0ICp
	 1PR9sNYpIVCMo+8UCsvDAJl0dFW8AHJzwq+IoKWfuonyY7BVWEnRtJJOEW489zT2VP
	 tgQLww9AInqWw==
Date: Sun, 13 Sep 2026 23:20:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Radu Sabau <radu.sabau@analog.com>, Salih Erim
 <salih.erim@amd.com>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
 "Jakub Szczudlo" <jakubszczudlo40@gmail.com>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 4/4] docs: iio: ade9000: document ADE9430 support
Message-ID: <20260913232006.43ab5a3b@jic23-hlaptop>
In-Reply-To: <20260907101623.8730-5-antoniu.miclaus@analog.com>
References: <20260907101623.8730-1-antoniu.miclaus@analog.com>
	<20260907101623.8730-5-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Sep 2026 13:16:21 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add the ADE9430 to the list of supported devices and note that, like the
> ADE9078, it does not provide the on-chip dip/swell voltage events. Also
> note that the ADE9430 has no on-chip digital integrator and instead uses
> an external analog integrator for Rogowski coils.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  Documentation/iio/ade9000.rst | 36 ++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
>=20
> diff --git a/Documentation/iio/ade9000.rst b/Documentation/iio/ade9000.rst
> index 72737b5ec59c..881b7ff2ad3e 100644
> --- a/Documentation/iio/ade9000.rst
> +++ b/Documentation/iio/ade9000.rst
> @@ -1,29 +1,31 @@
>  .. SPDX-License-Identifier: GPL-2.0
> =20
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -ADE9000/ADE9078 driver
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +ADE9000/ADE9078/ADE9430 driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> =20
> -This driver supports Analog Device's ADE9000 and ADE9078 energy measurem=
ent
> -ICs on SPI bus.
> +This driver supports Analog Device's ADE9000, ADE9078 and ADE9430 energy
> +measurement ICs on SPI bus.
> =20
>  1. Supported devices
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  * `ADE9000 <https://www.analog.com/media/en/technical-documentation/data=
-sheets/ADE9000.pdf>`_
>  * `ADE9078 <https://www.analog.com/media/en/technical-documentation/data=
-sheets/ADE9078.pdf>`_
> -
> -The ADE9000 and ADE9078 are highly accurate, fully integrated, multiphas=
e energy
> -and power quality monitoring devices. Superior analog performance and a =
digital
> -signal processing (DSP) core enable accurate energy monitoring over a wi=
de
> -dynamic range. An integrated high end reference ensures low drift over
> -temperature with a combined drift of less than =C2=B125 ppm/=C2=B0C maxi=
mum for the entire
> -channel including a programmable gain amplifier (PGA) and an analog-to-d=
igital
> -converter (ADC).
> -
> -The ADE9078 does not provide the on-chip dip/swell (sag) detection avail=
able on
> -the ADE9000, so the RMS voltage swell/dip events described below are only
> -available on the ADE9000.
> +* `ADE9430 <https://www.analog.com/media/en/technical-documentation/data=
-sheets/ADE9430.pdf>`_
> +
> +The ADE9000, ADE9078 and ADE9430 are highly accurate, fully integrated,

Maybe change it to

The supported parts are...

So this doesn't need updating for each new one added.

> +multiphase energy and power quality monitoring devices. Superior analog
> +performance and a digital signal processing (DSP) core enable accurate e=
nergy
> +monitoring over a wide dynamic range. An integrated high end reference e=
nsures
> +low drift over temperature with a combined drift of less than =C2=B125 p=
pm/=C2=B0C maximum
> +for the entire channel including a programmable gain amplifier (PGA) and=
 an
> +analog-to-digital converter (ADC).
> +
> +The ADE9078 and ADE9430 do not provide the on-chip dip/swell (sag) detec=
tion
> +available on the ADE9000, so the RMS voltage swell/dip events described =
below are
> +only available on the ADE9000. The ADE9430 additionally has no on-chip d=
igital
> +integrator and instead uses an external analog integrator for Rogowski c=
oils.
> =20
>  2. Device attributes
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

