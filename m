Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:12163 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727329AbeIQNzP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Sep 2018 09:55:15 -0400
Date: Mon, 17 Sep 2018 09:28:39 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] staging:iio:ad7606: update structs with doc annotations
Message-ID: <20180917092839.0000332e@huawei.com>
In-Reply-To: <b303011d8e1bdd8795acfff7d83bfcc95ebaeed5.camel@analog.com>
References: <20180913110736.31182-1-alexandru.ardelean@analog.com>
        <20180916122436.63916f40@archlinux>
        <b303011d8e1bdd8795acfff7d83bfcc95ebaeed5.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 17 Sep 2018 07:10:44 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2018-09-16 at 12:24 +0100, Jonathan Cameron wrote:
> > On Thu, 13 Sep 2018 14:07:36 +0300
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >   
> > > The current structs are only partially documented via annotations. This
> > > change updates annotations for all structs in the ad7606.h file.
> > > 
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> > 
> > Good stuff, though a few questions inline.
> > 
> > I'm hoping this means you are planning to finish tidying this driver
> > up and move it out of staging?   
> 
> Replies inline.
> 
> 
> So, I don't have a good track-record of saying yes to this question and
> sticking to it, because I also have the AD7192 [in my pipeline] to move out
> of staging [and it's only partially done].
> 
> But, specifically for this driver, we want to add a new chip to this [after
> the AD7605-4], so there is an interest from our side to actually see this
> through.
> 
> And also, we did manage to rebase quite a lot of our patches on top of a
> 4.14 base [ which should hopefully make things more easier to track
> internally vs upstream ].
> I do hope to send-out a bigger set of these patches upstream.
> And I'll try to separate patches as much as possible, because it's simpler
> to resend V2,V3,...,VN for smaller sets of patches.
> 
> So, this is not a definite-yes to your question; it's more of an indicative
> of what we're trying to do.

Cool. Thanks for the info and don't worry about it taking a while. I'm definitely
keen that new device support in staging drivers should at least be tangentially
connected to getting them out of staging as clearly there is active interest in
them.

I have drivers in my queue that have been there for a large number of years :(

One day I'll get to them all!

Jonathan
> 
> Thanks
> Alex
> 
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/staging/iio/adc/ad7606.h | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > > 
> > > diff --git a/drivers/staging/iio/adc/ad7606.h
> > > b/drivers/staging/iio/adc/ad7606.h
> > > index 4983e3aa6b0e..f422296354c9 100644
> > > --- a/drivers/staging/iio/adc/ad7606.h
> > > +++ b/drivers/staging/iio/adc/ad7606.h
> > > @@ -24,7 +24,26 @@ struct ad7606_chip_info {
> > >  
> > >  /**
> > >   * struct ad7606_state - driver instance specific data
> > > + * @dev		pointer to kernel device
> > > + * @chip_info		entry in the table of chips that
> > > describes this device
> > > + * @reg		regulator info for the the power supply of the
> > > device
> > > + * @poll_work		struct info for reading data in buffer
> > > mode  
> > 
> > I'm not quite sure on the intended meaning of this one above...  
> Ack.
> Will try to make it clearer.
> 
> >   
> > > + * @wq_data_avail	wait queue struct for buffer mode
> > > + * @bops		bus operations (SPI or parallel)
> > > + * @range		voltage range selection, selects which scale
> > > to apply
> > > + * @oversampling	oversampling selection
> > > + * @done		marks whether reading data is done
> > > + * @base_address	address from where to read data in parallel
> > > operation
> > >   * @lock		protect sensor state  
> > 
> > From what? Concurrent changes I guess, but would be good to be clear.  
> 
> Ack.
> Will update.
> 
> >   
> > > + * @gpio_convst	GPIO descriptor for conversion start signal
> > > (CONVST)
> > > + * @gpio_reset		GPIO descriptor for device hard-reset
> > > + * @gpio_range		GPIO descriptor for range selection
> > > + * @gpio_standby	GPIO descriptor for stand-by signal (STBY),
> > > + *			controls power-down mode of device
> > > + * @gpio_frstdata	GPIO descriptor for reading from device when
> > > data
> > > + *			is being read on the first channel
> > > + * @gpio_os		GPIO descriptors to control oversampling on
> > > the device
> > > + * @data		buffer for reading data from the device
> > >   */
> > >  
> > >  struct ad7606_state {
> > > @@ -55,6 +74,10 @@ struct ad7606_state {
> > >  	unsigned short			data[12]
> > > ____cacheline_aligned;
> > >  };
> > >  
> > > +/**
> > > + * struct ad7606_bus_ops - driver bus operations
> > > + * @read_block		function pointer for reading blocks of
> > > data
> > > + */
> > >  struct ad7606_bus_ops {
> > >  	/* more methods added in future? */
> > >  	int (*read_block)(struct device *dev, int num, void *data);  
> > 
> >  
