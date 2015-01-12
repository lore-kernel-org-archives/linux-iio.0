Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48052 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbbALVYE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jan 2015 16:24:04 -0500
Message-ID: <54B43B70.4070501@kernel.org>
Date: Mon, 12 Jan 2015 21:24:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	jkosina@suse.cz, a.zummo@towertech.it
CC: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	holler@ahsoftware.de, rtc-linux@googlegroups.com
Subject: Re: [PATCH 2/9] iio: hid-sensor-accel-3d: Adjust parameter for attribute
 read
References: <1420656483-7093-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1420656483-7093-3-git-send-email-srinivas.pandruvada@linux.intel.com> <54B1AAD6.6070303@kernel.org> <54B30286.7090106@linux.intel.com> <54B30610.3070907@linux.intel.com>
In-Reply-To: <54B30610.3070907@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/01/15 23:24, Srinivas Pandruvada wrote:
> 
> On 01/11/2015 03:08 PM, Srinivas Pandruvada wrote:
>>
>> On 01/10/2015 02:42 PM, Jonathan Cameron wrote:
>>> On 07/01/15 18:47, Srinivas Pandruvada wrote:
>>>> The new API added a flag for sync/async mode. Added sync mode flag.
>>>>
>>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>> Again, please don't break the build between patches like this.
>> As we did in the past, the hid sensor hub patches involving hid sensor and IIO part goes through one tree, either via IIO or HID.
>> So once acked this needs to go through a single tree, as done in the past.
>> So the patches submitted in a series to avoid breaking build.
>>
> Ignore this comment.
> Is this not a common procedure for API change? Single patch touching various subsystem, will be more difficult to apply.
Take one more step in doing it.
First you introduce a new function with the arguments changed
as you like.

Second you move all calls over to the new function.

Third you kill off the old function - sometimes you also do an easily
verified rename of all functions at once.

How the last patch gets applied is rather dependent on what it touches.
If just a couple of subsystems, then the maintainers tend to agree on who
is taking the series and if useful they create an immutable branch which
can then be pulled into any trees that need the change.  Doesn't matter
who ends up sending the pull request to Linus as Git will sort it all out.

If it's really kernel wide, then you need to get in touch with Linus.
Typically these are done at very specific points in the merge cycle - often
either just before or just after rc1 I think.

Rafael did one of these whilst changing some stuff with power management
kconfig dependencies in the last cycle.  It bit me because I was
running a couple of months behind mainline, but mostly it went in
without causing trouble.

Here, I'd probably just Ack the series and let Jiri pick it up and
keep a vague eye open for possible merge conflicts later in the cycle.


Jonathan
> 
> 
>> Thanks,
>> Srinivas
>>>
>>> If you want to do things in steps, you'll have to carry to versions of
>>> the function during the conversion and drop the unwanted one at the end.
>>>
>>>> ---
>>>>   drivers/iio/accel/hid-sensor-accel-3d.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
>>>> index d5d9531..0085c2f 100644
>>>> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
>>>> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
>>>> @@ -130,7 +130,8 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
>>>>               *val = sensor_hub_input_attr_get_raw_value(
>>>>                       accel_state->common_attributes.hsdev,
>>>>                       HID_USAGE_SENSOR_ACCEL_3D, address,
>>>> -                    report_id);
>>>> +                    report_id,
>>>> +                    SENSOR_HUB_SYNC);
>>>>           else {
>>>>               *val = 0;
>>>> hid_sensor_power_state(&accel_state->common_attributes,
>>>>
>>>
>>
> 

