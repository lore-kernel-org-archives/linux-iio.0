Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39480 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbbHRRgq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Aug 2015 13:36:46 -0400
In-Reply-To: <55D34B7E.2020407@intel.com>
References: <1439544580-21179-1-git-send-email-adriana.reus@intel.com> <1439544580-21179-3-git-send-email-adriana.reus@intel.com> <55CF4D54.8010007@kernel.org> <55D34B7E.2020407@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v3 2/2] devicetree: Add documentation for UPISEMI us5182d ALS and Proximity sensor
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 18 Aug 2015 18:36:23 +0100
To: Adriana Reus <adriana.reus@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, pmeerw@pmeerw.net,
	daniel.baluta@intel.com
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Message-ID: <2D4880A7-6EA2-4738-B60B-1052FFC34225@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 18 August 2015 16:13:02 BST, Adriana Reus <adriana.reus@intel.com> wrote:
>
>Thank you Jonathan, I'll add a new patch set soon, added some comments 
>inline also.
>
>Adriana
>On 15.08.2015 17:31, Jonathan Cameron wrote:
>> On 14/08/15 10:29, Adriana Reus wrote:
>>> Added entries in trivial-devices and i2c/vendor-prefixes for
>>> the us5182d als and proximity sensor. Also added a documentation
>file for
>>> this sensor's properties.
>>>
>>> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
>> It's not a trivial device if it has it's own docs.  So don't add it
>to that list
>> (the point is to not have separate docs for devices that don't really
>have
>> any device tree data other than where they are.
>right, I'll add a new path set soon.
>>
>> Few more bits inline.
>>> ---
>>>    No changes - resending because I forgot to cc devicetree.
>>>   .../devicetree/bindings/i2c/trivial-devices.txt    |  1 +
>>>   .../devicetree/bindings/iio/light/us5182d.txt      | 24
>++++++++++++++++++++++
>>>   .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>>>   3 files changed, 26 insertions(+)
>>>   create mode 100644
>Documentation/devicetree/bindings/iio/light/us5182d.txt
>>>
>>> diff --git
>a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>>> index 00f8652..96d3b9c 100644
>>> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>>> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>>> @@ -99,4 +99,5 @@ ti,tsc2003		I2C Touch-Screen Controller
>>>   ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two
>Wire Serial Interface
>>>   ti,tmp103		Low Power Digital Temperature Sensor with SMBUS/Two
>Wire Serial Interface
>>>   ti,tmp275		Digital Temperature Sensor
>>> +upisemi,usd5182		Als and Proximity Sensor
>>>   winbond,wpct301		i2c trusted platform module (TPM)
>>> diff --git a/Documentation/devicetree/bindings/iio/light/us5182d.txt
>b/Documentation/devicetree/bindings/iio/light/us5182d.txt
>>> new file mode 100644
>>> index 0000000..9ac3336
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/light/us5182d.txt
>>> @@ -0,0 +1,24 @@
>>> +* UPISEMI us5182d I2C ALS and Proximity sensor
>>> +
>>> +Required properties:
>>> +- compatible: must be "upisemi,usd5182"
>>> +- reg: the I2C address of the device
>>> +
>>> +Optional properties:
>>> +- upisemi,glass-coef: glass attenuation factor
>>> +- upisemi,dark-ths: array of thresholds corresponding to every
>scale
>> That needs more detail. I've read the driver and I am not sure what
>exactly
>> you mean!  Why should a scale have a threshold?
>I'll try to be more specific. These are values representing adc counts,
>
>that's why there are different values corresponding to every scale.
>>> +- upisemi,upper-dark-gain: tuning factor applied when light > th
>>> +- upisemi,lower-dark-gain: tuning factor applied when light < th
>>> +
>>> +Example:
>>> +
>>> +    usd5182@39 {
>>> +                compatible = "upisemi,usd5182";
>>> +                reg = <0x39>;
>>> +                upisemi,glass-coef = < 1000 >;
>>> +                upisemi,dark-ths = /bits/ 16 <170 200 512 512 800
>2000 4000 8000>;
>>> +                upisemi,upper-dark-gain = /bits/ 8 <0x00>;
>>> +                upisemi,lower-dark-gain = /bits/ 8 <0x16>;
>> Not sure why these are in hex.. Or why we care if they are 8 bits. 
>If there is a limit
>> on the possible values, perhaps mention it in the docs above.
>I should have been (much) more specific here: that represents a float 
>number with 4 integer bits and 4 fractional bits (Q4.4), so I find hex 
>more intuitive since it's split in half, let me know if you think 
>otherwise. 
One for the device tree guys to answer rather than me.  My gut feeling would be
a representation that made this obvious but I have no idea what normal choice would be.
>I'll add a more complete description. As for the "/bits/ x" 
>it's because currently in the driver I use the read_property_u8 or
>*_u16 
>functions, these require that the dts entry be as I wrote it in the 
>example, and since it's an example it should be functional, so I feel 
>that is ok as it is.
>>
>>
>>> +    };
>>> +
>> One blank line at the end is neough.
>>> +
>>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
>b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>> index d444757..5b40bab 100644
>>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>>> @@ -211,6 +211,7 @@ toshiba	Toshiba Corporation
>>>   toumaz	Toumaz
>>>   tplink	TP-LINK Technologies Co., Ltd.
>>>   truly	Truly Semiconductors Limited
>>> +upisemi	uPI Semiconductor Corp.
>>>   usi	Universal Scientific Industrial Co., Ltd.
>>>   v3	V3 Semiconductor
>>>   variscite	Variscite Ltd.
>>>
>>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
