Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3 V2] IIO: Add basic MXS LRADC driver
Date: Mon, 6 Aug 2012 05:53:50 +0200
Cc: linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Jonathan Cameron <jic23@kernel.org>,
 Juergen Beisert <jbe@pengutronix.de>,
 "Lars-Peter Clausen" <lars@metafoo.de>,
 Wolfgang Denk <wd@denx.de>
References: <1344007721-11595-1-git-send-email-marex@denx.de> <1344007721-11595-3-git-send-email-marex@denx.de> <20120806023743.GC18471@S2101-09.ap.freescale.net>
In-Reply-To: <20120806023743.GC18471@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201208060553.50398.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Shawn Guo,

> On Fri, Aug 03, 2012 at 05:28:40PM +0200, Marek Vasut wrote:
> > --- /dev/null
> > +++ b/drivers/staging/iio/adc/mxs-lradc.c
> 
> <snip>
> 
> > +#include <mach/mxs.h>
> > +#include <mach/common.h>
> > +
> 
> Why do you need these two mach headers?

Might be just some remnant ... any further comments please?

Best regards,
Marek Vasut
