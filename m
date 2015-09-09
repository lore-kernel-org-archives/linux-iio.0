Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35422 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880AbbIIFkP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Sep 2015 01:40:15 -0400
Subject: Re: [PATCH v6 2/2] devicetree: Add documentation for UPISEMI us5182d
 ALS and Proximity sensor
To: Adriana Reus <adriana.reus@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
References: <1440065534-8601-1-git-send-email-adriana.reus@intel.com>
 <1440065534-8601-3-git-send-email-adriana.reus@intel.com>
 <55DF71A5.1010705@kernel.org>
 <CAL_Jsq+uvhaE77yXqKGXF_p6gAV5F+rPwnT547ym-o23=3fR+w@mail.gmail.com>
 <55ED985E.8070806@intel.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, daniel.baluta@intel.com,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
From: Rob Herring <robherring2@gmail.com>
Message-ID: <55EF85E5.5070708@gmail.com>
Date: Tue, 8 Sep 2015 20:05:41 -0500
MIME-Version: 1.0
In-Reply-To: <55ED985E.8070806@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/07/2015 08:59 AM, Adriana Reus wrote:
> Thanks for your feedback, some comments inline.
> 
> On 31.08.2015 18:38, Rob Herring wrote:
>> On Thu, Aug 27, 2015 at 3:23 PM, Jonathan Cameron <jic23@kernel.org>
>> wrote:
>>> On 20/08/15 11:12, Adriana Reus wrote:
>>>> Added entries in i2c/vendor-prefixes for the us5182d als and
>>>> proximity sensor.
>>>> Also added a documentation file for this sensor's properties.
>>>>
>>>> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
>>> This isn't that trivial so I'd like some device tree maintainer
>>> input if possible.
>>
>> It seems fairly reasonable to me. Would other ALS or proximity sensors
>> need similar properties?
> The "glass-coef" is intended to compensate for the material (glass) that
> may be covering the sensor if it's integrated in a phone, tablet etc. I
> chose 1000 as resolution for this scaling factor (i'll add a more
> detailed description). So possibly similar properties could be used for
> other als sensors as well.

Seems like amstaos,cover-comp-gain would be doing the same thing. But it
is defined as an integer, so I'm not sure how that would work.

> 
> The last 3 tuning parameters are specific to this particular sensor.
>>
>>> For now I've backed out the driver from my tree (given timing we have
>>> loads of time to sort this out!)
>>>
>>> Anyhow, anyone device tree related able to take a look at this.
>>>
>>> Adriana, btw these should be cc'd to the device tree maintainers in
>>> the first place (now added).
>>>
>>> Jonathan
>>>> ---
>>>>   .../devicetree/bindings/iio/light/us5182d.txt      | 23
>>>> ++++++++++++++++++++++
>>>>   .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>>>>   2 files changed, 24 insertions(+)
>>>>   create mode 100644
>>>> Documentation/devicetree/bindings/iio/light/us5182d.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/light/us5182d.txt
>>>> b/Documentation/devicetree/bindings/iio/light/us5182d.txt
>>>> new file mode 100644
>>>> index 0000000..7785c56
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/light/us5182d.txt
>>>> @@ -0,0 +1,23 @@
>>>> +* UPISEMI us5182d I2C ALS and Proximity sensor
>>>> +
>>>> +Required properties:
>>>> +- compatible: must be "upisemi,usd5182"
>>>> +- reg: the I2C address of the device
>>>> +
>>>> +Optional properties:
>>
>> Do you expect certain defaults if not present? Some description of how
>> all these values are determined would be useful.
> Yes, if not present they will fall back to default values - the values
> in the example.
> - the glass-coef one is 1000 by default - so no glass compensation by
> default (lux = lux * 1000/1000)
> - the others were determined experimentally - by fine tuning starting
> from the default values in those registers).

So the default if the properties are not present is a default register
value or a default in the driver?

Rob
