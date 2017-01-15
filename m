Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57256 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbdAOOpy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jan 2017 09:45:54 -0500
Subject: Re: [PATCH v4 0/2] iio: adc: Add Maxim MAX11100 driver
To: jacopo mondi <jacopo@jmondi.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        marek.vasut@gmail.com, geert@linux-m68k.org, robh+dt@kernel.org,
        mark.rutland@arm.com
References: <1484301038-16386-1-git-send-email-jacopo+renesas@jmondi.org>
 <502b12a0-6011-c0eb-06b4-a40245d1d8db@jmondi.org>
 <a4fe9cd7-4854-d916-ae30-50a7668cec4e@kernel.org>
 <a1866192-dd3b-7ea8-bb03-1bbbf0678226@jmondi.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b606789b-de9a-ec2b-744b-fceea0c565f2@kernel.org>
Date: Sun, 15 Jan 2017 14:45:51 +0000
MIME-Version: 1.0
In-Reply-To: <a1866192-dd3b-7ea8-bb03-1bbbf0678226@jmondi.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/01/17 14:41, jacopo mondi wrote:
> Hi Jonathan,
> 
> On 15/01/2017 15:31, Jonathan Cameron wrote:
>> On 15/01/17 14:13, jacopo mondi wrote:
>>> Hi Jonathan,
>>>    thanks for review,
>>>
>>> On 13/01/2017 10:50, Jacopo Mondi wrote:
>>>> Hello,
>>>>    sending out v4 splitting device tree bindings documentation and actual ADC
>>>> driver.
>>>> No changes in driver code since v3.
>>>>
>>>> Same question for iio maintainers here:
>>>> I would like to have clarified the measure unit returned by read_raw().
>>>> Currently (value_raw * value_scale) return the ADC input value in mV.
>> Good.
>>>> While testing the patch I've been questioned if that should not actually
>>>> be in uV. This is easily achievable making _scale return a value in uV.
>>>> I have found no mention of this in the ABI documentation as it speaks of
>>>> generic voltage. Can we have a final word on this?
>>>
>>> I see you have reviewed the driver without complaining for the
>>> read_raw() measure unit, so I assume this replies to the above
>>> question as well...
>>>
>> The units are specified in Documentation/ABI/testing/sysfs-bus-iio.
>>
>>> What:        /sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
>>> What:        /sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
>>> What:        /sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
>>> What:        /sys/bus/iio/devices/iio:deviceX/in_voltageY_q_raw
>>> KernelVersion:    2.6.35
>>> Contact:    linux-iio@vger.kernel.org
>>> Description:
>>>         Raw (unscaled no bias removal etc.) voltage measurement from
>>>         channel Y. In special cases where the channel does not
>>>         correspond to externally available input one of the named
>>>         versions may be used. The number must always be specified and
>>>         unique to allow association with event codes. Units after
>>>         application of scale and offset are millivolts.
>>
>> So millivolts.  This comes from a, perhaps ill judged, decision to match
>> hwmon units were we could.
>>
> 
> Thank you! The "generic voltage" I said is mentioned in the ABI
> documentation is in _scale attributes description. I assume then the
> measure unit of the value returned by _scale is not relevant as long
> as the _raw one with scale applied returns millivolts.
Yes.  Scale is inherently a ratio really rather than a quantity with units
at all.  It just happens to correspond to the voltage represented by 1LSB.
> 
> Thanks, as soon as I have feedbacks on DTS binding docs, I'll send v5
> and we can hopefully close this one ;)
Cool.  Got a while in this cycle yet, but I know it's always nice to get
patches out of your personal queue!

Jonathan
> 
> Thanks j
> 
> 
> 
>> Jonathan
>>
>>> Thanks j
>>>
>>>>
>>>> Thanks Marek for having tested this.
>>>>
>>>> v1 -> v2:
>>>>     - incorporated pmeerw's review comments
>>>>     - retrieve vref from dts and use that to convert read_raw result
>>>>       to mV
>>>>     - add device tree bindings documentation
>>>>
>>>> v2 -> v3:
>>>>     - add _SCALE bit of read_raw function and change _RAW bit accordingly
>>>>     - call regulator_get_voltage when accessing the _SCALE part of read_raw
>>>>       and not during probe
>>>>     - add back remove function as regulator has to be disabled when detaching
>>>>       the module. Do not use devm_ version of iio_register/unregister functions
>>>>       anymore but do unregister in the remove.
>>>>     - remove mutex as access to SPI bus is protected by SPI core. Thanks marex
>>>>
>>>> v3 -> v4:
>>>>     - split device tree binding documentation and actual ADC driver
>>>>     - add "reg" to the list of required properties and use a better
>>>>       namimg for the adc device node in bindings documentation as suggested
>>>>       by Geert.
>>>>
>>>> Jacopo Mondi (2):
>>>>   iio: adc: Add Maxim MAX11100 driver
>>>>   dt-bindings: iio: document MAX11100 ADC
>>>>
>>>>  .../devicetree/bindings/iio/adc/max11100.txt       |  19 +++
>>>>  drivers/iio/adc/Kconfig                            |   9 +
>>>>  drivers/iio/adc/Makefile                           |   1 +
>>>>  drivers/iio/adc/max11100.c                         | 187 +++++++++++++++++++++
>>>>  4 files changed, 216 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max11100.txt
>>>>  create mode 100644 drivers/iio/adc/max11100.c
>>>>
>>>
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

