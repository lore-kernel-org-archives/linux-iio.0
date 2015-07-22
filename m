Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	"Dogaru, Vlad" <vlad.dogaru@intel.com>
Subject: RE: [PATCH 0/8] bmc150_magn fix and cleanup
Date: Wed, 22 Jul 2015 14:50:06 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F06CFCA@irsmsx105.ger.corp.intel.com>
References: <cover.1437090791.git.knaack.h@gmx.de>
 <1F3AC3675D538145B1661F571FE1805F2F06BB5B@irsmsx105.ger.corp.intel.com>
 <55AD3471.3030606@kernel.org>
In-Reply-To: <55AD3471.3030606@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-owner@vger.kernel=
.org] On Behalf Of Jonathan Cameron
> Sent: 20 July, 2015 20:49
> To: Tirdea, Irina; Hartmut Knaack; linux-iio@vger.kernel.org
> Cc: Lars-Peter Clausen; Peter Meerwald; Dogaru, Vlad
> Subject: Re: [PATCH 0/8] bmc150_magn fix and cleanup
>=20
> On 20/07/15 18:30, Tirdea, Irina wrote:
> >
> >
> >> -----Original Message-----
> >> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
> >> Sent: 17 July, 2015 11:52
> >> To: linux-iio@vger.kernel.org
> >> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Tirdea, Irin=
a; Dogaru, Vlad
> >> Subject: [PATCH 0/8] bmc150_magn fix and cleanup
> >>
> >> Some issues I spotted during review of this driver. First three are qu=
ite
> >> obvious problems, the rest may be matter of taste or intended to stay
> >> in the original form. Opinions welcome.
> >>
> >
> > Hi Hartmut,
> >
> > Thanks for taking the time to cleanup these issues. I know you did not =
get
> > to review this code before merge, so I was expecting your feedback :)
> >
> > I see Jonathan has already merged some of the changes, so I'm just goin=
g
> > to reply to the rest.
> > I am fine with the first 4 changes which already got merged anyway.
> Feel free to offer comments on the rest as well.  I was on a bit of a rol=
l
> and not giving sufficient time to others to review these.  The
> 'obviously' correct are not always so obvious given patch 5!
>=20
> Sorry about that
>=20

No problem, Jonathan.=20
I did review the rest of the patches as well and they look good to me.

Thanks,
Irina

> Jonathan
> >
> > Thanks,
> > Irina
> >
> >> Hartmut Knaack (8):
> >>   iio:magnetometer:bmc150_magn: add regmap dependency
> >>   iio:magnetometer:bmc150_magn: sort entry alphabetically
> >>   iio:magnetometer:bmc150_magn: output intended variable
> >>   iio:magnetometer:bmc150_magn: replace magic value
> >>   iio:magnetometer:bmc150_magn: add error handling on gpio probe
> >>   iio:magnetometer:bmc150_magn: protect runtime_resume with mutex
> >>   iio:magnetometer:bmc150_magn: expand mutex in trigger_handler
> >>   iio:magnetometer:bmc150_magn: use descriptive name for mask
> >>
> >>  drivers/iio/magnetometer/Kconfig       | 32 ++++++++++++++++++-------=
-------
> >>  drivers/iio/magnetometer/Makefile      |  3 +--
> >>  drivers/iio/magnetometer/bmc150_magn.c | 31 ++++++++++++++++++++++---=
------
> >>  3 files changed, 41 insertions(+), 25 deletions(-)
> >>
> >> --
> >> 2.4.3
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
