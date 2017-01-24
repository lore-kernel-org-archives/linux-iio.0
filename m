Return-Path: <SRS0=sDhQ=ZG=st.com=arnaud.pouliquen@kernel.org>
Subject: Re: [PATCH 2/7] MFD: add STM32 DFSDM support
To: Lee Jones <lee.jones@linaro.org>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
 <20170124082249.GR16020@dell>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack
	<knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <283c0e48-55e2-6516-369d-91dc72d12f73@st.com>
Date: Tue, 24 Jan 2017 09:30:27 +0100
MIME-Version: 1.0
In-Reply-To: <20170124082249.GR16020@dell>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

Hello Lee,

On 01/24/2017 09:22 AM, Lee Jones wrote:
> On Mon, 23 Jan 2017, Arnaud Pouliquen wrote:
> 
>> DFSDM hardware IP can be used at the same time for ADC sigma delta
> 
> Same time as what?
DFSDM is used for ADC acquisition (through IIO) but also PDM microphone
capture (through ASOC).
> 
>> conversion and audio PDM microphone.
>> MFD driver is in charge of configuring IP registers and managing IP clocks.
>> For this it exports an API to handles filters and channels resources.
> 
> This looks like an ADC driver?  What is it that makes it an MFD?
Yes it a kind of ADC but that supports 2 features audio and iio.
So it has to support 2 features based on 2 separate Frameworks.

> 
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>  drivers/mfd/Kconfig             |   11 +
>>  drivers/mfd/Makefile            |    2 +
>>  drivers/mfd/stm32-dfsdm-reg.h   |  220 +++++++++
>>  drivers/mfd/stm32-dfsdm.c       | 1044 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/stm32-dfsdm.h |  324 ++++++++++++
>>  5 files changed, 1601 insertions(+)
>>  create mode 100644 drivers/mfd/stm32-dfsdm-reg.h
>>  create mode 100644 drivers/mfd/stm32-dfsdm.c
>>  create mode 100644 include/linux/mfd/stm32-dfsdm.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index c6df644..4bb660b 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -1607,6 +1607,17 @@ config MFD_STW481X
>>  	  in various ST Microelectronics and ST-Ericsson embedded
>>  	  Nomadik series.
>>  
>> +config MFD_STM32_DFSDM
>> +	tristate "ST Microelectronics STM32 DFSDM"
>> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
>> +	select MFD_CORE
>> +	select REGMAP
>> +	select REGMAP_MMIO
>> +	help
>> +	  Select this option to enable the STM32 Digital Filter
>> +	  for Sigma Delta Modulators (DFSDM) driver used
>> +	  in various STM32 series.
>> +
>>  menu "Multimedia Capabilities Port drivers"
>>  	depends on ARCH_SA1100
> 
> [...]
> 

Regards
Arnaud
