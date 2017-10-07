Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:35997 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbdJGJNO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Oct 2017 05:13:14 -0400
Date: Sat, 7 Oct 2017 11:13:12 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>,
        "Andrew F. Davis" <afd@ti.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/2] iio: dac: Add Texas Instruments 8/10/12-bit
 2/4-channel DAC driver
Message-ID: <20171007091312.GA6890@wunner.de>
References: <cceeb1a985343d36dc90d2708371f3e1a73264f6.1504602350.git.lukas@wunner.de>
 <5d861035569248ac4ae971638ce7fd1e50947232.1504602350.git.lukas@wunner.de>
 <20170910161108.2ecc34d3@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170910161108.2ecc34d3@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Sep 10, 2017 at 04:11:08PM +0100, Jonathan Cameron wrote:
> On Tue, 5 Sep 2017 11:27:00 +0200 Lukas Wunner <lukas@wunner.de> wrote:
> > The DACrrcS085 (rr = 08/10/12, c = 2/4) family of SPI DACs was
> > inherited by TI when they acquired National Semiconductor in 2011.
> 
> Very nice.  A few really minor comments inline.

D'accord on all your comments except this one:


> > +	ret = sscanf(spi->modalias, "dac%2hhu%1d",
> > +		     &ti_dac->resolution, &indio_dev->num_channels);
> > +	WARN_ON(ret != 2);
> 
> Whilst this seems nice and clear now, it may not work if this driver
> had additional parts added in future. 
> 
> I would prefer an explicit table with this information in it and
> use an enum to reference into it.
> 
> This is a bit 'too clever' :)

Hm, I looked at the other SPI DACs available from TI and their programming
interface is sufficiently different that they don't lend themselves all
too well for integration into this driver.  There might be DACs from other
vendors with a similar programming interface.

What I *could* do is encode the resolution and number of channels in the
driver_data field of the spi MODULE_DEVICE_TABLE like this:

static const struct spi_device_id ti_dac_spi_id[] = {
	{ "dac082s085",  8 << 8 + 2 },
	{ "dac102s085", 10 << 8 + 2 },
	...

Then instead of reading the information from the modalias I'd read them
from driver_data.  However it looks a bit redundant and silly to me.
Can we add this extra complexity when the need for it actually arises?

Thanks,

Lukas
