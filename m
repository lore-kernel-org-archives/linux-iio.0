Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35926 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbdBPUPf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Feb 2017 15:15:35 -0500
Date: Thu, 16 Feb 2017 20:14:27 +0000
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "kernel@stlinux.com" <kernel@stlinux.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Olivier MOYSAN <olivier.moysan@st.com>
Message-ID: <20170216201427.z7ixcwbuyvb7ajgn@sirena.org.uk>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
 <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
 <40633f7c-a2ac-1658-cc9d-b30eaff8a95a@st.com>
 <20170215145341.sntwx7oqyqmw6azv@sirena.org.uk>
 <338f8db7-2077-626f-986b-b4e3df40469c@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7tmmzmmcxmah5mqc"
In-Reply-To: <338f8db7-2077-626f-986b-b4e3df40469c@st.com>
Subject: Re: [RFC v2 4/7] ASoC: dmaengine_pcm: add copy support
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--7tmmzmmcxmah5mqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 15, 2017 at 04:46:44PM +0100, Arnaud Pouliquen wrote:
> On 02/15/2017 03:53 PM, Mark Brown wrote:
> > On Wed, Feb 15, 2017 at 02:59:18PM +0100, Arnaud Pouliquen wrote:

> > No, copy() is an alternative to doing DMA rather than something
> > that works with DMA.  If you want to have some sort of post
> > processing operation it shoudn't be called copy().  It's probably
> > worth considering just making a new format and letting userspace
> > convert things here.

> You mean using a plug-in alsa to do it? this seems not possible with
> tiny-alsa...
> Without a plug-in, driver will not be compatible with standard audio
> application.

Right.  But if you're using tinyalsa you've got some open coded system
specific stuff anyway!

> Do you think this would be reasonable if i implement something similar
> in my driver, without using the soc generic DMA engine?

Probably.  It might even be possible to fit it elegently into the
generic dmaengine code, just don't say it's a copy() operation since
that's a specific thing in ALSA.

--7tmmzmmcxmah5mqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlimCCIACgkQJNaLcl1U
h9Cklgf6A8OM/wvcw9Pgv95z65Oh1spkmE78Oc9GpTsn19JugWb9tbmN4sj7XoU0
2dQgGD/SdYjwd9gnt1S8z7BzRg8xQV8uVkl7tgeJY2hlIxdrSOYsI0zJOfABuC3M
It+6DdGnpYTCyBCsa388Uhtyc02XI5Wnhg8MFevU/Lqq4kaNqdsA4451ufbejXdV
NB5JDmFv2nxCS2NYXt/D/eazCZqEJVHUyOW9+3nplJcekrKhRGiAjd68p640kWp3
OCU0wbUb84G5/M00pl4DzlsLrS1AgztfDP1CJrtJvlsheNzPPUDaqIhlBQVGn/aM
lxCG+tfZ47koyc0Iz7azf3qxJMfILw==
=c56f
-----END PGP SIGNATURE-----

--7tmmzmmcxmah5mqc--
