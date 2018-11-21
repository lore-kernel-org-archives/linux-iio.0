Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41810 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbeKUUGl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Nov 2018 15:06:41 -0500
Message-ID: <394a787d3afaeb6314c517739697430102170027.camel@gmail.com>
Subject: Re: [PATCH v2 5/5] Staging: iio: adt7316: Use device tree data to
 assign irq_type
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Date: Wed, 21 Nov 2018 15:02:52 +0530
In-Reply-To: <8f659e4351a9b2511658b01c0b18bed94ef72802.camel@analog.com>
References: <20181120170036.7403-1-shreeya.patel23498@gmail.com>
         <8f659e4351a9b2511658b01c0b18bed94ef72802.camel@analog.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2018-11-21 at 08:21 +0000, Ardelean, Alexandru wrote:
> On Tue, 2018-11-20 at 22:30 +0530, Shreeya Patel wrote:
> > ADT7316 driver no more uses platform data and hence use device tree
> > data instead of platform data for assigning irq_type field.
> > Switch case figures out the type of irq and if it's the default
> > case
> > then assign the default value to the irq_type i.e.
> > irq_type = IRQF_TRIGGER_LOW
> > 
> 
> 1 comment inline
> 
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > ---
> >  drivers/staging/iio/addac/adt7316.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/addac/adt7316.c
> > b/drivers/staging/iio/addac/adt7316.c
> > index 9c72538baf9e..c647875a64f5 100644
> > --- a/drivers/staging/iio/addac/adt7316.c
> > +++ b/drivers/staging/iio/addac/adt7316.c
> > @@ -2101,8 +2101,7 @@ int adt7316_probe(struct device *dev, struct
> > adt7316_bus *bus,
> >  {
> >  	struct adt7316_chip_info *chip;
> >  	struct iio_dev *indio_dev;
> > -	unsigned short *adt7316_platform_data = dev-
> > >platform_data;
> > -	int irq_type = IRQF_TRIGGER_LOW;
> > +	int irq_type;
> >  	int ret = 0;
> >  
> >  	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
> > @@ -2146,8 +2145,22 @@ int adt7316_probe(struct device *dev, struct
> > adt7316_bus *bus,
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  
> >  	if (chip->bus.irq > 0) {
> > -		if (adt7316_platform_data[0])
> > -			irq_type = adt7316_platform_data[0];
> > +		irq_type =
> > +			irqd_get_trigger_type(irq_get_irq_data(chi
> > p-
> > > bus.irq));
> > 
> > +
> > +		switch (irq_type) {
> > +		case IRQF_TRIGGER_HIGH:
> > +		case IRQF_TRIGGER_RISING:
> > +			break;
> > +		case IRQF_TRIGGER_LOW:
> > +		case IRQF_TRIGGER_FALLING:
> > +			break;
> > +		default:
> > +			dev_info(dev, "mode %d unsupported, using
> > IRQF_TRIGGER_LOW\n",
> > +				 irq_type);
> > +			irq_type = IRQF_TRIGGER_LOW;
> > +			break;
> > +		}
> 
> It would be an idea to move this part [together with
> devm_request_threaded_irq()] into a "adt7316_setup_irq()" function.
> To un-
> clutter the code in the adt7316_probe() function.
> 

Yes, seems like a good idea!
Even other drivers are doing the same as you told me to do...thanks :)

I'll do the change after Jonathan picks up the other patches and will
wait for some other reviews to come up if there are any.

Thanks

> >  
> >  		ret = devm_request_threaded_irq(dev, chip-
> > >bus.irq,
> >  						NULL,
