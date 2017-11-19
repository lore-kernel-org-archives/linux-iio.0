Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750895AbdKSQf4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 11:35:56 -0500
Date: Sun, 19 Nov 2017 16:35:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Marc CAPDEVILLE <m.capdeville@no-log.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4] iio : Add cm3218 smbus ara and acpi support
Message-ID: <20171119163551.5d52dec5@archlinux>
In-Reply-To: <20171102150407.bparxxskfo5pzvvs@ninjato>
References: <20171027161426.m27e52jvnpgembsu@azrael>
        <20171102143550.00005a66@huawei.com>
        <20171102150407.bparxxskfo5pzvvs@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 2 Nov 2017 16:04:07 +0100
Wolfram Sang <wsa@the-dreams.de> wrote:

> On Thu, Nov 02, 2017 at 02:35:50PM +0000, Jonathan Cameron wrote:
> > On Fri, 27 Oct 2017 18:27:02 +0200
> > Marc CAPDEVILLE <m.capdeville@no-log.org> wrote:
> >   
> > > On asus T100, Capella cm3218 chip is implemented as ambiant light
> > > sensor. This chip expose an smbus ARA protocol device on standard
> > > address 0x0c. The chip is not functional before all alerts are
> > > acknowledged.
> > > On asus T100, this device is enumerated on ACPI bus and the
> > > description give tow I2C connection. The first is the connection to
> > > the ARA device and the second gives the real address of the device.
> > > 
> > > So, on device probe,If the i2c address is the ARA address and the
> > > device is enumerated via acpi, we lookup for the real address in
> > > the ACPI resource list and change it in the client structure.
> > > if an interrupt resource is given, and only for cm3218 chip,
> > > we declare an smbus_alert device.
> > > 
> > > Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>  
> > 
> > Wolfram - this needs input from you on how to neatly handle
> > an ACPI registered ARA.  
> 
> ACPI is really not my field. Try asking the I2C ACPI maintainers or
> Benjamin Tissoires <benjamin.tissoires@redhat.com> who did work on SMBus
> interrupts recently.
> 
Hi Mika, Benjamin,

So we've lost most of the context in this thread, but the basic question
is how to handle smbus ARA support with ACPI. 

https://patchwork.kernel.org/patch/10030309/

Has the proposal made in this driver which is really not terribly nice
(as it registers the ARA device by messing with the address and registering
a second device).

As I understood it the ARA device registration should be handled by the
i2c master, but there are very few examples.

Phil pointed out that equivalent OF support recently got taken from him..
https://www.spinics.net/lists/devicetree/msg191947.html
https://www.spinics.net/lists/linux-i2c/msg31173.html

Any thoughts on the right way to do this?

Jonathan


