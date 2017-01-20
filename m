Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:24830 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751686AbdATKh4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jan 2017 05:37:56 -0500
Subject: Re: [PATCH 7/7] ARM: dts: stm32: Enable pwm1 and pwm3 for
 stm32f469-eval
To: Alexandre Torgue <alexandre.torgue@st.com>, <jic23@kernel.org>,
        <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1484832854-6314-1-git-send-email-fabrice.gasnier@st.com>
 <1484832854-6314-8-git-send-email-fabrice.gasnier@st.com>
 <451b28a0-6cf3-d75a-59a2-d4e2f8a7b373@st.com>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <eb886932-8c63-ac73-44e8-c886e51d07ff@st.com>
Date: Fri, 20 Jan 2017 11:36:59 +0100
MIME-Version: 1.0
In-Reply-To: <451b28a0-6cf3-d75a-59a2-d4e2f8a7b373@st.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/20/2017 11:19 AM, Alexandre Torgue wrote:
> Hi Fabrice
>
>
> On 01/19/2017 02:34 PM, Fabrice Gasnier wrote:
>> Define and enable pwm1 and pwm3, timers1 & 3 trigger outputs on
>> stm32f469-eval board.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>
> Typo issue in commit header (stm32f469 --> stm32f429)
Hi Alexandre,

I'll fix this in next revision.
Tanks for reviewing.

BR,
Fabrice

>
>
>>  arch/arm/boot/dts/stm32429i-eval.dts | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts 
>> b/arch/arm/boot/dts/stm32429i-eval.dts
>> index 2181220..892100f 100644
>> --- a/arch/arm/boot/dts/stm32429i-eval.dts
>> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
>> @@ -171,3 +171,31 @@
>>      pinctrl-names = "default";
>>      status = "okay";
>>  };
>> +
>> +&timers1 {
>> +    status = "okay";
>> +
>> +    pwm {
>> +        pinctrl-0 = <&pwm1_pins>;
>> +        pinctrl-names = "default";
>> +        status = "okay";
>> +    };
>> +
>> +    timer@0 {
>> +        status = "okay";
>> +    };
>> +};
>> +
>> +&timers3 {
>> +    status = "okay";
>> +
>> +    pwm {
>> +        pinctrl-0 = <&pwm3_pins>;
>> +        pinctrl-names = "default";
>> +        status = "okay";
>> +    };
>> +
>> +    timer@2 {
>> +        status = "okay";
>> +    };
>> +};
>>

