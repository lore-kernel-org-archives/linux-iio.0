Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hartmut
 Knaack" <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, "Peter
 Meerwald" <pmeerw@pmeerw.net>, Markus Pargmann <mpa@pengutronix.de>
Subject: RE: [PATCH 1/1] iio: accel: bmc150: remove unused definition
Date: Mon, 28 Mar 2016 16:08:44 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F2155BE@irsmsx105.ger.corp.intel.com>
References: <1458810056-24236-1-git-send-email-irina.tirdea@intel.com>
 <56F902A6.9020307@kernel.org>
In-Reply-To: <56F902A6.9020307@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: 28 March, 2016 13:09
> To: Tirdea, Irina; linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Hartmut Knaack; Lars-Peter Clausen; Pet=
er Meerwald; Markus Pargmann
> Subject: Re: [PATCH 1/1] iio: accel: bmc150: remove unused definition
>=20
> On 24/03/16 09:00, Irina Tirdea wrote:
> > bmc150_i2c_regmap_conf is defined in bmc150-accel-core.c, but
> > never used here. The definition is needed in bmc150-accel-i2c.c,
> > where it is again defined.
> >
> > Remove the unnecessary definition of bmc150_i2c_regmap_conf from
> > bmc150-accel-core.c and update the one from bmc150-accel-i2c.c
> > to contain all fields.
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Silly question.  Why isn't it shared between the i2c and spi drivers?
> Looks to be the same in both cases (as we'd expect from regmap most
> of the time!).  I think it would be better to share it.
>

Good point.  I'll keep the definition in the core file and share the regmap
with the rest.

Thanks,
Irina
