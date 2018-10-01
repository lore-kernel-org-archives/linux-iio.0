Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:13593 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729124AbeJAS5u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Oct 2018 14:57:50 -0400
Date: Mon, 1 Oct 2018 13:20:01 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Marek Vasut <marek.vasut@gmail.com>, <linux-iio@vger.kernel.org>,
        "Marek Vasut" <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Joe Perches <joe@perches.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: Fix Renesas GyroADC MAINTAINERS entry
Message-ID: <20181001132001.00007423@huawei.com>
In-Reply-To: <20181001121739.GB4134@kunai>
References: <20181001105804.17802-1-marek.vasut+renesas@gmail.com>
        <20181001115559.GA4134@kunai>
        <bc65ecfa-5135-5224-bdeb-938b3025c30c@gmail.com>
        <20181001121739.GB4134@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 1 Oct 2018 14:17:40 +0200
Wolfram Sang <wsa@the-dreams.de> wrote:

> On Mon, Oct 01, 2018 at 01:58:26PM +0200, Marek Vasut wrote:
> > On 10/01/2018 01:55 PM, Wolfram Sang wrote:  
> > > On Mon, Oct 01, 2018 at 12:58:04PM +0200, Marek Vasut wrote:  
> > >> Fix the F: entry in MAINTAINERS file, point it to the correct file.  
> > > 
> > > Right...
> > >   
> > >> @@ -12471,7 +12471,7 @@ RENESAS R-CAR GYROADC DRIVER
> > >>  M:	Marek Vasut <marek.vasut@gmail.com>
> > >>  L:	linux-iio@vger.kernel.org
> > >>  S:	Supported
> > >> -F:	drivers/iio/adc/rcar_gyro_adc.c
> > >> +F:	drivers/iio/adc/rcar-gyroadc.c  
> > > 
> > > Add the bindings, too?
> > > 
> > > Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
> > >   
> > Separate patch or V2 ?  
> 
> I'd say V2, but I am not the IIO maintainer.
> 
> 

v2 please given I haven't done anything with v1 yet.

Thanks,

Jonathan
