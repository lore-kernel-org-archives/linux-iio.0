Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55824 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753940Ab3JXPk7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 24 Oct 2013 11:40:59 -0400
Message-ID: <52693F77.80105@linux.intel.com>
Date: Thu, 24 Oct 2013 08:40:39 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/9] iio: hid_Sensors: fix crash during trigger unregister
References: <1382555476-15826-1-git-send-email-srinivas.pandruvada@linux.intel.com> <5268F995.3010004@kernel.org> <52693AE2.2030203@metafoo.de>
In-Reply-To: <52693AE2.2030203@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/2013 08:21 AM, Lars-Peter Clausen wrote:
> On 10/24/2013 12:42 PM, Jonathan Cameron wrote:
>> On 10/23/13 20:11, Srinivas Pandruvada wrote:
>>> We can't store the trigger instance created by iio_trigger_alloc, in
>>> trig field of iio_device structure. This needs to be stored in the
>>> driver private data. Othewise it can result in crash during module
>>> unload. Hence created a trig_ptr in the common data structure
>>> for each HID sensor IIO driver and storing here.
>>>
>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Other than the use of a void * this is fine. Please fix that little issue
>> up...
>>> --- a/include/linux/hid-sensor-hub.h
>>> +++ b/include/linux/hid-sensor-hub.h
>>> @@ -184,6 +184,7 @@ struct hid_sensor_common {
>>>   	struct platform_device *pdev;
>>>   	unsigned usage_id;
>>>   	bool data_ready;
>>> +	void *trig_ptr;
>> Why a void *?  It's struct iio_trigger *
>> Just put
>> struct iio_trigger;
>> above if you want to (reasonably) avoid including the
>> header.  Don't use a void pointer unless you really have no way
>> of knowing what the type is.
> Also just 'trigger' might be a better name then 'trig_ptr'.
Will change in next patch along with the suggestions from Jonathan.

Thanks,
Srinivas
>>>   	struct hid_sensor_hub_attribute_info poll;
>>>   	struct hid_sensor_hub_attribute_info report_state;
>>>   	struct hid_sensor_hub_attribute_info power_state;
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

