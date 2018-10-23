Return-Path: <SRS0=raEp=ND=poczta.fm=sst@kernel.org>
Date: Tue, 23 Oct 2018 15:32:34 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 1/1] staging: iio: adc: ad7280a: use devm_* APIs
Message-ID: <20181023133234.GA9359@x220.localdomain>
References: <20181019182013.GC20587@x220.localdomain>
 <20181021142632.2838a361@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181021142632.2838a361@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On paź 21, 2018 14:26, Jonathan Cameron wrote:
> On Fri, 19 Oct 2018 20:20:13 +0200
> Slawomir Stepien <sst@poczta.fm> wrote:
> 
> > devm_* APIs are device managed and make code simpler.
> > 
> > Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> 
> Hi Slawomir,
> 
> There are some complexities in using the managed allocators, almost
> always around possible race conditions.  See inline.

Thank you so much for pointing the problems!

> > @@ -692,7 +691,8 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
> >  	unsigned int *channels;
> >  	int i, ret;
> >  
> > -	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_KERNEL);
> > +	channels = devm_kcalloc(&st->spi->dev, st->scan_cnt, sizeof(*channels),
> > +				GFP_KERNEL);
> >  	if (!channels)
> >  		return IRQ_HANDLED;
> >  
> > @@ -744,7 +744,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
> >  	}
> >  
> >  out:
> > -	kfree(channels);
> > +	devm_kfree(&st->spi->dev, channels);
> 
> Now this I really don't want to see.
> Using the managed framework is far from free. Please don't do it when the
> normal path is to free the buffer like this...

OK

> >  	return IRQ_HANDLED;
> >  }
> >  static int ad7280_remove(struct spi_device *spi)
> > @@ -958,16 +948,9 @@ static int ad7280_remove(struct spi_device *spi)
> >  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> >  	struct ad7280_state *st = iio_priv(indio_dev);
> >  
> > -	if (spi->irq > 0)
> > -		free_irq(spi->irq, indio_dev);
> > -	iio_device_unregister(indio_dev);
> > -
> >  	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
> >  		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);
> So here, you need to think very carefully about what the various
> steps are doing.  By moving to devm_iio_device_unregister
> what difference has it made to the sequence of calls in remove?
> 
> The upshot is you just turned the device off before removing the
> interfaces which would allow userspace / kernel consumers to
> access the device.  A classic race condition that 'might' open
> up opportunities for problems.
> 
> Often the reality is that these sorts of races have very minimal
> impact, but they do break the cardinal rule that code should be
> obviously right (if possible).  Hence you can't do this sort
> of conversion so simply.  You can consider using the devm_add_action
> approach to ensure the tear down is in the right order though...

Yes I understand the problem here. I have some questions regarding
devm_add_action that might solve the problem here:

1. My understanding is that the action has to be added on the devres list before
the devm_iio_device_register call, so during unwinding the action will be called
after the call to devm_iio_device_unreg. Other order will be still not correct.
Am I thinking correctly here?

Please note that doing the action from probe is changing the current behaviour
of the driver - we will put the device into power-down software state also from
probe() (if irq setup fails).

2. devm_iio_device_unregister from what I see could be used here in place of
iio_device_unregister. Maybe that is the best way to go?

-- 
Slawomir Stepien
