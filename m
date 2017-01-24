Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:63071 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750779AbdAXNdo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jan 2017 08:33:44 -0500
Subject: Re: [PATCH 2/7] MFD: add STM32 DFSDM support
To: Lee Jones <lee.jones@linaro.org>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
 <20170124082249.GR16020@dell> <283c0e48-55e2-6516-369d-91dc72d12f73@st.com>
 <20170124113658.GW16020@dell>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <a1aaaa20-ac00-b182-f1c1-63152be41135@st.com>
Date: Tue, 24 Jan 2017 14:32:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170124113658.GW16020@dell>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 01/24/2017 12:36 PM, Lee Jones wrote:
> On Tue, 24 Jan 2017, Arnaud Pouliquen wrote:
>> On 01/24/2017 09:22 AM, Lee Jones wrote:
>>> On Mon, 23 Jan 2017, Arnaud Pouliquen wrote:
>>>
>>>> DFSDM hardware IP can be used at the same time for ADC sigma delta
>>>
>>> Same time as what?
>> DFSDM is used for ADC acquisition (through IIO) but also PDM microphone
>> capture (through ASOC).
>>>
>>>> conversion and audio PDM microphone.
>>>> MFD driver is in charge of configuring IP registers and managing IP clocks.
>>>> For this it exports an API to handles filters and channels resources.
>>>
>>> This looks like an ADC driver?  What is it that makes it an MFD?
>> Yes it a kind of ADC but that supports 2 features audio and iio.
>> So it has to support 2 features based on 2 separate Frameworks.
> 
> I'm still unsure why it needs to live in MFD.
> 
> By the looks of it, this driver needs to move into IIO and you need to
> call into it from ASoC.
> 

I think i introduce confusion by speaking about ADC for audio...

1) IIO handles sigma delta ADCs that can be used as example for motor
controls. the aim is to get value based on an application request or
using some triggers.
example: http://www.ti.com/lit/ds/symlink/ads1202.pdf

2) For audio part, we speak about Digital mems microphones that generate
PDM format stream. PDM is a continuous real time stream dedicated to
audio record and must be handled in ASOC ( codec Dmic part driver is
/sound/soc/codec/dmic.c).
DMIC example:
http://www.st.com/content/ccc/resource/technical/document/datasheet/47/bd/d2/13/8d/fd/48/26/DM00121815.pdf/files/DM00121815.pdf/jcr:content/translations/en.DM00121815.pdf

Form my point of view it very strange to handle DMICs in IIO, as it is
not designed to support audio streams.it is two separate features that
are not compatible.

Now, from software point of view
That would means that IIO declares ADCs that it can not expose, because
DMIC is not IIO standard. But IIO inkern API needs that device is
declared... So i should define a specific API in IIO for ASOC driver.


>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>>>> ---
>>>>  drivers/mfd/Kconfig             |   11 +
>>>>  drivers/mfd/Makefile            |    2 +
>>>>  drivers/mfd/stm32-dfsdm-reg.h   |  220 +++++++++
>>>>  drivers/mfd/stm32-dfsdm.c       | 1044 +++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/mfd/stm32-dfsdm.h |  324 ++++++++++++
>>>>  5 files changed, 1601 insertions(+)
>>>>  create mode 100644 drivers/mfd/stm32-dfsdm-reg.h
>>>>  create mode 100644 drivers/mfd/stm32-dfsdm.c
>>>>  create mode 100644 include/linux/mfd/stm32-dfsdm.h
>>>>
>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>> index c6df644..4bb660b 100644
>>>> --- a/drivers/mfd/Kconfig
>>>> +++ b/drivers/mfd/Kconfig
>>>> @@ -1607,6 +1607,17 @@ config MFD_STW481X
>>>>  	  in various ST Microelectronics and ST-Ericsson embedded
>>>>  	  Nomadik series.
>>>>  
>>>> +config MFD_STM32_DFSDM
>>>> +	tristate "ST Microelectronics STM32 DFSDM"
>>>> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
>>>> +	select MFD_CORE
>>>> +	select REGMAP
>>>> +	select REGMAP_MMIO
>>>> +	help
>>>> +	  Select this option to enable the STM32 Digital Filter
>>>> +	  for Sigma Delta Modulators (DFSDM) driver used
>>>> +	  in various STM32 series.
>>>> +
>>>>  menu "Multimedia Capabilities Port drivers"
>>>>  	depends on ARCH_SA1100
>>>
>>> [...]
>>>
>>
>> Regards
>> Arnaud
> 
