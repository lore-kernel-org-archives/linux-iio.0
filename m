Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34315 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760158AbdACSW7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Jan 2017 13:22:59 -0500
Date: Tue, 3 Jan 2017 10:23:43 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iio: adc: axp288: Drop bogus AXP288_ADC_TS_PIN_CTRL
 register modifications
Message-ID: <20170103102343.735dbdd1@jacob-builder>
In-Reply-To: <054b52de-40fd-a879-7b8e-2d25fed18840@redhat.com>
References: <20161214135525.16477-1-hdegoede@redhat.com>
        <1f31b2e7-90fa-0fb8-5f6e-a8ee2ddf69f7@kernel.org>
        <20161230101501.06958c0d@jacob-builder>
        <054b52de-40fd-a879-7b8e-2d25fed18840@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 1 Jan 2017 12:19:40 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 30-12-16 19:15, Jacob Pan wrote:
> > On Fri, 30 Dec 2016 16:46:03 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  
> >> On 14/12/16 13:55, Hans de Goede wrote:  
> >>> For some reason the axp288_adc driver was modifying the
> >>> AXP288_ADC_TS_PIN_CTRL register, changing bits 0-1 depending on
> >>> whether the GP_ADC channel or another channel was written.
> >>>
> >>> These bits control when a bias current is send to the TS_PIN, the
> >>> GP_ADC has its own pin and a separate bit in another register to
> >>> control the bias current.
> >>>  
> > It has been a while. Just looked at the datasheet, reg 84h is for
> > ADC and TS pin control. IIRC, we had to set the TS bits in order to
> > make ADC read to work.  
> 
> The bits the code I'm removing are manipulating are bits 0 & 1 of
> reg 84h which are:
> 
> 1-0 Current source from TS pin on/off enable bit [1:0]
> 
> 00: off
> 01: on when charging battery, off when not charging
> 10: on in ADC phase and off when out of the ADC phase, for power
> saving 11: always on
> 
> And they are being toggled between 10 and 11, so in both
> cases the current source is enabled when reading the adc
> value. Specifically the code this patch removes are setting
> these bits to 10 before reading and back to 11 after reading,
> which makes no sense.
> 
> And to make things even funkier, this manipulation is only
> done when reading the GP_ADC, which is the ADC function of
> GPIO0, whereas these bits control the bias current source
> for the TS pin, which is a completely different pin.
> 
> So all in all this entire bit of code seems to be big NOP.
> 
It could have been a quirk we had to do on our platforms, I just
cannot recall the details. Are you testing this on x86 platforms?

> > What is the other register?  
> 
> The register to actually enable / disable the bias current
> source for GPIO0 / the GPADC pin is register 85h, where setting
> bit 2 enables the GPIO0 output current.
> 
> Regards,
> 
> Hans
> 
> 
> 
> >>> Not only does changing when to enable the TS_PIN bias current
> >>> (always or only when sampling) when reading the GP_ADC make no
> >>> sense at all, the code is modifying these bits is writing the
> >>> entire register, assuming that all the other bits have their
> >>> default value. 
> > Agreed, it would be better to do read-modify-write and not to
> > touch the other bits.  
> >>> So if the firmware has configured a different bias-current for
> >>> either pin, then that change gets clobbered by the write, likewise
> >>> if the firmware has set bit 2 to indicate that the battery has no
> >>> thermal sensor, this will get clobbered by the write.
> >>>
> >>> This commit fixes all this, by simply removing all writes to the
> >>> AXP288_ADC_TS_PIN_CTRL register, they are not needed to read the
> >>> GP_ADC pin, and can actually be harmful.
> >>>
> >>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>  
> >> I guess you probably have more up to date contact details than I
> >> do, but seems worth trying to cc Jacob Pan on this to see if we
> >> can find out what the original reasoning behind this was.  Seems a
> >> very odd thing to do with no purpose!
> >>
> >> If Jacob isn't contactable we'll fall back to guessing it was just
> >> an oddity of driver evolution.
> >>
> >> Jonathan  
> >>> ---
> >>>  drivers/iio/adc/axp288_adc.c | 32
> >>> +------------------------------- 1 file changed, 1 insertion(+),
> >>> 31 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/adc/axp288_adc.c
> >>> b/drivers/iio/adc/axp288_adc.c index 7fd2494..64799ad 100644
> >>> --- a/drivers/iio/adc/axp288_adc.c
> >>> +++ b/drivers/iio/adc/axp288_adc.c
> >>> @@ -28,8 +28,6 @@
> >>>  #include <linux/iio/driver.h>
> >>>
> >>>  #define AXP288_ADC_EN_MASK		0xF1
> >>> -#define AXP288_ADC_TS_PIN_GPADC		0xF2
> >>> -#define AXP288_ADC_TS_PIN_ON		0xF3
> >>>
> >>>  enum axp288_adc_id {
> >>>  	AXP288_ADC_TS,
> >>> @@ -123,16 +121,6 @@ static int axp288_adc_read_channel(int *val,
> >>> unsigned long address, return IIO_VAL_INT;
> >>>  }
> >>>
> >>> -static int axp288_adc_set_ts(struct regmap *regmap, unsigned int
> >>> mode,
> >>> -				unsigned long address)
> >>> -{
> >>> -	/* channels other than GPADC do not need to switch TS pin
> >>> */
> >>> -	if (address != AXP288_GP_ADC_H)
> >>> -		return 0;
> >>> -
> >>> -	return regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL,
> >>> mode); -}
> >>> -
> >>>  static int axp288_adc_read_raw(struct iio_dev *indio_dev,
> >>>  			struct iio_chan_spec const *chan,
> >>>  			int *val, int *val2, long mask)
> >>> @@ -143,16 +131,7 @@ static int axp288_adc_read_raw(struct iio_dev
> >>> *indio_dev, mutex_lock(&indio_dev->mlock);
> >>>  	switch (mask) {
> >>>  	case IIO_CHAN_INFO_RAW:
> >>> -		if (axp288_adc_set_ts(info->regmap,
> >>> AXP288_ADC_TS_PIN_GPADC,
> >>> -					chan->address)) {
> >>> -			dev_err(&indio_dev->dev, "GPADC mode\n");
> >>> -			ret = -EINVAL;
> >>> -			break;
> >>> -		}
> >>>  		ret = axp288_adc_read_channel(val, chan->address,
> >>> info->regmap);
> >>> -		if (axp288_adc_set_ts(info->regmap,
> >>> AXP288_ADC_TS_PIN_ON,
> >>> -						chan->address))
> >>> -			dev_err(&indio_dev->dev, "TS pin
> >>> restore\n"); break;
> >>>  	default:
> >>>  		ret = -EINVAL;
> >>> @@ -162,15 +141,6 @@ static int axp288_adc_read_raw(struct iio_dev
> >>> *indio_dev, return ret;
> >>>  }
> >>>
> >>> -static int axp288_adc_set_state(struct regmap *regmap)
> >>> -{
> >>> -	/* ADC should be always enabled for internal FG to
> >>> function */
> >>> -	if (regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL,
> >>> AXP288_ADC_TS_PIN_ON))
> >>> -		return -EIO;
> >>> -
> >>> -	return regmap_write(regmap, AXP20X_ADC_EN1,
> >>> AXP288_ADC_EN_MASK); -}
> >>> -
> >>>  static const struct iio_info axp288_adc_iio_info = {
> >>>  	.read_raw = &axp288_adc_read_raw,
> >>>  	.driver_module = THIS_MODULE,
> >>> @@ -199,7 +169,7 @@ static int axp288_adc_probe(struct
> >>> platform_device *pdev)
> >>>  	 * Set ADC to enabled state at all time, including system
> >>> suspend.
> >>>  	 * otherwise internal fuel gauge functionality may be
> >>> affected. */
> >>> -	ret = axp288_adc_set_state(axp20x->regmap);
> >>> +	ret = regmap_write(info->regmap, AXP20X_ADC_EN1,
> >>> AXP288_ADC_EN_MASK); if (ret) {
> >>>  		dev_err(&pdev->dev, "unable to enable ADC
> >>> device\n"); return ret;
> >>>  
> >>  
> >
> > [Jacob Pan]
> >  

[Jacob Pan]
