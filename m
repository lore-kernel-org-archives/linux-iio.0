Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:35997 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbdAKPke (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jan 2017 10:40:34 -0500
Subject: Re: [PATCH V4] iio: adc: Add Renesas GyroADC driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20170110213338.15855-1-marek.vasut@gmail.com>
 <CAMuHMdW+ayhOgEKjBxYxKq7tVr24fM_Ph=Hd-SRtt1e68e4mcQ@mail.gmail.com>
 <14e8b7dc-546d-8f8d-0964-d111e94e1c3f@gmail.com>
 <CAMuHMdVtV2nYDBzCfEEEhCqsu6b2rmt=fn8XqgtD3SjixkSzSw@mail.gmail.com>
 <e1d1dc1c-017a-15d7-0301-994a64ae8782@gmail.com>
 <CAMuHMdU=ffS1k2X3Mi7qBJADQcusX1cP6wwystU9BU3VuzJ39A@mail.gmail.com>
Cc: linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <b41701b6-1c6e-77f4-998d-5dc4a543acb2@gmail.com>
Date: Wed, 11 Jan 2017 16:39:43 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU=ffS1k2X3Mi7qBJADQcusX1cP6wwystU9BU3VuzJ39A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/11/2017 03:41 PM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Wed, Jan 11, 2017 at 3:32 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 01/11/2017 02:11 PM, Geert Uytterhoeven wrote:
>>> On Wed, Jan 11, 2017 at 1:35 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
>>>>>> +Required properties for subnodes:
>>>>>> +- compatible:  Should be either of:
>>>>>> +               "fujitsu,mb88101a"
>>>>>> +                       - Fujitsu MB88101A compatible mode,
>>>>>> +                         12bit sampling, 4 channels
>>>>>
>>>>> For this one, we have to find a better representation in DT.
>>>>> Unlike the other two types, the MB88101A is a 4-channel ADC, and thus only
>>>>> a single instance is supported, providing 4 channels.
>>>>> Hence for MB88101A I suggest to just have a single node "adc", without a
>>>>> unit address or "reg" property.
>>>>
>>>> Hmmmmmm, this doesn't look quite right and it does make the binding
>>>> complicated and the MB88101A into quite the special snow flake. Also,
>>>> what if you have the MB88101A channels 0 and 1 connected only to ie.
>>>> gyroadc channels 2 and 3?
>>>
>>> The gyroadc does not have multiple channel inputs, only a single input
>>> pin for serialized data. Supporting multiple channels is done using a
>>> 3-bit channel select (CHS) output signal.
>>
>> Yep, it's kinda doing SPI behind the scenes.
>>
>>> In mode 1, the 2 lsb CHS lines are to be connected to the C[01] channel
>>> select pins on the MB88101A.
>>> In other modes, I think you need an external multiplexer to select one of the
>>> 8 connected ADCs.
>>
>> Yes.
>>
>>> So while you cannot have non-standard channel wirings in mode 1,
>>> you can have a partial (or none at all) multiplexer and less than 8 ADCs,
>>> duplicating data to multiple channels.
>>
>> Right
>>
>>>> What about something like:
>>>>
>>>> adc2: adc@2 {
>>>>  reg = <0>;
>>>>  compatible = "fujitsu,mb88101a";
>>>>  vref-supply = <&vref_fujitsu_mb88101a>;
>>>> };
>>>>
>>>> adc3: adc@3 {
>>>>  reg = <3>;
>>>>  renesas,adc-master = <&adc2>;
>>>> };
>>>
>>> Hmm, that can be used to describe duplicated channels, too ;-)
>>
>> So we go with this ? I'm not completely sure about the new
>> "renesas,adc-master" property, are we OK with it ?
> 
> I would still use just a single "adc" node for MB88101A, and multiple adc@n
> nodes (one for each physically present ADC) in other modes.
> 
> If someone really needs access to the higher scanning rate possible
> with duplicated channels, it can always be added later.

Oh well, all right then.

-- 
Best regards,
Marek Vasut
