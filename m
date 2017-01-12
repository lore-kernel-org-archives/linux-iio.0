Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750823AbdALDEX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Jan 2017 22:04:23 -0500
Date: Thu, 12 Jan 2017 04:04:19 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>,
        linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 0/7] mfd/iio: move the AB8500 GPADC driver to IIO
Message-ID: <20170112030419.j7ux7igi54556koc@earth>
References: <20170110234745.29691-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5e5cejsrhjwdz5tt"
In-Reply-To: <20170110234745.29691-1-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--5e5cejsrhjwdz5tt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Jan 11, 2017 at 12:47:38AM +0100, Linus Walleij wrote:
> I don't know the best merge path for this but suspect that as
> usual Lee can merge them all and provide an immutable branch to
> the other subsystems, which he has lots of routine in handling.
> The final DTS patch can probably be merged separately through
> ARM SoC.

I'm fine with that solution.

-- Sebastian

--5e5cejsrhjwdz5tt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh28jIACgkQ2O7X88g7
+ppDHQ/7B9bE5PEEFxVo94KH572oJrlA5SF8JANteNANCdcQlJP7kJzj+Ox1FNAm
Dx8iO0R4AUb+LsSXu01oBG87oQlETaOg0UG3Cf8AvLy48EVDm0TEZpt6dI/3TzZ6
hfQlCF6B3PPtwVHQcqALPzTrmTb/uh5Y/2Lp09DqNe+Iz6zIpLoQ95+cnNnyPWF2
K0hwzQne9eGAb2ZA0O9AqY10v07MrAL/tpBzTTKPMJhTY6TPXrfEcn7mIEOJTS/H
NGFCm3rzc9nn6nTZv8yyxHJmugTgEfEsIyCbZMgdJtwjd5rx90GwI1rSjQ5ESRi0
IXab1S+bYCeKtphkGFnQBIxV3OyHjEnCq9EPRfAkJ3gqANupgED2b4InhqZyqF0O
Jk+iQ4CMJ77E8UPVLGftxUSUE9e051tt+GFpIaFr9E27JvPrS0DpFdk2RXpDh5gY
PvEHELRrnorx9EIq4/DcRxORpkalOslGU1Qi44JKAZ+gDEo6ODN6gv38IDjN7m9q
/zvNKUARcxZ0Ef6l344IIeaiCyPmM1sT59y/ZkiwXiJpO6PKx625AIn+RwyIc4L3
gBjJHbM/5LvkD6ZcbDyJyRYCHdq3ULt2mMt8WvU5Q45dABhhtl9BspOpi+jaBxLk
wr1/XlHtsumnshh/u0kO5l86Byqd8dwEeH1aUzFAeYF/kWVObbc=
=oHcP
-----END PGP SIGNATURE-----

--5e5cejsrhjwdz5tt--
