Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:51100 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754310AbdBNRRg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Feb 2017 12:17:36 -0500
Date: Tue, 14 Feb 2017 17:16:30 +0000
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
        kernel@stlinux.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        olivier moysan <olivier.moysan@st.com>
Message-ID: <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hicslhhs4zfgzzsn"
In-Reply-To: <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
Subject: Re: [RFC v2 4/7] ASoC: dmaengine_pcm: add copy support
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--hicslhhs4zfgzzsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2017 at 05:38:26PM +0100, Arnaud Pouliquen wrote:
> From: olivier moysan <olivier.moysan@st.com>
>=20
> Add copy support in pcm damengine operations.
> As example, this allows to:
> - process data before rendering (IEC status insertion),
> - process captured sample ( sample mask and shift).

dmaengine with copy...  so not DMA at all?  I'm a bit confused about why
we're extending the dmaengine code to have a copy operation rather than
just writing driver code.

--hicslhhs4zfgzzsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlijO20ACgkQJNaLcl1U
h9C+ZggAheP4mEFbWQ3/f5hPBO1PLdptmUMpXbC/tiCkGNiK+TmpEsRkG0KgDbZ3
ybftSnkXa2ayTeaaCYG/MEo4BZM5HRhUY1gSINgV+aLsb858Af16cXkHlYMlbjPj
U4NYhZvDRZ2BLGS3FNwslIsKSv6dj0ACxypyXF+LVpTXShaE0kVqPXznIVOxtJF4
Yc2Jo2LcApERM2ulnkAtmsHDjKClEzMtSzJfAyLcyWvHPAWzfm24ZTfxB9keodbM
DLD80zL3H5dahdUwJAWjxC6T1JXPWR6YQi1NSocvMXv2Z2MHstIhiXPRLEo97zKM
Tu3E4yzY8FYtambuZQwJzUTIOVIdAQ==
=xEbl
-----END PGP SIGNATURE-----

--hicslhhs4zfgzzsn--
