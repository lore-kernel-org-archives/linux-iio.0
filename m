Return-Path: <SRS0=sakS=Z4=sirena.org.uk=broonie@kernel.org>
Date: Wed, 15 Feb 2017 16:53:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"kernel@stlinux.com" <kernel@stlinux.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Olivier MOYSAN <olivier.moysan@st.com>
Message-ID: <20170215165300.wxkzxvq5bjjovgop@sirena.org.uk>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-6-git-send-email-arnaud.pouliquen@st.com>
 <20170214174534.35ytbpax75mxcayg@sirena.org.uk>
 <9b875a75-294a-2f59-5830-cc0f6b3b62c7@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aougrl6cl6xjtuex"
In-Reply-To: <9b875a75-294a-2f59-5830-cc0f6b3b62c7@st.com>
Subject: Re: [RFC v2 5/7] ASoC: stm32: add DFSDM DAI support
List-ID: <linux-iio@vger.kernel.org>


--aougrl6cl6xjtuex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2017 at 05:39:53PM +0100, Arnaud Pouliquen wrote:
> On 02/14/2017 06:45 PM, Mark Brown wrote:

> > What's the physical minimum period limit?  The comment makes this=20
> > sound like it's just made up.

> I did not find physical minimum period limit, that why i considered
> this value from a scheduling point of view. I will re-check these values.

If there's no physical limit the minimum is one byte, it's the
application's problem if it's not actually able to sustain what it
chooses.

--aougrl6cl6xjtuex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlikh2sACgkQJNaLcl1U
h9DK/wf/ZdPsIU/jcL+tYmRvBQC7Gxf8w/pyyH32dI+6F5qOy5saetbOFL2RSfmo
yrLCDS9ZzKrlCyxmKGsAuZZQ8usz3O7jllgoxWCIi8+DRd0sJzB0z1xebtaTeFD0
BpPX1h115Yd6fk8sJzR5YrXTbSaVe0Pl4Oo0EN32exMwA027weQtetRSD+re+1LM
aIinPIFVaM/SnuVat5zo/skRDHfBVMJcc0neDiwdEmIP5QPXzXoqvMrLE28MM/Q3
Zl/rJCrTxVd8XmgoClPy6TigTWgHeDkbyt/pOgt+hi9/25pUDMk2c3ihYbYBh3hv
rvahh4s/myabNfJPY0Rbu6DuNqMvkg==
=A+xo
-----END PGP SIGNATURE-----

--aougrl6cl6xjtuex--
