Return-Path: <SRS0=StV2=KQ=codeaurora.org=smohanad@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 01 Aug 2018 10:37:54 -0700
From: smohanad@codeaurora.org
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 linux-iio-owner@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: Add DT binding document for
 PMIC5 ADC
In-Reply-To: <20180730214613.GA24177@rob-hp-laptop>
References: <1532562248-6810-1-git-send-email-smohanad@codeaurora.org>
 <20180730214613.GA24177@rob-hp-laptop>
Message-ID: <5919175c2723b3e989b263786106a766@codeaurora.org>
List-ID: <linux-iio@vger.kernel.org>

On 2018-07-30 14:46, Rob Herring wrote:
> On Wed, Jul 25, 2018 at 04:44:08PM -0700, Siddartha Mohanadoss wrote:
>> PMIC5 ADC has support for clients to measure voltage and current
>> on inputs connected to the PMIC. Clients include reading voltage
>> phone power and on board system thermistors for thermal management.
>> ADC5 on certain PMIC has support to read battery current.
>> 
>> This change adds documentation.
>> 
>> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
>> ---
>>  .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt |  77 
>> ++++++++++----
>>  include/dt-bindings/iio/qcom,spmi-vadc.h           | 115 
>> ++++++++++++++++++++-
>>  2 files changed, 172 insertions(+), 20 deletions(-)
> 
> Please add acks/reviewed-bys when posting new versions.
> 
> Rob

Hi Rob,

Sure, i will add the reviewed-by tag for the next version for this 
patch.

Thanks,
Siddartha

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
