Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.208]:58306 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbcC2IvR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Mar 2016 04:51:17 -0400
Date: Tue, 29 Mar 2016 10:51:05 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: potentiometer: add driver for Microchip
 MCP413X/414X/415X/416X/423X/424X/425X/426X
Message-ID: <20160329085105.GA9826@x220>
References: <20160323085720.GA6836@x220>
 <56F946AA.9070203@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56F946AA.9070203@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mar 28, 2016 15:58, Jonathan Cameron wrote:
> On 23/03/16 08:57, Slawomir Stepien wrote:
> > The following functionalities are supported:
> >  - write, read from volatile memory
> > 
> > Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/22060b.pdf
> > 
> > Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> One process comment below... And git actually copes fine with what you
> did (I wondered which way it would go until I tried it :)

I did try it on my tree with git and it works so I decided to do it like that.
I'll drop the additional --- next time.

> Applied to the togreg branch of iio.git - initially pushed out as
> testing for the autobuilders to play pingpong with it.
> 
> A very nice, clean driver.  Thanks for your hard work on this.
> 
> Note it is in a branch I happy to rebase for the next week, so if Joachim
> in particular would like to add a reviewed by tag, I'd be delighted to append
> it.  Often reviewers don't get enough credit in my opinion!

Thank you all for the support and really good comments on this patch. I've
learned a lot!

> > ---
> > Changes since v4:
> > - Added necessary include files and sorted all includes
> > - Added missing mutex unlock when there is CMDERR
> > - mcp4131_write_raw spi_write/mutex_unlock/return refactor
> > 
> > Changes since v3:
> > - Added 'potentiometer' to subject
> > - Replaced mcp4131_exec with spi_write and mcp4131_read
> > - Narrowed mutex locking and unlocking places
> > 
> > Changes since v2:
> > - Removed unnecessary parentheses in MCP4131_WIPER_SHIFT macro
> > - Replaced the rx and tx SPI buffers with one buf that is ____cacheline_aligned
> > - Changed mutex locking position
> > - Replaced the devid with pointer to model configuration
> > - Removed positive ("Registered" & "Unregistered") dev_info prints
> > - Removed the mcp4131_remove callback
> > 
> > Changes since v1:
> > - One line summary changed
> > - Fixed module name and OF compatible
> > - Based code on Peter Rosin's code from mcp4531.c
> > - No additional sysfs attributes
> > - Deleted not used devid struct memeber
> > - Changed mcp4131_exec function arguments:
> >  - write value is now u16
> >  - no need to pass return buffer array - rx array from mcp4131_data is used
> > - Added missing new line characters to dev_info
> Funnily enough, this is the only thing I can find wrong in this patch.
> Should not introduce an additional --- as you have done here.
> The version stuff should simply have a blank line between it and the stats ;)

How about the MAINTAINER file? I wasn't sure if I should add myself as the M of
this driver...

-- 
Slawomir Stepien
