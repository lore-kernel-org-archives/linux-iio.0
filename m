Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/8] Fixes for the mma9553 driver
Date: Mon, 13 Apr 2015 13:42:22 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A4F59D@irsmsx105.ger.corp.intel.com>
References: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com>
 <55265ECB.5020500@kernel.org>
In-Reply-To: <55265ECB.5020500@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-owner@vger.kernel=
.org] On Behalf Of Jonathan Cameron
> Sent: 09 April, 2015 14:13
> To: Tirdea, Irina; linux-iio@vger.kernel.org; Hartmut Knaack
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/8] Fixes for the mma9553 driver
>=20
> On 08/04/15 15:37, Irina Tirdea wrote:
> > This is a set of follow-up patches for the mma9553 driver that fixes
> > some issues as suggested by Hartmut.
> >
> > I have also added the enable channel for activity as suggested by Danie=
l.
> >
> > Irina Tirdea (8):
> >   iio: accel: mma9553: coding style fixes
> >   iio: accel: mma9553: use unsigned counters
> >   iio: accel: mma9553: fix gpio bitnum init value
> >   iio: accel: mma9553: refactor mma9553_read_activity_stepcnt
> >   iio: accel: mma9553: refactor mma9553_read_raw
> >   iio: accel: mma9553: check input value for activity period
> >   iio: accel: mma9551_core: prevent buffer overrun
> >   iio: accel: mma9553: add enable channel for activity
> >
> >  drivers/iio/accel/mma9551_core.c |  58 ++++++----
> >  drivers/iio/accel/mma9551_core.h |   2 +-
> >  drivers/iio/accel/mma9553.c      | 227 +++++++++++++++++--------------=
--------
> >  3 files changed, 136 insertions(+), 151 deletions(-)
> >
> Hi Irina,
Hi Jonathan,
>=20
> We've missed the merge window, so these are going to mostly hit one cycle
> after the original driver posting.
>=20
> As such can you reorder the patches to pull all the bug fixes to the begi=
nning
> as they can go into 4.1 whereas the style fixes etc will go into 4.2
> --

Sure, I'll reorder the series and send v2.

Thanks,
Irina

> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
