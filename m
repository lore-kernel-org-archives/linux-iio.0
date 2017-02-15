Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55834 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbdBOOyu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Feb 2017 09:54:50 -0500
Date: Wed, 15 Feb 2017 14:53:41 +0000
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
Message-ID: <20170215145341.sntwx7oqyqmw6azv@sirena.org.uk>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
 <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
 <40633f7c-a2ac-1658-cc9d-b30eaff8a95a@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="33ckhs5hsnh4v5h7"
In-Reply-To: <40633f7c-a2ac-1658-cc9d-b30eaff8a95a@st.com>
Subject: Re: [RFC v2 4/7] ASoC: dmaengine_pcm: add copy support
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--33ckhs5hsnh4v5h7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 15, 2017 at 02:59:18PM +0100, Arnaud Pouliquen wrote:

> For DFSDM we need to re-arrange samples after DMA transfer, before
> sending them to application.
> For this, a copy ops(called in snd_pcm_lib_read_transfer) alreday exists
> in snd_pcm_ops struct.

No, copy() is an alternative to doing DMA rather than something that
works with DMA.  If you want to have some sort of post processing
operation it shoudn't be called copy().  It's probably worth considering
just making a new format and letting userspace convert things here.

--33ckhs5hsnh4v5h7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlika3QACgkQJNaLcl1U
h9DKrgf/RKMVllUuaZSVpCSv327C4V+u3rtHbhzk50hwN25T16xLJtEr4+Jeuol8
qab3PO4EkbLfr4VbKZi2c57+2nwRw+XXNiKxIOjkb8t0D2y6UCMvNezepacWnJhM
pBiT3YmP2y8voF+iXAfM/5EhYIjoTcD7tA4U0tfCH/dDdW3UShgdgm8Tg8C6rh0c
7JmCH4scZuaqnud2Rwyd8zjdmWXpbQije7TVyc3zmLMxUpx3qgFt5c8Isen6lYRm
jhPEULoAZslyN8yAzbdFnuRFovFeY2qxfdXmgicNB39yaDNGhcUit5IIxa51NlXZ
0mnvwj+gqc1sN2/25xIMw4lRnDka7w==
=iYQi
-----END PGP SIGNATURE-----

--33ckhs5hsnh4v5h7--
