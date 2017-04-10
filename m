Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:53112 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753229AbdDJNlt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Apr 2017 09:41:49 -0400
From: "Koivunen, Mikko" <Mikko.Koivunen@fi.rohmeurope.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] iio: light: rpr0521 sample_frequency read/write
 added
Date: Mon, 10 Apr 2017 13:26:41 +0000
Message-ID: <E223F49C7E3E1C4E8F3928A8EC9CF0F8DBEC43F8@WILL-MAIL002.REu.RohmEu.com>
References: <1491566839-3925-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1491566839-3925-3-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <a6fa11da-21cf-404b-e2d5-c7906b377807@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 8.4.2017 18:02, Jonathan Cameron wrote:
> On 07/04/17 13:07, Mikko Koivunen wrote:
>> Added sysfs read/write sample frequency.
>>
>> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
> A few comments inline but looks basically good to me.
>
> Odd little bit of hardware!
>
> Jonathan
>> ---
>> Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
>>
>> Patch v1->v2 changes:
>> multiline comments fixed
>>
>>  drivers/iio/light/rpr0521.c |   99 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 99 insertions(+)
>>
>> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
>> index 30c2592..e92a8bb 100644
>> --- a/drivers/iio/light/rpr0521.c
>> +++ b/drivers/iio/light/rpr0521.c
>> @@ -132,6 +132,30 @@ static const struct rpr0521_gain_info {
>>  	},
>>  };
>>  
>> +struct rpr0521_samp_freq {
>> +	int	als_hz;
>> +	int	als_uhz;
>> +	int	pxs_hz;
>> +	int	pxs_uhz;
>> +};
>> +
>> +static const struct rpr0521_samp_freq rpr0521_samp_freq_i[13] = {
>> +/*	{ALS, PXS} */
> Hmm. You have them all listed here so that you can use the index as
> the register value.    Maybe add a symbol to indicate in the comment
> which ones you can actually use here...

Ack.

>> +	{0, 0, 0, 0},		/* 0000, 0=standby */
>> +	{0, 0, 100, 0},		/* 0001 */
>> +	{0, 0, 25, 0},		/* 0010 */
>> +	{0, 0, 10, 0},		/* 0011 */
>> +	{0, 0, 2, 500000},	/* 0100 */
>> +	{10, 0, 20, 0},		/* 0101 */
>> +	{10, 0, 10, 0},		/* 0110 */
>> +	{10, 0, 2, 500000},	/* 0111 */
>> +	{2, 500000, 20, 0},	/* 1000, measurement 100ms, sleep 300ms */
>> +	{2, 500000, 10, 0},	/* 1001, measurement 100ms, sleep 300ms */
>> +	{2, 500000, 0, 0},	/* 1010, high sensitivity mode */
>> +	{2, 500000, 2, 500000},	/* 1011, high sensitivity mode */
>> +	{20, 0, 20, 0}	/* 1100, ALS_data x 0.5, see specification P.18 */
> Whilst this one is odd, I don't think your write function below will refuse
> to set it...

Good catch. I'll change write in patchset v3 to also skip 20.

>> +};
>> +
>>  struct rpr0521_data {
>>  	struct i2c_client *client;
>>  
>> @@ -152,9 +176,15 @@ struct rpr0521_data {
>>  static IIO_CONST_ATTR(in_intensity_scale_available, RPR0521_ALS_SCALE_AVAIL);
>>  static IIO_CONST_ATTR(in_proximity_scale_available, RPR0521_PXS_SCALE_AVAIL);
>>  
>> +/* Start with easy freq first, whole table of freq combinations is more
> /*
>  * Start...
>
> (kernel multiline comment syntax)...

Ack. Maybe it finally gets right on v3.

>> + * complicated.
>> + */
>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("2.5 10");
> 20 not available?

Not advertising that since output values need scaling on 20. Scaling is
easy to do, but so far not done.

>> +
>>  static struct attribute *rpr0521_attributes[] = {
>>  	&iio_const_attr_in_intensity_scale_available.dev_attr.attr,
>>  	&iio_const_attr_in_proximity_scale_available.dev_attr.attr,
>> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>>  	NULL,
>>  };
>>  
>> @@ -170,6 +200,7 @@ static const struct iio_chan_spec rpr0521_channels[] = {
>>  		.channel2 = IIO_MOD_LIGHT_BOTH,
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>  			BIT(IIO_CHAN_INFO_SCALE),
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>  	},
>>  	{
>>  		.type = IIO_INTENSITY,
>> @@ -178,12 +209,14 @@ static const struct iio_chan_spec rpr0521_channels[] = {
>>  		.channel2 = IIO_MOD_LIGHT_IR,
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>  			BIT(IIO_CHAN_INFO_SCALE),
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>  	},
>>  	{
>>  		.type = IIO_PROXIMITY,
>>  		.address = RPR0521_CHAN_PXS,
>>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>  			BIT(IIO_CHAN_INFO_SCALE),
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>>  	}
>>  };
>>  
>> @@ -319,6 +352,56 @@ static int rpr0521_set_gain(struct rpr0521_data *data, int chan,
>>  				  idx << rpr0521_gain[chan].shift);
>>  }
>>  
>> +static int rpr0521_read_samp_freq(struct rpr0521_data *data,
>> +				enum iio_chan_type chan_type,
>> +			    int *val, int *val2)
>> +{
>> +	int reg, ret;
>> +
>> +	ret = regmap_read(data->regmap, RPR0521_REG_MODE_CTRL, &reg);
>> +	if (ret < 0)
>> +		return ret;
> I'd put a blank line here..

Ack.

>> +	reg &= RPR0521_MODE_MEAS_TIME_MASK;
>> +	if (reg >= ARRAY_SIZE(rpr0521_samp_freq_i))
>> +		return -EINVAL;
>> +
>> +	if (chan_type == IIO_INTENSITY) {
>> +		*val = rpr0521_samp_freq_i[reg].als_hz;
>> +		*val2 = rpr0521_samp_freq_i[reg].als_uhz;
>> +	} else if (chan_type == IIO_PROXIMITY) {
>> +		*val = rpr0521_samp_freq_i[reg].pxs_hz;
>> +		*val2 = rpr0521_samp_freq_i[reg].pxs_uhz;
>> +	} else {
>> +		return -EINVAL;
> switch might be tidier..  Also, perhaps return directly from first two
> cases.

Ack.

>> +	}
>> +	return 0;
>> +}
>> +
>> +static int rpr0521_write_samp_freq_common(struct rpr0521_data *data,
>> +				enum iio_chan_type chan_type,
>> +				int val, int val2)
>> +{
>> +	int i;
>> +
>> +	/* Ignore channel
> /*
>  * Ignore channel
>  ...

Ack.

>> +	 * both pxs and als are setup only to same freq because of simplicity
>> +	 */
>> +	for (i = 0; i < ARRAY_SIZE(rpr0521_samp_freq_i); i++)
>> +		if ((val == rpr0521_samp_freq_i[i].als_hz)
>> +			&& (val2 == rpr0521_samp_freq_i[i].als_uhz)
>> +			&& (val == rpr0521_samp_freq_i[i].pxs_hz)
>> +			&& (val2 == rpr0521_samp_freq_i[i].pxs_uhz)) {
> Hmm. a lot of complexity introduced above by sort of allowing for them
> to be different (which would indeed be a real pain to handle! Why not
> just drop the ones you can never actually use?

Because I'm hoping to get/planning to do full implementation later. Just
replace multi line comment with read+matching other channels freq.
However got short of time so it looks like this now.
But you are right, maybe better option at this point would be using
switch-case and add the complexity back later if needed. Changing to v3.

>> +			break;
>> +		}
>> +	if (i == ARRAY_SIZE(rpr0521_samp_freq_i))
>> +		return -EINVAL;
>> +
>> +	return regmap_update_bits(data->regmap,
>> +		RPR0521_REG_MODE_CTRL,
>> +		RPR0521_MODE_MEAS_TIME_MASK,
>> +		i);
>> +}
>> +
>>  static int rpr0521_read_raw(struct iio_dev *indio_dev,
>>  			    struct iio_chan_spec const *chan, int *val,
>>  			    int *val2, long mask)
>> @@ -365,8 +448,16 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
>>  		mutex_unlock(&data->lock);
>>  		if (ret < 0)
>>  			return ret;
>> +		return IIO_VAL_INT_PLUS_MICRO;
>>  
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		mutex_lock(&data->lock);
>> +		ret = rpr0521_read_samp_freq(data, chan->type, val, val2);
>> +		mutex_unlock(&data->lock);
>> +		if (ret < 0)
>> +			return ret;
>>  		return IIO_VAL_INT_PLUS_MICRO;
>> +
> Again, I think you are messing with original white space.  Don't do
> that as it just gives odd diff results like this one...

Thanks for pointing out. It has bothered me before, but not enough to
investigate reason.

>>  	default:
>>  		return -EINVAL;
>>  	}
>> @@ -384,8 +475,16 @@ static int rpr0521_write_raw(struct iio_dev *indio_dev,
>>  		mutex_lock(&data->lock);
>>  		ret = rpr0521_set_gain(data, chan->address, val, val2);
>>  		mutex_unlock(&data->lock);
> You are removing the blank line here.. (I think anyway!). Not a change
> that should be in this patch (or possibly happen at all - this one
> is in the personal taste category).  If nothing else it made diff less
> readable!

Ack.

>> +		return ret;
>>  
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		mutex_lock(&data->lock);
>> +		ret = rpr0521_write_samp_freq_common(data,
>> +			chan->type,
>> +			val, val2);
>> +		mutex_unlock(&data->lock);
>>  		return ret;
>> +
>>  	default:
>>  		return -EINVAL;
>>  	}
>>
>

