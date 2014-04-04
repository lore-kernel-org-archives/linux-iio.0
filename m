Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16704 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751900AbaDDVeh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 4 Apr 2014 17:34:37 -0400
Message-ID: <533F263D.4090009@linux.intel.com>
Date: Fri, 04 Apr 2014 14:38:05 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 1/5] IIO: core: Introduce read_raw_multi
References: <1393185048-4004-1-git-send-email-srinivas.pandruvada@linux.intel.com> <5336AB4F.4020703@kernel.org>
In-Reply-To: <5336AB4F.4020703@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/29/2014 04:15 AM, Jonathan Cameron wrote:
> On 23/02/14 19:50, Srinivas Pandruvada wrote:
>> This callback is introduced to overcome some limitations of existing
>> read_raw callback. The functionality of both existing read_raw and
>> read_raw_multi is similar, both are used to request values from the
>> device. The current read_raw callback allows only two return values.
>> The new read_raw_multi allows returning multiple values. Instead of
>> passing just address of val and val2, it passes length and pointer
>> to values. Depending on the type and length of passed buffer, iio
>> client drivers can return multiple values.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Hi Srinivas.
>
> Whilst it wasn't the most in depth of discussions, I think the outcome
> of the 'how to handle quaternion sysfs naming' element of the
> thread.
> [RFC] IIO: New interfaces for 'interesting' channel types.
>
> was that we should do them as a modifier instead of a new channel type.
> e.g.
>
> in_rot_quaternion_raw
> etc.
>
> Could you convert this driver over and repost?
>
> If you disagree, then feel free to contribute to that discussion and
> we'll continue from there.
>
> Sorry this took so long to sort out, I was hoping for a few more inputs
> but there we are...
>
Hi Jonathan,

I have resubmitted with the modifier for quaternion dropping this patch.
I only allow buffered mode as without this patch representing in raw mode
all four component is not possible. Current applications only is using 
buffer mode.
So I can wait for core support something similar to this patch.

Thanks,
Srinivas




> Jonathan
>> ---
>>   drivers/iio/iio_core.h           |  2 +-
>>   drivers/iio/industrialio-core.c  | 51 
>> +++++++++++++++++++++++-----------------
>>   drivers/iio/industrialio-event.c |  6 +++--
>>   drivers/iio/inkern.c             | 15 ++++++++++--
>>   include/linux/iio/iio.h          | 16 +++++++++++++
>>   5 files changed, 63 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
>> index f6db6af..4172f22 100644
>> --- a/drivers/iio/iio_core.h
>> +++ b/drivers/iio/iio_core.h
>> @@ -35,7 +35,7 @@ int __iio_add_chan_devattr(const char *postfix,
>>                  struct list_head *attr_list);
>>   void iio_free_chan_devattr_list(struct list_head *attr_list);
>>
>> -ssize_t iio_format_value(char *buf, unsigned int type, int val, int 
>> val2);
>> +ssize_t iio_format_value(char *buf, unsigned int type, int *val);
>>
>>   /* Event interface flags */
>>   #define IIO_BUSY_BIT_POS 1
>> diff --git a/drivers/iio/industrialio-core.c 
>> b/drivers/iio/industrialio-core.c
>> index acc911a..b1225a4 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -373,41 +373,42 @@ EXPORT_SYMBOL_GPL(iio_enum_write);
>>    * @buf: The buffer to which the formated value gets written
>>    * @type: One of the IIO_VAL_... constants. This decides how the 
>> val and val2
>>    *        parameters are formatted.
>> - * @val: First part of the value, exact meaning depends on the type 
>> parameter.
>> - * @val2: Second part of the value, exact meaning depends on the 
>> type parameter.
>> + * @vals: pointer to the values, exact meaning depends on the type 
>> parameter.
>>    */
>> -ssize_t iio_format_value(char *buf, unsigned int type, int val, int 
>> val2)
>> +ssize_t iio_format_value(char *buf, unsigned int type, int *vals)
>>   {
>>       unsigned long long tmp;
>>       bool scale_db = false;
>>
>>       switch (type) {
>>       case IIO_VAL_INT:
>> -        return sprintf(buf, "%d\n", val);
>> +        return sprintf(buf, "%d\n", vals[0]);
>>       case IIO_VAL_INT_PLUS_MICRO_DB:
>>           scale_db = true;
>>       case IIO_VAL_INT_PLUS_MICRO:
>> -        if (val2 < 0)
>> -            return sprintf(buf, "-%ld.%06u%s\n", abs(val), -val2,
>> +        if (vals[1] < 0)
>> +            return sprintf(buf, "-%ld.%06u%s\n", abs(vals[0]),
>> +                    -vals[1],
>>                   scale_db ? " dB" : "");
>>           else
>> -            return sprintf(buf, "%d.%06u%s\n", val, val2,
>> +            return sprintf(buf, "%d.%06u%s\n", vals[0], vals[1],
>>                   scale_db ? " dB" : "");
>>       case IIO_VAL_INT_PLUS_NANO:
>> -        if (val2 < 0)
>> -            return sprintf(buf, "-%ld.%09u\n", abs(val), -val2);
>> +        if (vals[1] < 0)
>> +            return sprintf(buf, "-%ld.%09u\n", abs(vals[0]),
>> +                    -vals[1]);
>>           else
>> -            return sprintf(buf, "%d.%09u\n", val, val2);
>> +            return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
>>       case IIO_VAL_FRACTIONAL:
>> -        tmp = div_s64((s64)val * 1000000000LL, val2);
>> -        val2 = do_div(tmp, 1000000000LL);
>> -        val = tmp;
>> -        return sprintf(buf, "%d.%09u\n", val, val2);
>> +        tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
>> +        vals[1] = do_div(tmp, 1000000000LL);
>> +        vals[0] = tmp;
>> +        return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
>>       case IIO_VAL_FRACTIONAL_LOG2:
>> -        tmp = (s64)val * 1000000000LL >> val2;
>> -        val2 = do_div(tmp, 1000000000LL);
>> -        val = tmp;
>> -        return sprintf(buf, "%d.%09u\n", val, val2);
>> +        tmp = (s64)vals[0] * 1000000000LL >> vals[1];
>> +        vals[1] = do_div(tmp, 1000000000LL);
>> +        vals[0] = tmp;
>> +        return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
>>       default:
>>           return 0;
>>       }
>> @@ -419,14 +420,20 @@ static ssize_t iio_read_channel_info(struct 
>> device *dev,
>>   {
>>       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>       struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> -    int val, val2;
>> -    int ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
>> -                        &val, &val2, this_attr->address);
>> +    int vals[INDIO_MAX_RAW_ELEMENTS];
>> +    int ret;
>> +
>> +    if (indio_dev->info->read_raw_multi)
>> +        ret = indio_dev->info->read_raw_multi(indio_dev, this_attr->c,
>> +                INDIO_MAX_RAW_ELEMENTS, vals, this_attr->address);
>> +    else
>> +        ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
>> +                    &vals[0], &vals[1], this_attr->address);
>>
>>       if (ret < 0)
>>           return ret;
>>
>> -    return iio_format_value(buf, ret, val, val2);
>> +    return iio_format_value(buf, ret, vals);
>>   }
>>
>>   /**
>> diff --git a/drivers/iio/industrialio-event.c 
>> b/drivers/iio/industrialio-event.c
>> index c9c1419..0f7f78e 100644
>> --- a/drivers/iio/industrialio-event.c
>> +++ b/drivers/iio/industrialio-event.c
>> @@ -272,7 +272,7 @@ static ssize_t iio_ev_value_show(struct device *dev,
>>   {
>>       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>       struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> -    int val, val2;
>> +    int val, val2, val_arr[2];
>>       int ret;
>>
>>       ret = indio_dev->info->read_event_value(indio_dev,
>> @@ -281,7 +281,9 @@ static ssize_t iio_ev_value_show(struct device *dev,
>>           &val, &val2);
>>       if (ret < 0)
>>           return ret;
>> -    return iio_format_value(buf, ret, val, val2);
>> +    val_arr[0] = val;
>> +    val_arr[1] = val2;
>> +    return iio_format_value(buf, ret, val_arr);
>>   }
>>
>>   static ssize_t iio_ev_value_store(struct device *dev,
>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>> index 0cf5f8e..6a93d57 100644
>> --- a/drivers/iio/inkern.c
>> +++ b/drivers/iio/inkern.c
>> @@ -417,12 +417,23 @@ static int iio_channel_read(struct iio_channel 
>> *chan, int *val, int *val2,
>>       enum iio_chan_info_enum info)
>>   {
>>       int unused;
>> +    int vals[INDIO_MAX_RAW_ELEMENTS];
>> +    int ret;
>>
>>       if (val2 == NULL)
>>           val2 = &unused;
>>
>> -    return chan->indio_dev->info->read_raw(chan->indio_dev, 
>> chan->channel,
>> -                        val, val2, info);
>> +    if (chan->indio_dev->info->read_raw_multi) {
>> +        ret = chan->indio_dev->info->read_raw_multi(chan->indio_dev,
>> +                    chan->channel, INDIO_MAX_RAW_ELEMENTS,
>> +                    vals, info);
>> +        *val = vals[0];
>> +        *val2 = vals[1];
>> +    } else
>> +        ret = chan->indio_dev->info->read_raw(chan->indio_dev,
>> +                    chan->channel, val, val2, info);
>> +
>> +    return ret;
>>   }
>>
>>   int iio_read_channel_raw(struct iio_channel *chan, int *val)
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index 75a8a20..ddf9f60 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -284,6 +284,8 @@ static inline s64 iio_get_time_ns(void)
>>   #define INDIO_ALL_BUFFER_MODES                    \
>>       (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE)
>>
>> +#define INDIO_MAX_RAW_ELEMENTS        4
>> +
>>   struct iio_trigger; /* forward declaration */
>>   struct iio_dev;
>>
>> @@ -298,6 +300,14 @@ struct iio_dev;
>>    *            the channel in question.  Return value will specify the
>>    *            type of value returned by the device. val and val2 will
>>    *            contain the elements making up the returned value.
>> + * @read_raw_multi:    function to return values from the device.
>> + *            mask specifies which value. Note 0 means a reading of
>> + *            the channel in question.  Return value will specify the
>> + *            type of value returned by the device. vals pointer
>> + *            contain the elements making up the returned value.
>> + *            val_len specifies maximum number of elements
>> + *            vals pointer can contain. In contrast to to read_raw
>> + *            device can return multiple values not just two.
>>    * @write_raw:        function to write a value to the device.
>>    *            Parameters are the same as for read_raw.
>>    * @write_raw_get_fmt:    callback function to query the expected
>> @@ -324,6 +334,12 @@ struct iio_info {
>>               int *val2,
>>               long mask);
>>
>> +    int (*read_raw_multi)(struct iio_dev *indio_dev,
>> +            struct iio_chan_spec const *chan,
>> +            int val_len,
>> +            int *vals,
>> +            long mask);
>> +
>>       int (*write_raw)(struct iio_dev *indio_dev,
>>                struct iio_chan_spec const *chan,
>>                int val,
>>
>
>

