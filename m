Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37876 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbcGTPLH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jul 2016 11:11:07 -0400
Subject: Re: [PATCH 0/5] hwmon: New hwmon registration API
To: Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>
References: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
 <d83c43cc-dfa3-684d-9315-e1eec5cd79fe@kernel.org>
 <5782EEBB.1040209@roeck-us.net>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <af94ec36-b77d-96f8-ff15-2cfbbe89c3fa@kernel.org>
Date: Wed, 20 Jul 2016 16:11:04 +0100
MIME-Version: 1.0
In-Reply-To: <5782EEBB.1040209@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/07/16 01:56, Guenter Roeck wrote:
> Hi Jonathan,
> 
> On 07/10/2016 09:00 AM, Jonathan Cameron wrote:
>> On 26/06/16 04:26, Guenter Roeck wrote:
>>> Up to now, each hwmon driver has to implement its own sysfs attributes.
>>> This requires a lot of template code, and distracts from the driver's
>>> core function to read and write chip registers.
>>>
>>> To be able to reduce driver complexity, move sensor attribute handling
>>> and thermal zone registration into the hwmon core. By using the new API,
>>> driver size is typically reduced by 20-50% depending on driver complexity
>>> and the number of sysfs attributes supported.
>>>
>>> The first patch of the series introduces the API as well as support
>>> for temperature sensors. Subsequent patches introduce support for
>>> voltage, current, power, energy, humidity, and fan speed sensors.
>>>
>>> The series was tested by converting several drivers (lm75, lm90, tmp102,
>>> tmp421, ltc4245) to the new API. Testing was done with with real chips
>>> as well as with the hwmon driver module test code available at
>>> https://github.com/groeck/module-tests.
>> Some cool stuff hiding in there :)
>>
>> I've only reviewed 1 and 7 and the intermediate ones are really either
>> correct or they aren't and they look fine to me.
>>
> Thanks a lot for your feedback - it is reassuring that it looks sane to you.
> 
>>
>> So what's next? (beyond presumably a lot of driver conversions).
>>
> Next steps will be to address your comments, re-test, submit a new series,
> add to -next after v4.8-rc1 is out, submit the conversions I have done
> and add to -next. Then, obviously, only accept new drivers using the
> new API.
> 
> Not sure if there is anything else we can or want to do do at this time.
> Do you have anything in mind ?
> 
Was wondering about the bridge to IIO (reverse of iio to hwmon bridge)
that you mentioned - for that you'd probably need some in kernel interfaces
for all this stuff.

Anyhow, stuff for the future (perhaps distant)

Jonathan
> Thanks,
> Guenter
> 

