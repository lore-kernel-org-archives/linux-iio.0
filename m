Return-Path: <SRS0=bS2f=5Y=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?iso-8859-1?Q?Br=FCns=2C_Stefan?= <Stefan.Bruens@rwth-aachen.de>
To: Jonathan Cameron <jic23@kernel.org>, "afd@ti.com" <afd@ti.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hartmut Knaack
	<knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, "Peter
 Meerwald-Stadler" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 3/3] iio: adc: Fix polling of INA219 conversion ready
 flag
Date: Mon, 19 Jun 2017 18:24:56 +0000
Message-ID: <1598491.c75bYYbHRJ@sbruens-linux>
References: <20170524000907.7788-1-stefan.bruens@rwth-aachen.de>
 <20170524205335.166b7085@kernel.org>
 <20170524205641.20252455@jic23.retrosnub.co.uk>
In-Reply-To: <20170524205641.20252455@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Mittwoch, 24. Mai 2017 21:56:54 CEST Jonathan Cameron wrote:
> On Wed, 24 May 2017 20:53:35 +0100
>=20
> Jonathan Cameron <jic23@kernel.org> wrote:
> > On Wed, 24 May 2017 02:09:07 +0200
> >=20
> > Stefan Br=FCns <stefan.bruens@rwth-aachen.de> wrote:
> > > While the INA226 has a conversion ready flag (CVRF) in the R/W
> > > Mask/Enable
> > > register with read-to-clear semantics, the corresponding bit of the
> > > INA219
> > > (CNVR) is part of the bus voltage register. The flag is cleared by
> > > reading
> > > the power register.
> > >=20
> > > Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>
> >=20
> > Again, looks good to me, but I would like input form Marc or Andrew
> > who are more familiar with these devices than me!
> >=20
> > Ping me in a week or two if nothing is happening and I look to have
> > lost these!
>=20
> Ah Marc's old email is bouncing.  If no one has a more up to
> data address I guess we'll be looking at Andrew to have a chance to
> respond (which is more likely if I actually cc him ;)

Ping ;-)

Kind regards,

Stefan=
