Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54031 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751710AbdK0LmX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Nov 2017 06:42:23 -0500
Date: Mon, 27 Nov 2017 13:35:44 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Marc CAPDEVILLE <m.capdeville@no-log.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v4] iio : Add cm3218 smbus ara and acpi support
Message-ID: <20171127113544.GI22431@lahna.fi.intel.com>
References: <20171027161426.m27e52jvnpgembsu@azrael>
 <20171102143550.00005a66@huawei.com>
 <20171102150407.bparxxskfo5pzvvs@ninjato>
 <20171119163551.5d52dec5@archlinux>
 <20171120105756.GC22431@lahna.fi.intel.com>
 <20171125140034.10d6e581@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171125140034.10d6e581@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Nov 25, 2017 at 02:00:34PM +0000, Jonathan Cameron wrote:
> > There does not seem to be any way in ACPI to tell which "connection" is
> > used to describe ARA so that part currently is something each driver
> > needs to handle as they know the device the best. I don't think we have
> > any means to handle it in generic way in I2C core except to provide some
> > helpers that work on top of i2c_setup_smbus_alert() but understand ACPI
> > resources. Say provide function like this:
> > 
> >   int acpi_i2c_setup_smbus_alert(struct i2c_adapter *adapter, int index);
> > 
> > Which then extracts automatically I2cSerialBus connection from "index"
> > and calls i2c_setup_smbus_alert() accordingly.
> > 
> > In the long run we could introduce _DSD property that can be used to
> > name the connection in the same way DT does;
> > 
> >     Name (_CRS, ResourceTemplate () {
> >         I2cSerialBus () { ... } // ARA
> >         I2cSerialBus () { ... } // normal device address
> >     })
> > 
> >     Name (_DSD, Package () {
> >         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >         Package () {
> >             Package () {"smbus_alert", 0} // Where 0 means the first I2cSerialBus
> >             ...
> >         }
> >     })
> > 
> > But it does not help the existing systems.
> 
> I'm curious - how would we go about promoting this piece of common sense?

I guess a proper patch series including relevant mailing lists (like
linux-acpi and linux-i2c) would be a good starting point :)
