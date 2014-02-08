Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41429 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbaBHMQa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2014 07:16:30 -0500
Message-ID: <52F6203C.9030308@kernel.org>
Date: Sat, 08 Feb 2014 12:17:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Beomho Seo <beomho.seo@samsung.com>, linux-iio@vger.kernel.org
CC: Myungjoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 1/2] iio: cm36651:  Fix read/write integration time function.
References: <52F4BFCD.2080203@samsung.com> <52F4C79D.6010909@samsung.com>
In-Reply-To: <52F4C79D.6010909@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/02/14 11:46, Jaehoon Chung wrote:
> On 02/07/2014 08:13 PM, Beomho Seo wrote:
>>
>> This patch is fixed [read/write] integration time function.
>> cm36651 have integration time from 1 to 640 milliseconds.
>> But, print more then the thounsand second. when call *_integration_time attribute.
>> Because read_integration_time function return IIO_VAL_INT.
>> read integration time function is changed return IIO_VAL_INT_PLUS_MICRO;
>> And then .write_raw_get_fmt callback function for parse a fixed-point number from a string.
>> Some description is revised milliseconds unit.
>>
>> This patch have been tested on exynos4 board.
>>
>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>> ---
>>   drivers/iio/light/cm36651.c |   71 ++++++++++++++++++++++++-------------------
>>   1 file changed, 40 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
>> index 0a142af..076780c 100644
>> --- a/drivers/iio/light/cm36651.c
>> +++ b/drivers/iio/light/cm36651.c
>> @@ -50,10 +50,10 @@
>>   #define CM36651_CS_CONF2_DEFAULT_BIT	0x08
>>
>>   /* CS_CONF3 channel integration time */
>> -#define CM36651_CS_IT1			0x00 /* Integration time 80000 usec */
>> -#define CM36651_CS_IT2			0x40 /* Integration time 160000 usec */
>> -#define CM36651_CS_IT3			0x80 /* Integration time 320000 usec */
>> -#define CM36651_CS_IT4			0xC0 /* Integration time 640000 usec */
>> +#define CM36651_CS_IT1			0x00 /* Integration time 80 msec */
>> +#define CM36651_CS_IT2			0x40 /* Integration time 160 msec */
>> +#define CM36651_CS_IT3			0x80 /* Integration time 320 msec */
>> +#define CM36651_CS_IT4			0xC0 /* Integration time 640 msec */
>>
>>   /* PS_CONF1 command code */
>>   #define CM36651_PS_ENABLE		0x00
>> @@ -64,10 +64,10 @@
>>   #define CM36651_PS_PERS4		0x0C
>>
>>   /* PS_CONF1 command code: integration time */
>> -#define CM36651_PS_IT1			0x00 /* Integration time 320 usec */
>> -#define CM36651_PS_IT2			0x10 /* Integration time 420 usec */
>> -#define CM36651_PS_IT3			0x20 /* Integration time 520 usec */
>> -#define CM36651_PS_IT4			0x30 /* Integration time 640 usec */
>> +#define CM36651_PS_IT1			0x00 /* Integration time 0.32 msec */
>> +#define CM36651_PS_IT2			0x10 /* Integration time 0.42 msec */
>> +#define CM36651_PS_IT3			0x20 /* Integration time 0.52 msec */
>> +#define CM36651_PS_IT4			0x30 /* Integration time 0.64 msec */
>>
>>   /* PS_CONF1 command code: duty ratio */
>>   #define CM36651_PS_DR1			0x00 /* Duty ratio 1/80 */
>> @@ -93,8 +93,8 @@
>>   #define CM36651_CLOSE_PROXIMITY		0x32
>>   #define CM36651_FAR_PROXIMITY			0x33
>>
>> -#define CM36651_CS_INT_TIME_AVAIL	"80000 160000 320000 640000"
>> -#define CM36651_PS_INT_TIME_AVAIL	"320 420 520 640"
>> +#define CM36651_CS_INT_TIME_AVAIL	"0.08 0.16 0.32 0.64"
>> +#define CM36651_PS_INT_TIME_AVAIL	"0.000320 0.000420 0.000520 0.000640"
>>
>>   enum cm36651_operation_mode {
>>   	CM36651_LIGHT_EN,
>> @@ -356,30 +356,30 @@ static int cm36651_read_channel(struct cm36651_data *cm36651,
>>   }
>>
>>   static int cm36651_read_int_time(struct cm36651_data *cm36651,
>> -				struct iio_chan_spec const *chan, int *val)
>> +				struct iio_chan_spec const *chan, int *val2)
>>   {
>>   	switch (chan->type) {
>>   	case IIO_LIGHT:
>>   		if (cm36651->cs_int_time[chan->address] == CM36651_CS_IT1)
>> -			*val = 80000;
>> +			*val2 = 80000;
>>   		else if (cm36651->cs_int_time[chan->address] == CM36651_CS_IT2)
>> -			*val = 160000;
>> +			*val2 = 160000;
>>   		else if (cm36651->cs_int_time[chan->address] == CM36651_CS_IT3)
>> -			*val = 320000;
>> +			*val2 = 320000;
>>   		else if (cm36651->cs_int_time[chan->address] == CM36651_CS_IT4)
>> -			*val = 640000;
>> +			*val2 = 640000;
>>   		else
>>   			return -EINVAL;
>>   		break;
>>   	case IIO_PROXIMITY:
>>   		if (cm36651->ps_int_time == CM36651_PS_IT1)
>> -			*val = 320;
>> +			*val2 = 320;
>>   		else if (cm36651->ps_int_time == CM36651_PS_IT2)
>> -			*val = 420;
>> +			*val2 = 420;
>>   		else if (cm36651->ps_int_time == CM36651_PS_IT3)
>> -			*val = 520;
>> +			*val2 = 520;
>>   		else if (cm36651->ps_int_time == CM36651_PS_IT4)
>> -			*val = 640;
>> +			*val2 = 640;
>>   		else
>>   			return -EINVAL;
>>   		break;
>> @@ -387,11 +387,11 @@ static int cm36651_read_int_time(struct cm36651_data *cm36651,
>>   		return -EINVAL;
>>   	}
>>
>> -	return IIO_VAL_INT;
>> +	return IIO_VAL_INT_PLUS_MICRO;
>>   }
>>
>>   static int cm36651_write_int_time(struct cm36651_data *cm36651,
>> -				struct iio_chan_spec const *chan, int val)
>> +				struct iio_chan_spec const *chan, int val2)
> I didn't know why do you change from val to val2?
> This is just changing variable name, isn't?
The reasoning is probably to match names with the variable being passed into
the function.  I'd rather keep the amount of code in a fix like this to a minimum so
perhaps rename the function to cm36641_write_int_time_microsecs or similar to make
it clear what is going on?  If anything that is clearer than the change you have made
here.
>
>>   {
>>   	struct i2c_client *client = cm36651->client;
>>   	struct i2c_client *ps_client = cm36651->ps_client;
>> @@ -399,13 +399,13 @@ static int cm36651_write_int_time(struct cm36651_data *cm36651,
>>
>>   	switch (chan->type) {
>>   	case IIO_LIGHT:
>> -		if (val == 80000)
>> +		if (val2 == 80000)
>>   			int_time = CM36651_CS_IT1;
>> -		else if (val == 160000)
>> +		else if (val2 == 160000)
>>   			int_time = CM36651_CS_IT2;
>> -		else if (val == 320000)
>> +		else if (val2 == 320000)
>>   			int_time = CM36651_CS_IT3;
>> -		else if (val == 640000)
>> +		else if (val2 == 640000)
>>   			int_time = CM36651_CS_IT4;
>>   		else
>>   			return -EINVAL;
>> @@ -419,13 +419,13 @@ static int cm36651_write_int_time(struct cm36651_data *cm36651,
>>   		cm36651->cs_int_time[chan->address] = int_time;
>>   		break;
>>   	case IIO_PROXIMITY:
>> -		if (val == 320)
>> +		if (val2 == 320)
>>   			int_time = CM36651_PS_IT1;
>> -		else if (val == 420)
>> +		else if (val2 == 420)
>>   			int_time = CM36651_PS_IT2;
>> -		else if (val == 520)
>> +		else if (val2 == 520)
>>   			int_time = CM36651_PS_IT3;
>> -		else if (val == 640)
>> +		else if (val2 == 640)
>>   			int_time = CM36651_PS_IT4;
>>   		else
>>   			return -EINVAL;
>> @@ -459,7 +459,8 @@ static int cm36651_read_raw(struct iio_dev *indio_dev,
>>   		ret = cm36651_read_channel(cm36651, chan, val);
>>   		break;
>>   	case IIO_CHAN_INFO_INT_TIME:
>> -		ret = cm36651_read_int_time(cm36651, chan, val);
>> +		*val = 0;
>> +		ret = cm36651_read_int_time(cm36651, chan, val2);
>>   		break;
>>   	default:
>>   		ret = -EINVAL;
>> @@ -479,7 +480,7 @@ static int cm36651_write_raw(struct iio_dev *indio_dev,
>>   	int ret = -EINVAL;
>>
>>   	if (mask == IIO_CHAN_INFO_INT_TIME) {
>> -		ret = cm36651_write_int_time(cm36651, chan, val);
>> +		ret = cm36651_write_int_time(cm36651, chan, val2);
>>   		if (ret < 0)
>>   			dev_err(&client->dev, "Integration time write failed\n");
>>   	}
>> @@ -487,6 +488,13 @@ static int cm36651_write_raw(struct iio_dev *indio_dev,
>>   	return ret;
>>   }
>>
>> +static int cm36651_write_raw_get_fmt(struct iio_dev *indio_dev,
>> +				struct iio_chan_spec const *chan,
>> +				long mask)
>> +{
>> +	return IIO_VAL_INT_PLUS_MICRO;
>> +}
>> +
>>   static int cm36651_read_prox_thresh(struct iio_dev *indio_dev,
>>   					const struct iio_chan_spec *chan,
>>   					enum iio_event_type type,
>> @@ -614,6 +622,7 @@ static const struct iio_info cm36651_info = {
>>   	.driver_module		= THIS_MODULE,
>>   	.read_raw		= &cm36651_read_raw,
>>   	.write_raw		= &cm36651_write_raw,
>> +	.write_raw_get_fmt	= &cm36651_write_raw_get_fmt,
>>   	.read_event_value	= &cm36651_read_prox_thresh,
>>   	.write_event_value	= &cm36651_write_prox_thresh,
>>   	.read_event_config	= &cm36651_read_prox_event_config,
>>
>

