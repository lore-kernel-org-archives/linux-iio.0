Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36338 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbcJ0RhN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Oct 2016 13:37:13 -0400
Subject: Re: [PATCH V3 2/2] iio: adc: spmi-vadc: Changes to support different
 scaling
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-iio@vger.kernel.org, jic23@kernel.org,
        devicetree@vger.kernel.org
References: <1477492887-1663-1-git-send-email-rphani@codeaurora.org>
 <1477492887-1663-3-git-send-email-rphani@codeaurora.org>
 <8418e7f1-55d9-2dfa-1dc7-5960f9da0305@linaro.org>
Cc: robh@kernel.org, linux-arm-msm@vger.kernel.org,
        smohanad@codeaurora.org, mgautam@codeaurora.org,
        sivaa@codeaurora.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Julia.Lawall@lip6.fr
From: "Phani A, Rama Krishna" <rphani@codeaurora.org>
Message-ID: <be7d758f-1698-1b6d-e6a1-a2910a914737@codeaurora.org>
Date: Thu, 27 Oct 2016 23:07:04 +0530
MIME-Version: 1.0
In-Reply-To: <8418e7f1-55d9-2dfa-1dc7-5960f9da0305@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Stan,

On 27-Oct-16 4:48 PM, Stanimir Varbanov wrote:
> Hi Rama,
>
> On 10/26/2016 05:41 PM, Rama Krishna Phani A wrote:
>> Polling can also be used for End of conversion completion. Implement logic
>> to choose either polling or interrupt for End of conversion completion.
>> Scaling can be done on the voltage to report adc code in physical units.
>> Add changes to support different scale functions to convert adc code to
>> physical units.
>>
>> Signed-off-by: Rama Krishna Phani A <rphani@codeaurora.org>
>> ---
>>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |  14 ++
>>  drivers/iio/adc/qcom-spmi-vadc.c                   | 263 +++++++++++++++++----
>>  2 files changed, 236 insertions(+), 41 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
>> index 0fb4613..39e31c0e 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
>> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
>> @@ -37,6 +37,12 @@ VADC node:
>>      Value type: <prop-encoded-array>
>>      Definition: End of conversion interrupt.
>>
>> +- qcom,vadc-poll-eoc:
>> +    Usage: optional
>> +    Value type: <bool>
>> +    Definition: Use polling instead of interrupts for End of Conversion
>> +		completion.
>
> Why you need to add such a flag in DT?
>
> The DT should describe hardware details not how the driver will choose
> pooling vs interrupt.
>
> On which use-case you would prefer pooling?
>

Few PMIC's support interrupt functionality for ADC where as few PMIC's 
dont support. Based on the functionality that is supported in hardware 
we choose whether to go for polling or for interrupt.

>> +
>>  Channel node properties:
>>
>>  - reg:
>> @@ -92,6 +98,14 @@ Channel node properties:
>>              Valid values are: 1, 2, 4, 8, 16, 32, 64, 128, 256, 512
>>              If property is not found, 1 sample will be used.
>>
>> +- qcom,scale-function:
>> +    Usage: optional
>> +    Value type: <u32>
>> +    Definition: Scaling function used to convert raw ADC code to
>> +	units specific to a given channel. Scaled units can be
>> +	microvolts, millidegC.Valid values are: 0, 1, 2, 3, 4.
>> +	If property is not found, 0 scaling will be used.
>
> This shouldn't be in DT binding. Just select the scale function for each
> channel in the driver based on compatible property.
>
>
Ok ., Will remove this binding from DT, implement logic in driver and 
will post next patch.

Thanks,
Ramakrishna

