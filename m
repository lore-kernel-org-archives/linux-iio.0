Return-Path: <SRS0=xFK7=DA=sirena.org.uk=broonie@kernel.org>
Date: Mon, 4 Dec 2017 16:58:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH v6 13/13] ASoC: stm32: add DFSDM DAI support
Message-ID: <20171204165854.m75tpfauxxwz6bi4@sirena.org.uk>
References: <1512150020-20335-1-git-send-email-arnaud.pouliquen@st.com>
 <1512150020-20335-14-git-send-email-arnaud.pouliquen@st.com>
 <20171202150952.1b5f3bfd@archlinux>
 <bd2ba77f-2d91-efb7-d89a-3f8cdeb941f7@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rlh6d4dswgtajyfg"
In-Reply-To: <bd2ba77f-2d91-efb7-d89a-3f8cdeb941f7@st.com>
List-ID: <linux-iio@vger.kernel.org>


--rlh6d4dswgtajyfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04, 2017 at 09:58:42AM +0100, Arnaud Pouliquen wrote:
> On 12/02/2017 04:09 PM, Jonathan Cameron wrote:

> > Mark, given this set is moderately invasive on the IIO side and
> > should just drop in cleanly on the sound side of things, either
> > I could take it via IIO or one of us can do an immutable branch
> > and we take it through both trees.

> Don't know if you saw the reply from Mark on V5:
> "This is basically fine, if someone could send me a pull request and the
> relevant patches when the IIO stuff is sorted out I'll give it a final
> check and apply then."

Yup, I figure that a shared branch with the IIO changes in will be the
easiest thing (Morimoto-san is donig a bunch of subsystem wide ASoC
cleanups ATM).

--rlh6d4dswgtajyfg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlolfs4ACgkQJNaLcl1U
h9AI6Qf+Ns7UxHco/nllDt1X0901uEorPHxMn67VgUYAh587jmNIHugMSZh5zTA/
2OXe/FU0JWus7baKx76e8CqWE23p1qsEviwlR/IGRvjAM8Rd9VF1TUJJE3bjkWFS
sXJJlK4XNrSzLijRO4+pa43ovu777eigHgfAUlt4+vyOCnb16pc33Mix5uKRsHrE
W7XKf122/kCvMS1DOp7EOgzpQRonOy+x4h0cnaTheOSS/ayzN80qVImW7e+70bAs
MmwBK/gMyGdyeGmhgUxonO5tf3gxYGXcM7LzCyG1Sm8wLELLduEo/JCTaEamqvCp
yewbRgeW50AJjWbkHLmDkompA7FYmg==
=Bx4K
-----END PGP SIGNATURE-----

--rlh6d4dswgtajyfg--
