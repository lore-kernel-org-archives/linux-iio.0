Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbdKYO2o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 09:28:44 -0500
Date: Sat, 25 Nov 2017 14:28:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iio: proximity: sx9500: Assign interrupt from
 GpioIo()
Message-ID: <20171125142839.07d13031@archlinux>
In-Reply-To: <20171120103027.GA22431@lahna.fi.intel.com>
References: <20171103130340.42459-1-andriy.shevchenko@linux.intel.com>
        <20171104031119.00006e56@huawei.com>
        <20171106093556.GR2283@lahna.fi.intel.com>
        <20171119152411.12e4c7cb@archlinux>
        <20171120103027.GA22431@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 20 Nov 2017 12:30:27 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> On Sun, Nov 19, 2017 at 03:24:11PM +0000, Jonathan Cameron wrote:
> > On Mon, 6 Nov 2017 11:35:56 +0200
> > Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> >   
> > > On Sat, Nov 04, 2017 at 03:11:19AM +0000, Jonathan Cameron wrote:  
> > > > On Fri, 3 Nov 2017 15:03:36 +0200
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > >     
> > > > > The commit 0f0796509c07
> > > > > 
> > > > > ("iio: remove gpio interrupt probing from drivers that use a single
> > > > > interrupt")
> > > > > 
> > > > > removed custom IRQ assignment for the drivers which are enumerated via
> > > > > ACPI or OF. Unfortunately, some ACPI tables have IRQ line defined as
> > > > > GpioIo() resource and thus automatic IRQ allocation will fail.    
> > > > 
> > > > I'll ask the obvious question - is this allowed under the ACPI spec?    
> > > 
> > > Yes, it is perfectly fine.  
> > 
> > I'm unconvinced...
> >   
> > >   
> > > > > Partially revert the commit 0f0796509c07 to restore original
> > > > > behaviour.
> > > > > 
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>    
> > > > 
> > > > I really don't like scattering fixes for broken ACPI tables through
> > > > drivers...  Is there really no better solution to this?    
> > > 
> > > This is not about broken ACPI tables. We just currently have
> > > "convenience" stuff in the kernel that translates trivial things like a
> > > single ACPI GpioInt() resource directly to a device interrupt. If the
> > > table has multiple GpioInt()s or uses GpioIo() then it is up to the
> > > driver to handle device specific details.  
> > 
> > I agree on the multiple cases needing hanlding. 
> > What bothers me is that there is no guarantee at all that a GpioIo
> > can even do an interrupt.
> > 
> > (table 6.2.17 in the 6.1 spec for example makes it clear that we are
> > in a mess)  If it is a gpioio lots of the interrupt specific stuff
> > cannot be supplied (all the stuff in byte 7)
> > 
> > So as I read the ACPI specification any interrupt specified as GpioIO
> > is simply broken.  
> 
> Well, it is the same with DT if you just declare GPIOs as in "xxx-gpios"
> but still use them to trigger interrupts.
> 
> Normally you would use GpioInt in ACPI case but sometimes there might
> actually be need to use the GPIO as input/output without interrupts. I
> remember there was some I2C connected touchpanel that required some
> magic to be done when it was put to low power states. In those cases
> GpioIo is more correct IMHO.
> 
> It is also possible that the BIOS people just messed this up.
> 
> > > > On patches like this best to pull in ACPI and GPIO on the cc list.
> > > > 
> > > > Also cc'd Mika who made the original change to support gpioint.    
> > > 
> > > The patch looks fine to me,
> > > 
> > > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>  
> > 
> > I'll probably take it anyway to support the platforms doing this particular
> > piece of fun as doubtlessly the chance of fixing the firmware is next
> > to nothing...  
> 
> Thanks!
Not sure I actually replied to say I had applied this one to the fixes-togreg
branch of iio.git.  I certainly hadn't marked it as such locally and
just tried to apply it again ;)

Thanks,

Jonathan
