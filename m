Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591A847A0B7;
	Tue,  4 Aug 2026 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864644; cv=none; b=slN4MPHpy3TcXUgTRSZibjxIVfuypOvgN3Hb8idOXZZ7ZjambHSVaMuXcvarcwH4OT38Wm0RVxtjAZZbMq+8ZGeke07LxxSeKGnpMTj6CqWjBsmhSXAt9MQbwB9hNVEf9mDB9YEHqyw14AAQkauuL3UTvR2oqJvZGh9MdYXsSjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864644; c=relaxed/simple;
	bh=gPN5ohq+ElnkyqoN2bqWqlPIELg6HwK6BJIhnPdujXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObblBLQevx9mlWju1kOuOs04kI8hXmRwhEJyD4a3Gi7Wj7OanvH6pTqi8Yt6iKXT/YBFFxGrnLTK8tbZUJMIZNCTpzgGYFVu5QSfHqRTipzyhjBjrPQ+ZuNn/7dACq0lGMrrqICNBSTpuvnE9B3iAkNFU1K31cO5NvuAfXVIKi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRCSbCj0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRCSbCj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484751F000E9;
	Tue,  4 Aug 2026 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785864642;
	bh=FmbMSXBnTdxS8Bf3zgCzs96igb83r/aC/Ca1iL8RCfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WRCSbCj030LspXN7pVmNm1HoKGDmFF0RrlKCAmHfFNAnk9XxQI73INtfiNeyUtoX5
	 vkOJD1PleYPatZTFaxc77hoahjy6Ng03s6UBUIIMZ3M5PpP2DE33lYY6ZRaO19OSvm
	 bAj7c4iH1JtDTb74aYLX3ttkIJ0eq36nI6yMVrQ6DecZtkIPxuzb1+7taACS2M0iOg
	 SCovdx8ETvzVT1ltsMG7sMwIbnHYF7c2O4ZMSKk0rP39jpotcZmPEBzorCAIp4r9Ab
	 lvYc87EJMIkLpgdJHHkQ+t+hDgM8MMCpq4TtHXlq62E+NARerLUz8avBKWOd8XYwHx
	 pVmsi3MkP2ZCg==
Date: Tue, 4 Aug 2026 18:30:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: imu: inv_icm42600: drop the whoami check
Message-ID: <20260804-scarily-hacker-651df3eafea9@spud>
References: <20260728184351.75015-1-jorijnvdgraaf@catcrafts.net>
 <20260728184351.75015-3-jorijnvdgraaf@catcrafts.net>
 <20260801032310.18f5f16d@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="goaxSQJDDMJ3/Lmf"
Content-Disposition: inline
In-Reply-To: <20260801032310.18f5f16d@jic23-huawei>

--goaxSQJDDMJ3/Lmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 01, 2026 at 03:23:10AM +0100, Jonathan Cameron wrote:
> On Tue, 28 Jul 2026 20:43:50 +0200
> Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net> wrote:
>=20
> > A WHOAMI value differing from the one the compatible implies aborts
> > probe with -ENODEV, preventing a register-compatible part described
> > with a fallback compatible from probing at all.
> >=20
> > The devicetree compatible is authoritative for which part is fitted:
> > drop the check, and with it the now-unused whoami definitions. No
> > warning replaces it, since probing via a fallback compatible is
> > legitimate use, not a condition to report. This changes the probe
> > outcome on mismatch for all parts the driver supports.
> >=20
> > Tested via a backport to a Fairphone 6 running a 7.1-based kernel: its
> > ICM-42630 (WHOAMI 0x0C), described with an icm42631 fallback compatible
> > and matched as icm42631, probes silently, and accelerometer, gyroscope
> > and temperature reads work.
> >=20
> > Suggested-by: Conor Dooley <conor@kernel.org>
> > Link: https://lore.kernel.org/all/20260722-creature-volley-0f083b904c1d=
@spud/
> > Link: https://lore.kernel.org/all/20260728-extradite-yanking-42d918637f=
61@spud/
> > Assisted-by: Claude:claude-fable-5
> > Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
>=20
> Hi Jorijn,
>=20
> I'm open to other opinions, particularly from those who are using
> this driver but I think dropping any form of hint that the device isn't
> the one we expect is too far when previous we just failed to probe.

FWIW, what I don't want is warning or error level printouts, so
something informational is tolerable to me.

>=20
> We have a lot of drivers that issue such a print and my understanding
> is that has been useful.  If we want to make it non threatening we could
> phrase it as something like "Device ID XX is not the YY associate with the
> FW specified device, probably using a valid fallback compatible".  That
> would still provide the breadcrumb for anyone seeing an unexpected
> part change on their device vs the DT.
>=20

--goaxSQJDDMJ3/Lmf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCanIhugAKCRB4tDGHoIJi
0piNAQDB1fNsjsOb10VCF5Kh/TFY/ezsqjVEZ7jG3W4l0kxQqgEA9hmIFRBeAGJQ
d0iLpIRr6XYKYor/cB+OHwRRaYi5CQE=
=CaxK
-----END PGP SIGNATURE-----

--goaxSQJDDMJ3/Lmf--
