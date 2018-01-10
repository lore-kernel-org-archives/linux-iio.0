Return-Path: <SRS0=LhAi=EF=st.com=arnaud.pouliquen@kernel.org>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, <arnaud.pouliquen@st.com>
Subject: [RESEND PATCH v9 00/13] Add STM32 DFSDM support
Date: Wed, 10 Jan 2018 11:13:02 +0100
Message-ID: <1515579195-12894-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Hello Mark,

Here is the resend of the patchset.
I added the Reviewed-by: Jonathan Cameron in patch 10/13.

Jonathan's comment for you, posted for this version:
>So Mark, over to you. I'm happy if you want to do the immutable branch once 
>any issue you find are fixed, or I can do it. 
>I'm just looking for acks or a pull request now.

History:

Version 9 fix patch 10/13: IIO: ADC: add stm32 DFSDM support for PDM microphone

Main deltas V9 vs V8:
- Rework probe and remove order for audio configuration in stm32-dfsdm-adc.c.
- Optimization of the filling of the dma_slave_config struct.

Main deltas V8 vs V7:
- Few typos fixes.
- Function return optimizations in sound/soc/stm/stm32_adfsdm.c.

Main deltas V7 vs V6:
- Replaces the custom license information text with the appropriate 
  SPDX identifier.
- Few fixes in sound/soc/stm/stm32_adfsdm.c and stm32-dfsdm-core.c.
- Add missing #interrupt-cells in binding examples.
- Integrate last Jonathan's comments.

Main deltas V6 vs V5:
- Fix warning reported by kbuild test in :
   include/linux/iio/consumer.h
   sound/soc/stm/stm32_adfsdm.c

Main deltas V5 vs V4:
- Integrate ASOC DAI as a subnode of the DFSDM.
- Add in kernel consumer interface to allow to manipulate attribute.

Thanks,
Arnaud

Arnaud Pouliquen (12):
  docs: driver-api: add iio hw consumer section
  IIO: hw_consumer: add devm_iio_hw_consumer_alloc
  IIO: inkern: API for manipulating channel attributes
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

 .../ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32      |   16 +
 .../bindings/iio/adc/sigma-delta-modulator.txt     |   13 +
 .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        |  128 +++
 .../devicetree/bindings/sound/st,stm32-adfsdm.txt  |   63 +
 Documentation/driver-api/iio/hw-consumer.rst       |   51 +
 Documentation/driver-api/iio/index.rst             |    1 +
 drivers/iio/adc/Kconfig                            |   37 +
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/sd_adc_modulator.c                 |   68 ++
 drivers/iio/adc/stm32-dfsdm-adc.c                  | 1216 ++++++++++++++++++++
 drivers/iio/adc/stm32-dfsdm-core.c                 |  309 +++++
 drivers/iio/adc/stm32-dfsdm.h                      |  310 +++++
 drivers/iio/buffer/Kconfig                         |   10 +
 drivers/iio/buffer/Makefile                        |    1 +
 drivers/iio/buffer/industrialio-buffer-cb.c        |   11 +
 drivers/iio/buffer/industrialio-hw-consumer.c      |  247 ++++
 drivers/iio/inkern.c                               |   17 +-
 include/linux/iio/adc/stm32-dfsdm-adc.h            |   18 +
 include/linux/iio/consumer.h                       |   37 +
 include/linux/iio/hw-consumer.h                    |   21 +
 include/linux/iio/iio.h                            |   28 -
 include/linux/iio/types.h                          |   28 +
 sound/soc/stm/Kconfig                              |   11 +
 sound/soc/stm/Makefile                             |    3 +
 sound/soc/stm/stm32_adfsdm.c                       |  347 ++++++
 25 files changed, 2961 insertions(+), 33 deletions(-)
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
