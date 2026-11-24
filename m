Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795518529;
	b=TjyfbxiPDYpO1c5wK0/Wzu9+DYi44wJ627ztvQ/29kHHmNz+I6vD2D2DjGFrTb5zkZO5
	 GtbkqANjMX31sN1PFcyfNHVCmtz1mb2bIVFYCXkDGGRtoSYDQf/aFoqvL3oQ2qBD2rReS
	 R4EPS3gEv3NSR30ncpz+se1bp0xQ5JZLPLKRgFvVIO4l/hg2xuHsJ/1Hb8IOUIR9UbRjV
	 vD873MUdVRUpbO5ShB3GThh1k0U5yAVVgi7hWHEefQPNuSqOW4AlIEVDDRLHpYtcyrmY2
	 mHOv/W9MybGowExBLgQHLo7tMAgowBxVk0mWII8ZjYBfMLNxf/7DwAkvGY7C+2kYk3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795518529;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CetQmFtOguzNQpi7pceO/bzzVwbiUxajNwWkf66b/V0=;
	b=DFBJJHVRiOp8vYEn9xEvHA8tdXvIjHNfhg3IFZeticnT4jBKRtHbsjfhzznTBMLfpJPB
	 l9ylvNJQ+PsTlyocnlZMxxh5by2HpqK1f0nmJ8vOTlVsQcTkYu0GHcpPJT6bwYe/sql8J
	 fZs/J3OzZBSPo3KDtHQeQDl8tBS6Fo3d2Y8R+GX+lRafJ0yxWhA5htlqDbAG0LdaAJNNX
	 IeCXzusNsNzsUTE3HYebJF4YPd+HyuvCgkx0sXrnZW+CFgHna2LqBHRicw+SV0t96n1g5
	 8VZDyNNbDacTNJKaqx+zT/wElP0E/ny9DCa6xp2VlgPVxT4x9/YQx7FRB4BgSSi7/TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1rb+TSw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9BF23606A31E;
	Tue, 24 Nov 2026 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M1rb+TSw
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 458D91F000C4;
	Tue, 24 Nov 2026 11:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795518528;
	bh=CetQmFtOguzNQpi7pceO/bzzVwbiUxajNwWkf66b/V0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M1rb+TSwVXhD0FcaK2WuQjvpoRwDYVTIZeJ7lOekP+N7uFNNYvcEbobbMX7Hgi+hw
	 nydEjihjcg8p2WLIz+z38Zsvlm3Nq+IyH2i0RbxFNynK0DdMN+OTTn4Ue0n4LSGTzh
	 xikwWBrLZEZZTnD0ZrJ9qgvzNYTlV3YJLN+eTeFV65cudfCTufYGzn3ToxygexqYbB
	 vW9jC1LVfEWcPgMdgZ0B9FxcKmScB4NyVZlrww9bEyt4gS0zkw3CUD7hFcc6JBu6mF
	 3B5zw2SipetxTx2IL+MhyCmi20e+IPrkr7iURXX0lne+0aQTHtxu8lSy0gUtberGBV
	 nJq5FPOFvb/Vg==
Date: Tue, 24 Nov 2026 12:08:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Conor Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich <michael.hennerich@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, David Lechner <dlechner@baylibre.com>, linux-pwm@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/6] pwm: core: add pwm_get_waveform_step_might_sleep()
Message-ID: <awVki6lC3SxGfqSl@monoceros>
References: <awQ9oGse6orrsCDj@monoceros>
 <20261123165522.336249-1-Nicolae-daniel.Deaconescu@analog.com>
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
	protocol="application/pgp-signature"; boundary="sbfv4le22k4govfd"
Content-Disposition: inline
In-Reply-To: <20261123165522.336249-1-Nicolae-daniel.Deaconescu@analog.com>


--sbfv4le22k4govfd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 1/6] pwm: core: add pwm_get_waveform_step_might_sleep()
MIME-Version: 1.0

Hello Daniel,

On Mon, Nov 23, 2026 at 06:55:22PM +0200, Nicolae-Daniel Deaconescu wrote:
> The driver has to know the clock rate the PWMs run from. CNV and the CLK
> gate are one burst of whole clock cycles after each conversion, and I have
> to place the end of the burst relative to the next CNV. The gate has to pass
> exactly the number of clock pulses the ADC shifts out, so I need the exact
> number of clock pulses in the window to place its edges.

I don't understand that, but it sounds a bit like
https://en.wikipedia.org/wiki/XY_problem. I suspect you need a pattern
like this (just one period depicted; 12 is just an example):

                   _   _   _       _
___________...____/ \_/ \_/ \_..._/ \__
                  ---- 12 pulses ----

and the idea is to create that from two signals, a clk and a PWM:

 _   _   _     _   _   _   _       _
/ \_/ \_/ \.../ \_/ \_/ \_/ \_..._/ \__
                  ---- 12 pulses ----
                   __________________
___________...____/                  \_

and OR them together to make the PWM mask the unwanted clk pulses.

And then with a 2nd PWM that does:

     _
____/ \____..._________________________

to trigger a conversion.

> The existing rounding functions give me the rounded nanoseconds, but not how
> many clock cycles that is. For example, 4 pulses of a 120 MHz clock last
> 33.3 ns, so 33 ns is rounded down to 3 cycles and only 34 to 41 ns give
> exactly 4. At 100 MHz the range for 4 cycles is 40 to 49 ns. If the driver
> doesn't know the rate, it can't pick a number in the right window, and would
> either run into the next conversion or corrupt the data with a shift.

Unless the clk is very fast, the nanosecond resolution should be
finegrained enough!? With the clk running at 120 MHz[1] and 4 desired
pulses the masking PWM needs a duty cycle between 29.16667 ns and
33.33333 ns, i.e. between 3.5 and 4 ticks (and a common rising edge with
the clk signal).

Assuming a sane hardware composition and seeing that requesting
.duty_length_ns = 33 yields 25 ns, .duty_length_ns = 34 is the right
choice.

The same calculation with clk rate = 100 MHz yields: duty_length in
[3.5; 4] clk ticks = [35; 40] ns and 40 ns gives an exact match.

Does that fit your problem and make sense?

Best regards
Uwe

[1] assuming a 50% clk duty

--sbfv4le22k4govfd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsFcDMACgkQj4D7WH0S
/k7fiAgAgDDYAMOZwxyp+5zUgbzyWNhnQ7SVPQKkIkFo/bzASTZq4++ykCE9Awh4
AiYUNIt2NuduNav7sHVRCvvhoiIbTyIuIbsnT+ESSw7sbWoL/FiJDCaDPYJ92ufO
b4FW9BNJ6FdQR124b5WZt4fbnMitAJrFerWpZPdqVS24F9+hsOS9zR8Eg/0VIPtp
vc8bq0CUAuIBNP+kfOGRd9hEM+2G1rxHso86YL6odMfeOMNiXZWzLrO/gUe5eQ7Y
FdCiXQjlRTO/mKNX7mKKzKPLN9J4cVhNBicFAodyFdln2efG9+xEV+gF613zyYpZ
5tJPjKpG1g36WWjhhnOuOMuqDsm85g==
=c5bw
-----END PGP SIGNATURE-----

--sbfv4le22k4govfd--
