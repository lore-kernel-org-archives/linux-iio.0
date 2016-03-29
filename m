Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:52882 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbcC2MbZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Mar 2016 08:31:25 -0400
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"Lars-Peter Clausen" <lars@metafoo.de>,
	Markus Pargmann <mpa@pengutronix.de>
Subject: RE: [PATCH 1/1] iio: accel: bmc150: fix endianness when reading axes
Date: Tue, 29 Mar 2016 12:31:05 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F2158E4@irsmsx105.ger.corp.intel.com>
References: <1459185141-18319-1-git-send-email-irina.tirdea@intel.com>
 <alpine.DEB.2.02.1603281937390.4312@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1603281937390.4312@pmeerw.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-owner@vger.kernel.org] On Behalf Of Peter Meerwald-Stadler
> Sent: 28 March, 2016 20:43
> To: Tirdea, Irina
> Cc: Jonathan Cameron; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Hartmut Knaack; Lars-Peter Clausen; Markus
> Pargmann
> Subject: Re: [PATCH 1/1] iio: accel: bmc150: fix endianness when reading axes
> 
> On Mon, 28 Mar 2016, Irina Tirdea wrote:
> 
> > For big endian platforms, reading the axes will return
> > invalid values.
> >
> > The device stores each axis value in a 16 bit little
> > endian register. The driver uses regmap_read_bulk to get
> > the axis value, resulting in a 16 bit little endian value.
> > This needs to be converted to cpu endianness to work
> > on big endian platforms.
> >
> > Fix endianness for big endian platforms by converting
> > the values for the axes read from little endian to
> > cpu.
> >
> > This is also partially fixed in commit b6fb9b6d6552 ("iio:
> > accel: bmc150: optimize transfers in trigger handler").
> 
> looks good
> 
> in bmc150_accel_get_axis() the call to regmap_bulk_read() could now pass
> sizeof(raw_val) instead of 2
> 

Yes, that would look better. I'll send a new version with this change.

Thanks,
Irina

