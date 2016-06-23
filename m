Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33762 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbcFWKCw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jun 2016 06:02:52 -0400
Date: Thu, 23 Jun 2016 11:02:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>
Message-ID: <20160623100243.GW28202@sirena.org.uk>
References: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
 <1466628819-29784-5-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O7hm+SMpb/lu0d4d"
In-Reply-To: <1466628819-29784-5-git-send-email-linus.walleij@linaro.org>
Subject: Re: [PATCH 4/9 v2] iio: pressure: bmp280: support supply regulators
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--O7hm+SMpb/lu0d4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 22, 2016 at 10:53:34PM +0200, Linus Walleij wrote:

> +	data->vddd = devm_regulator_get(&client->dev, "vddd");
> +	if (IS_ERR(data->vddd)) {
> +		dev_err(&client->dev, "failed to get VDDD regulator\n");
> +		return PTR_ERR(data->vddd);
> +	}
> +	ret = regulator_enable(data->vddd);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to enable VDDD regulator\n");
> +		return ret;
> +	}

I'm not seeing any matching regulator_disable() calls anywhere...

--O7hm+SMpb/lu0d4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXa7PBAAoJECTWi3JdVIfQ0AgH/iw6jGb/xMQKCiviaX3nWaQt
OE3kv9tr7ZPUzmaLloxUZNTn9EBIWrO8MypNYAiC20fDnpixL0mURFt7AE4WIggi
de3KgPUJq2gnaQjaw+t2Ahmjee7TMPKtmaDEFEWIfKmQCVdQ/nY2HNbuUKQBUwBu
ZxeeCNQlc5T+GOtzoOhuDQdvBA7w7+gY6Em6Ga9faefk9R03gkJG0rE3wI+g5g/S
U7xA1SSDpdhRlaDnRJAb/qTuBMSRJomDne96PKeFg4RsSg5AcWD3Id4heYZs2jrK
oNj0bM4ewIisStWbBUGU55X3vh7k+dmAvn1pTnsBPLorMO4O6J7xp1Td7DlvdmY=
=wJFs
-----END PGP SIGNATURE-----

--O7hm+SMpb/lu0d4d--
