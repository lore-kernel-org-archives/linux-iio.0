Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44039 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751178AbdJWIHd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Oct 2017 04:07:33 -0400
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: stm32: add support for diff
 channels
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC: <robh+dt@kernel.org>, <linux@armlinux.org.uk>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
References: <1508246145-19417-1-git-send-email-fabrice.gasnier@st.com>
 <1508246145-19417-2-git-send-email-fabrice.gasnier@st.com>
 <20171021185401.529f2eb2@archlinux> <20171021202327.51dd2855@archlinux>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <0726f676-0440-afbe-f275-ec7fdaa29c9f@st.com>
Date: Mon, 23 Oct 2017 10:06:27 +0200
MIME-Version: 1.0
In-Reply-To: <20171021202327.51dd2855@archlinux>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/21/2017 09:23 PM, Jonathan Cameron wrote:
> On Sat, 21 Oct 2017 18:54:01 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Tue, 17 Oct 2017 15:15:43 +0200
>> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>>
>>> STM32H7 ADC channels may be configured either as single-ended or
>>> differential.
>>> Add 'st,adc-diff-channels' property to support differential channels.
>>> Differential channels are defined as a pair of positive and negative
>>> inputs: vinp & vinn.
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>  
>> Hmm. Fair enough.  Sometimes we support both types of channels
>> and leave it to userspace, but in many cases that makes little sense
>> - particularly if like I think is going on here, we aren't combining channels
>> that can be separately read but rather the negative pin is simply unused
>> when we are in single channel mode... (did I understand that right?)
> I clearly didn't understand.  This is same as other devices
> in that we are picking a pair from the channels that can otherwise be
> used as single end channels. (I think). 

Hi Jonathan,

Indeed, we're picking a pair from the channels that can be used as
single channels otherwise.
Also, it doesn't makes sense to leave the choice to userspace: when
these channels are used in differential mode, both input should be
biased. This is quite dependent on hardware (board), not really a
runtime choice.
Hope this clarifies ?

> 
> For this binding I think I'd like to see an example added showing how
> this works...

You're right, I should have added that. Please let me know if I can add
bellow example in v2:

Example to setup differential channels 1, 2 & 3 (with resp. 0, 6 & 7
negative inputs):
	adc: adc@40022000 {
		compatible = "st,stm32h7-adc-core";
		...
		adc1: adc@0 {
			compatible = "st,stm32h7-adc";
			...
			st,adc-diff-channels = <1 0>, <2 6>, <3 7>;
		};
	};

Thanks for reviewing,
Best Regards,
Fabrice

> 
> Thanks,
> 
> Jonathan
>>
>> Jonathan
>>
>>> ---
>>>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>>> index 48bfcaa3..c3c8de1 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>>> @@ -62,6 +62,12 @@ Required properties:
>>>  - st,adc-channels: List of single-ended channels muxed for this ADC.
>>>    It can have up to 16 channels on stm32f4 or 20 channels on stm32h7, numbered
>>>    from 0 to 15 or 19 (resp. for in0..in15 or in0..in19).
>>> +- st,adc-diff-channels: List of differential channels muxed for this ADC.
>>> +  Depending on part used, some channels can be configured as differential
>>> +  instead of single-ended (e.g. stm32h7). List here positive and negative
>>> +  inputs pairs as <vinp vinn>, <vinp vinn>,... vinp and vinn are numbered
>>> +  from 0 to 19 on stm32h7)
>>> +  Note: At least one of "st,adc-channels" or "st,adc-diff-channels" is required.
>>>  - #io-channel-cells = <1>: See the IIO bindings section "IIO consumers" in
>>>    Documentation/devicetree/bindings/iio/iio-bindings.txt
>>>    
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
