Return-Path: <broonie@sirena.org.uk>
Date: Thu, 23 Jun 2016 11:48:03 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Gregor Boirie <gregor.boirie@parrot.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>
Message-ID: <20160623104803.GY28202@sirena.org.uk>
References: <1466547498-15484-1-git-send-email-linus.walleij@linaro.org>
 <1466547498-15484-2-git-send-email-linus.walleij@linaro.org>
 <576A7C28.70905@parrot.com>
 <CACRpkdZT_9gs9vPYGku2XeZnxaXPaE=X3XLWccPkB2iK9_KvcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="USQ0BwiCE5W4XvtQ"
In-Reply-To: <CACRpkdZT_9gs9vPYGku2XeZnxaXPaE=X3XLWccPkB2iK9_KvcA@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: magn: ak8975: fix regulator usage
List-ID: <linux-iio@vger.kernel.org>


--USQ0BwiCE5W4XvtQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 22, 2016 at 05:41:51PM +0200, Linus Walleij wrote:

> The only way a regulator doesn't resolve to a dummy
> is with regulator_get_exclusive() which I'm not using or if your board
> is lacking full constraints. (All DT boards have full constraints.)

You mean regulator_get_optional() here I think.

--USQ0BwiCE5W4XvtQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXa75iAAoJECTWi3JdVIfQ7YIH/0cPsg8biqXZaeOaPqv/s7x2
5UFjpMoqLa3fpW+OYGjbogTbkj6wU1UQXPQDe5cNmPseUu8daI+hLG1IcaeJ/YGU
oHL+cwaNGlbyywElG2a70qX7rxrJoiiRWWT4aeeWO9aC5AkPaU9hOgo1W7tNkKyi
hKBydcSXK4S/CXNq2HfG6VQFkwYuqUMkBs8WJVQjSsefq4A5I3tTzWi9WO+yoDPW
TbtdM0XwyNwGme23syjKUGJqFl3pMDfITE/7DU5F2d4n2m9w1O7S06VRF0j71qDD
Qi4mRMiu67GdPk2H65YuJm0PkjSRHcDzRvUpkrhM/kAv4b7rkcMr5RMAT8okm1o=
=vjPg
-----END PGP SIGNATURE-----

--USQ0BwiCE5W4XvtQ--
