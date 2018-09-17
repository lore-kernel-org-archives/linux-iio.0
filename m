Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33914 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeIRCrD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Sep 2018 22:47:03 -0400
Date: Mon, 17 Sep 2018 14:17:19 -0700
From: Mark Brown <broonie@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] spi: introduce SPI_CS_WORD mode flag
Message-ID: <20180917211719.GG2471@sirena.org.uk>
References: <20180913003920.30600-1-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+sHJum3is6Tsg7/J"
In-Reply-To: <20180913003920.30600-1-david@lechnology.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 12, 2018 at 07:39:16PM -0500, David Lechner wrote:
> This series introduces a new SPI mode flag, SPI_CS_WORD, that indicates that
> the chip select line should be toggled after each word sent. This series
> includes examples of how this can be implemented for both an SPI controller
> and an SPI device.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-cs-word

for you to fetch changes up to cbaa62e0094a840fecc853910e0c0454529cec03:

  spi: add software implementation for SPI_CS_WORD (2018-09-17 14:14:18 -0700)

----------------------------------------------------------------
spi: Provide SPI_CS_WORD

This provides a SPI operation mode which changes chip select after every
word, used by some devices such as ADCs and DACs.

----------------------------------------------------------------
David Lechner (2):
      spi: add new SPI_CS_WORD flag
      spi: add software implementation for SPI_CS_WORD

 drivers/spi/spi.c       | 31 ++++++++++++++++++++++++++++++-
 include/linux/spi/spi.h |  2 +-
 2 files changed, 31 insertions(+), 2 deletions(-)

--+sHJum3is6Tsg7/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlugGd4ACgkQJNaLcl1U
h9DJIgf/f4joAEfsig+UrOY9kHMRYVZQQFoCjDDAefcaga6TIqBd+4x5xuZQImCY
inytWF9nN4fkhmdlYAS1yDBSFQJveVIRS26W6A0qPZFJ1ZcIE7DAbcfZ6E5orXlD
lTNn3SbkZWUDEw2TCSbMvgRPBvIvvaKQW1sqomZTM5Em6IivdRoQRpzR8E6V6oZL
ThWQ/ApRuVKjdfzz1cho02XDGnPUX+3/AszMIsymBXjRnF+FkViQf+Wz+lvIweeR
14IJVEdYn1ZeAFKOihoVpGKf0TO4CtviaFYCuAtbmvX6UwLjsz0FpWuA8L4NExVj
4M06Dc8gbeMtjZT1YF7lia4ShuRNbw==
=mNnI
-----END PGP SIGNATURE-----

--+sHJum3is6Tsg7/J--
