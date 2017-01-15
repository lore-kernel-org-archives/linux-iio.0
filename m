Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35655 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbdAOPly (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jan 2017 10:41:54 -0500
Subject: Re: [PATCH v4 0/2] iio: adc: Add Maxim MAX11100 driver
To: Jonathan Cameron <jic23@kernel.org>,
        jacopo mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        geert@linux-m68k.org, robh+dt@kernel.org, mark.rutland@arm.com
References: <1484301038-16386-1-git-send-email-jacopo+renesas@jmondi.org>
 <502b12a0-6011-c0eb-06b4-a40245d1d8db@jmondi.org>
 <a4fe9cd7-4854-d916-ae30-50a7668cec4e@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <89b6a029-cbeb-e993-db9b-8ed6dbf3029e@gmail.com>
Date: Sun, 15 Jan 2017 16:41:50 +0100
MIME-Version: 1.0
In-Reply-To: <a4fe9cd7-4854-d916-ae30-50a7668cec4e@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/15/2017 03:31 PM, Jonathan Cameron wrote:
> On 15/01/17 14:13, jacopo mondi wrote:
>> Hi Jonathan,
>>    thanks for review,
>>
>> On 13/01/2017 10:50, Jacopo Mondi wrote:
>>> Hello,
>>>    sending out v4 splitting device tree bindings documentation and actual ADC
>>> driver.
>>> No changes in driver code since v3.
>>>
>>> Same question for iio maintainers here:
>>> I would like to have clarified the measure unit returned by read_raw().
>>> Currently (value_raw * value_scale) return the ADC input value in mV.
> Good.
>>> While testing the patch I've been questioned if that should not actually
>>> be in uV. This is easily achievable making _scale return a value in uV.
>>> I have found no mention of this in the ABI documentation as it speaks of
>>> generic voltage. Can we have a final word on this?
>>
>> I see you have reviewed the driver without complaining for the
>> read_raw() measure unit, so I assume this replies to the above
>> question as well...
>>
> The units are specified in Documentation/ABI/testing/sysfs-bus-iio.
> 
>> What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
>> What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
>> What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
>> What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_raw
>> KernelVersion:	2.6.35
>> Contact:	linux-iio@vger.kernel.org
>> Description:
>> 		Raw (unscaled no bias removal etc.) voltage measurement from
>> 		channel Y. In special cases where the channel does not
>> 		correspond to externally available input one of the named
>> 		versions may be used. The number must always be specified and
>> 		unique to allow association with event codes. Units after
>> 		application of scale and offset are millivolts.
> 
> So millivolts.  This comes from a, perhaps ill judged, decision to match
> hwmon units were we could.

Fun, regulator framework returns values in uV to add to the chaos :)


-- 
Best regards,
Marek Vasut
