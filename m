Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527956;
	b=UJy2ATXS8TTuWuaVo5yt/vqQaZHg20328Bn9bZBF+sRFA0eIq7K6MzmdEvyonSe5nHmg
	 dEsymFrwa9LmZIJ1MqLzuQd3hNcvTyRvnAa8bNGgixx8O6ADaIXbUr0e97M0mSF8EdqOX
	 CobIJ49aUsRhqMQmzSkycCJmaIIQZ7CHpvnzOyFGu0c6lxbekY/JwV2dh1OAk/OsfYlIg
	 81x6J/MPxB4CXlD4uJjIzC0K4jISQcLr9NTSq2s5NGDKvHa+29MUBmIyzmqtBaUcLLk1g
	 ioMtVA5i46dSmwOvxNHEuPipIpwy+YkVlzS0YqPi2YmJl8h5/AjHeNwK9AsXf90f44w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527956;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=klse+WkM5nsp7cQ6XpAeI80imLNq4UgVB6hd9cWjqJ0=;
	b=rXore6cw0RDd89QI1utPQoqxlXyZapzaUphM+EwDkGkh1mqm7l63si4EZTK52NN6cAtK
	 HNpQVgPIcaAGb2jv4RRHtR0Pz/IjyRay1K9rwqDH+EJDGk75je3v7QIMfj3ou+VQdOm62
	 lzkVJ85wxkeXJKnSJBABZWRyGD05aE/AGZM3oxX7cXTu98hkW3OdlPZ6+Zrqf+vHYYdsp
	 TdD+cg0cYHosR3M1Plo0eZKMbys2Qt7k27jAPMx1effnndxjSKYqY1eAjnw8nIqrtl7oQ
	 WbTK2TZeeHlrxG7vEKRhh4v0A0z/4BofSDBO+TbvCFqjJekBb4THC/SfRB0xvvYA/JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UNgmgpNH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759D606A31E;
	Tue, 24 Nov 2026 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UNgmgpNH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B3E1F000CA;
	Tue, 24 Nov 2026 13:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795527955;
	bh=klse+WkM5nsp7cQ6XpAeI80imLNq4UgVB6hd9cWjqJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UNgmgpNHrbdULPvjKIavxxzZRxy4Xjer0TkEjH3zHYzAE6re4X+AWlr8/5Xeo4iOS
	 qk9d+EGekW5+Q+UjrVTe5GrJjV0s9sBEIdjGw62hVKabx1hrt4CVDgErzl/tRvxGXx
	 5de8akPt0sRem+qH8swqBWrG0fX46E9pEic1EYzJDFY2MmxWqNcM+MPdtqMt9BYFIg
	 D41KgXkAEnfg086kymdrgSCVXeheERzRHF6Kcv0aOicNqG8cviYyq+InADWzmBm8WU
	 ifckWuON0WFW6OTZkpxgD1CXhkm7YUdr5N6+Li/Oxn6UakAXz2lwIZfWGcobYZCSjf
	 Ey1cOp9mcx2Kg==
Date: Tue, 24 Nov 2026 13:45:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH RFC] regmap: kunit: add tests for values wider than
 val_bits
Message-ID: <a78a0db4-041d-42e7-aba3-f8f737bbf6a1@sirena.org.uk>
References: <20261117-regmap-kunit-val-bits-v1-1-a1cd02063217@gmail.com>
 <av1qOFxolvDhQTKs@ashevche-desk.local>
 <a93f6d11-22a2-42db-81d8-297240c9bd2d@sirena.org.uk>
 <CAJsKa+4KEU8ejsDvj0=qCh3=XC5dZZNv_X+Saco4Ln3Y9q9dOg@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="fZ3qR/wdXIXW2/8j"
Content-Disposition: inline
In-Reply-To: <CAJsKa+4KEU8ejsDvj0=qCh3=XC5dZZNv_X+Saco4Ln3Y9q9dOg@mail.gmail.com>
X-Cookie: Real Users never use the Help key.


--fZ3qR/wdXIXW2/8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 24, 2026 at 07:29:34AM +0000, Raffaele Tranfaglia wrote:

> > It means we can't enable this test cases without addressing the underneath
> > implementation(s) of the regmap. I think the proper solution is to cut upper
> > bits on the regmap level, so the cache and HW will see it as expected.

> Mark, would you be ok with masking in the core? I would mask val at the
> start of _regmap_write(), before the cache is updated, so that the cache
> and the bus see the same value, and document it for regmap_write().

Yes.

--fZ3qR/wdXIXW2/8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsFlQ4ACgkQJNaLcl1U
h9BqAgf+NN8K8XBHfrCWcWFWZZkgpjw/m2yiERZtFwStD9K/017B7ex8fgl9eq1y
NgQ6Yxb/qape0IW9/Xrk2GGbJIPSrtJnT9fvTa+H8oxgHPmudbhXkM8Pr4s55TKi
Yyah0aXWeEXzmUPXPdd9p1o8f7PmC39q9Qi5zD8P5NHzumjSJpkNpgyP45raFDtA
1ndwnCBKdDx7GasjFsg4iLzja2RS8spe8hz0SHtXLZZrhM849mt+mhtMEJmRwgcB
zVFFpsDasVG56ppaOEm/mAsg7ffpTzfUoZRoNVH7W9fo7bo44B2C7ilEUpAiWQy1
NHkEVlmW0ETwNeqABwmMUjip0beYMQ==
=2Wln
-----END PGP SIGNATURE-----

--fZ3qR/wdXIXW2/8j--
