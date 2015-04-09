Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57459 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754048AbbDIRDc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 9 Apr 2015 13:03:32 -0400
Date: Thu, 9 Apr 2015 10:02:15 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: IIO <linux-iio@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Aaron Lu <aaron.lu@intel.com>,
	Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH v2] iio/axp288_adc: add missing channel info mask
Message-ID: <20150409100215.5264f990@icelake>
In-Reply-To: <55267C39.5050707@kernel.org>
References: <1428345500-27672-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<55267C39.5050707@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 09 Apr 2015 14:18:49 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On 06/04/15 19:38, Jacob Pan wrote:
> > Commit 65de7654d39c70c2b ("iio: iio: Fix iio_channel_read return if
> > channel havn't info") added a check for valid info masks.
> > 
> > This patch adds missing channel info masks for all ADC channels.
> > Otherwise, iio_read_channel_raw() would return -EINVAL when called
> > by consumer drivers.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> This makes me a little nervous. Why did we have the separate raw and
> processed paths in the read_raw function in the first place?
> 
Good point, I failed to explain that the reason to have separate raw and
processed was that the raw channels happened to need some special
processing in axp288_adc_set_ts(), since I have added a check for
address:
	/* channels other than GPADC do not need to switch TS pin */
	if (address != AXP288_GP_ADC_H)
		return 0;

we no longer need special case the channels based on RAW flag. Thinking
back it was kind of an abuse.

> Also this changes the exposed userspace ABI by dropping those
> processed attributes that already exist..
> 
I don't know the current users outside what we develop internally. What
is your suggestion?

> Jonathan
> > ---
> >  drivers/iio/adc/axp288_adc.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/axp288_adc.c
> > b/drivers/iio/adc/axp288_adc.c index 08bcfb0..56008a8 100644
> > --- a/drivers/iio/adc/axp288_adc.c
> > +++ b/drivers/iio/adc/axp288_adc.c
> > @@ -53,39 +53,42 @@ static const struct iio_chan_spec const
> > axp288_adc_channels[] = { .channel = 0,
> >  		.address = AXP288_TS_ADC_H,
> >  		.datasheet_name = "TS_PIN",
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >  	}, {
> >  		.indexed = 1,
> >  		.type = IIO_TEMP,
> >  		.channel = 1,
> >  		.address = AXP288_PMIC_ADC_H,
> >  		.datasheet_name = "PMIC_TEMP",
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >  	}, {
> >  		.indexed = 1,
> >  		.type = IIO_TEMP,
> >  		.channel = 2,
> >  		.address = AXP288_GP_ADC_H,
> >  		.datasheet_name = "GPADC",
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >  	}, {
> >  		.indexed = 1,
> >  		.type = IIO_CURRENT,
> >  		.channel = 3,
> >  		.address = AXP20X_BATT_CHRG_I_H,
> >  		.datasheet_name = "BATT_CHG_I",
> > -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >  	}, {
> >  		.indexed = 1,
> >  		.type = IIO_CURRENT,
> >  		.channel = 4,
> >  		.address = AXP20X_BATT_DISCHRG_I_H,
> >  		.datasheet_name = "BATT_DISCHRG_I",
> > -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >  	}, {
> >  		.indexed = 1,
> >  		.type = IIO_VOLTAGE,
> >  		.channel = 5,
> >  		.address = AXP20X_BATT_V_H,
> >  		.datasheet_name = "BATT_V",
> > -		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >  	},
> >  };
> >  
> > @@ -151,9 +154,6 @@ static int axp288_adc_read_raw(struct iio_dev
> > *indio_dev, chan->address))
> >  			dev_err(&indio_dev->dev, "TS pin
> > restore\n"); break;
> > -	case IIO_CHAN_INFO_PROCESSED:
> > -		ret = axp288_adc_read_channel(val, chan->address,
> > info->regmap);
> > -		break;
> >  	default:
> >  		ret = -EINVAL;
> >  	}
> > 
> 

[Jacob Pan]
