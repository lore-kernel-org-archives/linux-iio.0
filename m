Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752169AbdGDTdA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Jul 2017 15:33:00 -0400
Date: Tue, 4 Jul 2017 20:32:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Revert "axp288: Drop bogus
 AXP288_ADC_TS_PIN_CTRL register modifications"
Message-ID: <20170704203255.09659904@kernel.org>
In-Reply-To: <6db78aed-5859-aa5b-6623-aa9d1122093d@redhat.com>
References: <20170630174254.12056-1-hdegoede@redhat.com>
        <20170701104638.5a857f88@kernel.org>
        <6db78aed-5859-aa5b-6623-aa9d1122093d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 4 Jul 2017 15:52:42 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 01-07-17 11:46, Jonathan Cameron wrote:
> > On Fri, 30 Jun 2017 19:42:54 +0200
> > Hans de Goede <hdegoede@redhat.com> wrote:
> >   
> >> Inheriting the ADC BIAS current settings from the BIOS instead of
> >> hardcoding then causes the AXP288 to disable charging (I think it
> >> mis-detects an overheated battery) on at least one model tablet.
> >>
> >> So lets go back to hard coding the values, this reverts
> >> commit fa2849e9649b ("iio: adc: axp288: Drop bogus
> >> AXP288_ADC_TS_PIN_CTRL register modifications"), fixing charging not
> >> working on the model tablet in question.  
> > Given the original patch description, I'm a little worried we are
> > changing too much by doing a straight forward revert.  
> 
> Perhaps.
> 
> > Should we be addressing just the relevant bit related to the
> > thermal sensor instead?  
> 
> According to the bugreport I received it is this write:
> 
>  >> +static int axp288_adc_set_state(struct regmap *regmap)
>  >> +{
>  >> +	/* ADC should be always enabled for internal FG to function */
>  >> +	if (regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, AXP288_ADC_TS_PIN_ON))
>  >> +		return -EIO;  
> 
> Which fixes the regression, so looking at the register documentation
> we actually need to change the bias currents as well as set the
> bits which control whether the bias current us always on or only on
> when sampling to bias always on.
> 
> > I suppose the revert is the low risk option, but I would really
> > like a slightly better understanding of what is going on here if
> > possible.  
> 
> The problem is that we really don't know what is going on
> exactly, all we can be sure of is that the original code was there
> for a reason after all. The datasheet for the axp288 unfortunaly
> does not offer a clue. Possibly it is just outright wrong.
> 
> As such I would prefer to just go for the revert.
Fair enough.  I added a line saying the exact cause wasn't
fully understood so we were going back to the known working
case.

Applied to the fixes-togreg branch of iio.git.

thanks,

Jonathan
> 
> Regards,
> 
> Hans
> 
> 
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Umberto Ixxo <sfumato1977@gmail.com>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>   drivers/iio/adc/axp288_adc.c | 32 +++++++++++++++++++++++++++++++-
> >>   1 file changed, 31 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
> >> index 64799ad7ebad..7fd24949c0c1 100644
> >> --- a/drivers/iio/adc/axp288_adc.c
> >> +++ b/drivers/iio/adc/axp288_adc.c
> >> @@ -28,6 +28,8 @@
> >>   #include <linux/iio/driver.h>
> >>   
> >>   #define AXP288_ADC_EN_MASK		0xF1
> >> +#define AXP288_ADC_TS_PIN_GPADC		0xF2
> >> +#define AXP288_ADC_TS_PIN_ON		0xF3
> >>   
> >>   enum axp288_adc_id {
> >>   	AXP288_ADC_TS,
> >> @@ -121,6 +123,16 @@ static int axp288_adc_read_channel(int *val, unsigned long address,
> >>   	return IIO_VAL_INT;
> >>   }
> >>   
> >> +static int axp288_adc_set_ts(struct regmap *regmap, unsigned int mode,
> >> +				unsigned long address)
> >> +{
> >> +	/* channels other than GPADC do not need to switch TS pin */
> >> +	if (address != AXP288_GP_ADC_H)
> >> +		return 0;
> >> +
> >> +	return regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, mode);
> >> +}
> >> +
> >>   static int axp288_adc_read_raw(struct iio_dev *indio_dev,
> >>   			struct iio_chan_spec const *chan,
> >>   			int *val, int *val2, long mask)
> >> @@ -131,7 +143,16 @@ static int axp288_adc_read_raw(struct iio_dev *indio_dev,
> >>   	mutex_lock(&indio_dev->mlock);
> >>   	switch (mask) {
> >>   	case IIO_CHAN_INFO_RAW:
> >> +		if (axp288_adc_set_ts(info->regmap, AXP288_ADC_TS_PIN_GPADC,
> >> +					chan->address)) {
> >> +			dev_err(&indio_dev->dev, "GPADC mode\n");
> >> +			ret = -EINVAL;
> >> +			break;
> >> +		}
> >>   		ret = axp288_adc_read_channel(val, chan->address, info->regmap);
> >> +		if (axp288_adc_set_ts(info->regmap, AXP288_ADC_TS_PIN_ON,
> >> +						chan->address))
> >> +			dev_err(&indio_dev->dev, "TS pin restore\n");
> >>   		break;
> >>   	default:
> >>   		ret = -EINVAL;
> >> @@ -141,6 +162,15 @@ static int axp288_adc_read_raw(struct iio_dev *indio_dev,
> >>   	return ret;
> >>   }
> >>   
> >> +static int axp288_adc_set_state(struct regmap *regmap)
> >> +{
> >> +	/* ADC should be always enabled for internal FG to function */
> >> +	if (regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, AXP288_ADC_TS_PIN_ON))
> >> +		return -EIO;
> >> +
> >> +	return regmap_write(regmap, AXP20X_ADC_EN1, AXP288_ADC_EN_MASK);
> >> +}
> >> +
> >>   static const struct iio_info axp288_adc_iio_info = {
> >>   	.read_raw = &axp288_adc_read_raw,
> >>   	.driver_module = THIS_MODULE,
> >> @@ -169,7 +199,7 @@ static int axp288_adc_probe(struct platform_device *pdev)
> >>   	 * Set ADC to enabled state at all time, including system suspend.
> >>   	 * otherwise internal fuel gauge functionality may be affected.
> >>   	 */
> >> -	ret = regmap_write(info->regmap, AXP20X_ADC_EN1, AXP288_ADC_EN_MASK);
> >> +	ret = axp288_adc_set_state(axp20x->regmap);
> >>   	if (ret) {
> >>   		dev_err(&pdev->dev, "unable to enable ADC device\n");
> >>   		return ret;  
> >   
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

