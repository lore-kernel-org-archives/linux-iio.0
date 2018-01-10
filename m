Return-Path: <arnaud.pouliquen@st.com>
Subject: Re: [RESEND PATCH v9 00/13] Add STM32 DFSDM support
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Mark Brown
	<broonie@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
References: <1515579195-12894-1-git-send-email-arnaud.pouliquen@st.com>
 <20180110103607.GD9003@sirena.org.uk>
 <EDAAA911-C2FA-44B1-AAD6-22D7600CF6A5@jic23.retrosnub.co.uk>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <8e261059-d233-162c-3dbd-6dc4215380f1@st.com>
Date: Wed, 10 Jan 2018 14:24:05 +0100
MIME-Version: 1.0
In-Reply-To: <EDAAA911-C2FA-44B1-AAD6-22D7600CF6A5@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>



On 01/10/2018 01:57 PM, Jonathan Cameron wrote:
> 
> 
> On 10 January 2018 10:36:07 GMT, Mark Brown <broonie@kernel.org> wrote:
>>On Wed, Jan 10, 2018 at 11:13:02AM +0100, Arnaud Pouliquen wrote:
>>
>>> Jonathan's comment for you, posted for this version:
>>> >So Mark, over to you. I'm happy if you want to do the immutable
>>branch once 
>>> >any issue you find are fixed, or I can do it. 
>>> >I'm just looking for acks or a pull request now.
>>
>>Jonathan, this is a pretty weird way of doing things - the bulk of the
>>series is for IIO so I'd have expected it to go in via the IIO tree.
>>It's especially odd to end up with the driver which isn't a build
>>dependency in my tree.
> 
> Hi Mark,
> 
> Sure, such a branch in IIO might have made more sense. I got it into my
> head that you
>  wanted to do it this way!
> 
> Didn't care myself as result is the same.
> 
> Oops if that wasn't your intent.
> 
> Ah well, all is well that ends well and thanks for this.
> 
> Jonathan
> 

Jonathan, Lars, Mark and Rob

Even if it is just the first step of the integration process, i would
like to take this opportunity to thank you for your help to integrate
the DFSDM drivers.
Probably not the most tricky one, but not the easiest either...
So thanks for your reviews, advices, solutions, and compromises.

Regards
Arnaud

>>
>>The following changes since commit
>>4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>>
>>  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>>
>>are available in the Git repository at:
>>
>>https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>>tags/iio-asoc-sync
>>
>>for you to fetch changes up to
>>16cbca06fa8288a4f58426fc898b141e12ee8008:
>>
>>  IIO: consumer: allow to set buffer sizes (2018-01-10 10:30:14 +0000)
>>
>>----------------------------------------------------------------
>>IIO: ST DFSDM support
>>
>>This is the IIO portion of some patches adding support for the ST DFSDM
>>IP, it's shared with ASoC as the hardware is also used for audio.
>>
>>----------------------------------------------------------------
>>Arnaud Pouliquen (10):
>>      docs: driver-api: add iio hw consumer section
>>      IIO: hw_consumer: add devm_iio_hw_consumer_alloc
>>      IIO: inkern: API for manipulating channel attributes
>>      IIO: Add DT bindings for sigma delta adc modulator
>>      IIO: ADC: add sigma delta modulator support
>>      IIO: add DT bindings for stm32 DFSDM filter
>>      IIO: ADC: add stm32 DFSDM core support
>>      IIO: ADC: add STM32 DFSDM sigma delta ADC support
>>      IIO: ADC: add stm32 DFSDM support for PDM microphone
>>      IIO: consumer: allow to set buffer sizes
>>
>>Lars-Peter Clausen (1):
>>      iio: Add hardware consumer buffer support
>>
>> .../ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32      |   16 +
>> .../bindings/iio/adc/sigma-delta-modulator.txt     |   13 +
>> .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        |  128 +++
>> Documentation/driver-api/iio/hw-consumer.rst       |   51 +
>> Documentation/driver-api/iio/index.rst             |    1 +
>> drivers/iio/adc/Kconfig                            |   37 +
>> drivers/iio/adc/Makefile                           |    3 +
>> drivers/iio/adc/sd_adc_modulator.c                 |   68 ++
>>drivers/iio/adc/stm32-dfsdm-adc.c                  | 1216
>>++++++++++++++++++++
>> drivers/iio/adc/stm32-dfsdm-core.c                 |  309 +++++
>> drivers/iio/adc/stm32-dfsdm.h                      |  310 +++++
>> drivers/iio/buffer/Kconfig                         |   10 +
>> drivers/iio/buffer/Makefile                        |    1 +
>> drivers/iio/buffer/industrialio-buffer-cb.c        |   11 +
>> drivers/iio/buffer/industrialio-hw-consumer.c      |  247 ++++
>> drivers/iio/inkern.c                               |   17 +-
>> include/linux/iio/adc/stm32-dfsdm-adc.h            |   18 +
>> include/linux/iio/consumer.h                       |   37 +
>> include/linux/iio/hw-consumer.h                    |   21 +
>> include/linux/iio/iio.h                            |   28 -
>> include/linux/iio/types.h                          |   28 +
>> 21 files changed, 2537 insertions(+), 33 deletions(-)
>>create mode 100644
>>Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
>>create mode 100644
>>Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
>>create mode 100644
>>Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
>> create mode 100644 Documentation/driver-api/iio/hw-consumer.rst
>> create mode 100644 drivers/iio/adc/sd_adc_modulator.c
>> create mode 100644 drivers/iio/adc/stm32-dfsdm-adc.c
>> create mode 100644 drivers/iio/adc/stm32-dfsdm-core.c
>> create mode 100644 drivers/iio/adc/stm32-dfsdm.h
>> create mode 100644 drivers/iio/buffer/industrialio-hw-consumer.c
>> create mode 100644 include/linux/iio/adc/stm32-dfsdm-adc.h
>> create mode 100644 include/linux/iio/hw-consumer.h
> 
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
