Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59878 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab3KFIVa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Nov 2013 03:21:30 -0500
In-Reply-To: <527988E3.6010900@linux.intel.com>
References: <1383173333-18618-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1383173333-18618-7-git-send-email-srinivas.pandruvada@linux.intel.com> <52797AF9.2080502@kernel.org> <527988E3.6010900@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v3 7/8] iio: Add quaternion channel
From: Jonathan Cameron <jic23@kernel.org>
Date: Wed, 06 Nov 2013 07:58:45 +0000
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Message-ID: <83ccbb80-ad75-4ecd-bc79-914525420679@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>On 11/05/2013 03:10 PM, Jonathan Cameron wrote:
>> On 10/30/13 22:48, Srinivas Pandruvada wrote:
>>> A quaternion channel type is added. Here channel information is
>>> composed of four components: a vector with x, y, z coordinates and
>>> a w rotation. Reusing x, y, z channel modifiers, but added "w"
>>> component in the modifier list.
>>>
>>> Signed-off-by: Srinivas Pandruvada
><srinivas.pandruvada@linux.intel.com>
>> In brief I am against this for the same reason I didn't like this
>before.
>> A quaternion has no meaning if it isn't all present.  Hence we need
>to
>> ensure that it is always presented to userspace with all four
>components
>> present.
>>
>> I'll hopefully have a few mins at the weekend to to bash out some
>example
>> code for how I would suggest we handle this.
>>
>> If you could repost the patches before this one with everything that
>should
>> be in them then hopefully we can take those whilst still 'discussing'
>> how to handle the last 2!
>Sorry about the issues with previous patches. I was trying to order new
>
>driver at the end and missed dependencies.

Not to worry. We all make that mistake occasionally!
>I have applied all patches which I am sending after this email safely 
>apply to fixes-togreg branch.
>For the last two, I will wait for your suggestion.
>
>Thanks,
>Srinivas
>>
>> Jonathan
>>> ---
>>>   drivers/iio/industrialio-core.c | 2 ++
>>>   include/linux/iio/types.h       | 2 ++
>>>   2 files changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/iio/industrialio-core.c
>b/drivers/iio/industrialio-core.c
>>> index f95c697..b754f50 100644
>>> --- a/drivers/iio/industrialio-core.c
>>> +++ b/drivers/iio/industrialio-core.c
>>> @@ -66,6 +66,7 @@ static const char * const
>iio_chan_type_name_spec[] = {
>>>   	[IIO_ALTVOLTAGE] = "altvoltage",
>>>   	[IIO_CCT] = "cct",
>>>   	[IIO_PRESSURE] = "pressure",
>>> +	[IIO_QUAT_ROT] = "quat_rot",
>>>   };
>>>   
>>>   static const char * const iio_modifier_names[] = {
>>> @@ -80,6 +81,7 @@ static const char * const iio_modifier_names[] = {
>>>   	[IIO_MOD_LIGHT_RED] = "red",
>>>   	[IIO_MOD_LIGHT_GREEN] = "green",
>>>   	[IIO_MOD_LIGHT_BLUE] = "blue",
>>> +	[IIO_MOD_W] = "w",
>>>   };
>>>   
>>>   /* relies on pairs of these shared then separate */
>>> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
>>> index 88bf0f0..4565f5c 100644
>>> --- a/include/linux/iio/types.h
>>> +++ b/include/linux/iio/types.h
>>> @@ -29,6 +29,7 @@ enum iio_chan_type {
>>>   	IIO_ALTVOLTAGE,
>>>   	IIO_CCT,
>>>   	IIO_PRESSURE,
>>> +	IIO_QUAT_ROT,
>>>   };
>>>   
>>>   enum iio_modifier {
>>> @@ -52,6 +53,7 @@ enum iio_modifier {
>>>   	IIO_MOD_LIGHT_RED,
>>>   	IIO_MOD_LIGHT_GREEN,
>>>   	IIO_MOD_LIGHT_BLUE,
>>> +	IIO_MOD_W,
>>>   };
>>>   
>>>   #define IIO_VAL_INT 1
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
