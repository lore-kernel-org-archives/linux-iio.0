Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EE5411FAE;
	Fri, 14 Aug 2026 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692502; cv=none; b=SUFRJTkpw0D4My51UIHMEjTHR4iIx4n+jRAlZDz/BKSA9i0Ivm6ouNZcXNuS3qp3FobPODd/xSw/n/Iw2+imwEdjlzYuOW2Cq6iJ8Zy2RgMHh+hzQ8zXDp23eve5Huhiirzf3QgJTB5DTvFtL6U3Gptd58zZTjZ3YPVJmlFgLms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692502; c=relaxed/simple;
	bh=gNw8jvVxwECprKQqUez+HKR8hRIiHjgS3tXcbwvjr+M=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=QHbn17VJljQxPUCsN6BEwxXzp8Z2AXcG/zSkM465wxLzCrvrkWryM8yvaoy2TV5yBi+6Gnec/094pznu86RT51F+EoJBo1Cp8SUr1Ks5mNTVxMKivHjJ+YnCYjWMwjj2LbTcdF9/lTfpBIqhWRkDwEZxEdU7dCBb339cdSGgMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1UX5dN/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1UX5dN/"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 559AE1F00A3A;
	Fri, 14 Aug 2026 07:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786692488;
	bh=gNw8jvVxwECprKQqUez+HKR8hRIiHjgS3tXcbwvjr+M=;
	h=Date:From:To:Subject:Cc:References:In-Reply-To;
	b=R1UX5dN/STm5mFPVZ6SBfz/ckapgM0zx2VLLYiMeBdEXTvSYyQweivSNSUbe2wmzy
	 JYY1gG8quBHz2DGNlcq92BNxS5jtGf5wrDPrb5FWvW/WExC0NavjclRcjGKcpJh/mf
	 FmZAxukRFRRgYn1ATNCTH0MDsJgaA0BwyTkldNCGPpjYfAY1QPnCjFG/VewS743LJ7
	 1xP7tS0WwNtw9cBnE12GoOI85UvuQT3TndKDkmdsd4PR3IPGkcJS0OR81z2vLr1hZT
	 u6/KzrMM07ByHm/Szgzzrv//1/2GsEW7cOMBumPexHPfvzJcCeXoivc0HrFYsEuqmX
	 HZCRsMmax4mJg==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=615ecc9b50dacd6d80a48a8a712bf052d811016e396005c97d7cf5ff0b6c;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 14 Aug 2026 09:28:04 +0200
Message-Id: <DKOHMK9JKVHM.DQX7QMRWRJ85@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Janani Sunil" <janani.sunil@analog.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Michael Hennerich" <Michael.Hennerich@analog.com>,
 "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, "Andy Shevchenko" <andy@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Olivier Moysan"
 <olivier.moysan@foss.st.com>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Linus Walleij" <linusw@kernel.org>, "Bartosz Golaszewski"
 <brgl@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3 11/14] gpio: regmap: Use regmap_test_bits() for
 single bit reads
Cc: <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <jananisunil.dev@gmail.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
X-Mailer: aerc 0.20.0
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
 <20260813-ad7768-driver-v3-11-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-11-cb554399ad26@analog.com>

--615ecc9b50dacd6d80a48a8a712bf052d811016e396005c97d7cf5ff0b6c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Aug 13, 2026 at 3:57 PM CEST, Janani Sunil wrote:
> Use regmap_test_bits() when reading a single GPIO value from a normal
> register and when reading the direction bit.
>
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Reviewed-by: Michael Walle <mwalle@kernel.org>

--615ecc9b50dacd6d80a48a8a712bf052d811016e396005c97d7cf5ff0b6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCan7DhRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/h/5gF+JAS9+CfWG42mOjRE5mdOzSb1535sLo22
xanfTgHQE4kSE9//vulohp3Wh9qgd+6yAYC+yc6v2946tDEXBlv6THnwtcQwdnTg
EbL8ecGz4MtccCFgXdvYEcoUCAoSrfTDdIA=
=arAg
-----END PGP SIGNATURE-----

--615ecc9b50dacd6d80a48a8a712bf052d811016e396005c97d7cf5ff0b6c--
