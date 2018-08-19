Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbeHSWZM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Aug 2018 18:25:12 -0400
Date: Sun, 19 Aug 2018 20:12:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, eraretuya@gmail.com,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] iio: adxl345: move null check for i2c id at start of
 probe
Message-ID: <20180819201238.28db4b58@archlinux>
In-Reply-To: <20180819185458.GA15660@himanshu-Vostro-3559>
References: <20180807140605.19156-1-alexandru.ardelean@analog.com>
        <20180811101833.GA5243@himanshu-Vostro-3559>
        <20180819183132.4f785935@archlinux>
        <20180819174309.GA14393@himanshu-Vostro-3559>
        <d0598278-31b6-8b47-6106-259b1d287e42@metafoo.de>
        <20180819185458.GA15660@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 20 Aug 2018 00:24:58 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Sun, Aug 19, 2018 at 07:59:38PM +0200, Lars-Peter Clausen wrote:
> > On 08/19/2018 07:43 PM, Himanshu Jha wrote:  
> > > On Sun, Aug 19, 2018 at 06:31:32PM +0100, Jonathan Cameron wrote:  
> > >> On Sat, 11 Aug 2018 15:48:33 +0530
> > >> Himanshu Jha <himanshujha199640@gmail.com> wrote:
> > >>  
> > >>> On Tue, Aug 07, 2018 at 05:06:05PM +0300, Alexandru Ardelean wrote:  
> > >>>> Fixes ef89f4b96a2 ("iio: adxl345: Add support for the ADXL375").
> > >>>>
> > >>>> This was found via static checker.
> > >>>> After looking into the code a bit, it's unlikely that there will be a NULL
> > >>>> dereference if the `id` object in that specific code path.
> > >>>> However, it's safe to add a NULL (paranoid) check just to make sure and
> > >>>> remove any uncertainties.    
> > >>>
> > >>> I would like to know when would that case happen actually ?
> > >>>
> > >>> Because probe will only be called only when a match occurs either
> > >>> through DT or id matching. Isn't it ?
> > >>>  
> > >> Yes. Alternative would have just not been to check it, but this is fine
> > >> so applied. I'm not going to rush this through stable though given
> > >> I don't think it can actually happen.  
> > > 
> > > Thanks for the confirmation.
> > > 
> > > So, I have another doubt and it seems to be right time to ask.
> > > 
> > > BME680 currently supports both ACPI matching and traditional ID
> > > matching. So, it there any priority list to which patch the driver
> > > would choose to match the device.
> > > 
> > > ACPI > ID matching ? (In my case this happens)
> > > 
> > > Because this matching tends to decide the `name` attribute of loaded
> > > driver.
> > > 
> > > For ACPI: BME0680 (not sure maybe it was I2C0:BME0680)
> > > For ID: bme680  
> > 
> > Yeah, that's wrong. But pretty much all ACPI drivers have that issue.
> > Maybe we should just deprecate the name attribute.  
> 
> libiio is the most affected due to this issue as I can figure out.
> Particularly, the iio_device_get_name() api:
> https://analogdevicesinc.github.io/libiio/group__Context.html#gae5807303b638869679ece67270e72e77
> 

Yeah, the name thing was one of those ones that got away from us a long
time ago and became ABI in far too many drivers.  The 'intent' was
that it would just provide a convenient "what's this part?" sysfs
attribute, so should always return the part number rather than anything
to do with any of the bindings.  Unfortunately it often doesn't.

We could add a new attribute called something like 'part_number'
as then it should be more obvious what the intent is an hopefully it'll
get used right.

Jonathan
