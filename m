Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795716386;
	b=NK5sWcEsr5s3D7toGA7axeHPpl5vwqGG314g46gQ/FVp22+81cz91ZWLpZtgKxsA6RYa
	 2aI7FC1Dhpx0r2ogQ37GeYJGuBgi8Aep3Q0Zy7DqYdNkt3ocj9XUgmLz0rFhAs9UlE0wn
	 3xnSIC89tyqKG2hQwPY2lrv4Zl1kdjSDD9ktb91FRahO6lL2IzboEdLfZIpTPAf1/PXiI
	 gcgSq11E6XPSEnvLTQ3xYU41GK4Yjalp80MC7kEaYRloZtNZmrwpEBQfoSLgF6Ha/nwc5
	 t4rqts6GfcLkq2lp/UcmRVZD7ySOA8bWrOUjdYbSPoQQAIcxYgXLwQ9xgXDKUZBPUZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795716386;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vFiqpi2vO+v0iYRizrcF8ISAo4VFPi9115L8KP0Vp1Y=;
	b=QKTeZMDWOc9YCkXllwoxv3V6j9NDWAI4SiJOnHE6gVGP1S5Gxu14r35ma8Sgsq8Wpe/X
	 vKbkdZXgoO2PEKn1NHX1k4boQqeuC3LhwQtdWbSfPDIPy/7XM2HC+kQulD6w95/q+zccg
	 PmQODEzIv3y93d3pwBxVqRYyXvQFF729QkbSv+ej186YcmcS+CJ2rV4hrLLA/IcWyu+2+
	 SGJZvKM4uo3H3a7vn/kv4y8KwC+10+DcxXvTbWyhaiIgzkbeE0s66VHYLSnjqD00BPuuJ
	 spP+UYwfnEI23w8w72U4LioXSuywa4sxr3R9r2V0q6HOrWDqrsbb6abszj4PnjCUefA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGEPqpXs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80E9606A338;
	Thu, 26 Nov 2026 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iGEPqpXs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DEA1F000C4;
	Thu, 26 Nov 2026 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795716385;
	bh=vFiqpi2vO+v0iYRizrcF8ISAo4VFPi9115L8KP0Vp1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iGEPqpXsxnwA5DSC97ccHwh/El3+n29R0uasWcFskHEnWdMOXlZj+9ggfIz+ebwyu
	 y51mIH+hhj4maq+0Lou9NrCbR3+vQlMkdE+Mc8lH25M+Ijxi43z7hX3iIJHpvvZQHg
	 vrEwHCCPNqH5cUb+Zzlh0AHqlFL/XthorSt/HVVqqoe8kr4/Tkzo2fzioiPdo3D8T4
	 8XZ2uoXK9bGMPcqEcyDeWor3T24ohFTq7FL2UPmtgq04BeEDX8R57T6KSl/P2VQB/M
	 If77AWE4LmSABZeEYRclwurSU8ry9J40JB+qtwWpPoSo9rb7/kyr1SL0QI/7Jma1FK
	 rAtcF8HNleJ5Q==
Date: Thu, 26 Nov 2026 18:06:21 +0000
From: Conor Dooley <conor@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	David Lechner <dlechner@baylibre.com>, linux-pwm@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/6] pwm: core: add pwm_get_waveform_step_might_sleep()
Message-ID: <20261126-delouse-provoke-270d68386526@spud>
References: <awVki6lC3SxGfqSl@monoceros>
 <20261124114714.611570-1-Nicolae-daniel.Deaconescu@analog.com>
 <20261124-bath-runaround-dccb788f14e3@spud>
 <awgEH1y_JnsiactY@monoceros>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Tm5avPfYM60WAnIB"
Content-Disposition: inline
In-Reply-To: <awgEH1y_JnsiactY@monoceros>

--Tm5avPfYM60WAnIB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 11:11:41AM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Nov 24, 2026 at 06:34:13PM +0000, Conor Dooley wrote:
> > On Tue, Nov 24, 2026 at 01:47:13PM +0200, Nicolae-Daniel Deaconescu wro=
te:
> > > Hi Uwe,
> > >=20
> > > Yes, that works. It is how the gate duty was set before, in ad7625.c,=
 with
> > > DIV_ROUND_UP(NSEC_PER_SEC * pulses, rate), which gives 34 ns for 4 pu=
lses
> > > at 120 MHz. I'd drop the step API (patches 1 and 2) and do the same f=
or the
> > > new parts, but i don't have the clock rate, and without a clocks prop=
erty
> > > I don't know how I should get it. The PWM core has no way to report i=
t.
> > >=20
> > > Conor, Uwe: is a clocks property on adi,ltc2387 acceptable,?
> > > If not, how should the driver get the rate?
> >=20
> > My opinion here has not changed. The clock is an input to the pwm
> > generator, not the iio device.
>=20
> The setup as I understand it (
>=20
>               ,-----.                   ,---.
>   clk ---+----> PWM >--- pwm signal ---->   |         ,-----.
>          |    `-----'                   | & >---------| iio |

>          `------------------------------>   |         `-----'

As far as I gathered from the v1 submission and looking at the datasheet
at that time, this lower path that skips the pwm does not exist.

>                                         `---'
> )
> works as the clk feeds into both, the PWM and (masked by the PWM) also
> into the iio device. So the clk is in the same way relevant for the iio
> device as the PWM signal?!

--Tm5avPfYM60WAnIB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCawh1HQAKCRB4tDGHoIJi
0ttHAQDaOg0PUxK9eQ7ac0ZhYoDIGFmUAGUiOkVf4glt7EiFSAD9F11XrNMmSXeQ
RTOLcZYJO9f921XrGcNUmns4Mnbmjg0=
=aTV5
-----END PGP SIGNATURE-----

--Tm5avPfYM60WAnIB--
