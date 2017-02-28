Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36203 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751332AbdB1IZE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Feb 2017 03:25:04 -0500
Subject: Re: [PATCH 1/2] dt-bindings: iio: stm32-adc: add option to set
 resolution
To: Jonathan Cameron <jic23@kernel.org>, <linux@armlinux.org.uk>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1487177757-19427-1-git-send-email-fabrice.gasnier@st.com>
 <1487177757-19427-2-git-send-email-fabrice.gasnier@st.com>
 <c2b73482-ae01-34b5-3c16-b7e63893259e@kernel.org>
 <b9f59559-c7a8-f575-0868-bd3b149a35c9@st.com>
 <d64bd76d-a2c6-6148-c126-fa73e96019a1@kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <79e01c5c-d27c-89ea-4d8f-9e66a6c091e6@st.com>
Date: Tue, 28 Feb 2017 09:21:49 +0100
MIME-Version: 1.0
In-Reply-To: <d64bd76d-a2c6-6148-c126-fa73e96019a1@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/25/2017 04:11 PM, Jonathan Cameron wrote:
> On 24/02/17 16:04, Fabrice Gasnier wrote:
>> On 02/19/2017 01:09 PM, Jonathan Cameron wrote:
>>> On 15/02/17 16:55, Fabrice Gasnier wrote:
>>>> Add documentation for 'st,adc-res' dt optional property.
>>>>
>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>> I'm happy with this, but would like to leave time for a device tree review.
>>>
>>> Ultimately we may well want to make this a generic property and call it something
>>> like adc-resolution but perhaps we need to wait until we have a few more devices
>>> supporting setting it via device tree to figure out what the best interface is.
>>> It would exactly be a problem to support this as a deprecated binding at that
>>> point.
>>
>> Hi Jonathan,
>>
>> I agree with you on this... It may be better to have generic property
>> for this, especially if you see that it will come in the near future.
>> May I suggest this prop to be less restrictive, e.g. like
>> resolution-bits as is may also be worth for other device types, e.g.
>> DAC as an example ?>
> Sure, why not - no loss of meaning here.  We may never use it for anything
> else but that doesn't matter.

Hi Jonathan,

Following Rob's comment, how you see such a common property can be
integrated. Currently I don't see much devices are doing this.
Do you have ideas or preferences on this ?

- Do you think replacing 'st,adc-res' by 'resolution-bits' in current 
patchset is enough for now ?
- Or do I need to add dt parsing routine in IIO core, e.g. as simple
as of_iio_get_resolution(), or something like this ? Or parsing routine
that may fill in a common properties structure (but only resolution
will be there from the start)...

Please let me know.

Thanks,
Fabrice

>>>
>>> Give me a poke if we hear nothing from Rob or Mark for say another week.
>>
>> No news yet, but it can wait a little longer.
> Rob / Mark, can you take a look at this if you have time?
>
> Thanks,
>
> Jonathan
>>
>> Please advise,
>> Regards,
>> Fabrice
>>
>>>
>>> Thanks,
>>>
>>> Jonathan
>>>
>>>> ---
>>>>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>>>> index 5dfc88e..45f7ff2 100644
>>>> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>>>> @@ -57,6 +57,9 @@ Optional properties:
>>>>  - dmas: Phandle to dma channel for this ADC instance.
>>>>    See ../../dma/dma.txt for details.
>>>>  - dma-names: Must be "rx" when dmas property is being used.
>>>> +- st,adc-res: Resolution (bits) to use for conversions. Must match device
>>>> +  available resolutions (e.g. can be 6, 8, 10 or 12 on stm32f4). Default
>>>> +  is maximum resolution if unset.
>>>>
>>>>  Example:
>>>>      adc: adc@40012000 {
>>>> @@ -84,6 +87,7 @@ Example:
>>>>              st,adc-channels = <8>;
>>>>              dmas = <&dma2 0 0 0x400 0x0>;
>>>>              dma-names = "rx";
>>>> +            st,adc-res = <8>;
>>>>          };
>>>>          ...
>>>>          other adc child nodes follow...
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
