Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795687905;
	b=IM6lHmn/0jeohdyr3hH0RYBkAqKXaUyWmHKGxGHm482VE6gnX3Dh0MJK6pEXw/gQE5Px
	 HeXZacqDppjGFCc41VqCo5lmr92GV7xvHL/F7GFbM0lyTUS58G5RUHsF/zvl+Eq9kUI+l
	 L4K2QLUnvpWWXbHQBrlYyRGohBHgBCdZe7TYeOygEEm6rhg0kw8/nPqW1BTlMAP+80rxP
	 cqtK6oegB6oqx3Kh1BUb3ciyBzrhkQpyIOcCgm/uFzEIWb4idgcoxN+LN8FFN5HwDUZ31
	 hg/gTpqUb/osWi7yUtMoSdIszB2uDqkZmY7fwzMEjFNGHOWG1trUb6+qlTcJ4bDrocw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687905;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HAJAo8CN+a2ad2/AuSuWENM8KqTIk5dcUroaCZsRSVU=;
	b=k9brD/klaWDqsoHDO/un2wDe01KHRlxsjkfRHzSOWSYqfq3c1eYPPuWuC5YFUHZAV3Tz
	 U3N5BsJ0Nimop0Up8aRPAjZaFc8meXRLEVr0eu8fHr5TV4lit5O+fk9NQd6t0XWQoVIsB
	 01FGv/rLBqx2qiWuhFvwaewGbDlFFCDmoTGLTl8F6dT81l8pzIvqMpMkDbPQTl8WnYI9S
	 Az9NLei/0VjncOlpTIUtlQ7gIQZvdmqZvwye4JsgXZfAWzaToKI72fYSF2/AJVgedYttN
	 hEKEM+AT0hFM4LaLDRBKRV6sWy3B0u+3AGi8oZ9MHjLZfO9W2IxjoRGY/ieA1gBZ/7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbL8Txbg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2B044606A321;
	Thu, 26 Nov 2026 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbL8Txbg
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E34CD1F000CF;
	Thu, 26 Nov 2026 10:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795687904;
	bh=HAJAo8CN+a2ad2/AuSuWENM8KqTIk5dcUroaCZsRSVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EbL8Txbg44fuRJcGf0rVEAKpWer0aO3WEnilkpTjoEm0VZK7cj22NKzGZaUFasWwp
	 EiOCBAml/DFFOZkkZErv+4fpq5YaMrFXm0ifeuYT2ja3y+3rHmws/pBNoJnEzuh5Dx
	 mKzMKcVq3FMuhvZUoRbRAohP628pgb8+0rTNZEjI0xlE8norc1aCkyiYRxIDOEkBzW
	 BekoyPtxkUaqd7foOfPWclykoJ2mZnMWK9a2Xg2rFFUZmdbcNem1IF3mDWxwXFwabb
	 5U5VQ+wHRpYTGDGTvms3PV7Uvw/R4E5uWSCzwUERMJddHRK0vlrWR7Lbq4xzgiWvAz
	 hyBcl7MlnHbvQ==
Date: Thu, 26 Nov 2026 11:11:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
	David Lechner <dlechner@baylibre.com>, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/6] pwm: core: add pwm_get_waveform_step_might_sleep()
Message-ID: <awgEH1y_JnsiactY@monoceros>
References: <awVki6lC3SxGfqSl@monoceros>
 <20261124114714.611570-1-Nicolae-daniel.Deaconescu@analog.com>
 <20261124-bath-runaround-dccb788f14e3@spud>
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
	protocol="application/pgp-signature"; boundary="2cgg4o7s4rucd725"
Content-Disposition: inline
In-Reply-To: <20261124-bath-runaround-dccb788f14e3@spud>


--2cgg4o7s4rucd725
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/6] pwm: core: add pwm_get_waveform_step_might_sleep()
MIME-Version: 1.0

On Tue, Nov 24, 2026 at 06:34:13PM +0000, Conor Dooley wrote:
> On Tue, Nov 24, 2026 at 01:47:13PM +0200, Nicolae-Daniel Deaconescu wrote:
> > Hi Uwe,
> >=20
> > Yes, that works. It is how the gate duty was set before, in ad7625.c, w=
ith
> > DIV_ROUND_UP(NSEC_PER_SEC * pulses, rate), which gives 34 ns for 4 puls=
es
> > at 120 MHz. I'd drop the step API (patches 1 and 2) and do the same for=
 the
> > new parts, but i don't have the clock rate, and without a clocks proper=
ty
> > I don't know how I should get it. The PWM core has no way to report it.
> >=20
> > Conor, Uwe: is a clocks property on adi,ltc2387 acceptable,?
> > If not, how should the driver get the rate?
>=20
> My opinion here has not changed. The clock is an input to the pwm
> generator, not the iio device.

The setup as I understand it (

              ,-----.                   ,---.
  clk ---+----> PWM >--- pwm signal ---->   |         ,-----.
         |    `-----'                   | & >---------| iio |
         `------------------------------>   |         `-----'
                                        `---'
)
works as the clk feeds into both, the PWM and (masked by the PWM) also
into the iio device. So the clk is in the same way relevant for the iio
device as the PWM signal?!

> Using the pwm generator input clock in this way is also inherently tied
> to one implementation, since assumes a particular relationship between
> input clock and output waveforms. Were a different pwm generator to be
> used that had a /2 divider between input and output to be used, the
> logic here would break?

Yes an additional divider only on the clk->PWM path would break that (or
need adaptions to the algorithm at least).

Best regards
Uwe

--2cgg4o7s4rucd725
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsIBdsACgkQj4D7WH0S
/k4mKQf/RO6OHP/Eo6JdjL4f5G2MIQWChDzq9XoctpM2ec7U6Gkr54MFg1Yl8tF2
74J6Amq1GKVf0zca3FGhmpLWp+rkAf9ryoiUmj+NMC9S6TNIO7YmYAR9EJVKrLXg
kvEBQIj5vqCF5f7fggrQhPqnF0ESlxZQPHkATnOn03O1V81ut1ORqQDzh4daZurQ
jEs7iPtfOfWXYRcbGCuBiOfF6VXk2h1IpMzbyVgVM/Kd9wz88crjektyp8b4Gt7t
B1PaJfx0xgw611RKHlslJIdukWJb0eUXBr+a7hbuWp+xGOCRaUKvi1gQjIUl5gub
poambkD6A8/tncOim01feVRP+yfU+w==
=HhS5
-----END PGP SIGNATURE-----

--2cgg4o7s4rucd725--
