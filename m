Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Pandruvada, Srinivas"
	<srinivas.pandruvada@intel.com>, "Reus, Adriana" <adriana.reus@intel.com>
Subject: RE: [PATCH 0/2] bmc150-accel driver optimizations
Date: Fri, 20 Feb 2015 12:05:45 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A20DE0@irsmsx105.ger.corp.intel.com>
References: <1424110621-16571-1-git-send-email-irina.tirdea@intel.com>
 <alpine.DEB.2.02.1502162026470.26763@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1502162026470.26763@pmeerw.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-owner@vger.kernel=
.org] On Behalf Of Peter Meerwald
> Sent: 16 February, 2015 21:27
> To: Tirdea, Irina
> Cc: Jonathan Cameron; linux-iio@vger.kernel.org; linux-kernel@vger.kernel=
.org; Pandruvada, Srinivas; Reus, Adriana
> Subject: Re: [PATCH 0/2] bmc150-accel driver optimizations
>=20
>=20
> > Adds optimization of i2c transactions in trigger handler and
> > usage of available_scan_masks for bmc150-accel.
>=20
> same comments as for kxcjk-1013, this changes the capabilities of the
> driver
>=20
Will fix the comments for all the patchsets.

Thanks,
Irina

> > Irina Tirdea (2):
> >   iio: accel: bmc150: use available_scan_masks
> >   iio: accel: bmc150: optimize i2c transfers in trigger handler
> >
> >  drivers/iio/accel/bmc150-accel.c | 49 +++++++++++++++++++++++++++++++-=
--------
> >  1 file changed, 38 insertions(+), 11 deletions(-)
> >
> >
>=20
> --
>=20
> Peter Meerwald
> +43-664-2444418 (mobile)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
