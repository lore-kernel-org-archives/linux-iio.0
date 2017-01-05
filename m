Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:46560 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752336AbdAEMBD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jan 2017 07:01:03 -0500
Date: Thu, 5 Jan 2017 12:00:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Message-ID: <20170105120027.4nftlpegln2se7bq@sirena.org.uk>
References: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com>
 <44cce3d5-f65e-1a35-20a4-5eb9fda42312@metafoo.de>
 <CAMpxmJWDWk-mXUHHGEKm-VVwzqEGLDQjc274Xq+Qwc2eN=YbsQ@mail.gmail.com>
 <d4c7f1ca-49d4-7abe-bfc9-e1728f62a9fb@metafoo.de>
 <bf3dde7e-cee8-c54c-db93-447ffa063116@kernel.org>
 <CAMpxmJVJ+y9tRbRBsVg+i0EJO_6EFuvrypwC=ETnBWbMnxRFyg@mail.gmail.com>
 <c670d597-46b6-235f-545f-7136a3abff7f@metafoo.de>
 <CAMuHMdX3u4cb2Yq2+VV_eDUaw2EqiOjN2TorW+F5-39Mm=mXmQ@mail.gmail.com>
 <9609b56b-194c-9899-1142-ff2ee285c6bd@metafoo.de>
 <CAMuHMdXnzDUYcr8qiUTwE2peBdjwuVWPRUkms2J8AHFaQ=SHHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="poi24u4kh3yy7qdm"
In-Reply-To: <CAMuHMdXnzDUYcr8qiUTwE2peBdjwuVWPRUkms2J8AHFaQ=SHHQ@mail.gmail.com>
Subject: Re: [PATCH] iio: misc: add a generic regulator driver
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--poi24u4kh3yy7qdm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 23, 2016 at 01:56:11PM +0100, Geert Uytterhoeven wrote:
> On Fri, Dec 23, 2016 at 12:35 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> > cooperation between kernel- and userspace. Kernelspace offering an interface
> > to export a device for userspace access and userspace making use of that
> > interface to request access to a device. In a similar way to how vfio is
> > structured.

...

> We do not have bindings to describe GPIOs connected to e.g. relays.

Well, it depends what the relays are doing in the system of course...

> Switching external devices (the internals of those devices not described
> itself in DT, like in an industrial context), sounds more like something to
> be handled by IIO, doesn't it?

The BayLibre ACME systems have a case like this with their power
metering stuff (I've got a similar but more overenginered board I'm in
theory working on with actual relays).  The system itself is controlling
a power line, it knows nothing about what's connected.  It seems like
this is coming up often enough that someone should probably just write
an external system control binding, also tying in things like references
to the console and so on.

--poi24u4kh3yy7qdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhuNVoACgkQJNaLcl1U
h9Atdgf/WDPBaWtTJTwLBt9L5yArvrFOC69azq9epeF9ybv1x6KW1PI7EsmMeQSd
nAFUykUou3IgAmlWM/JgKlcKVE25xf/S3DskIrMRLd4XkvFQiFPzk2Ng80+NTQGk
Yy+EejiMxiLDb5rRsuwTjf5kVxq1klfQ2qOWpM7rAmTk50d4lr+FXa6AOPS00UkN
IBCMo0PIAe+Xg3mXvk9TsLwF8na446BJKho8uT96hoV7k8kdcOdzG4pwhALJU6js
cwNixNs8UX66WgqXsJE50sM3b5iajKS8Fj+QQkeTn5Lx/rExu5qOCFz/RUIDTAtj
WDsyNdrCLrlKtXn4rSZi14qaEEjH/A==
=aMkk
-----END PGP SIGNATURE-----

--poi24u4kh3yy7qdm--
