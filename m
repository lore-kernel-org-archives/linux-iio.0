Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbeKLC4R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 21:56:17 -0500
Date: Sun, 11 Nov 2018 17:07:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Chris Coffey <cmc@babblebit.net>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] iio: potentiometer: Add driver for Microchip
 MCP41xxx/42xxx
Message-ID: <20181111170708.5dbda253@archlinux>
In-Reply-To: <1d5f47e8-b69c-e40f-9b4f-7423ee485747@axentia.se>
References: <20181106113130.9612-1-cmc@babblebit.net>
        <6f3ead94-b1ed-900d-b675-3822d67dbfd7@axentia.se>
        <20181111145530.2463b9c3@archlinux>
        <1d5f47e8-b69c-e40f-9b4f-7423ee485747@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 11 Nov 2018 16:49:28 +0000
Peter Rosin <peda@axentia.se> wrote:

> On 2018-11-11 15:55, Jonathan Cameron wrote:
> > On Tue, 6 Nov 2018 16:37:11 +0000
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> Hi!
> >>
> >> Some comments inline...  
> > A few additions from me.  
> 
> *snip*
> 
> >>> +	data = iio_priv(indio_dev);
> >>> +	spi_set_drvdata(spi, indio_dev);
> >>> +	data->spi = spi;
> >>> +	data->cfg = &mcp41010_cfg[devid];    
> >>
> >> I'm missing a "of_device_get_match_data(dev)" call somewhere in here, see e.g. the
> >> max5481.c file in this directory. Yes, that's missing from the mcp4131 driver as
> >> well, but that's not a valid reason for not doing it here AFAICT...  
> > If you want to use the data elements from the devicetree bindings you'll need
> > to do that.  However, there is an odd path that actually means it will fall back
> > to getting the right thing as you have it here.
> > spi_get_device_id calls spi_match_id which compares the sdev->modalias
> > with the id table names.  modalias has been carefully constructed
> > to be the text after the comma only and as such this works as is.
> > 
> > Perhaps it's neater though to just use the devicetree access functions.  
> 
> Isn't that part about not looking at the vendor-part of the DT-compatible slightly
> fragile? Or will modalias/chip-number clashes be detected by something?
Yes :)

Well actually in this case not so bad.

It will use a match on the of_device_id to find which driver to probe if there is
one. The modalias part is only being abused to then figure out which device we
have within the driver.

I definitely prefer the explicit route.  Just wanted to point out it 'worked'
:)

> 
> Cheers,
> Peter
