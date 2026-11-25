Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620146;
	b=2L3YZ1crm8zdR6jMioBfJ5T8v9V4rPOT5AW1O8jU06aJgbGKuWXPzqx2jwtw6Dl+XFPn
	 YgELHGEze2u3EOUggvxfOJpiGiPjK5/HCbORJRQSkWs6sjWcfB5TgA0/utejR0qQI7ndC
	 HLGC8aSdsLwefKY79XK8rPypaE8oLsZgyr4pzDITNQrft5MIGCZKr+RUf2UeI5n/o+DBK
	 pFZEc8geF03BVBFKCK1KbNs7wbBgrck0GDSbOAdLT5sIYuvrUhkSAEpGa2ZqNe9ErFval
	 Txyx5jiveoLAHTkJV3x9F7xmRf8czDgG1p+HOwPP+MeM2grYnn8Dr4uFJkZa9mD+N+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620146;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=WPm5f6o6q9fQoFUXqZTkOjGUojfVjYLnzIwjI2iGOZA=;
	b=H0x1tqDZSjp3A+YnyKCAxZ4Vh3bvxwXJLr3RhJGYZswECwDPKIBqDGWbJ53gFV+yZWTH
	 3kPPco7e3TPD329pB1BUpm1LD0AkgmNUsIEUu3J3QTd/38CDbAmCk2tgA2dKsEG2eLSWy
	 LwSXIdMynWXYesERhr8YXJaWYT62aO9tSFA/KKaNfaxET+/WVYXZuYWPnv6acazXsYYAp
	 KioweFWIePvZplJHhQdaGAMInx1RJ9fGLIE0snGQaN7M54uuS9Uku1u46b8oBbMa9q0/7
	 oPzRgEXCsQ52V3Udd2zSUjJOo0ZwMehrRtzw1Jw1HdBwJLXiGIH7ITezm3kJThBN15g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iirkhZsk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8521606A31E;
	Wed, 25 Nov 2026 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iirkhZsk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C911F000C0;
	Wed, 25 Nov 2026 15:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620146;
	bh=WPm5f6o6q9fQoFUXqZTkOjGUojfVjYLnzIwjI2iGOZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iirkhZskCFEGY5EgYsFyvEtuayDf13fe1TB9VZlGBLo63US3MpFkmWHz4LxlPfedb
	 LfZyvNlGEk0m0Ao3tNxrWy/uKsQrUzrWa8j1dSDjL7J3R92pmrWBNuERT9LG2iS2hR
	 uWYZiLkNlLNSbP2xouJYCetuy65y5siHjM33ZszIaBKkfqv5674aOja7y0UEVca8U5
	 RK7Ct15GNb8toAnGWx7f7QnSu95a4n3DvSsh218HDL+gle6tM8MEyH2y8byhbDfBpN
	 4auyymDP7u3CfBsTLd9RMuepu53iGhwlu/6cqQmamXbWhUhODAHaH4VwPZEgcTejXU
	 gphu0cY239okw==
Date: Wed, 25 Nov 2026 15:22:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: raffaele.tranfaglia@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-sound@vger.kernel.org, Neo Chang <YLCHANG2@nuvoton.com>
Subject: Re: [PATCH v2 1/3] ASoC: codecs: nau8360: set val_bits to the widest
 register size
Message-ID: <1c55d4cc-bd67-4344-8727-0017fd5b79f7@sirena.org.uk>
References: <20261125-regmap-kunit-val-bits-v2-0-81db3b79cd3f@gmail.com>
 <20261125-regmap-kunit-val-bits-v2-1-81db3b79cd3f@gmail.com>
 <awbhwVw52eSTTmiu@ashevche-desk.local>
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
	protocol="application/pgp-signature"; boundary="2vhTjSjPcqbwGTMA"
Content-Disposition: inline
In-Reply-To: <awbhwVw52eSTTmiu@ashevche-desk.local>
X-Cookie: -- Owen Meredith


--2vhTjSjPcqbwGTMA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 25, 2026 at 03:25:21PM +0200, Andy Shevchenko wrote:

> Hmm... While it works, it might be not the best approach. In cases like this
> elsewhere we create two regmaps (one per each val_bits size) and choose them
> based on the register offset.

Either approach works fine, neither is particuarly elegant - you do end
up with a bit of open coding with the register I/O functions, but
equally it causes surprises elsewhere to have multiple register maps for
the same device and that's also error prone so there's something to be
said for putting the special casing in the two functions.

--2vhTjSjPcqbwGTMA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsG/SwACgkQJNaLcl1U
h9CQkQf+JBrJ5QV/gQV+1O7tzRwKf4d0vznu88UTJU3Xytz1LKQzUFrihlew+uMc
hkIe6ghvi2S6VC237c1JQNbGQ3S0hrEDKRlA7YlatPEPU4WZMSsCphiCwH2qityO
n4JXaihCtV/x2X9bvz5VfKF6aHvJiPMDDaaPpwplKXr9fbwFY7awuoBs+NIvlFgy
fBCmNfr+oShutTvPJvUqafAiLeBzNHkkH7BWK3LijyAmC/BdjTSM0BNYhdUfZIhN
A9i07xVWjt5Kw7qgEYMlRf04oZ/85j9R7oKbxRbFNqxh26fXqO1OkOwb5/bL7BE/
3M88cALi3Xc+VFF3YSmJQeafm9S2Bw==
=1vm1
-----END PGP SIGNATURE-----

--2vhTjSjPcqbwGTMA--
