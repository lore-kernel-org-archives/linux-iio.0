Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11143FBB72;
	Fri,  4 Sep 2026 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541746; cv=none; b=CIoRYhZYojwUqIP316seS0x5GSivPhdBtLAbh4kwtzP47ThKwh1RV6KONOY8m50hn2/vFqf0za76WdooqWp1P9SR9Rgwv2mf9GNokGxNVnU/iFeyPmYylrMPUCc3Cc6oTtlPxGq67iIy7ZapllNIz7VOOSl5+4JV3Qz51E6QTy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541746; c=relaxed/simple;
	bh=lw4DXJTdVx4Gw7xWT95Xd6jIdq8p5U3vIlWYtOL68C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8zWHEDJZYF0LY7tKqSuG8YDTy76NccJdDtDqzJlVFEtG99MXIvZitv9SUqdp273bHTIIks/119NWVPeiE8+bssqkSVGPZ7pIT9Ind5s58VtEEaq6V3FaU8BtzwDROe7cNZxXASB5wyaAF6KyvX63/3xN/uFVBwkg1E7j0j+c1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsskS7Tj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsskS7Tj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167AB1F00A3D;
	Fri,  4 Sep 2026 17:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788541744;
	bh=lw4DXJTdVx4Gw7xWT95Xd6jIdq8p5U3vIlWYtOL68C8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XsskS7TjzEjfQ8V3UyMObmX+B8AsWFxFvKpg0pwsEJYOvXQlgkXxUnIYcJxKKKEbI
	 zmbfjSr6vud0Ss5CpXECCmyFiI/XxOaRzBNYyvQiL3ySvvZ2NFpQH/2DTs0y+qnAoW
	 YAbZsVsxVSB/omLVQiVPfGAC1LysLgb91jFLYwnjt3owxNZLNQCcL3T8QD9q7Oap4c
	 p93/EEjUG2Vvmnn1iVdJ5E+gRtUU9yW68UgeYcVqqqfjMYu0NbfN5R/CoyN1etNsvP
	 7bIH++6cZAvsDo6LuIHkAnaXcvSYzG+l0Qv6LVkjhoBhVDCdSas7p5rcXEitfA443s
	 87kfktHQpLIgw==
Date: Fri, 4 Sep 2026 18:08:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v6 02/17] dt-bindings: iio: adc: Add AD7768
Message-ID: <20260904-unified-tyke-bc1b8f9d4d3a@spud>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
 <20260904-ad7768-driver-v6-2-e4378f946bfb@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BVdepgrbK4Hrr/oe"
Content-Disposition: inline
In-Reply-To: <20260904-ad7768-driver-v6-2-e4378f946bfb@analog.com>

--BVdepgrbK4Hrr/oe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2026 at 04:14:54PM +0200, Janani Sunil wrote:
> Devicetree Bindings for AD7768-4 (4 channel) and AD7768 (8 channel)
> simultaneous sampling ADCs.
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

One more binding that the nuances of are probably beyond me, but David
and Jonathan appear okay with judging from previous iterations.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--BVdepgrbK4Hrr/oe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapr7KQAKCRB4tDGHoIJi
0jYPAPiwchvAdt4TRq/YwxhKFvfwb60afzexZoOFqptcIXeiAQDxZvo1BVSfwJuq
6E37fGonWHIoluMbkgDar6ifwoKhAA==
=4wNq
-----END PGP SIGNATURE-----

--BVdepgrbK4Hrr/oe--
