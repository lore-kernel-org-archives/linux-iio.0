Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34980 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdAXLdB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jan 2017 06:33:01 -0500
Received: by mail-wm0-f42.google.com with SMTP id r126so177187041wmr.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Jan 2017 03:33:00 -0800 (PST)
Date: Tue, 24 Jan 2017 11:36:58 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
Subject: Re: [PATCH 2/7] MFD: add STM32 DFSDM support
Message-ID: <20170124113658.GW16020@dell>
References: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
 <1485189145-29576-3-git-send-email-arnaud.pouliquen@st.com>
 <20170124082249.GR16020@dell>
 <283c0e48-55e2-6516-369d-91dc72d12f73@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <283c0e48-55e2-6516-369d-91dc72d12f73@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 24 Jan 2017, Arnaud Pouliquen wrote:
> On 01/24/2017 09:22 AM, Lee Jones wrote:
> > On Mon, 23 Jan 2017, Arnaud Pouliquen wrote:
> > 
> >> DFSDM hardware IP can be used at the same time for ADC sigma delta
> > 
> > Same time as what?
> DFSDM is used for ADC acquisition (through IIO) but also PDM microphone
> capture (through ASOC).
> > 
> >> conversion and audio PDM microphone.
> >> MFD driver is in charge of configuring IP registers and managing IP clocks.
> >> For this it exports an API to handles filters and channels resources.
> > 
> > This looks like an ADC driver?  What is it that makes it an MFD?
> Yes it a kind of ADC but that supports 2 features audio and iio.
> So it has to support 2 features based on 2 separate Frameworks.

I'm still unsure why it needs to live in MFD.

By the looks of it, this driver needs to move into IIO and you need to
call into it from ASoC.

> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> >> ---
> >>  drivers/mfd/Kconfig             |   11 +
> >>  drivers/mfd/Makefile            |    2 +
> >>  drivers/mfd/stm32-dfsdm-reg.h   |  220 +++++++++
> >>  drivers/mfd/stm32-dfsdm.c       | 1044 +++++++++++++++++++++++++++++++++++++++
> >>  include/linux/mfd/stm32-dfsdm.h |  324 ++++++++++++
> >>  5 files changed, 1601 insertions(+)
> >>  create mode 100644 drivers/mfd/stm32-dfsdm-reg.h
> >>  create mode 100644 drivers/mfd/stm32-dfsdm.c
> >>  create mode 100644 include/linux/mfd/stm32-dfsdm.h
> >>
> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >> index c6df644..4bb660b 100644
> >> --- a/drivers/mfd/Kconfig
> >> +++ b/drivers/mfd/Kconfig
> >> @@ -1607,6 +1607,17 @@ config MFD_STW481X
> >>  	  in various ST Microelectronics and ST-Ericsson embedded
> >>  	  Nomadik series.
> >>  
> >> +config MFD_STM32_DFSDM
> >> +	tristate "ST Microelectronics STM32 DFSDM"
> >> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
> >> +	select MFD_CORE
> >> +	select REGMAP
> >> +	select REGMAP_MMIO
> >> +	help
> >> +	  Select this option to enable the STM32 Digital Filter
> >> +	  for Sigma Delta Modulators (DFSDM) driver used
> >> +	  in various STM32 series.
> >> +
> >>  menu "Multimedia Capabilities Port drivers"
> >>  	depends on ARCH_SA1100
> > 
> > [...]
> > 
> 
> Regards
> Arnaud

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
