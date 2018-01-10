Return-Path: <SRS0=l8wP=EF=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Wed, 10 Jan 2018 12:57:56 +0000
In-Reply-To: <20180110103607.GD9003@sirena.org.uk>
References: <1515579195-12894-1-git-send-email-arnaud.pouliquen@st.com> <20180110103607.GD9003@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [RESEND PATCH v9 00/13] Add STM32 DFSDM support
To: Mark Brown <broonie@kernel.org>,Arnaud Pouliquen <arnaud.pouliquen@st.com>
CC: Rob Herring <robh+dt@kernel.org>,Mark Rutland <mark.rutland@arm.com>,Jonathan Cameron <jic23@kernel.org>,Hartmut Knaack <knaack.h@gmx.de>,Lars-Peter Clausen <lars@metafoo.de>,Peter Meerwald-Stadler <pmeerw@pmeerw.net>,Jaroslav Kysela <perex@perex.cz>,Takashi Iwai <tiwai@suse.com>,Liam Girdwood <lgirdwood@gmail.com>,devicetree@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-iio@vger.kernel.org,alsa-devel@alsa-project.org,Maxime Coquelin <mcoquelin.stm32@gmail.com>,Alexandre Torgue <alexandre.torgue@st.com>
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <EDAAA911-C2FA-44B1-AAD6-22D7600CF6A5@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 10 January 2018 10:36:07 GMT, Mark Brown <broonie@kernel=2Eorg> wrote:
>On Wed, Jan 10, 2018 at 11:13:02AM +0100, Arnaud Pouliquen wrote:
>
>> Jonathan's comment for you, posted for this version:
>> >So Mark, over to you=2E I'm happy if you want to do the immutable
>branch once=20
>> >any issue you find are fixed, or I can do it=2E=20
>> >I'm just looking for acks or a pull request now=2E
>
>Jonathan, this is a pretty weird way of doing things - the bulk of the
>series is for IIO so I'd have expected it to go in via the IIO tree=2E
>It's especially odd to end up with the driver which isn't a build
>dependency in my tree=2E

Hi Mark,

Sure, such a branch in IIO might have made more sense=2E I got it into my =
head that you
 wanted to do it this way!

Didn't care myself as result is the same=2E

Oops if that wasn't your intent=2E

Ah well, all is well that ends well and thanks for this=2E

Jonathan

>
>The following changes since commit
>4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>
>  Linux 4=2E15-rc1 (2017-11-26 16:01:47 -0800)
>
>are available in the Git repository at:
>
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/broonie/sound=2Egit
>tags/iio-asoc-sync
>
>for you to fetch changes up to
>16cbca06fa8288a4f58426fc898b141e12ee8008:
>
>  IIO: consumer: allow to set buffer sizes (2018-01-10 10:30:14 +0000)
>
>----------------------------------------------------------------
>IIO: ST DFSDM support
>
>This is the IIO portion of some patches adding support for the ST DFSDM
>IP, it's shared with ASoC as the hardware is also used for audio=2E
>
>----------------------------------------------------------------
>Arnaud Pouliquen (10):
>      docs: driver-api: add iio hw consumer section
>      IIO: hw_consumer: add devm_iio_hw_consumer_alloc
>      IIO: inkern: API for manipulating channel attributes
>      IIO: Add DT bindings for sigma delta adc modulator
>      IIO: ADC: add sigma delta modulator support
>      IIO: add DT bindings for stm32 DFSDM filter
>      IIO: ADC: add stm32 DFSDM core support
>      IIO: ADC: add STM32 DFSDM sigma delta ADC support
>      IIO: ADC: add stm32 DFSDM support for PDM microphone
>      IIO: consumer: allow to set buffer sizes
>
>Lars-Peter Clausen (1):
>      iio: Add hardware consumer buffer support
>
> =2E=2E=2E/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32      |   16 +
> =2E=2E=2E/bindings/iio/adc/sigma-delta-modulator=2Etxt     |   13 +
> =2E=2E=2E/bindings/iio/adc/st,stm32-dfsdm-adc=2Etxt        |  128 +++
> Documentation/driver-api/iio/hw-consumer=2Erst       |   51 +
> Documentation/driver-api/iio/index=2Erst             |    1 +
> drivers/iio/adc/Kconfig                            |   37 +
> drivers/iio/adc/Makefile                           |    3 +
> drivers/iio/adc/sd_adc_modulator=2Ec                 |   68 ++
>drivers/iio/adc/stm32-dfsdm-adc=2Ec                  | 1216
>++++++++++++++++++++
> drivers/iio/adc/stm32-dfsdm-core=2Ec                 |  309 +++++
> drivers/iio/adc/stm32-dfsdm=2Eh                      |  310 +++++
> drivers/iio/buffer/Kconfig                         |   10 +
> drivers/iio/buffer/Makefile                        |    1 +
> drivers/iio/buffer/industrialio-buffer-cb=2Ec        |   11 +
> drivers/iio/buffer/industrialio-hw-consumer=2Ec      |  247 ++++
> drivers/iio/inkern=2Ec                               |   17 +-
> include/linux/iio/adc/stm32-dfsdm-adc=2Eh            |   18 +
> include/linux/iio/consumer=2Eh                       |   37 +
> include/linux/iio/hw-consumer=2Eh                    |   21 +
> include/linux/iio/iio=2Eh                            |   28 -
> include/linux/iio/types=2Eh                          |   28 +
> 21 files changed, 2537 insertions(+), 33 deletions(-)
>create mode 100644
>Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
>create mode 100644
>Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator=2Etxt
>create mode 100644
>Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc=2Etxt
> create mode 100644 Documentation/driver-api/iio/hw-consumer=2Erst
> create mode 100644 drivers/iio/adc/sd_adc_modulator=2Ec
> create mode 100644 drivers/iio/adc/stm32-dfsdm-adc=2Ec
> create mode 100644 drivers/iio/adc/stm32-dfsdm-core=2Ec
> create mode 100644 drivers/iio/adc/stm32-dfsdm=2Eh
> create mode 100644 drivers/iio/buffer/industrialio-hw-consumer=2Ec
> create mode 100644 include/linux/iio/adc/stm32-dfsdm-adc=2Eh
> create mode 100644 include/linux/iio/hw-consumer=2Eh

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
