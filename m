Return-Path: <SRS0=FQXd=2M=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH v3 6/6] iio: adc: stm32: add support for EXTI trigger
To: Fabrice Gasnier <fabrice.gasnier@st.com>, jic23@kernel.org,
 linux@armlinux.org.uk, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
 <1488300679-3259-7-git-send-email-fabrice.gasnier@st.com>
 <5be44ed9-2c86-ac51-d964-d231d5ca62fa@metafoo.de>
 <abeb2ef6-8bc8-bbea-e8e1-4b2ebe72b5f9@st.com>
 <9f39b0ac-a6fb-8a9f-7280-c6718b56aabe@metafoo.de>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, knaack.h@gmx.de,
 pmeerw@pmeerw.net, benjamin.gaignard@linaro.org, benjamin.gaignard@st.com,
 linus.walleij@linaro.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b6bef4d0-31d3-ea63-65ab-acfd0459489a@metafoo.de>
Date: Fri, 3 Mar 2017 16:47:10 +0100
MIME-Version: 1.0
In-Reply-To: <9f39b0ac-a6fb-8a9f-7280-c6718b56aabe@metafoo.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 03/03/2017 04:46 PM, Lars-Peter Clausen wrote:
> On 03/03/2017 02:00 PM, Fabrice Gasnier wrote:
>> On 03/03/2017 12:45 PM, Lars-Peter Clausen wrote:
>>> On 02/28/2017 05:51 PM, Fabrice Gasnier wrote:
>>>> EXTi (external interrupt) signal can be routed internally as trigger
>>>> source for ADC conversions: STM32F4 ADC can use EXTI11.
>>>>
>>>> Retrieve interrupt trigger from DT, so it can be muxed into ADC IP,
>>>> via extsel.
>>>
>>> Hi,
>>>
>>> Sorry, I have some trouble understanding the specifics of this. Is EXTI a
>>> hardware input signal into the ADC that automatically triggers a conversion
>>> when asserted? If yes how is it configured which external signal is used
>>> here. Your bindings suggest that any GPIO can be used, but the driver only
>>> differentiates between EXTI on or EXTI off.
>> Hi Lars,
>>
>> Yes, STM32 EXTI is external interrupt/event line. In case of STM32 ADC,
>> EXTI11 signal can be used to start a conversion. In this case, it must
>> be selected inside ADC IP using extsel bitfield. This EXTI11 line can
>> mapped from any GPIO bank A,B... line 11 (e.g. PA11 or PB11...) by using
>> interrupt binding.
>> This is why I expose this in DT.
> 
> How is the mapping? That's the part I don't understand. How does requesting

How is the mapping done?

> the IRQ for the GPIO as a generic software IRQ establish the hardware
> connection between the GPIO block and the ADC?
> 
