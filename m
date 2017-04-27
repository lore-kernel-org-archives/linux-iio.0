Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37950 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933656AbdD0GRl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 02:17:41 -0400
Subject: Re: [PATCH] iio: hid-sensor: fix return of -EINVAL on invalid values
 in ret or value
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Colin King <colin.king@canonical.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Song Hongyan <hongyan.song@intel.com>,
        hock.leong.kweh@intel.com, linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170419143548.14130-1-colin.king@canonical.com>
 <8b33d431-4c3b-fb94-539c-a35cb3a123cc@kernel.org>
 <1493214945.21220.15.camel@linux.intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fc005c1c-a080-7f9a-240f-d63d19da0ef0@kernel.org>
Date: Thu, 27 Apr 2017 07:17:34 +0100
MIME-Version: 1.0
In-Reply-To: <1493214945.21220.15.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/04/17 14:55, Srinivas Pandruvada wrote:
> On Wed, 2017-04-26 at 07:32 +0100, Jonathan Cameron wrote:
>> On 19/04/17 15:35, Colin King wrote:
>>>
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Ensure that when an invalid value in ret or value is found -EINVAL
>>> is returned. A previous commit broke the way the return error is
>>> being returned and instead caused the return code in ret to be
>>> re-assigned rather than be returned.
>>>
>>> Fixes: 5d9854eaea776 ("iio: hid-sensor: Store restore poll and
>>> hysteresis on S3")
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> Given the 'fun' we have had with this on recently Srinivas, could you
>> sanity check what looks like an obviously correct patch?
> Sorry for not paying enough attention to this patch.
> If the set_feature() fails, the get_feature will also fail as only time
> they will fail if the element is not supported. Invalid values are
> silently rejected or in some hubs caps to nearest good value.
> 
> But patch itself is fine, but not an urgent one. It can go with normal
> release cycle.
> 
> Thanks,
> Srinivas
Thanks,

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Jonathan
> 
>>
>> I'm being overly paranoid for a while ;)
>>
>> Jonathan
>>>
>>> ---
>>>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c 
>>> b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>>> index 1c0874cdf665..aeb09a85d7a8 100644
>>> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>>> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
>>> @@ -230,7 +230,7 @@ int hid_sensor_write_samp_freq_value(struct
>>> hid_sensor_common *st,
>>>  	ret = sensor_hub_set_feature(st->hsdev, st-
>>>> poll.report_id,
>>>  				     st->poll.index,
>>> sizeof(value), &value);
>>>  	if (ret < 0 || value < 0)
>>> -		ret = -EINVAL;
>>> +		return -EINVAL;
>>>  
>>>  	ret = sensor_hub_get_feature(st->hsdev,
>>>  				     st->poll.report_id,
>>> @@ -283,7 +283,7 @@ int hid_sensor_write_raw_hyst_value(struct
>>> hid_sensor_common *st,
>>>  				     st->sensitivity.index,
>>> sizeof(value),
>>>  				     &value);
>>>  	if (ret < 0 || value < 0)
>>> -		ret = -EINVAL;
>>> +		return -EINVAL;
>>>  
>>>  	ret = sensor_hub_get_feature(st->hsdev,
>>>  				     st->sensitivity.report_id,
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

