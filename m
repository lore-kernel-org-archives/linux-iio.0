Return-Path: <rachna@ti.com>
From: "Patil, Rachna" <rachna@ti.com>
To: Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>
CC: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Dmitry Torokhov <dtor@mail.ru>, Jonathan Cameron
	<jic23@cam.ac.uk>
Subject: RE: [PATCH v4 5/5] MFD: ti_tscadc: add suspend/resume functionality
Date: Wed, 3 Oct 2012 06:49:19 +0000
Message-ID: <4CE347531D4CA947960AF71FF095B9323E959D06@DBDE01.ent.ti.com>
References: <1348636814-14129-1-git-send-email-rachna@ti.com>
 <1348636814-14129-6-git-send-email-rachna@ti.com> <5062A373.4000707@ti.com>
 <4CE347531D4CA947960AF71FF095B9323E95738D@DBDE01.ent.ti.com>
 <5066C45B.3000500@kernel.org> <20120930232202.GF12231@sortiz-mobl>
In-Reply-To: <20120930232202.GF12231@sortiz-mobl>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Samuel,

Hi On Mon, Oct 01, 2012 at 04:52:02, Samuel Ortiz wrote:
> Hi Jonathan,
>=20
> On Sat, Sep 29, 2012 at 10:50:19AM +0100, Jonathan Cameron wrote:
> > On 09/26/2012 11:09 AM, Patil, Rachna wrote:
> > > Hi Shubhrajyoti,
> > >=20
> > > On Wed, Sep 26, 2012 at 12:10:51, Datta, Shubhrajyoti wrote:
> > >> On Wednesday 26 September 2012 10:50 AM, Patil, Rachna wrote:
> > >>> This patch adds support for suspend/resume of TSC/ADC MFDevice.
> > >> this should be merged with the patch adding support else we may end=
=20
> > >> up in a case where patch a does the runtime calls and the call back =
=20
> > >> handlers added later.
> > >=20
> > > I am adding both the runtime calls and the handlers in this patch.
> > > I think maintaining this as a separate patch in better in terms of=20
> > > readability as well.
> > I would prefer this merged into patch 4 as it's a simple addition to a=
=20
> > driver that should arguably have been there in the first place.
> I agree. And I would even go as far as saying that having all the MFD par=
ts from this patchset merged into patch #2 would make sense.
> Rachna, could you please re-work this patchset in such way, and adress my=
 comments on patch #2 ? I could then take the MFD parts and then Jonathan a=
nd Dmitry take their parts. There are build time dependencies, but neither =
the input nor the ADC driver could be actually built as long as the MFD one=
 is not merged (provided that the subdevices driver comes with the right Kc=
onfig dependecy).

I will re-work the patchset and address all the review comments accordingly=
.

Thanks & Regards,
Rachna

>=20
> Cheers,
> Samuel.
>=20
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/
>=20
