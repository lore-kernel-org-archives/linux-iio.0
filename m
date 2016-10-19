Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:35382 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941301AbcJSOWd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 Oct 2016 10:22:33 -0400
Date: Wed, 19 Oct 2016 09:04:51 -0400
From: Brian Masney <masneyb@onstation.org>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iio: light: tsl2583: use DEVICE_ATTR_{RO, RW, WO}
 macros
Message-ID: <20161019130451.GC6741@basecamp.onstation.org>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
 <1476873130-24926-3-git-send-email-masneyb@onstation.org>
 <alpine.DEB.2.02.1610191244390.29572@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1610191244390.29572@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 19, 2016 at 12:47:13PM +0200, Peter Meerwald-Stadler wrote:
> 
> > Use the DEVICE_ATTR_RO, IIO_DEVICE_ATTR_RW, and IIO_DEVICE_ATTR_WO
> > macros to create the device attributes.
> 
> great that you work on cleaning this up!
> 
> the patch does a bit more than is claimed, it also renames stuff; 
> eventually, a proper prefix ('tsl2583_') should be used...

We can't have the tsl2583_ prefix on the function with the
DEVICE_ATTR_{RW,RO,WO} macros. drivers/acpi/nfit/core.c is one of many
examples of this.

I will submit a separate patch to fix the prefix on the other functions
when I get to code style cleanups in that driver.

> maybe you can unify the two files in this patch series?
> ./staging/iio/Documentation/sysfs-bus-iio-light-tsl2583
> ./staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
> 
> Suggested-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> :-)

I'll add that to my list.

There are plenty of other issues to fix in this driver and I'll have
more cleanup patches. I was at a good stopping point and wanted to send
out what I had so far to get feedback. I should have let the patch series
sit for a day before I sent it out.

Brian

