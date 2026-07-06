Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467543AC0F8;
	Mon,  6 Jul 2026 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353093; cv=none; b=htCQeFNRmIvMlwmV4QITKQxqvsMr52mUIma2bzxWmnjiHbQLX9lsS3FWpI7bfBwNBFNjgagC80BEhyvMYiBEGfOXbcZdMPPTHTnQNFEL7HDBV12XOxUOHqu+rWOCyeeaKTBWZNqN+1xqvy0O0FbjYjPialX5aIj0tMW8BajLAW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353093; c=relaxed/simple;
	bh=z/1mjf2GZF+ks4yAWLay5+aaQRTfRriTPAgvrElKVSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omr4AHinHzf19e4phVFhdtCx/3nHsH8LVSnVpkZKWoXBgpQxr9qvP6sIUCE79M+LHFlJaxlMp6FChj3ErHB3uA0jlrh41EmJ3e6cuGk6afa5IUxTVB3OB/ecilSfHK9xvQH08ZDmHafOj5/6ZG5Y53f7je0GKGGVn0Awi7NkRhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBOfRpsp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBOfRpsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8591F000E9;
	Mon,  6 Jul 2026 15:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783353089;
	bh=+HWVQnxXSx5p/uTVQFQ2iVAaXJNAP8m0nBfBPJamNWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iBOfRpspryqFDPXxkhE8wZ5zf/UztNoxBeZcVSD+Ixoep4xIENKMJ+utSeWtnSIVe
	 BHNK4FPj4WOY/ZIRfmggr+dNVUJTJxUYY4JHjAQfU211w8tXBr1pXmibY2slnfi7Ub
	 Zb7TShRHpr0Fs9u03VuMjLabCc2ozTPX/WXR11L83oGb42ei6GjprVrVuwxIKt/OwC
	 e4a6ZgAADckfCeeFcw3ClGBidp/IoZO/vD1jldUpDFp+PzEpqgMkNdUdyeoUgyt5MM
	 eGOt+5/oq6Vdo4QxYbtxkgmeIxUJPJxjtk6hsxzhLpGjDRDoFi4GHbyOrSUxwK9bHm
	 M0EJwaMpvjTJw==
Date: Mon, 6 Jul 2026 16:51:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v6 16/16] docs: iio: add documentation for ad9910 driver
Message-ID: <20260706165120.156f67a2@jic23-huawei>
In-Reply-To: <p77cvtvjmo7hr6i6jxhfxps3if6fyy5kdwxrwlcnsziixycyen@rf5zfchlxgt6>
References: <20260618-ad9910-iio-driver-v6-0-79125ffbe430@analog.com>
	<20260618-ad9910-iio-driver-v6-16-79125ffbe430@analog.com>
	<20260703193059.4deda617@jic23-huawei>
	<p77cvtvjmo7hr6i6jxhfxps3if6fyy5kdwxrwlcnsziixycyen@rf5zfchlxgt6>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Jul 2026 15:23:28 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 03/07/26 19:30, Jonathan Cameron wrote:
> > On Thu, 18 Jun 2026 14:27:32 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel=
.org> wrote:
> >  =20
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > >=20
> > > Add documentation for the AD9910 DDS IIO driver, which describes chan=
nels,
> > > DDS modes, attributes and ABI usage examples. =20
>=20
> ...
>=20
> > > +Digital ramp generator (DRG)
> > > +----------------------------
> > > +
> > > +The DRG produces linear frequency, phase or amplitude sweeps using d=
edicated
> > > +hardware. The active ramp target (destination) is selected by enabli=
ng the
> > > +corresponding typed channel at channel number 130:
> > > +
> > > +- ``out_frequency130`` (label ``drg_frequency``) =E2=80=94 ramp targ=
ets frequency
> > > +- ``out_phase130`` (label ``drg_phase``) =E2=80=94 ramp targets phase
> > > +- ``out_altcurrent130`` (label ``drg_amplitude``) =E2=80=94 ramp tar=
gets amplitude
> > > +
> > > +Writing ``en=3D1`` to one of these channels enables the DRG and swit=
ches its
> > > +destination. Writing ``en=3D0`` disables the DRG if the channel is t=
he current
> > > +active destination; writing to an already-inactive destination is a =
no-op.
> > > +
> > > +Each destination channel also exposes a read-only ``scale`` attribute
> > > +reporting the physical quantity per ramp register LSB, which allows =
converting
> > > +raw limit codes to physical values.
> > > +
> > > +The two ramp channels ``out_altcurrent131`` (``drg_rising``) and
> > > +``out_altcurrent132`` (``drg_falling``) configure ascending and desc=
ending
> > > +ramp parameters independently.
> > > +
> > > +Destination channel attributes
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > +.. flat-table::
> > > +   :header-rows: 1
> > > +
> > > +   * - Attribute
> > > +     - Unit
> > > +     - Description
> > > +
> > > +   * - ``en``
> > > +     - boolean
> > > +     - Enable the DRG with this channel as the active destination. O=
nly one
> > > +       destination can be active at a time.
> > > +
> > > +   * - ``scale``
> > > +     - Hz/LSB, rad/LSB or mA/LSB
> > > +     - Read-only. Physical quantity per raw units. Multiply a ramp
> > > +       rising/falling channel ``raw`` value by this scale to get the=
 physical
> > > +       ramp target.
> > > +
> > > +Ramp channel attributes
> > > +^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > +.. flat-table::
> > > +   :header-rows: 1
> > > +
> > > +   * - Attribute
> > > +     - Unit
> > > +     - Description
> > > +
> > > +   * - ``dwell_en``
> > > +     - boolean
> > > +     - Enable dwell at the ramp limit. When disabled, the ramp
> > > +       auto-transitions at this limit without waiting for the DRCTL =
pin.
> > > +       Disabling both creates a bidirectional continuous ramp (trian=
gular
> > > +       pattern). Other combinations create single-shot ramps at the =
DRCTL
> > > +       pin transition.
> > > +
> > > +   * - ``raw``
> > > +     - integer (64-bit)
> > > +     - Ramp limit expressed as a raw DRG register code in
> > > +       :math:`[0, 2^{32}-1]`. The physical value is ``raw * scale`` =
where
> > > +       ``scale`` is read from the active destination channel.
> > > +
> > > +   * - ``sampling_frequency``
> > > +     - Hz
> > > +     - Ramp clock rate. Controlled by an integer divider; the writte=
n value
> > > +       is adjusted to the nearest supported rate.
> > > +
> > > +   * - ``raw_roc``
> > > +     - /s
> > > +     - Rate of change. Number of register codes advanced per second,=
 computed
> > > +       from the hardware step size and the current ramp clock. Writi=
ng
> > > +       requires ``sampling_frequency`` to be configured first.
> > > +
> > > +Usage examples
> > > +^^^^^^^^^^^^^^
> > > +
> > > +Configure a frequency sweep from 40 MHz to 60 MHz with a rate of cha=
nge of
> > > +25 GHz/s:
> > > +
> > > +.. code-block:: bash
> > > +
> > > +  # Disable dwell on both limits for a bidirectional continuous ramp
> > > +  echo 0 > /sys/bus/iio/devices/iio\:device0/out_altcurrent131_dwell=
_en
> > > +  echo 0 > /sys/bus/iio/devices/iio\:device0/out_altcurrent132_dwell=
_en
> > > +
> > > +  # Set ramp rate at 250 MHz
> > > +  echo 250000000 > /sys/bus/iio/devices/iio\:device0/out_altcurrent1=
31_sampling_frequency
> > > +  echo 250000000 > /sys/bus/iio/devices/iio\:device0/out_altcurrent1=
32_sampling_frequency
> > > +
> > > +  # read the frequency scale to convert physical values to raw units
> > > +  cat /sys/bus/iio/devices/iio\:device0/out_frequency130_scale
> > > +  0.232830643650
> > > +
> > > +  # 40 MHz / 0.232830643650 =3D 171798692
> > > +  echo 171798692 > /sys/bus/iio/devices/iio\:device0/out_altcurrent1=
31_raw
> > > +  # 60 MHz / 0.232830643650 =3D 257698038
> > > +  echo 257698038 > /sys/bus/iio/devices/iio\:device0/out_altcurrent1=
32_raw =20
> >=20
> > Why is this writing frequencies to altcurrent channels? Shouldn't this =
be the
> > frequency ones? =20
>=20
> All the attributes for ramp up/down channels would do the same thing in s=
eparate
> channel types: sampling_frequency, raw, raw_roc and dwell_en... do we nee=
d frequency
> and phase ones? For the DRG, right now I have:
>=20
> * out_frequency130: en, scale
> * out_phase130: en, scale
> * out_altcurrent130: en: scale
> 	* out_altcurrent131: raw, raw_roc, dwell_en, sampling_frequency
> 	* out_altcurrent132: raw, raw_roc, dwell_en, sampling_frequency

Yes. I think we should have separate ones.  If later we did have a device
that was otherwise similar but had separate registers, maybe for some weird
sync sweep of frequency and magnitude then the naming would match the thing
being enabled.   I'm not that bothered if they 'overwrite' each other, as in
there is only one backend store of the value.  Also fine if you think some
caching layer would be more user friendly.

Thanks,

Jonathan

> =20
> > > +
> > > +  # 25 GHz/s / 0.232830643650 =3D 107374182402
> > > +  echo 107374182402 > /sys/bus/iio/devices/iio\:device0/out_altcurre=
nt131_raw_roc
> > > +  echo 107374182402 > /sys/bus/iio/devices/iio\:device0/out_altcurre=
nt132_raw_roc
> > > +
> > > +  # Enable the DRG with frequency as the destination
> > > +  echo 1 > /sys/bus/iio/devices/iio\:device0/out_frequency130_en
> > > + =20
>=20
> ...
>=20

