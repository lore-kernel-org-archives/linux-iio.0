Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35636 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbeIRCsE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Sep 2018 22:48:04 -0400
Date: Mon, 17 Sep 2018 14:18:35 -0700
From: Mark Brown <broonie@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi <linux-spi@vger.kernel.org>, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] spi: spi-davinci: Add support for SPI_CS_WORD
Message-ID: <20180917211835.GH2471@sirena.org.uk>
References: <20180913003920.30600-1-david@lechnology.com>
 <20180913003920.30600-5-david@lechnology.com>
 <CAMuHMdUb=sXBBRLhKNxsWT_Z4PCoLcM16NajvmPVHWsvgoL7_w@mail.gmail.com>
 <fb43f4d7-5b19-72be-9216-efdca9b59eba@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
In-Reply-To: <fb43f4d7-5b19-72be-9216-efdca9b59eba@lechnology.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--AqCDj3hiknadvR6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 13, 2018 at 09:26:48AM -0500, David Lechner wrote:
> On 09/13/2018 08:44 AM, Geert Uytterhoeven wrote:

> I suppose it might be best to modify the SPI core to say:

> 	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
> 					  gpio_is_valid(spi->cs_gpio)) {

> instead of:

> 	if ((spi->mode & SPI_CS_WORD) && !(ctlr->mode_bits & SPI_CS_WORD)) {

> Then we could drop the error above.

Yes, that makes sense - the same thing is going to apply to any
controller with this support.

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlugGioACgkQJNaLcl1U
h9Acdgf/X/OeJnFpgtiBslpY7yCDTv4ulyxoYx45ExUrvKW0mJTNGrJa2zjPiX98
j7v4A/s9MJb7t5Rn8I9ZhDVApF0ydTbEDj/sLtyjvdzMVXH/moB48WAYWlCl9Cdm
OPdxhZyoO1DyxrszcsUO0o+LsCEQoslL4ru7Wk9wdyOCi05j9yTxPpxlPlq6Wfcu
ugs/OVezQYE6EKqCegn/UtDJTrZjFKafY/7Db6SZBKWnXz/ffSV+mc7CHK5QfBrz
LHf01dtYhAoURWfH7VMmOukkLeR5C6WFSU7sTWD9FucjGtw009p6LGK4yRtH33yw
8xR4A3ErQos2mFIkWmexZNTnAyLb+w==
=Wiqq
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--
