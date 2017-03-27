Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40922 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbdC0MAZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2017 08:00:25 -0400
Date: Mon, 27 Mar 2017 12:59:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>,
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
Message-ID: <20170327115920.opbtui7mor5q6tch@sirena.org.uk>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-9-git-send-email-arnaud.pouliquen@st.com>
 <20170324144603.zos7n4oqelaag433@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pe5njdkllemkgbb4"
In-Reply-To: <20170324144603.zos7n4oqelaag433@rob-hp-laptop>
Subject: Re: [PATCH v3 08/11] ASoC: Add bindings for DMIC codec driver
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--pe5njdkllemkgbb4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 24, 2017 at 09:46:03AM -0500, Rob Herring wrote:
> On Fri, Mar 17, 2017 at 03:08:21PM +0100, Arnaud Pouliquen wrote:

> > +Device-Tree bindings for dmic codec

> Please define what is and isn't a DMIC here. What's the interface?

Digital microphones are a well understood concept for anyone familiar
with the problem domain, they all provide a PDM output.

> > +
> > +Required properties:
> > +	- compatible: should be "dmic-codec".

> DMICs don't have part numbers?

Not meaningfully in this context any more than analogue microphones do -
they have no software visible interface.

--pe5njdkllemkgbb4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljY/pcACgkQJNaLcl1U
h9AjgAf+JxDZOC2ncfYHSTbxJzxXceJREmXx466ytDR2JZj6LWiFlJiqjeM/3v3Z
TFzeM98xHgkX06G7VYOZ9YUFR9tai7IxR9fPXS5yiWLwvb2ZEw5rowCKmFIClWxL
E7CQRhqYzbJa94XUtfY6qYXMuNk7NZ56EQfEoM/nZ46bw7iZTstVWVZrcxQzmPpL
tmEhguZYZ8DN0BCRU6fu7u68UHrEEGOsWg+fmoK0JfkW//9xaVXRe1xq5DhHZG5A
DJkqa1U4ssmq70X9LF/6MSrs746d13PXq+aCu06t0XvEokVpY3dyOEg1X3qoLyIU
7U2s5OaUoflzOsMKHu6UBQVEl4T/Xw==
=W9ta
-----END PGP SIGNATURE-----

--pe5njdkllemkgbb4--
