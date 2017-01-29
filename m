Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50986 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbdA2M3I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2017 07:29:08 -0500
Subject: Re: [PATCH 2/7] MFD: add STM32 DFSDM support
To: Lee Jones <lee.jones@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
 <20170124082249.GR16020@dell> <283c0e48-55e2-6516-369d-91dc72d12f73@st.com>
 <20170124113658.GW16020@dell> <a1aaaa20-ac00-b182-f1c1-63152be41135@st.com>
 <20170127101545.g53uah57vgfu55o5@dell>
 <7b3eb38d-4fd1-2006-7423-94f2a7b38b27@st.com>
 <20170127171746.lf2nbpsaqs3dmy44@dell>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3810896b-c982-e9fd-b095-658921422855@kernel.org>
Date: Sun, 29 Jan 2017 12:28:59 +0000
MIME-Version: 1.0
In-Reply-To: <20170127171746.lf2nbpsaqs3dmy44@dell>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/01/17 17:17, Lee Jones wrote:
> On Fri, 27 Jan 2017, Arnaud Pouliquen wrote:
>> On 01/27/2017 11:15 AM, Lee Jones wrote:
>>> On Tue, 24 Jan 2017, Arnaud Pouliquen wrote:
>>>> On 01/24/2017 12:36 PM, Lee Jones wrote:
>>>>> On Tue, 24 Jan 2017, Arnaud Pouliquen wrote:
>>>>>> On 01/24/2017 09:22 AM, Lee Jones wrote:
>>>>>>> On Mon, 23 Jan 2017, Arnaud Pouliquen wrote:
>>>>>>>
>>>>>>>> DFSDM hardware IP can be used at the same time for ADC sigma delta
>>>>>>>
>>>>>>> Same time as what?
>>>>>> DFSDM is used for ADC acquisition (through IIO) but also PDM microphone
>>>>>> capture (through ASOC).
>>>>>>>
>>>>>>>> conversion and audio PDM microphone.
>>>>>>>> MFD driver is in charge of configuring IP registers and managing IP clocks.
>>>>>>>> For this it exports an API to handles filters and channels resources.
>>>>>>>
>>>>>>> This looks like an ADC driver?  What is it that makes it an MFD?
>>>>>> Yes it a kind of ADC but that supports 2 features audio and iio.
>>>>>> So it has to support 2 features based on 2 separate Frameworks.
>>>>>
>>>>> I'm still unsure why it needs to live in MFD.
>>>>>
>>>>> By the looks of it, this driver needs to move into IIO and you need to
>>>>> call into it from ASoC.
>>>>>
>>>>
>>>> I think i introduce confusion by speaking about ADC for audio...
>>>>
>>>> 1) IIO handles sigma delta ADCs that can be used as example for motor
>>>> controls. the aim is to get value based on an application request or
>>>> using some triggers.
>>>> example: http://www.ti.com/lit/ds/symlink/ads1202.pdf
>>>>
>>>> 2) For audio part, we speak about Digital mems microphones that generate
>>>> PDM format stream. PDM is a continuous real time stream dedicated to
>>>> audio record and must be handled in ASOC ( codec Dmic part driver is
>>>> /sound/soc/codec/dmic.c).
>>>> DMIC example:
>>>> http://www.st.com/content/ccc/resource/technical/document/datasheet/47/bd/d2/13/8d/fd/48/26/DM00121815.pdf/files/DM00121815.pdf/jcr:content/translations/en.DM00121815.pdf
>>>>
>>>> Form my point of view it very strange to handle DMICs in IIO, as it is
>>>> not designed to support audio streams.it is two separate features that
>>>> are not compatible.
>>>>
>>>> Now, from software point of view
>>>> That would means that IIO declares ADCs that it can not expose, because
>>>> DMIC is not IIO standard. But IIO inkern API needs that device is
>>>> declared
>>>
>>>> So i should define a specific API in IIO for ASOC driver.
>>>
>>> Yes, this is what I think you should do.
>>>
>>> MFD is not a dumping ground for devices that do not fit anywhere else.
>>
>> I fully understand that you don't want to create unnecessary MFD devices.
>> But In case of DFSDM ,it is really a device that supports 2 features.
>> The main evidence is that "ADC acquisition" and "digital microphone"
>> features are handled by two separate frameworks.
>> So this corresponds to two features that share the same device resources
>> (registers, IRQs, clocks).
>> Seems that this match with MFD definition.
>>
>> Now, if IIO and ASOC maintainers are aligned with you proposal, i will
>> move MFD part in IIO.
>> But in this case, i can not see another way to do it, except a MFD
>> driver hidden in IIO?
>>
>> Here is my analysis of a design in IIO:
>>
>> Natural way to do this is to consider that ASOC is a customer of IIO so
>> use the customer.h API.
>> 1) As Digital microphone can not be handled by IIO dev interface, i can
>> not expose them as an IIO channel, that would be visible by applications
>> in /sys/bus/iio/devices/iio
>> 2) ASOC needs to configure DFSDM filter to match to specific frequencies
>> and sample formats requested by users. Not standard IIO interface to do
>> this. (on IIO side this is done by attribute file)
>> 3) audio stream is a real time stream. So for audio quality best is to
>> minimize latencies and Xrun. That why transfer as done from HW to
>> application using LLI DMA transfers with a minimum of copy. This does
>> not match with the IIO inkern API.
>>  => So seems not possible to use IIO inkern API.
>>
>> That's means that i would need to create a ST specific include file to
>> offer an API to ASoC to handle DFSDM resources linked to the DMIC.
>> and to probe ASOc device in IIO one.
>> So the solution would be to create something like a sub IIO driver That
>> probe and handle some IIO and ASOC devices.
>> Ultimately This would correspond to a MFD driver integrated in IIO...
> 
> The issue is not the creation of an MFD driver to create shared
> resources and probe the child devices.  That's what MFD *is* for.
> What I do take exception to is having lots of code in MFD which
> should clearly live in a different subsystem.
> 
> Since this device only serves a couple of functions, I expect it to be
> a few hundred lines, maximum.  Everything else should be farmed out.
> MFD knows nothing of "channels" or "filters" so anything related to
> them (init, get, start, stop, release, etc) needs to find another
> home.  Whether that's in IIO is a separate discussion, but it
> certainly doesn't live in MFD.
> 
>> Jonathan, Mark, Please could you share your opinion on this topic?
Hmm - based on a fairly quick read through of the code (which is never
ideal!). I can see that the ideal would indeed be as Lee says, to
expand the IIO interfaces sufficiently to support what you need.


So, reading the code (fairly quickly I'm afraid as had a lot of reviews
to catch up on this weekend).
What we need:
1) DMA support in the ADC driver.  This would be a good anyway!
2) DMA consumer support - I defer to Lars for comments on this.
3) Means of describing and controlling the sinc filters applied. 
4) Appropriate channel support.  I'm not convinced that it doesn't make
sense to have IIO channels for the microphones - at least in a streaming
mode.  It's data - I don't really care what ;)
Coarsely it's a filtered pulse per period counter which is
a perfectly valid type to have a channel for.

The big question to my mind is the DMA consumer support. How would
it work. It it wouldn't this is somewhat of a non starter.

To bring up another slightly ugly MFD case where it is borderline
on whether an MFD makes sense (just as a reference point of something
we have discussed a few times before)

ADCs with features directed at touchscreen support.
These are odd as the ADC bit is generic, but the specific output
and read sequences used for touchscreen reading don't correspond to
anything that makes any real sense for other applications.

We have started to get hybrid drives that have an MFD underneath but
do the ADC reads through IIO consumer interfaces, and the timing
control from a touchscreen driver.  We haven't really gotten this
one right yet either.

Here however, to my mind things are different - as I read it
(and feel free to point out what I'm missing), the sound usecase
is just a question of setting up sampling frequencies and filters
appropriate to the microphones and what ASoC expects?

That's not to say the IIO dma stuff is flexible enough (yet) to
handle the data flows, but perhaps we can work towards that.

Jonathan

>>
>> Regards
>> Arnaud
>>
>>>
>>>>>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>>>>>>>> ---
>>>>>>>>  drivers/mfd/Kconfig             |   11 +
>>>>>>>>  drivers/mfd/Makefile            |    2 +
>>>>>>>>  drivers/mfd/stm32-dfsdm-reg.h   |  220 +++++++++
>>>>>>>>  drivers/mfd/stm32-dfsdm.c       | 1044 +++++++++++++++++++++++++++++++++++++++
>>>>>>>>  include/linux/mfd/stm32-dfsdm.h |  324 ++++++++++++
>>>>>>>>  5 files changed, 1601 insertions(+)
>>>>>>>>  create mode 100644 drivers/mfd/stm32-dfsdm-reg.h
>>>>>>>>  create mode 100644 drivers/mfd/stm32-dfsdm.c
>>>>>>>>  create mode 100644 include/linux/mfd/stm32-dfsdm.h
>>>>>>>>
>>>>>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>>>>>> index c6df644..4bb660b 100644
>>>>>>>> --- a/drivers/mfd/Kconfig
>>>>>>>> +++ b/drivers/mfd/Kconfig
>>>>>>>> @@ -1607,6 +1607,17 @@ config MFD_STW481X
>>>>>>>>  	  in various ST Microelectronics and ST-Ericsson embedded
>>>>>>>>  	  Nomadik series.
>>>>>>>>  
>>>>>>>> +config MFD_STM32_DFSDM
>>>>>>>> +	tristate "ST Microelectronics STM32 DFSDM"
>>>>>>>> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
>>>>>>>> +	select MFD_CORE
>>>>>>>> +	select REGMAP
>>>>>>>> +	select REGMAP_MMIO
>>>>>>>> +	help
>>>>>>>> +	  Select this option to enable the STM32 Digital Filter
>>>>>>>> +	  for Sigma Delta Modulators (DFSDM) driver used
>>>>>>>> +	  in various STM32 series.
>>>>>>>> +
>>>>>>>>  menu "Multimedia Capabilities Port drivers"
>>>>>>>>  	depends on ARCH_SA1100
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>
>>>>>> Regards
>>>>>> Arnaud
>>>>>
>>>
> 

