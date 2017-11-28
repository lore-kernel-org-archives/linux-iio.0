Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34830 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753715AbdK1PIN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Nov 2017 10:08:13 -0500
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
Subject: [PATCH v5 00/13] Add STM32 DFSDM support
Date: Tue, 28 Nov 2017 16:05:44 +0100
Message-ID: <1511881557-28596-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

Here is a new version integrating remarks from Rob and Jonathan.

Main deltas vs V4:
- Integrate ASOC DAI not as a subnode of the DFSDM.
- Add in kernel consumer interface to allow to manipulate attribute.

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

Regards,
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
 .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        |  127 ++
 .../devicetree/bindings/sound/st,stm32-adfsdm.txt  |   62 +
 Documentation/driver-api/iio/hw-consumer.rst       |   51 +
 Documentation/driver-api/iio/index.rst             |    1 +
 drivers/iio/adc/Kconfig                            |   37 +
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/sd_adc_modulator.c                 |   81 ++
 drivers/iio/adc/stm32-dfsdm-adc.c                  | 1232 ++++++++++++++++++++
 drivers/iio/adc/stm32-dfsdm-core.c                 |  318 +++++
 drivers/iio/adc/stm32-dfsdm.h                      |  319 +++++
 drivers/iio/buffer/Kconfig                         |   10 +
 drivers/iio/buffer/Makefile                        |    1 +
 drivers/iio/buffer/industrialio-buffer-cb.c        |   11 +
 drivers/iio/buffer/industrialio-hw-consumer.c      |  248 ++++
 drivers/iio/inkern.c                               |   18 +-
 include/linux/iio/adc/stm32-dfsdm-adc.h            |   28 +
 include/linux/iio/consumer.h                       |   37 +
 include/linux/iio/hw-consumer.h                    |   22 +
 sound/soc/stm/Kconfig                              |   11 +
 sound/soc/stm/Makefile                             |    3 +
 sound/soc/stm/stm32_adfsdm.c                       |  386 ++++++
 23 files changed, 3030 insertions(+), 5 deletions(-)
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

