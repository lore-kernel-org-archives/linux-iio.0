Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:36304 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbdA2Rua (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2017 12:50:30 -0500
Date: Sun, 29 Jan 2017 17:50:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Message-ID: <20170129175005.2u25l7zd2anlc6tw@sirena.org.uk>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
 <20170124082249.GR16020@dell>
 <283c0e48-55e2-6516-369d-91dc72d12f73@st.com>
 <20170124113658.GW16020@dell>
 <a1aaaa20-ac00-b182-f1c1-63152be41135@st.com>
 <20170127101545.g53uah57vgfu55o5@dell>
 <7b3eb38d-4fd1-2006-7423-94f2a7b38b27@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hapx4fny3zdvi7ik"
In-Reply-To: <7b3eb38d-4fd1-2006-7423-94f2a7b38b27@st.com>
Subject: Re: [PATCH 2/7] MFD: add STM32 DFSDM support
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--hapx4fny3zdvi7ik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 27, 2017 at 02:45:49PM +0100, Arnaud Pouliquen wrote:

> Jonathan, Mark, Please could you share your opinion on this topic?

I really don't have enough visbility of what the hardware or software is
doing to say much and though there's extensive backtrace in here it's
not enough to follow.  If it's a generic ADC that happens to have audio
applications then some relationship with IIO might make sense but I
don't know how separate the audio and general purpose bits of the
hardware are.

Please understand that I get copied in on *lots* of threads about MFDs
with drivers getting posted repeatedly for whatever revisions are needed
with little relevance to me so it's very random if I even look at these
things, much less read them with detail.

--hapx4fny3zdvi7ik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliOK0wACgkQJNaLcl1U
h9A1MQf/TRDyJvQa1AT0k+9ghr8Uix9BthcokasfxQBM/I6jauAq7hp3HEPpcTYf
AZ88MjZdxhS8iNgmmZzllGStvUIqgFRkAt++yH0jc0s+KyTRRcM6cZal5Zcii8NE
e3Pui/XMpuoSuaAaS7UKUcy6nnUf43M7QZ4mW866NJvQ1qJSmvJrWqnOODO+IaoC
geSt5v4jGnDOyxhP60llrspideFGs7SpXfHtOK/6G1kRQOslvBGLHtlNwjvr40oa
pRzjZk/loAJ2x0YAq7bA9TkgT7Jjb9yWdd4bTngnmlbHI4b531yjqiPdtRBlQhw3
+O62U1yyrvN9CLGIoQBfG80o9ytlJQ==
=Mbpq
-----END PGP SIGNATURE-----

--hapx4fny3zdvi7ik--
