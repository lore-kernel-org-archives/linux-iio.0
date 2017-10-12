Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:54244 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbdJLN4H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Oct 2017 09:56:07 -0400
Subject: Re: [PATCH v2 3/4] dt-bindings: hwmon: Add
 ti-max-expected-current-microamp property to ina2xx
To: Maciej Purski <m.purski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <CGME20171012123635eucas1p1ff9a982db9d541cd0475d44d114ff92a@eucas1p1.samsung.com>
 <1507811765-31005-1-git-send-email-m.purski@samsung.com>
 <1507811765-31005-4-git-send-email-m.purski@samsung.com>
 <CAJKOXPc1B1uqravtmHrh4eUK5JiQRiZLeoveSMk5qVyF-mK7Kw@mail.gmail.com>
 <4597b058-ecb1-59ef-8693-1a23f374eae0@samsung.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <79da3a8b-e885-8a02-cbba-dfd1834450db@roeck-us.net>
Date: Thu, 12 Oct 2017 06:55:59 -0700
MIME-Version: 1.0
In-Reply-To: <4597b058-ecb1-59ef-8693-1a23f374eae0@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/12/2017 06:00 AM, Maciej Purski wrote:
> 
> 
> On 10/12/2017 02:39 PM, Krzysztof Kozlowski wrote:
>> On Thu, Oct 12, 2017 at 2:36 PM, Maciej Purski <m.purski@samsung.com> wrote:
>>> Add optional max expected current property which allows calibrating
>>> the ina sensor in order to achieve requested measure scale. Document
>>> the changes in Documentation/hwmon/ina2xx.
>>>
>>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>>> ---
>>>   Documentation/devicetree/bindings/hwmon/ina2xx.txt | 4 +++-
>>>   Documentation/hwmon/ina2xx                         | 3 +++
>>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/ina2xx.txt b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
>>> index 02af0d9..49ef0be 100644
>>> --- a/Documentation/devicetree/bindings/hwmon/ina2xx.txt
>>> +++ b/Documentation/devicetree/bindings/hwmon/ina2xx.txt
>>> @@ -14,11 +14,13 @@ Optional properties:
>>>
>>>   - shunt-resistor
>>>          Shunt resistor value in micro-Ohm
>>> -
>>> +- ti-max-expected-current-microamp
>>> +       Max expected current value in mA
>>>   Example:
>>>
>>>   ina220@44 {
>>>          compatible = "ti,ina220";
>>>          reg = <0x44>;
>>>          shunt-resistor = <1000>;
>>> +       ti-max-expected-current-microamp = <3000>;
>>>   };
>>> diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
>>> index cfd31d9..30620e8 100644
>>> --- a/Documentation/hwmon/ina2xx
>>> +++ b/Documentation/hwmon/ina2xx
>>> @@ -55,6 +55,9 @@ The shunt value in micro-ohms can be set via platform data or device tree at
>>>   compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
>>>   refer to the Documentation/devicetree/bindings/i2c/ina2xx.txt for bindings
>>>   if the device tree is used.
>>> +The max expected current value in miliamp can be set via platform data
>>
>> mili or micro?
>>
>> BR,
>> Krzysztof
> 
> Sorry, these should be mili everywhere. I'll fix this.
> 

You sure ? I think DT usually uses micro.

Guenter

>>
>>> +or device tree at compile-time or via currX_max attribute in sysfs
>>> +at run-time.
>>>
>>>   Additionally ina226 supports update_interval attribute as described in
>>>   Documentation/hwmon/sysfs-interface. Internally the interval is the sum of
>>> -- 
>>> 2.7.4
>>>
>>
>>
>>
> 

