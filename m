Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48063 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbALVZ6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 12 Jan 2015 16:25:58 -0500
Message-ID: <54B43BE4.6040909@kernel.org>
Date: Mon, 12 Jan 2015 21:25:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] iio: magnetometer: ak8975: Add AK8963
References: <1420846238-31802-1-git-send-email-srinivas.pandruvada@linux.intel.com> <54B1706A.3080809@kernel.org> <54B30186.3030104@linux.intel.com>
In-Reply-To: <54B30186.3030104@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/01/15 23:04, Srinivas Pandruvada wrote:
> 
> On 01/10/2015 10:33 AM, Jonathan Cameron wrote:
>> On 09/01/15 23:30, Srinivas Pandruvada wrote:
>>> Added AK8963 in the id table. Unfortunately some commercial devices
>>> using caps version ak8963.
>>>
>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Hmm. I'm not sure what the general opinion on supporting this sort of
>> mess up is.
> This string comes from manufacturer provided BIOS (via ACPI config).
> 
> Thanks,
> Srinivas
grr, guess we'll have to take it then.  I'm tempted to add a comment
saying it is strictly as a work around though..
> 
>> Are we talking naming provided from a device tree or via old fashioned board
>> files?  If the board files I'd be inclined to say they are running a custom
>> kernel anyway so can patch this driver themselves.  If device tree I guess
>> we probably do need to support it - perhaps as a deprecated binding?
>>
>> Wolfram / Jean - you guys must have seen this before. Did you let
>> the capital form in alongside the lower case one?  I guessing no ;)
>>
>> I did a quick grep of hwmon and couldn't find any instances of this...
>>
>> Jonathan
>>> ---
>>>   drivers/iio/magnetometer/ak8975.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
>>> index 0d10a4b..b13936d 100644
>>> --- a/drivers/iio/magnetometer/ak8975.c
>>> +++ b/drivers/iio/magnetometer/ak8975.c
>>> @@ -813,6 +813,7 @@ static int ak8975_probe(struct i2c_client *client,
>>>   static const struct i2c_device_id ak8975_id[] = {
>>>       {"ak8975", AK8975},
>>>       {"ak8963", AK8963},
>>> +    {"AK8963", AK8963},
>>>       {"ak09911", AK09911},
>>>       {"ak09912", AK09912},
>>>       {}
>>>
>>
> 

