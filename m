Return-Path: <iwamatsu@nigauri.org>
MIME-Version: 1.0
In-Reply-To: <CAHfPSqCyn=Q_zH11=pRjP3rY69xbHDnRSwBmiA4fGmz62hV-Vg@mail.gmail.com>
References: <1364298777-8178-1-git-send-email-sachin.kamat@linaro.org> <CAHfPSqCyn=Q_zH11=pRjP3rY69xbHDnRSwBmiA4fGmz62hV-Vg@mail.gmail.com>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Wed, 27 Mar 2013 09:19:44 +0900
Message-ID: <CABMQnVLnj3CphEuAo_JVesNkT3VNZkhKy_J1URhooxw5zs0Otg@mail.gmail.com>
Subject: Re: [PATCH 1/1] iio: exynos-adc: Fix typo in DT documentation
To: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, patches@linaro.org, linux-iio@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com,
	jic23@kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Wed, Mar 27, 2013 at 8:55 AM, Naveen Krishna Ch
<naveenkrishna.ch@gmail.com> wrote:
> On 26 March 2013 04:52, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> Fixes some typos in the documentation of exynos-adc.txt.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  .../devicetree/bindings/arm/samsung/exynos-adc.txt |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>> index 05e9d95..1fc744b 100644
>> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>> @@ -1,6 +1,6 @@
>>  Samsung Exynos Analog to Digital Converter bindings
>>
>> -This devicetree binding are for the new adc driver written fori
>> +The devicetree bindings are for the new ADC driver written for
> Thanks for the correction
>>  Exynos4 and upward SoCs from Samsung.
>>
>>  New driver handles the following
>> @@ -49,4 +49,4 @@ adc@12D10000 {
>>  };
>>
>>  Note: Does not apply to ADC driver under arch/arm/plat-samsung/
>> -Note: The child node can be added under the adc node or seperately.
>> +Note: The child node can be added under the adc node or separately.
> Sorry, but i cant see whats the difference here.

This changed from sep*e*rately to sep*a*rately.
