Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.babblebit.net ([37.139.8.208]:38256 "EHLO
        mail.babblebit.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeKGSyh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Nov 2018 13:54:37 -0500
Date: Wed, 7 Nov 2018 09:25:04 +0000
From: Chris Coffey <cmc@babblebit.net>
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] iio: potentiometer: Add driver for Microchip
 MCP41xxx/42xxx
Message-ID: <20181107092503.z3tdakbsckj2nwns@deb-660>
References: <20181106113130.9612-1-cmc@babblebit.net>
 <6f3ead94-b1ed-900d-b675-3822d67dbfd7@axentia.se>
 <afc9d11f-b4bf-fe74-bb9d-417c6f29ea9a@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <afc9d11f-b4bf-fe74-bb9d-417c6f29ea9a@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 06, 2018 at 08:08:15PM +0000, Peter Rosin wrote:
> On 2018-11-06 17:37, Peter Rosin wrote:
> > Hi!
> > 
> > Some comments inline...
> > 

[snip]

> >> +
> >> +	data->buf[0] = MCP41010_WIPER_ENABLE << channel;
> >> +	data->buf[0] |= MCP41010_WRITE;
> > 
> > Will this not clobber the other channel for mcp42xxx chips???
> 
> 
> I had a peak in the datasheet, and no, it will not. It was just the naming
> with ..._WIPER_ENABLE that threw me off. It assumed, from the naming, that
> each channel has a separate enable bit in the command byte and that you
> were required to keep the state of those intact for each and every command
> you sent. After looking at the datasheet, that is obviously not the case,
> and the code is fine. But may I ask for a change in naming here?
> 
> MCP41010_WIPER_CHANNEL instead of MCP41010_WIPER_ENABLE perhaps?
> 
> Cheers,
> Peter
> 

I agree -- my naming for this is indeed ambiguous/confusing. I'll
change it for v2.

Thanks again,
Chris
