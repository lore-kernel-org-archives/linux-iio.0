Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24942 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942AbbBTMDm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 20 Feb 2015 07:03:42 -0500
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
	"Reus, Adriana" <adriana.reus@intel.com>
Subject: RE: [PATCH 0/2] kxcjk-1013 driver optimizations
Date: Fri, 20 Feb 2015 12:03:38 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A20DB9@irsmsx105.ger.corp.intel.com>
References: <1424110909-16878-1-git-send-email-irina.tirdea@intel.com>
 <alpine.DEB.2.02.1502162011090.26763@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1502162011090.26763@pmeerw.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Peter Meerwald [mailto:pmeerw@pmeerw.net]
> Sent: 16 February, 2015 21:14
> To: Tirdea, Irina
> Cc: Jonathan Cameron; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Pandruvada, Srinivas; Reus, Adriana
> Subject: Re: [PATCH 0/2] kxcjk-1013 driver optimizations
> 
> 
> > Adds optimization of i2c transactions in trigger handler and
> > usage of available_scan_masks for kxcjk-1013.
> 
> the 'optimization' changes the capabilities of the driver, reading
> individual channel is not possible anymore
> 
We can still read individual channels, just that the driver does not see that anymore and the demux is handled by the iio core.
available_scan_masks contains the bitmap superset for all channels we can enable (I will remove the 0 available_scan_mask as it does not makes sense).
When a new channel is enabled, the iio core checks if the new mask is a subset of any entry in available_scan_masks. When the buffer is pushed from the driver, the iio core will select only the enabled channel values.

> > Adriana Reus (2):
> >   iio: accel: kxcjk-1013: use available_scan_masks
> >   iio: accel: kxcjk-1013: optimize i2c transfers in trigger handler
> >
> >  drivers/iio/accel/kxcjk-1013.c | 50 ++++++++++++++++++++++++++++++++----------
> >  1 file changed, 39 insertions(+), 11 deletions(-)
> >
> >
> 
> --
> 
> Peter Meerwald
> +43-664-2444418 (mobile)
