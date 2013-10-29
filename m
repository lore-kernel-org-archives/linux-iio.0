Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49151 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab3J2Gyq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 02:54:46 -0400
In-Reply-To: <526EF6ED.4010900@linux.intel.com>
References: <1382555476-15826-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1382555476-15826-8-git-send-email-srinivas.pandruvada@linux.intel.com> <52690209.8020604@kernel.org> <526939F3.9060303@linux.intel.com> <526948E9.4020507@kernel.org> <526EF6ED.4010900@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v2 8/9] iio: Add channel modifiers for Quaternion Rotations
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 29 Oct 2013 06:54:40 +0000
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Message-ID: <d4528ff0-e1a2-4f8a-a9f7-cb144f296895@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
>On 10/24/2013 09:20 AM, Jonathan Cameron wrote:
>> On 10/24/13 16:17, Srinivas Pandruvada wrote:
>>> Hi Jonathan,
>>> On 10/24/2013 04:18 AM, Jonathan Cameron wrote:
>>>> On 10/23/13 20:11, Srinivas Pandruvada wrote:
>>>>> A quaternion is composed of four components: a vector with x, y, z
>>>>> coordinates and a w rotation. Added channel modifiers for
>exporting
>>>>> these four components via user space.
>>>>>
>>>>> Signed-off-by: Srinivas Pandruvada
><srinivas.pandruvada@linux.intel.com>
>>>> Quaternions are one of the 'interesting' cases that make me wonder
>if we need
>>>> a slightly more generic form of read_raw.  The quaternion only has
>meaning
>>>> with an associated scale.  Hence you really have to guarantee that
>you can grab all
>>>> 4 components together.
>What if we add two members in iio_chan_info:
>IIO_CHAN_INFO_TRIG_RAW_SYNC  (WR): To trigger a read of and store
>sample 
>in internal memory
>(As per HID sensor spec you have to read/write all quaternion
>components 
>together, data is also packed together. )
>IIO_CHAN_INFO_RAW_SYNC  (RD): To return individual channel raw data 
>captured during IIO_CHAN_INFO_TRIG_RAW_SYNC
>In this way four reads will give all component data but they are
>related 
>to each other.
That is a bit ugly. I would rather consider a single channel that outputs all 4 components and change the handling to cope.
If people want synchronized data across multiple normal channels then they should be using the buffer...
>>>>
>>>> Do we need to rethink how the read callback works?
>>>>
>>>> Mind you, if we do that then we need to extend the description of
>the buffer element
>>>> in the scan_mask.  We could define a compound description for a
>channel, but that is 'interesting'.
>For scan elements we have to specify a way so that the scan_elem
>doesn't 
>contain per channel enable/disable.
>We create one global channel enable sysfs entry. This is what you are 
>thinking?
No. Either we have a single channel which contains all 4 components or just handle them separately. If anyone requests only some of them from user space it does not matter to us even if the data will be useless.
>
>Thanks,
>Srinivas
>
>
>>>> I also don't like this being defined as type IIO_ROT - the units
>(such as exist are different).
>>>> See next patch for what I'm referring to here.
>>> I didn't receive your next patch with comments. Can you please
>resend?
>>> Thanks,
>> Sorry for not being clear, I simply meant the IIO_ROT bit was in the
>next batch,
>> but as it is connected to my comment here, didn't want to start
>another discussion
>> in reply to that patch.
>>
>> (hence I never replied to that patch)
>>> Srinivas
>>>> I've cc'd a few people who might have views on this.
>>>>
>>>>
>>>>
>>>>> ---
>>>>>    drivers/iio/industrialio-core.c | 4 ++++
>>>>>    include/linux/iio/types.h       | 4 ++++
>>>>>    2 files changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iio/industrialio-core.c
>b/drivers/iio/industrialio-core.c
>>>>> index f95c697..4ffaead 100644
>>>>> --- a/drivers/iio/industrialio-core.c
>>>>> +++ b/drivers/iio/industrialio-core.c
>>>>> @@ -80,6 +80,10 @@ static const char * const iio_modifier_names[]
>= {
>>>>>        [IIO_MOD_LIGHT_RED] = "red",
>>>>>        [IIO_MOD_LIGHT_GREEN] = "green",
>>>>>        [IIO_MOD_LIGHT_BLUE] = "blue",
>>>>> +    [IIO_MOD_QUATERNION_X] = "quat_x",
>>>>> +    [IIO_MOD_QUATERNION_Y] = "quat_y",
>>>>> +    [IIO_MOD_QUATERNION_Z] = "quat_z",
>>>>> +    [IIO_MOD_QUATERNION_W] = "quat_w",
>>>>>    };
>>>>>      /* relies on pairs of these shared then separate */
>>>>> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
>>>>> index 88bf0f0..ac2345c 100644
>>>>> --- a/include/linux/iio/types.h
>>>>> +++ b/include/linux/iio/types.h
>>>>> @@ -52,6 +52,10 @@ enum iio_modifier {
>>>>>        IIO_MOD_LIGHT_RED,
>>>>>        IIO_MOD_LIGHT_GREEN,
>>>>>        IIO_MOD_LIGHT_BLUE,
>>>>> +    IIO_MOD_QUATERNION_X,
>>>>> +    IIO_MOD_QUATERNION_Y,
>>>>> +    IIO_MOD_QUATERNION_Z,
>>>>> +    IIO_MOD_QUATERNION_W,
>>>>>    };
>>>>>      #define IIO_VAL_INT 1
>>>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
