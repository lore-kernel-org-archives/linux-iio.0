Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46604 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953Ab3C2J1n (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Mar 2013 05:27:43 -0400
Message-ID: <51555E90.1090205@kernel.org>
Date: Fri, 29 Mar 2013 09:27:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
CC: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	Sachin Kamat <sachin.kamat@linaro.org>, patches@linaro.org,
	linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	rob.herring@calxeda.com
Subject: Re: [PATCH 1/1] iio: exynos-adc: Fix typo in DT documentation
References: <1364298777-8178-1-git-send-email-sachin.kamat@linaro.org> <CAHfPSqCyn=Q_zH11=pRjP3rY69xbHDnRSwBmiA4fGmz62hV-Vg@mail.gmail.com> <CABMQnVLnj3CphEuAo_JVesNkT3VNZkhKy_J1URhooxw5zs0Otg@mail.gmail.com> <CAHfPSqD9K85rypFEYhQoC61F3dUOfGtu_kTfvrVFCww7cgrMQA@mail.gmail.com>
In-Reply-To: <CAHfPSqD9K85rypFEYhQoC61F3dUOfGtu_kTfvrVFCww7cgrMQA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/27/2013 12:41 AM, Naveen Krishna Ch wrote:
> On 26 March 2013 17:19, Nobuhiro Iwamatsu <iwamatsu@nigauri.org> wrote:
>> On Wed, Mar 27, 2013 at 8:55 AM, Naveen Krishna Ch
>> <naveenkrishna.ch@gmail.com> wrote:
>>> On 26 March 2013 04:52, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>>>> Fixes some typos in the documentation of exynos-adc.txt.
>>>>
>>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to togreg branch of iio.git. Thanks
>>>> ---
>>>>  .../devicetree/bindings/arm/samsung/exynos-adc.txt |    4 ++--
>>>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>>>> index 05e9d95..1fc744b 100644
>>>> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>>>> @@ -1,6 +1,6 @@
>>>>  Samsung Exynos Analog to Digital Converter bindings
>>>>
>>>> -This devicetree binding are for the new adc driver written fori
>>>> +The devicetree bindings are for the new ADC driver written for
>>> Thanks for the correction
>>>>  Exynos4 and upward SoCs from Samsung.
>>>>
>>>>  New driver handles the following
>>>> @@ -49,4 +49,4 @@ adc@12D10000 {
>>>>  };
>>>>
>>>>  Note: Does not apply to ADC driver under arch/arm/plat-samsung/
>>>> -Note: The child node can be added under the adc node or seperately.
>>>> +Note: The child node can be added under the adc node or separately.
>>> Sorry, but i cant see whats the difference here.
>>
>> This changed from sep*e*rately to sep*a*rately.
> ohh missed it again, thanks
> 
> 
> 
> --
> Shine bright,
> (: Nav :)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
