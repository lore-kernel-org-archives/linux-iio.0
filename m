Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15698 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753087AbdBMQkz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Feb 2017 11:40:55 -0500
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
To: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC: <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <kernel@stlinux.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <arnaud.pouliquen@st.com>, olivier moysan <olivier.moysan@st.com>
Subject: [RFC v2 0/7]  Add STM32 DFSDM support
Date: Mon, 13 Feb 2017 17:38:22 +0100
Message-ID: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This RFC is following first patch-set sent for DFSDM driver
(https://www.spinics.net/lists/arm-kernel/msg557133.html).
AS MFD driver has been rejected, a new way to integrate DFSDM has to 
be defined.

Aim of this RFC is to provide a base to discuss this redesign.

1) DFSDM hardware overview:
-----------------------
The Digital Filter for Sigma Delta  is a module dedicated to interface external sigma 
delta modulators to STM32 micro-controllers. It is targeted for:
	- Audio mode signal with Pulse density modulation (PDM) microphone
	- motor and Sensing mode with sigma delta ADC modulator

Main Features:
 - Up to 8 multiplexed input digital serial channel (SIT)
	. SPI (PDM compatible) or Manchester interface
	.  Slave or master ( one main SPI CLK OUT for all interface) 
 - Alternative inputs for 8 internal digital parallel channels (PIT)
	. 16 bits resolution
	. internal sources: ADC or memory
 - Digital signal processing:
	. 4 instances
	. Sincx filter (x : order 1 to 5) oversampling ratio up to 1024
	. integrator: oversampling ratio up to 256
 - Channel multiplexer
	. allow to connect SIT or PIT to filter
	. channel n can be connected SIT n or SIT n+1
 - up to 24-bit output resolution
 	. signed
        . sampling rate  and resolution depend on filter parameters.
 - data offset correction
 - detector:
	. analog watchdog
	. short circuit detection
	. clock absence detection
	. extremes

For details on DFSDM IP, please refer to STM32F413 data-sheet chapter 15:
http://www.st.com/content/ccc/resource/technical/document/reference_manual/group0/81/ea/88/1f/97/9e/4a/d0/DM00305666/files/DM00305666.pdf/jcr:content/translations/en.DM00305666.pdf

2) SW design proposal:
---------------------
Patch-set associated to this RFC proposes an implementation of the
DFSDM features shared between ASoC and IIO frameworks.

Patch-set is only a Skeleton of the drivers, so a base to discuss and validate a design. 
It contains minimum code to allow probing (with DT) and to expose the ASoC and IIO ABI.
Hope that is sufficent in a first step to allow to focus on APIs.

In this patch-set there are two new APIs used:
	- IIO in-kern API: based on hw_customer API proposed by Lars
 	- ASOC <-> IIO API inspired by API defined for hdmi-codec for ASoC/DRM interconnect. 
   	  API is dedicated to DFSDM only.

Notice also that this design is based on following assumption:
	- Audio stream ABI interface is ASoC, no access to data through IIO ABI for PDM. 
	- ASoC DMA should be used for audio transfer as designed for real time stream.
	- Need some runtime parameters exchange between ASoC and IIO
	  due to the correlation between the sample frequency, the DFSDM decimation 
          factor and the associated scaling.

- "ASoC: dmaengine_pcm: add copy support" patch:
 I added a patch in ASoC that allows to implement a copy function to process data 
 after DMA transfer. Requested, as DFSDM samples captured contain channel ID 
 on 8-LSB bits and need also a potential rescale to present DAT on 24-bits.  	

- "IIO: ADC: add sigma delta modulator support" patch:
Simple dummy driver created to support external Sigma delta modulator. 
It is binded to DFSDM driver through hw_customer API.

Regards
Arnaud

Arnaud Pouliquen (6):
  iio: Add hardware consumer support
  IIO: Add bindings for simple sigma delta adc
  IIO: ADC: add sigma delta modulator support
  ASoC: stm32: add DFSDM DAI support
  IIO: add bindings for stm32 DFSDM filter
  IIO: ADC: add stm32 DFSDM support

olivier moysan (1):
  ASoC: dmaengine_pcm: add copy support

 .../devicetree/bindings/iio/adc/simple_sd_adc.txt  |  13 +
 .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        | 125 ++++++
 drivers/iio/Kconfig                                |   6 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/adc/Kconfig                            |  24 +
 drivers/iio/adc/Makefile                           |   2 +
 drivers/iio/adc/simple_sd_adc.c                    | 112 +++++
 drivers/iio/adc/stm32-dfsdm-adc.c                  | 483 +++++++++++++++++++++
 drivers/iio/adc/stm32-dfsdm-core.c                 | 273 ++++++++++++
 drivers/iio/adc/stm32-dfsdm.h                      | 141 ++++++
 drivers/iio/hw_consumer.c                          | 156 +++++++
 include/linux/iio/hw_consumer.h                    |  12 +
 include/sound/dmaengine_pcm.h                      |   3 +
 include/sound/stm32-adfsdm.h                       |  80 ++++
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/soc-generic-dmaengine-pcm.c              |  37 +-
 sound/soc/stm/Kconfig                              |  10 +
 sound/soc/stm/Makefile                             |   2 +
 sound/soc/stm/stm32_adfsdm.c                       | 365 ++++++++++++++++
 20 files changed, 1845 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/simple_sd_adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
 create mode 100644 drivers/iio/adc/simple_sd_adc.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm-adc.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm-core.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm.h
 create mode 100644 drivers/iio/hw_consumer.c
 create mode 100644 include/linux/iio/hw_consumer.h
 create mode 100644 include/sound/stm32-adfsdm.h
 create mode 100644 sound/soc/stm/Kconfig
 create mode 100644 sound/soc/stm/Makefile
 create mode 100644 sound/soc/stm/stm32_adfsdm.c

-- 
1.9.1

