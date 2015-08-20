Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33869 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbbHTXxv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2015 19:53:51 -0400
Date: Thu, 20 Aug 2015 18:53:41 -0500
From: Michael Welling <mwelling@ieee.org>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Andrea Galbusera <gizero@gmail.com>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Manfred Schlaegl <manfred.schlaegl@gmx.at>,
	=?iso-8859-1?Q?S=F8ren?= Andersen <san@rosetechnology.dk>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH 13/18] iio: adc: mcp320x: Set struct spi_driver
 .of_match_table
Message-ID: <20150820235340.GA31967@deathstar>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-14-git-send-email-javier@osg.samsung.com>
 <20150820200912.GA2866@deathstar>
 <55D64E80.4050502@osg.samsung.com>
 <20150820222906.GB28249@deathstar>
 <55D65937.6070909@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55D65937.6070909@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Aug 21, 2015 at 12:48:23AM +0200, Javier Martinez Canillas wrote:
> Hello Michael,
> 
> On 08/21/2015 12:29 AM, Michael Welling wrote:
> > On Fri, Aug 21, 2015 at 12:02:40AM +0200, Javier Martinez Canillas wrote:
> >> Hello Michael,
> >>
> >> On 08/20/2015 10:09 PM, Michael Welling wrote:
> >>> On Thu, Aug 20, 2015 at 09:07:26AM +0200, Javier Martinez Canillas wrote:
> >>>> The driver has an OF id table but the .of_match_table is not set so
> >>>> the SPI core can't do an OF style match and the table was unused.
> >>>>
> >>>
> >>> Is an OF style match necessary?
> >>>
> >>
> >> Did you read the cover letter [0] on which I explain why is needed to
> >> avoid breaking module autoloading in the future? Once the SPI core is
> >> changed by RFC patch 18/18? (you were cc'ed in the cover letter BTW).
> > 
> > Well I have read it now. :)
> >
> 
> Great :)
>  
> >>
> >>> I have been using devicetree and it matches based on the .id_table.
> >>>
> >>
> >> Yes it fallbacks to the .id_table or the driver name but the correct
> >> thing to do for devices registered by OF, is to match using the
> >> compatible string.
> >>
> >>> Couldn't we just remove the mcp320x_dt_ids table instead?
> >>>
> >>
> >> No, that is the wrong thing to do IMHO since the compatible string
> >> contains both vendor and device name whle the .id_table only contains
> >> a device name.
> >>
> >> So it makes sense to match using the compatible string and also report
> >> the OF modalias information to user-space.
> >>
> >> Otherwise what's the point of the vendor in the compatible string for
> >> SPI devices? You can just use "bar" instead of "foo,bar" as a string.
> >>
> > 
> > Well then shouldn't the patch include adding the vendor to the compatible
> > string?
> >
> 
> Well, I was talking in general. You are right that this specific driver does
> not have a vendor prefix for the compatible strings. This is incorrect
> according to the ePAPR document [0].
> 
> However, these compatible strings are already documented as a DT binding doc
> in Documentation/devicetree/bindings/iio/adc/mcp320x.txt so I don't know
> what is the correct thing to do in this situation.
> 
> Changing the compatible string will break old DTB with newer kernels and that
> is a no go. But that doesn't invalidate what I said since once the SPI core
> is changed and report OF modalias, you will need a MODULE_DEVICE_TABLE(of,...)
> regardless if the compatible string has a vendor prefix or not.
>

Okay.

Acked-by: Michael Welling <mwelling@ieee.org>
 
> [0]: https://www.power.org/documentation/epapr-version-1-1/
> 
> Best regards,
> -- 
> Javier Martinez Canillas
> Open Source Group
> Samsung Research America
