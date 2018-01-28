Return-Path: <SRS0=zW5g=EX=gmail.com=embed3d@kernel.org>
Subject: Re: [PATCH 04/16] iio: adc: sun4i-gpadc-iio: rework: sampling
 start/end code readout reg
To: Jonathan Cameron <jic23@kernel.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 maxime.ripard@free-electrons.com, wens@csie.org, linux@armlinux.org.uk,
 knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, davem@davemloft.net,
 hans.verkuil@cisco.com, mchehab@kernel.org, rask@formelder.dk,
 clabbe.montjoie@gmail.com, sean@mess.org, krzk@kernel.org,
 quentin.schulz@free-electrons.com, icenowy@aosc.io, edu.molinas@gmail.com,
 singhalsimran0@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20180126151941.12183-1-embed3d@gmail.com>
 <20180126151941.12183-5-embed3d@gmail.com>
 <20180128084359.3f3e523c@archlinux>
From: Philipp Rossak <embed3d@gmail.com>
Message-ID: <ee2bd3b5-e0c7-66b2-d05f-1523d9d894d7@gmail.com>
Date: Sun, 28 Jan 2018 14:34:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180128084359.3f3e523c@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 28.01.2018 09:43, Jonathan Cameron wrote:
> On Fri, 26 Jan 2018 16:19:29 +0100
> Philipp Rossak <embed3d@gmail.com> wrote:
> 
>> For adding newer sensor some basic rework of the code is necessary.
>>
>> This commit reworks the code and allows the sampling start/end code and
>> the position of value readout register to be altered. Later the start/end
>> functions will be used to configure the ths and start/stop the
>> sampling.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> Hmm. It almost always turns out to be a bad idea to assume a particular
> set of registers will be consistent across a hardware family.  Usual convention
> is just to prefix them with the first supported device and use them across
> the variants where they are correct.  I.e. don't use wild cards or generic
> names as they often end up implying a wider range of applicability than
> we want.
>

The new THS sensors seems to use the same THS ip core, only configured 
with different amount of sensors. So for H3, A83T, H5, A80 and A64 the 
registers are all the same.

I think the big question is, do we want to have a few very big patches. 
Or more small patches with code that is used in later patches.

> A few other comments inline.  Reworking code to make it ready for later
> patches is fine, but this also adds a lot of new code which isn't used until
> much later in the series.  Move it there...

please see comments below.

>> ---
>>   drivers/iio/adc/sun4i-gpadc-iio.c | 87 +++++++++++++++++++++++++++++++++++----
>>   include/linux/mfd/sun4i-gpadc.h   | 19 +++++++--
>>   2 files changed, 94 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
>> index 03804ff9c006..363936b37c5a 100644
>> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
>> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
>> @@ -49,6 +49,18 @@ static unsigned int sun6i_gpadc_chan_select(unsigned int chan)
>>   	return SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
>>   }
>>   
>> +struct sun4i_gpadc_iio;
>> +
>> +/*
>> + * Prototypes for these functions, which enable these functions to be
>> + * referenced in gpadc_data structures.
>> + */
>> +static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info);
>> +static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info);
>> +
>> +static int sunxi_ths_sample_start(struct sun4i_gpadc_iio *info);
> 
> Superficially this appears to be introduced but not used... Patch 9
> is first to use it I think?  Introduce it then rather than here.
> 

You are right, this function is used first in Patch 9. In an very early 
version, I had this together with Patch 9. But then I had the feeling 
that everything got too messy... Right now this is a very big patch 
series and I wanted to have a clear structure in it and easy to review.

If I would rework this it will end up in squashing, Patch 4, Parts of 
Patch 7, Patch 8 and Patch 9.

>> +static int sunxi_ths_sample_end(struct sun4i_gpadc_iio *info);
>> +
>>   struct gpadc_data {
>>   	int		temp_offset;
>>   	int		temp_scale;
>> @@ -56,6 +68,13 @@ struct gpadc_data {
>>   	unsigned int	tp_adc_select;
>>   	unsigned int	(*adc_chan_select)(unsigned int chan);
>>   	unsigned int	adc_chan_mask;
>> +	unsigned int	temp_data;
>> +	int		(*sample_start)(struct sun4i_gpadc_iio *info);
>> +	int		(*sample_end)(struct sun4i_gpadc_iio *info);
>> +	u32		ctrl0_map;
>> +	u32		ctrl2_map;
>> +	u32		sensor_en_map;
>> +	u32		filter_map;
>>   };
>>   
>>   static const struct gpadc_data sun4i_gpadc_data = {
>> @@ -65,6 +84,9 @@ static const struct gpadc_data sun4i_gpadc_data = {
>>   	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
>>   	.adc_chan_select = &sun4i_gpadc_chan_select,
>>   	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
>> +	.temp_data = SUN4I_GPADC_TEMP_DATA,
>> +	.sample_start = sun4i_gpadc_sample_start,
>> +	.sample_end = sun4i_gpadc_sample_end,
>>   };
>>   
>>   static const struct gpadc_data sun5i_gpadc_data = {
>> @@ -74,6 +96,9 @@ static const struct gpadc_data sun5i_gpadc_data = {
>>   	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
>>   	.adc_chan_select = &sun4i_gpadc_chan_select,
>>   	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
>> +	.temp_data = SUN4I_GPADC_TEMP_DATA,
>> +	.sample_start = sun4i_gpadc_sample_start,
>> +	.sample_end = sun4i_gpadc_sample_end,
>>   };
>>   
>>   static const struct gpadc_data sun6i_gpadc_data = {
>> @@ -83,12 +108,18 @@ static const struct gpadc_data sun6i_gpadc_data = {
>>   	.tp_adc_select = SUN6I_GPADC_CTRL1_TP_ADC_SELECT,
>>   	.adc_chan_select = &sun6i_gpadc_chan_select,
>>   	.adc_chan_mask = SUN6I_GPADC_CTRL1_ADC_CHAN_MASK,
>> +	.temp_data = SUN4I_GPADC_TEMP_DATA,
>> +	.sample_start = sun4i_gpadc_sample_start,
>> +	.sample_end = sun4i_gpadc_sample_end,
>>   };
>>   
>>   static const struct gpadc_data sun8i_a33_gpadc_data = {
>>   	.temp_offset = -1662,
>>   	.temp_scale = 162,
>>   	.tp_mode_en = SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
>> +	.temp_data = SUN4I_GPADC_TEMP_DATA,
>> +	.sample_start = sun4i_gpadc_sample_start,
>> +	.sample_end = sun4i_gpadc_sample_end,
>>   };
>>   
>>   struct sun4i_gpadc_iio {
>> @@ -277,7 +308,7 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
>>   	if (info->no_irq) {
>>   		pm_runtime_get_sync(indio_dev->dev.parent);
>>   
>> -		regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
>> +		regmap_read(info->regmap, info->data->temp_data, val);
>>   
>>   		pm_runtime_mark_last_busy(indio_dev->dev.parent);
>>   		pm_runtime_put_autosuspend(indio_dev->dev.parent);
>> @@ -382,10 +413,8 @@ static irqreturn_t sun4i_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> -static int sun4i_gpadc_runtime_suspend(struct device *dev)
>> +static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info)
>>   {
>> -	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
>> -
>>   	/* Disable the ADC on IP */
>>   	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, 0);
>>   	/* Disable temperature sensor on IP */
>> @@ -394,19 +423,32 @@ static int sun4i_gpadc_runtime_suspend(struct device *dev)
>>   	return 0;
>>   }
>>   
>> -static int sun4i_gpadc_runtime_resume(struct device *dev)
>> +static int sunxi_ths_sample_end(struct sun4i_gpadc_iio *info)
>> +{
>> +	/* Disable temperature sensor */
>> +	regmap_write(info->regmap, SUNXI_THS_CTRL2, 0x0);
>> +
>> +	return 0;
>> +}
>> +
>> +static int sun4i_gpadc_runtime_suspend(struct device *dev)
>>   {
>>   	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
>>   
>> +	return info->data->sample_end(info);
>> +}
>> +
>> +static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info)
>> +{
>>   	/* clkin = 6MHz */
>>   	regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
>>   		     SUN4I_GPADC_CTRL0_ADC_CLK_DIVIDER(2) |
>>   		     SUN4I_GPADC_CTRL0_FS_DIV(7) |
>> -		     SUN4I_GPADC_CTRL0_T_ACQ(63));
>> +		     SUNXI_THS_ACQ0(63));
>>   	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, info->data->tp_mode_en);
>>   	regmap_write(info->regmap, SUN4I_GPADC_CTRL3,
>> -		     SUN4I_GPADC_CTRL3_FILTER_EN |
>> -		     SUN4I_GPADC_CTRL3_FILTER_TYPE(1));
>> +		     SUNXI_THS_FILTER_EN |
>> +		     SUNXI_THS_FILTER_TYPE(1));
> 
> Why if these are temperature sensor features are we setting them in the
> general purpose ADC start function?

This is part of the olds sensors (before Allwinner reworked their 
temperature sensor (only ths) ). Those "old" sensors integrate an ADC 
and a Thermal sensor in one ip block/register space. I don't want to 
break those sensors/adc, since I'm not able to test them!

>>   	/* period = SUN4I_GPADC_TPR_TEMP_PERIOD * 256 * 16 / clkin; ~0.6s */
>>   	regmap_write(info->regmap, SUN4I_GPADC_TPR,
>>   		     SUN4I_GPADC_TPR_TEMP_ENABLE |
>> @@ -415,6 +457,35 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
>>   	return 0;
>>   }
>>   
>> +static int sunxi_ths_sample_start(struct sun4i_gpadc_iio *info)
>> +{
>> +	u32 value;
>> +
>> +	if (info->data->ctrl0_map)
>> +		regmap_write(info->regmap, SUNXI_THS_CTRL0,
>> +			info->data->ctrl0_map);
>> +
>> +	regmap_write(info->regmap, SUNXI_THS_CTRL2,
>> +		info->data->ctrl2_map);
>> +
>> +	regmap_write(info->regmap, SUNXI_THS_FILTER,
>> +		info->data->filter_map);
>> +
>> +	regmap_read(info->regmap, SUNXI_THS_CTRL2, &value);
>> +
>> +	regmap_write(info->regmap, SUNXI_THS_CTRL2,
>> +		info->data->sensor_en_map | value);
>> +
>> +	return 0;
>> +}
>> +
>> +static int sun4i_gpadc_runtime_resume(struct device *dev)
>> +{
>> +	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
>> +
>> +	return info->data->sample_start(info);
>> +}
>> +
>>   static int sun4i_gpadc_get_temp(void *data, int *temp)
>>   {
>>   	struct sun4i_gpadc_iio *info = data;
>> diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
>> index 78d31984a222..39e096c3ddac 100644
>> --- a/include/linux/mfd/sun4i-gpadc.h
>> +++ b/include/linux/mfd/sun4i-gpadc.h
>> @@ -17,7 +17,6 @@
>>   #define SUN4I_GPADC_CTRL0_ADC_CLK_SELECT		BIT(22)
>>   #define SUN4I_GPADC_CTRL0_ADC_CLK_DIVIDER(x)		((GENMASK(1, 0) & (x)) << 20)
>>   #define SUN4I_GPADC_CTRL0_FS_DIV(x)			((GENMASK(3, 0) & (x)) << 16)
>> -#define SUN4I_GPADC_CTRL0_T_ACQ(x)			(GENMASK(15, 0) & (x))
>>   
>>   #define SUN4I_GPADC_CTRL1				0x04
>>   
>> @@ -51,9 +50,6 @@
>>   
>>   #define SUN4I_GPADC_CTRL3				0x0c
>>   
>> -#define SUN4I_GPADC_CTRL3_FILTER_EN			BIT(2)
>> -#define SUN4I_GPADC_CTRL3_FILTER_TYPE(x)		(GENMASK(1, 0) & (x))
>> -
>>   #define SUN4I_GPADC_TPR					0x18
>>   
>>   #define SUN4I_GPADC_TPR_TEMP_ENABLE			BIT(16)
>> @@ -90,6 +86,21 @@
>>   /* 10s delay before suspending the IP */
>>   #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
>>   
>> +/* SUNXI_THS COMMON REGISTERS + DEFINES */
>> +#define SUNXI_THS_CTRL0					0x00
>> +#define SUNXI_THS_CTRL2					0x40
>> +#define SUNXI_THS_FILTER				0x70
>> +
>> +#define SUNXI_THS_FILTER_EN				BIT(2)
>> +#define SUNXI_THS_FILTER_TYPE(x)			(GENMASK(1, 0) & (x))
>> +#define SUNXI_THS_ACQ0(x)				(GENMASK(15, 0) & (x))
>> +#define SUNXI_THS_ACQ1(x)				(GENMASK(31, 16) & ((x) << 16))
>> +
>> +#define SUNXI_THS_TEMP_SENSE_EN0			BIT(0)
>> +#define SUNXI_THS_TEMP_SENSE_EN1			BIT(1)
>> +#define SUNXI_THS_TEMP_SENSE_EN2			BIT(2)
>> +#define SUNXI_THS_TEMP_SENSE_EN3			BIT(3)
>> +
>>   struct sun4i_gpadc_dev {
>>   	struct device			*dev;
>>   	struct regmap			*regmap;
> 

In general I'm ok with changing those things, but I would like to wait 
for some more feedback/thoughts about this.

Thanks,
Philipp
