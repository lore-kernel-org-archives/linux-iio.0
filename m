Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52323 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752188AbeETA06 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 May 2018 20:26:58 -0400
Message-ID: <1526776015.32235.38.camel@gmail.com>
Subject: Re: [PATCH v2] Add support for external reference voltage through
 the regulator framework
From: Silvan Murer <silvan.murer@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Date: Sun, 20 May 2018 02:26:55 +0200
In-Reply-To: <7560bccf-1ac9-0233-a80d-1543bc653b14@metafoo.de>
References: <1526415250.32235.17.camel@gmail.com>
         <37a86fef-2097-cc02-56e4-9c3ffbe393e3@metafoo.de>
         <1526634816.32235.24.camel@gmail.com>
         <7560bccf-1ac9-0233-a80d-1543bc653b14@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Thank you for the additional informations.
I just submitted the fixed patch to the mailinglist.


On Fre, 2018-05-18 at 11:59 +0200, Lars-Peter Clausen wrote:
> On 05/18/2018 11:13 AM, Silvan Murer wrote:
> > 
> > Hi Lars,
> > Thanks for your review.
> > Should I create a new version of this patch whithout the whitespace
> > issues?
> > Generally question: What is the next step? Do you include the
> > reviewed
> > patch into the iio.git repository? And do you submit the patches to
> > the
> > mainline repository?
> > Sorry for the basic questions, currently I try to understand the
> > whole
> > flow of the patch flow :)
> 
> Hi,
> 
> Jonathan will pick the patch up and add it to the iio.git repository,
> when
> he finds the time and thinks the patch is good. And then the patches
> will
> find their way to mainline.
> 
> You could ask Jonathan to fix the whitespace errors when he picks up
> the
> patch. But it would be less work for him if you just send a version
> that has
> the whitespace fixed (Keep by Reviewed-by tag).
> 
> - Lars
> 
> > 
> > 
> > 
> > On Don, 2018-05-17 at 13:01 +0200, Lars-Peter Clausen wrote:
> > > 
> > > On 05/15/2018 10:14 PM, Silvan Murer wrote:
> > > > 
> > > > 
> > > > Add support for external reference voltage through the
> > > > regulator
> > > > framework.
> > > > 
> > > > Signed-off-by: Silvan Murer <silvan.murer@gmail.com>
> > > Looks good, thanks.
> > > 
> > > Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> > > 
> > > Just two tiny whitespace issues.
> > > 
> > > [...]
> > > > 
> > > > 
> > > >  enum ltc2632_supported_device_ids {
> > > > @@ -90,7 +96,7 @@ static int ltc2632_read_raw(struct iio_dev
> > > > *indio_dev,
> > > >  
> > > >  	switch (m) {
> > > >  	case IIO_CHAN_INFO_SCALE:
> > > > -		*val = chip_info->vref_mv;
> > > > +		*val =  st->vref_mv;
> > > Extra space after the '='.
> > > 
> > > > 
> > > > 
> > > >  		*val2 = chan->scan_type.realbits;
> > > >  		return IIO_VAL_FRACTIONAL_LOG2;
> > > >  	}
> > > > @@ -247,6 +253,45 @@ static int ltc2632_probe(struct spi_device
> > > > *spi)
> > > >  	chip_info = (struct ltc2632_chip_info *)
> > > >  			spi_get_device_id(spi)->driver_data;
> > > >  
> > > > +	st->vref_reg = devm_regulator_get_optional(&spi->dev,
> > > > "vref");
> > > > +	if (PTR_ERR(st->vref_reg) == -ENODEV) {
> > > > +		/* use internal reference voltage */
> > > > +		st->vref_reg = NULL;
> > > > +		st->vref_mv = chip_info->vref_mv;
> > > > +
> > > > +		ret = ltc2632_spi_write(spi,
> > > > LTC2632_CMD_INTERNAL_REFER,
> > > > +				0, 0, 0);
> > > > +		if (ret) {
> > > > +			dev_err(&spi->dev,
> > > > +				"Set internal reference
> > > > command
> > > > failed, %d\n",
> > > > +				ret);
> > > > +			return ret;
> > > > +		}
> > > > +	} else if (IS_ERR(st->vref_reg)) {
> > > > +		dev_err(&spi->dev,
> > > > +				"Error getting voltage
> > > > reference
> > > > regulator\n");
> > > > +			return PTR_ERR(st->vref_reg);
> > > Extra tab before the 'return'.
> > > 
> > > > 
> > > > 
> > > > +	} else {
> > > > +		/* use external reference voltage */
> > > > +		ret = regulator_enable(st->vref_reg);
> > > > +		if (ret) {
> > > > +			dev_err(&spi->dev,
> > > > +				"enable reference regulator
> > > > failed, %d\n",
> > > > +				ret);
> > > > +			return ret;
> > > > +		}
> > > > +		st->vref_mv = regulator_get_voltage(st-
> > > > >vref_reg)
> > > > / 1000;
> > > > +
> > > > +		ret = ltc2632_spi_write(spi,
> > > > LTC2632_CMD_EXTERNAL_REFER,
> > > > +				0, 0, 0);
> > > > +		if (ret) {
> > > > +			dev_err(&spi->dev,
> > > > +				"Set external reference
> > > > command
> > > > failed, %d\n",
> > > > +				ret);
> > > > +			return ret;
> > > > +		}
> > > > +	}
> > > > +
> > > [...]
