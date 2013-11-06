Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <527988E3.6010900@linux.intel.com>
Date: Tue, 05 Nov 2013 16:10:11 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 7/8] iio: Add quaternion channel
References: <1383173333-18618-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1383173333-18618-7-git-send-email-srinivas.pandruvada@linux.intel.com> <52797AF9.2080502@kernel.org>
In-Reply-To: <52797AF9.2080502@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 11/05/2013 03:10 PM, Jonathan Cameron wrote:
> On 10/30/13 22:48, Srinivas Pandruvada wrote:
>> A quaternion channel type is added. Here channel information is
>> composed of four components: a vector with x, y, z coordinates and
>> a w rotation. Reusing x, y, z channel modifiers, but added "w"
>> component in the modifier list.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> In brief I am against this for the same reason I didn't like this before.
> A quaternion has no meaning if it isn't all present.  Hence we need to
> ensure that it is always presented to userspace with all four components
> present.
>
> I'll hopefully have a few mins at the weekend to to bash out some example
> code for how I would suggest we handle this.
>
> If you could repost the patches before this one with everything that should
> be in them then hopefully we can take those whilst still 'discussing'
> how to handle the last 2!
Sorry about the issues with previous patches. I was trying to order new 
driver at the end and missed dependencies.
I have applied all patches which I am sending after this email safely 
apply to fixes-togreg branch.
For the last two, I will wait for your suggestion.

Thanks,
Srinivas
>
> Jonathan
>> ---
>>   drivers/iio/industrialio-core.c | 2 ++
>>   include/linux/iio/types.h       | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index f95c697..b754f50 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -66,6 +66,7 @@ static const char * const iio_chan_type_name_spec[] = {
>>   	[IIO_ALTVOLTAGE] = "altvoltage",
>>   	[IIO_CCT] = "cct",
>>   	[IIO_PRESSURE] = "pressure",
>> +	[IIO_QUAT_ROT] = "quat_rot",
>>   };
>>   
>>   static const char * const iio_modifier_names[] = {
>> @@ -80,6 +81,7 @@ static const char * const iio_modifier_names[] = {
>>   	[IIO_MOD_LIGHT_RED] = "red",
>>   	[IIO_MOD_LIGHT_GREEN] = "green",
>>   	[IIO_MOD_LIGHT_BLUE] = "blue",
>> +	[IIO_MOD_W] = "w",
>>   };
>>   
>>   /* relies on pairs of these shared then separate */
>> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
>> index 88bf0f0..4565f5c 100644
>> --- a/include/linux/iio/types.h
>> +++ b/include/linux/iio/types.h
>> @@ -29,6 +29,7 @@ enum iio_chan_type {
>>   	IIO_ALTVOLTAGE,
>>   	IIO_CCT,
>>   	IIO_PRESSURE,
>> +	IIO_QUAT_ROT,
>>   };
>>   
>>   enum iio_modifier {
>> @@ -52,6 +53,7 @@ enum iio_modifier {
>>   	IIO_MOD_LIGHT_RED,
>>   	IIO_MOD_LIGHT_GREEN,
>>   	IIO_MOD_LIGHT_BLUE,
>> +	IIO_MOD_W,
>>   };
>>   
>>   #define IIO_VAL_INT 1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
