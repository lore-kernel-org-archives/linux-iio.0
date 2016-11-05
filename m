Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51377 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755147AbcKERxW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2016 13:53:22 -0400
Subject: Re: [PATCH] iio: hid-sensor-als: Add realtime data type parse support
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Song, Hongyan" <hongyan.song@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1477617606-29362-1-git-send-email-hongyan.song@intel.com>
 <aa4b33a0-01a8-8395-0943-b31aae4904bb@kernel.org>
 <1477874099.8025.51.camel@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3ffbed3f-1e20-c1be-bb92-778da166bd68@kernel.org>
Date: Sat, 5 Nov 2016 17:53:20 +0000
MIME-Version: 1.0
In-Reply-To: <1477874099.8025.51.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/10/16 00:37, Pandruvada, Srinivas wrote:
> On Sun, 2016-10-30 at 16:26 +0000, Jonathan Cameron wrote:
>> On 28/10/16 02:20, Song Hongyan wrote:
>>>
>>> In parse report function it only support to parse absolute data
>>> type
>>> reported. Some platforms which report realtime data cannot be
>>> parsed,
>>> they will get "Invalid Argument" when try to get sensor data.
>>>
>>> Add realtime data type support to match different platforms.
>> I'm not 100% sure that rel stands for real time here...
>>
>> Relative percent?  There is also a percent of range option though no
>> idea if any hardware actually uses that.
>>
>> Srinivas, could you take a look at this one as well.
> I asked Hongyan to post to mailing list to seek some opinion.
> The IIO ABI hysteresis is absolute value, but this will specify a
> relative value with percentage.
> I think we need a new ABI.
Agreed.
> 
> Thanks,
> Srinivas
> 
> 
>>
>> thanks,
>>
>> Jonathan
>>>
>>>
>>> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
>>> ---
>>>  drivers/iio/light/hid-sensor-als.c | 11 +++++++++++
>>>  include/linux/hid-sensor-ids.h     |  1 +
>>>  2 files changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/iio/light/hid-sensor-als.c
>>> b/drivers/iio/light/hid-sensor-als.c
>>> index 8bb1f90..3b3aa66 100644
>>> --- a/drivers/iio/light/hid-sensor-als.c
>>> +++ b/drivers/iio/light/hid-sensor-als.c
>>> @@ -252,6 +252,17 @@ static int als_parse_report(struct
>>> platform_device *pdev,
>>>  			st->common_attributes.sensitivity.index,
>>>  			st-
>>>> common_attributes.sensitivity.report_id);
>>>  	}
>>> +	if (st->common_attributes.sensitivity.index < 0) {
>>> +		sensor_hub_input_get_attribute_info(hsdev,
>>> +			HID_FEATURE_REPORT, usage_id,
>>> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVI
>>> TY_REL_PCT |
>>> +			HID_USAGE_SENSOR_LIGHT_ILLUM,
>>> +			&st->common_attributes.sensitivity);
>>> +		dev_dbg(&pdev->dev, "Sensitivity index:report
>>> %d:%d\n",
>>> +			st->common_attributes.sensitivity.index,
>>> +			st-
>>>> common_attributes.sensitivity.report_id);
>>> +	}
>>> +
>>>  	return ret;
>>>  }
>>>  
>>> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-
>>> sensor-ids.h
>>> index f2ee90a..755f5e2 100644
>>> --- a/include/linux/hid-sensor-ids.h
>>> +++ b/include/linux/hid-sensor-ids.h
>>> @@ -141,6 +141,7 @@
>>>  /* Per data field properties */
>>>  #define HID_USAGE_SENSOR_DATA_MOD_NONE				
>>> 	0x00
>>>  #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		
>>> 0x1000
>>> +#define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT	
>>> 	0xE000
>>>  
>>>  /* Power state enumerations */
>>>  #define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM	0x
>>> 200850

