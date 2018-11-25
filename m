Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeKYXVc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Nov 2018 18:21:32 -0500
Date: Sun, 25 Nov 2018 12:30:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Coffey <cmc@babblebit.net>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>,
        Slawomir Stepien <sst@poczta.fm>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: potentiometer: Add driver for Microchip
 MCP41xxx/42xxx
Message-ID: <20181125123028.4b034d5a@archlinux>
In-Reply-To: <20181120222011.lgxzhnr5yefgkose@deb-660>
References: <20181120141713.9963-1-cmc@babblebit.net>
        <20181120141713.9963-3-cmc@babblebit.net>
        <alpine.DEB.2.21.1811201526550.17527@vps.pmeerw.net>
        <20181120222011.lgxzhnr5yefgkose@deb-660>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 20 Nov 2018 22:20:11 +0000
Chris Coffey <cmc@babblebit.net> wrote:

> On Tue, Nov 20, 2018 at 03:30:05PM +0100, Peter Meerwald-Stadler wrote:
> > On Tue, 20 Nov 2018, Chris Coffey wrote:
> > 
> > Hello,
> > 
> > some minor comments below, otherwise looks good
> > 
> > regards, p.
> >   
> 
> Hi Peter,
> 
> Thank you for the review. One comment below.
> 
> > > This patch adds driver support for the Microchip MCP41xxx/42xxx family
> > > of digital potentiometers:
> > > 
> > > DEVICE      Wipers  Positions   Resistance (kOhm)
> > > MCP41010    1       256         10
> > > MCP41050    1       256         50
> > > MCP41100    1       256         100
> > > MCP42010    2       256         10
> > > MCP42050    2       256         50
> > > MCP42100    2       256         100
> > > 
> > > Datasheet: http://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
> > > 
> > > Signed-off-by: Chris Coffey <cmc@babblebit.net>
> > > ---
> > >  drivers/iio/potentiometer/Kconfig    |  12 +++
> > >  drivers/iio/potentiometer/Makefile   |   1 +
> > >  drivers/iio/potentiometer/mcp41010.c | 204 +++++++++++++++++++++++++++++++++++
> > >  3 files changed, 217 insertions(+)
> > >  create mode 100644 drivers/iio/potentiometer/mcp41010.c
> > > 
> > > diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> > > index 79ec2eba49..6303cbe799 100644
> > > --- a/drivers/iio/potentiometer/Kconfig
> > > +++ b/drivers/iio/potentiometer/Kconfig
> > > @@ -90,6 +90,18 @@ config MCP4531
> > >  	  To compile this driver as a module, choose M here: the
> > >  	  module will be called mcp4531.
> > >  
> > > +config MCP41010
> > > +	tristate "Microchip MCP41xxx/MCP42xxx Digital Potentiometer driver"
> > > +	depends on SPI
> > > +	help
> > > +	  Say yes here to build support for the Microchip
> > > +	  MCP41010, MCP41050, MCP41100,
> > > +	  MCP42010, MCP42050, MCP42100
> > > +	  digital potentiometer chips.
> > > +
> > > +	  To compile this driver as a module, choose M here: the
> > > +	  module will be called mcp41010.
> > > +
> > >  config TPL0102
> > >  	tristate "Texas Instruments digital potentiometer driver"
> > >  	depends on I2C
> > > diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
> > > index 4af657883c..8ff55138cf 100644
> > > --- a/drivers/iio/potentiometer/Makefile
> > > +++ b/drivers/iio/potentiometer/Makefile
> > > @@ -11,4 +11,5 @@ obj-$(CONFIG_MAX5487) += max5487.o
> > >  obj-$(CONFIG_MCP4018) += mcp4018.o
> > >  obj-$(CONFIG_MCP4131) += mcp4131.o
> > >  obj-$(CONFIG_MCP4531) += mcp4531.o
> > > +obj-$(CONFIG_MCP41010) += mcp41010.o
> > >  obj-$(CONFIG_TPL0102) += tpl0102.o
> > > diff --git a/drivers/iio/potentiometer/mcp41010.c b/drivers/iio/potentiometer/mcp41010.c
> > > new file mode 100644
> > > index 0000000000..4a91066cb1
> > > --- /dev/null
> > > +++ b/drivers/iio/potentiometer/mcp41010.c
> > > @@ -0,0 +1,204 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Industrial I/O driver for Microchip digital potentiometers
> > > + *
> > > + * Copyright (c) 2018 Chris Coffey <cmc@babblebit.net>
> > > + * Based on: Slawomir Stepien's code from mcp4131.c
> > > + *
> > > + * Datasheet: http://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf
> > > + *
> > > + * DEVID	#Wipers	#Positions	Resistance (kOhm)
> > > + * mcp41010	1	256		10
> > > + * mcp41050	1	256		50
> > > + * mcp41100	1	256		100
> > > + * mcp42010	2	256		10
> > > + * mcp42050	2	256		50
> > > + * mcp42100	2	256		100
> > > + */
> > > +
> > > +#include <linux/cache.h>
> > > +#include <linux/err.h>
> > > +#include <linux/export.h>  
> > 
> > wondering if export.h is needed?
> >   
> 
> You're right; turns out it's not needed. I'll fix this in v4.
> 
> [snip]
Given both the issues Peter raised were trivial and I couldn't
see any others, I've applied this with the changes Peter suggested.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
