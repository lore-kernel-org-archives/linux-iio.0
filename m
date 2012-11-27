Return-Path: <rachna@ti.com>
From: "Patil, Rachna" <rachna@ti.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Landley
	<rob@landley.net>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring
	<rob.herring@calxeda.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Jonathan
 Cameron <jic23@cam.ac.uk>
Subject: RE: [PATCH RESEND 3/7] input: ti_am335x_tsc: Add variance filter
Date: Tue, 27 Nov 2012 07:07:12 +0000
Message-ID: <4CE347531D4CA947960AF71FF095B9323E96FBB2@DBDE01.ent.ti.com>
References: <1352271124-5513-1-git-send-email-rachna@ti.com>
 <1352271124-5513-4-git-send-email-rachna@ti.com>
 <20121121183350.GB18950@core.coreip.homeip.net>
In-Reply-To: <20121121183350.GB18950@core.coreip.homeip.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, Nov 22, 2012 at 00:03:50, Dmitry Torokhov wrote:
> Hi Rachna,

Hi Dmitry,

>=20
> On Wed, Nov 07, 2012 at 12:22:00PM +0530, Patil, Rachna wrote:
> > Only fine tuning variance parameter present in tslib utility does not=20
> > help in removing all the ADC noise.
> > This logic of filtering is necessary to get this touchscreen to work=20
> > finely.
>=20
> No, if filtering in tslib is not adequate please fix tslib so that your w=
ork is usable for other devices as well.

For now I will drop this patch from the patch set and send across the next =
version of the set with review comments on remaining patches addressed.
I will take up tslib separately.

Regards,
Rachna

>=20
> Thanks.
>=20
> --
> Dmitry
>=20
