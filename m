Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdKSQDX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 11:03:23 -0500
Date: Sun, 19 Nov 2017 16:03:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Joel Stanley <joel@jms.id.au>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Rick Altherr <raltherr@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: aspeed: Deassert reset in probe
Message-ID: <20171119160318.41d7e85a@archlinux>
In-Reply-To: <20171102144932.00001e17@huawei.com>
References: <20171031021203.18248-1-joel@jms.id.au>
        <CA+gwMcdVpq1P5kWAWzkg2A+Ah-fKyTk0adhGdg4465gkOY3EKA@mail.gmail.com>
        <CACPK8Xc1d89MXBjSJw7Jz0oqkCcoxKbymaVDmJq-kHFK6qG0Sw@mail.gmail.com>
        <20171102144932.00001e17@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 2 Nov 2017 14:49:32 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Wed, 1 Nov 2017 10:15:32 +1030
> Joel Stanley <joel@jms.id.au> wrote:
> 
> > On Tue, Oct 31, 2017 at 10:28 PM, Philipp Zabel
> > <philipp.zabel@gmail.com> wrote:  
> > > On Tue, Oct 31, 2017 at 3:12 AM, Joel Stanley <joel@jms.id.au>
> > > wrote:    
> > >> The ASPEED SoC must deassert a reset in order to use the ADC
> > >> peripheral.
> > >>
> > >> The device tree bindings are updated to document the resets
> > >> phandle, and the example is updated to match what is expected for
> > >> both the reset and clock phandle. Note that the bindings should
> > >> have always had the reset controller, as the hardware is unusable
> > >> without it.
> > >>
> > >> Signed-off-by: Joel Stanley <joel@jms.id.au>    
> > >
> > > It is unfortunate that this has to break DT (theoretical) backwards
> > > compatibility, but given that the old bindings never worked,
> > > this is better than to pretend a required reset is optional.
> > >
> > > Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>    
> > 
> > Thanks. I agree that it's unfortunate; this has been my first time
> > working on an ARM SoC and there were few things we could have done
> > better in hindsight.
> > 
> > I've got similar patches for the ASPEED hwmon pwm/tach driver, and the
> > i2c driver that I'll send out now.
> > 
> > Thanks for the review.
> > 
> > Cheers,
> > 
> > Joel  
> Hi Joel,
> 
> IIO is closed for this cycle anyway now.
> Otherwise, series looks good.
> 
> Will pick up when back with my main PC as traveling for this week and
> next.
Forgot to ask, do you want me to pick this up as a fix?
Also does it make sense to tag it for stable?

If not I can pick it up for the coming cycle. Given the code changes
are small and well isolated I'm happy to do any of the 3 options,
it really depends on whether the rest of the platform works well enough
to be worth rushing these through?

Jonathan
> 
> Thanks,
> 
> Jonathan
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

