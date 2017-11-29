Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60964 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933165AbdK2Pij (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Nov 2017 10:38:39 -0500
Date: Wed, 29 Nov 2017 15:37:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v5 13/13] ASoC: stm32: add DFSDM DAI support
Message-ID: <20171129153748.awllz4aoziaxpk2c@sirena.org.uk>
References: <1511881557-28596-1-git-send-email-arnaud.pouliquen@st.com>
 <1511881557-28596-14-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ubr6w2kr5kkkan2b"
In-Reply-To: <1511881557-28596-14-git-send-email-arnaud.pouliquen@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--ubr6w2kr5kkkan2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 28, 2017 at 04:05:57PM +0100, Arnaud Pouliquen wrote:
> Add driver to handle DAI interface for PDM microphones connected
> to Digital Filter for Sigma Delta Modulators IP.

This is basically fine, if someone could send me a pull request and the
relevant patches when the IIO stuff is sorted out I'll give it a final
check and apply then.

--ubr6w2kr5kkkan2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloe1EsACgkQJNaLcl1U
h9BVlAf9GgCBlhd0NGfdwnmtmo4I9hpicJhKkSm5CoRoPoSVZrjSoO+hSxQim9ea
mslKawzNOUb5yJkXpmiYIXq2AKDsZqTNTPH5s1MsUeeGvOsVynPjFD9AdQvwFY0u
kCz3DrTRH9eijZ4/3yUhzNZE6xE810JKKfMh8/GVO8JU/WzWLqfQW/hJNB43JS3w
47beIOvNyHWeqoYOPqHasndk2Z7vKX3StMJqXBm2aND4V2S/sDbPr5Ibxm+pxKBn
bK8i6+fP+8nbW00narB67Or4n1NUbE6o0wDFwyDP+Hqk/VLVZiDOGFgMpD+IBWw4
lF0HSawOKJHYRKjx6uwUc893stEjQQ==
=9NM4
-----END PGP SIGNATURE-----

--ubr6w2kr5kkkan2b--
