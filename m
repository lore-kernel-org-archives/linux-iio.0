Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41036 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754025AbdKIKN6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Nov 2017 05:13:58 -0500
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
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH v4 00/12] Add STM32 DFSDM support
Date: Thu, 9 Nov 2017 11:12:22 +0100
Message-ID: <1510222354-15290-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,
Here is a new version of the DFSDM proposed.

Context reminder:
-----------------

DFSDM peripheral is a peripheral that allows to connect some sigma delta ADCs
or PDM microphones via a SPI or Manchester bus.
DFSDM integrates digital filters to offer up to 24 bits final resolution.

In term of SW architecture. 2 use-cases have to be supported:

1) Sigma delta ADC conversion through IIO framework.
Sigma delta ADC is handled by generic sigma delta modulator driver. 
DFSDM peripheral is binded to a SD modulator ADC using the IIO HW consumer interface. 
Please notice that IIO HW consumer interface has be proposed by Lars, but is
part of this patchset with Lars's agreement.
User interface is IIO one.
Notice that this patch-set propose only a raw conversion, to simplify review.
Buffer and trigger management will be added in next patch-sets.

2) PDM microphone record through ALSA framework.
PDM microphone is handled by ASOC Generic DMIC codec driver.
ADFSDM ASOC DAI driver is binded to IIO driver using the IIO consumer interface
ADFSDM ASOC DAI driver is binded to a PDM microphone ASOC component using ASOC Of_graph.
User interface is ALSA one.
As IIO DMA management is not adapted to an audio realtime stream. A specific DMA 
management has been implemented in IIO driver for audio purposes.

 
History of the versions:
-----------------------
V3:
Implementation with DMA support in IIO instead of handling it in ASOC.

	- New patches to support ASoC DMA codec in DT 
  		- ASoC: Add Bindins for DMIC codec driver.
  		- ASoC: codec: add DT support in dmic codec.
        - New patches to allow in-kernel set of IIO buffer size and watermark   
  		- IIO: consumer: allow to set buffer sizes.
	- IIO DFSDM drivers
        	- Split audio and ADC support in 2 drivers.
                - Implement DMA cyclic mode.
                - Add SPI bus Trigger for buffer management.
                
	- IIO sigma delta adc drivers
        	-  Suppress "simple and rename driver.
         
         - ASoC driver
         	- Suppress DMA engine.
                - Suppress copy ops.
                - Use IIO consmumer interface to enable/Disable DFSDM.        

V2:

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


Regards,
Arnaud


Arnaud Pouliquen (11):
  docs: driver-api: add iio hw consumer section
  IIO: hw_consumer: add devm_iio_hw_consumer_alloc
  IIO: Add DT bindings for sigma delta adc modulator
  IIO: ADC: add sigma delta modulator support
  IIO: add DT bindings for stm32 DFSDM filter
  IIO: ADC: add stm32 DFSDM core support
  IIO: ADC: add STM32 DFSDM sigma delta ADC support
  IIO: ADC: add stm32 DFSDM support for PDM microphone
  IIO: consumer: allow to set buffer sizes
  ASoC: add bindings for stm32 DFSDM filter
  ASoC: stm32: add DFSDM DAI support

Lars-Peter Clausen (1):
  iio: Add hardware consumer buffer support

 .../ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32      |   22 +
 .../bindings/iio/adc/sigma-delta-modulator.txt     |   13 +
 .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        |  127 ++
 .../devicetree/bindings/sound/st,stm32-adfsdm.txt  |   63 +
 Documentation/driver-api/iio/hw-consumer.rst       |   50 +
 Documentation/driver-api/iio/index.rst             |    1 +
 drivers/iio/adc/Kconfig                            |   37 +
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/sd_adc_modulator.c                 |   82 ++
 drivers/iio/adc/stm32-dfsdm-adc.c                  | 1250 ++++++++++++++++++++
 drivers/iio/adc/stm32-dfsdm-core.c                 |  318 +++++
 drivers/iio/adc/stm32-dfsdm.h                      |  319 +++++
 drivers/iio/buffer/Kconfig                         |   10 +
 drivers/iio/buffer/Makefile                        |    1 +
 drivers/iio/buffer/industrialio-buffer-cb.c        |   11 +
 drivers/iio/buffer/industrialio-hw-consumer.c      |  248 ++++
 include/linux/iio/adc/stm32-dfsdm-adc.h            |   27 +
 include/linux/iio/consumer.h                       |   11 +
 include/linux/iio/hw-consumer.h                    |   22 +
 sound/soc/stm/Kconfig                              |   11 +
 sound/soc/stm/Makefile                             |    3 +
 sound/soc/stm/stm32_adfsdm.c                       |  388 ++++++
 22 files changed, 3017 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
 create mode 100644 Documentation/driver-api/iio/hw-consumer.rst
 create mode 100644 drivers/iio/adc/sd_adc_modulator.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm-adc.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm-core.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm.h
 create mode 100644 drivers/iio/buffer/industrialio-hw-consumer.c
 create mode 100644 include/linux/iio/adc/stm32-dfsdm-adc.h
 create mode 100644 include/linux/iio/hw-consumer.h
 create mode 100644 sound/soc/stm/stm32_adfsdm.c

-- 
2.7.4

