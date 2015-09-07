Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:17270 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbbIGOAI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 7 Sep 2015 10:00:08 -0400
Message-ID: <55ED985E.8070806@intel.com>
Date: Mon, 07 Sep 2015 16:59:58 +0300
From: Adriana Reus <adriana.reus@intel.com>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: Peter Meerwald <pmeerw@pmeerw.net>, daniel.baluta@intel.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v6 2/2] devicetree: Add documentation for UPISEMI us5182d
 ALS and Proximity sensor
References: <1440065534-8601-1-git-send-email-adriana.reus@intel.com> <1440065534-8601-3-git-send-email-adriana.reus@intel.com> <55DF71A5.1010705@kernel.org> <CAL_Jsq+uvhaE77yXqKGXF_p6gAV5F+rPwnT547ym-o23=3fR+w@mail.gmail.com>
In-Reply-To: <CAL_Jsq+uvhaE77yXqKGXF_p6gAV5F+rPwnT547ym-o23=3fR+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Thanks for your feedback, some comments inline.

On 31.08.2015 18:38, Rob Herring wrote:
> On Thu, Aug 27, 2015 at 3:23 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 20/08/15 11:12, Adriana Reus wrote:
>>> Added entries in i2c/vendor-prefixes for the us5182d als and proximity sensor.
>>> Also added a documentation file for this sensor's properties.
>>>
>>> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
>> This isn't that trivial so I'd like some device tree maintainer
>> input if possible.
>
> It seems fairly reasonable to me. Would other ALS or proximity sensors
> need similar properties?
The "glass-coef" is intended to compensate for the material (glass) that 
may be covering the sensor if it's integrated in a phone, tablet etc. I 
chose 1000 as resolution for this scaling factor (i'll add a more 
detailed description). So possibly similar properties could be used for 
other als sensors as well.

The last 3 tuning parameters are specific to this particular sensor.
>
>> For now I've backed out the driver from my tree (given timing we have
>> loads of time to sort this out!)
>>
>> Anyhow, anyone device tree related able to take a look at this.
>>
>> Adriana, btw these should be cc'd to the device tree maintainers in
>> the first place (now added).
>>
>> Jonathan
>>> ---
>>>   .../devicetree/bindings/iio/light/us5182d.txt      | 23 ++++++++++++++++++++++
>>>   .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>>>   2 files changed, 24 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/iio/light/us5182d.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/light/us5182d.txt b/Documentation/devicetree/bindings/iio/light/us5182d.txt
>>> new file mode 100644
>>> index 0000000..7785c56
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/light/us5182d.txt
>>> @@ -0,0 +1,23 @@
>>> +* UPISEMI us5182d I2C ALS and Proximity sensor
>>> +
>>> +Required properties:
>>> +- compatible: must be "upisemi,usd5182"
>>> +- reg: the I2C address of the device
>>> +
>>> +Optional properties:
>
> Do you expect certain defaults if not present? Some description of how
> all these values are determined would be useful.
Yes, if not present they will fall back to default values - the values 
in the example.
- the glass-coef one is 1000 by default - so no glass compensation by 
default (lux = lux * 1000/1000)
- the others were determined experimentally - by fine tuning starting 
from the default values in those registers).
>
>
>>> +- upisemi,glass-coef: glass attenuation factor
>>> +- upisemi,dark-ths: array of thresholds (adc counts) corresponding to every scale
>
> What is the size of the array and valid range of values?
>
> Be specific this is 16-bit property.
Ok, I'll add this info in a following patch set.
>
>>> +- upisemi,upper-dark-gain: tuning factor(4 int and 4 fractional bits - Q4.4) applied when light > threshold
>>> +- upisemi,lower-dark-gain: tuning factor(4 int and 4 fractional bits - Q4.4) applied when light < threshold
>
> Be specific this is an 8-bit property.
ok
>
>>> +
>>> +Example:
>>> +
>>> +    usd5182@39 {
>>> +                compatible = "upisemi,usd5182";
>>> +                reg = <0x39>;
>>> +                upisemi,glass-coef = < 1000 >;
>>> +                upisemi,dark-ths = /bits/ 16 <170 200 512 512 800 2000 4000 8000>;
>>> +                upisemi,upper-dark-gain = /bits/ 8 <0x00>;
>>> +                upisemi,lower-dark-gain = /bits/ 8 <0x16>;
>>> +    };
>>> +
>>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>> index d444757..5b40bab 100644
>>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>> @@ -211,6 +211,7 @@ toshiba   Toshiba Corporation
>>>   toumaz       Toumaz
>>>   tplink       TP-LINK Technologies Co., Ltd.
>>>   truly        Truly Semiconductors Limited
>>> +upisemi      uPI Semiconductor Corp.
>>>   usi  Universal Scientific Industrial Co., Ltd.
>>>   v3   V3 Semiconductor
>>>   variscite    Variscite Ltd.
>>>
>>
