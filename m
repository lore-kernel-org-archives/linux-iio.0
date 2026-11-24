Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526416;
	b=F42y19ijDOE+5GCREgyuPyfg2a5XNRn1wtrNzfKka0urAxIFv3I20AXJgkGzW/HPMmI5
	 3LlnikJaWV+AMODZBF+q+gc/EBe9WyGMfk+VH9R/Z25GovBxoVb7KRhm6hh08A2W2w7m8
	 XR9v8bYqKkRWUP91iFrmYGhgkq0fo4My6tUQIKSONqZw4RPFO93mKVzxuf8Oe1+yC2+Co
	 e2+MxnUdDd9PThA1vo6AZd4XArRizYUS+sa21EDfMgYB7zUhTu0vGaNmtRhDB7axMY9Zd
	 veNWR9Cf2k6hgZrrJrbaNOWL8XKaQaR2VZAQBGW337jEcvtUuZL3PQkLOA+SewbPb6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526416;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cZJ8DL1d7qjgUTKMH6thK/4qY2ynwBsw0u6il0VZqYc=;
	b=TvKWAcNwDAv4I19rrwYXMGIliyztt0pN1QgEqp/1MQt2zGMic59g0Qz6V/egjOcSFazi
	 tBEL3LaG4NkgDCFb5Q+3ivzKfap0uEOYO+VIOU0iyLGcIVFUH/4SCUHDWKaZQRHspKnFk
	 Lv7z/2FczpEar7P9Oiv0ysTGdMbWdrr/12S0cEguEx8Vf5XBQjv8l/zRGpTkH4HI1AQrq
	 XaxzqOxP1/bE3E5do+sRLcLwwR1VztydS6qGQLYzWGdxU9YgnGetrrAqQmyqRotJtpUTk
	 7umSi1fhNi1y/Ee0zzKNjYyWigrPUIHvIt2Z2W7RzbJHV7cpWzW+btoF+IzTPqePyOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjN36CHb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C4CBB606A330;
	Tue, 24 Nov 2026 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MjN36CHb
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0907C1F000EB;
	Tue, 24 Nov 2026 13:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795526416;
	bh=cZJ8DL1d7qjgUTKMH6thK/4qY2ynwBsw0u6il0VZqYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MjN36CHb5CPashNExo/4MfOyLwR4/aGKPRCPFPAuS9sIdJ9iwrQlx4u41QhpTql4i
	 n4Di4J2M1dxOuXq7cjWVTPxl26QEmBwqsTsGkKwRU5VJrkXaGQ1ieVWnqS64zG4/+S
	 70bsDrOU6/8VdkdTfcx942sw09bodxLlUC2UNAgJZ0ZN5a+qMwb77Psq7nw3QhIqI4
	 dydLaP+wNo8sakib17sqWZU/v4No17z22soA8zUrElhHsNB4DZ1WjO9C9aV/ouYISd
	 v6HjTNEWEoEg2u+076HtCYy2F+3SJ/2chvi4KdUGT22Goml5qAoDZEpfCwSlonMfw0
	 4Sj27iiiVBDXg==
Date: Tue, 24 Nov 2026 14:20:14 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Conor Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich <michael.hennerich@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, David Lechner <dlechner@baylibre.com>, linux-pwm@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/6] pwm: core: add pwm_get_waveform_step_might_sleep()
Message-ID: <awWOlgD86XQ_1Vgs@monoceros>
References: <awVki6lC3SxGfqSl@monoceros>
 <20261124114714.611570-1-Nicolae-daniel.Deaconescu@analog.com>
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
	protocol="application/pgp-signature"; boundary="nh52dyjfpekntz2n"
Content-Disposition: inline
In-Reply-To: <20261124114714.611570-1-Nicolae-daniel.Deaconescu@analog.com>


--nh52dyjfpekntz2n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/6] pwm: core: add pwm_get_waveform_step_might_sleep()
MIME-Version: 1.0

Hello Daniel,

On Tue, Nov 24, 2026 at 01:47:13PM +0200, Nicolae-Daniel Deaconescu wrote:
> Yes, that works. It is how the gate duty was set before, in ad7625.c, with
> DIV_ROUND_UP(NSEC_PER_SEC * pulses, rate), which gives 34 ns for 4 pulses
> at 120 MHz. I'd drop the step API (patches 1 and 2) and do the same for t=
he
> new parts, but i don't have the clock rate, and without a clocks property
> I don't know how I should get it. The PWM core has no way to report it.
>=20
> Conor, Uwe: is a clocks property on adi,ltc2387 acceptable,?
> If not, how should the driver get the rate?

I'd say yes, the clock is a relevant information in the hardware
description.

Best regards
Uwe

--nh52dyjfpekntz2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsFjwoACgkQj4D7WH0S
/k652gf/REvKgLBulTTz5q2QpmszqJRFowxppKIG+DzxbxLrHf559toya10tLlEZ
Ft34T1j0U8WfOKXm0Z71P80VXXXc9Zt11KJDnbezai36FA6LJplQqjAUmhPGR6E8
/RKeoOaeyFcE+VkHnjWlHNq8e4MGC2LKUq44vS6tXFOvdrpxhkA+sT0VlLJjABI2
bxP7grkBZoGN96s3ILGMdeZVFuWos465Asy8batD1o0c9P8v0ImlPMMeGsoDqcuK
mAns9q4wI5fW70UuZGV27Pfg296bn29JvBfY9IpCFVOQu5vD+EYZr8Wwnt0bRY1J
3b+PHqVEPUNc7NAZhXbTghjaSZQu+A==
=BKMi
-----END PGP SIGNATURE-----

--nh52dyjfpekntz2n--
