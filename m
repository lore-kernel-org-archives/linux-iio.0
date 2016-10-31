Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37257 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763705AbcJaJ05 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2016 05:26:57 -0400
Received: by mail-wm0-f50.google.com with SMTP id t79so37886462wmt.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Oct 2016 02:26:57 -0700 (PDT)
Subject: Re: [PATCH V3 2/2] iio: adc: spmi-vadc: Changes to support different
 scaling
To: Rama Krishna Phani A <rphani@codeaurora.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1477492887-1663-1-git-send-email-rphani@codeaurora.org>
 <1477492887-1663-3-git-send-email-rphani@codeaurora.org>
 <8418e7f1-55d9-2dfa-1dc7-5960f9da0305@linaro.org>
 <be7d758f-1698-1b6d-e6a1-a2910a914737@codeaurora.org>
 <a96141dc-6ee5-2d7c-868c-7cb282002b89@kernel.org>
 <812bb533-0f19-7abc-1fa1-9e83f1db10f4@codeaurora.org>
Cc: robh@kernel.org, linux-arm-msm@vger.kernel.org,
        smohanad@codeaurora.org, mgautam@codeaurora.org,
        sivaa@codeaurora.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Julia.Lawall@lip6.fr
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <7c0baa96-51a1-06fb-7a90-1bfb3338a294@linaro.org>
Date: Mon, 31 Oct 2016 11:26:53 +0200
MIME-Version: 1.0
In-Reply-To: <812bb533-0f19-7abc-1fa1-9e83f1db10f4@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Rama,

On 10/31/2016 09:12 AM, Rama Krishna Phani A wrote:
> Hi Jonathan,
> 
> On 30-Oct-16 10:43 PM, Jonathan Cameron wrote:
>> On 27/10/16 18:37, Phani A, Rama Krishna wrote:
>>> Hi Stan,
>>>
>>> On 27-Oct-16 4:48 PM, Stanimir Varbanov wrote:
>>>> Hi Rama,
>>>>
>>>> On 10/26/2016 05:41 PM, Rama Krishna Phani A wrote:
>>>>> Polling can also be used for End of conversion completion.
>>>>> Implement logic
>>>>> to choose either polling or interrupt for End of conversion
>>>>> completion.
>>>>> Scaling can be done on the voltage to report adc code in physical
>>>>> units.
>>>>> Add changes to support different scale functions to convert adc
>>>>> code to
>>>>> physical units.
>>>>>
>>>>> Signed-off-by: Rama Krishna Phani A <rphani@codeaurora.org>
>>>>> ---
>>>>>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |  14 ++
>>>>>  drivers/iio/adc/qcom-spmi-vadc.c                   | 263
>>>>> +++++++++++++++++----
>>>>>  2 files changed, 236 insertions(+), 41 deletions(-)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
>>>>> b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
>>>>> index 0fb4613..39e31c0e 100644
>>>>> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
>>>>> @@ -37,6 +37,12 @@ VADC node:
>>>>>      Value type: <prop-encoded-array>
>>>>>      Definition: End of conversion interrupt.
>>>>>
>>>>> +- qcom,vadc-poll-eoc:
>>>>> +    Usage: optional
>>>>> +    Value type: <bool>
>>>>> +    Definition: Use polling instead of interrupts for End of
>>>>> Conversion
>>>>> +        completion.
>>>>
>>>> Why you need to add such a flag in DT?
>>>>
>>>> The DT should describe hardware details not how the driver will choose
>>>> pooling vs interrupt.
>>>>
>>>> On which use-case you would prefer pooling?
>>>>
>>>
>>> Few PMIC's support interrupt functionality for ADC where as few
>>> PMIC's dont support. Based on the functionality that is supported in
>>> hardware we choose whether to go for polling or for interrupt.
>> Can't use the usual trick of an optional interrupt in DT?
>> If it's there we try to use it, if not then fall back to polling?
>>
> Ok., Will check this logic for implementation and will post next patch.

The interrupts DT property in binding doc is marked as optional already,
so I can't really understand what you are trying to achieve with this
new qcom,vadc-poll-eoc boolean property?

-- 
regards,
Stan
