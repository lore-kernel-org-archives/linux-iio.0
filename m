Return-Path: <SRS0=g/W7=IW=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Mon, 04 Jun 2018 11:04:08 +0100
In-Reply-To: <45ff713b-7811-22c6-2124-4fbcad59b7e8@microchip.com>
References: <1526975559-18966-1-git-send-email-eugen.hristev@microchip.com> <20180522185732.0336d29c@archlinux> <45ff713b-7811-22c6-2124-4fbcad59b7e8@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v7 0/9] Add support for SAMA5D2 touchscreen
To: Eugen Hristev <eugen.hristev@microchip.com>,Jonathan Cameron <jic23@kernel.org>
CC: ludovic.desroches@microchip.com,alexandre.belloni@bootlin.com,linux-arm-kernel@lists.infradead.org,devicetree@vger.kernel.org,linux-kernel@vger.kernel.org,linux-iio@vger.kernel.org,linux-input@vger.kernel.org,nicolas.ferre@microchip.com,dmitry.torokhov@gmail.com,robh@kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <DB1C0B30-BEB4-4FA6-9A13-F87F419CB822@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 4 June 2018 07:15:57 BST, Eugen Hristev <eugen=2Ehristev@microchip=2Eco=
m> wrote:
>
>
>On 22=2E05=2E2018 20:57, Jonathan Cameron wrote:
>> On Tue, 22 May 2018 10:52:30 +0300
>> Eugen Hristev <eugen=2Ehristev@microchip=2Ecom> wrote:
>>=20
>>> Hello,
>>>
>>> This patch series is a rework of my previous series named:
>>> [PATCH 00/14] iio: triggers: add consumer support
>>>
>>> This is the version 7 of the series, and addresses the received
>feedback
>>> on the v2 series named:
>>> [PATCH v2 00/10]  Add support for SAMA5D2 touchscreen
>>> and the v3 series named
>>> [PATCH v3 00/11]  Add support for SAMA5D2 touchscreen
>>> and the v4 series named
>>> [PATCH v4 0/9]  Add support for SAMA5D2 touchscreen
>>> and fixes one bug found in series named
>>> [PATCH v5 0/9]  Add support for SAMA5D2 touchscreen
>>> and addresses comments in series named
>>> [PATCH v6 0/9]  Add support for SAMA5D2 touchscreen
>>>
>>> This series applies on top of fixes-togreg branch of iio=2Egit,
>>> specifically on top of commit:
>>> "f0c8d1f" : iio: adc: at91-sama5d2_adc:
>>>   fix channel configuration for differential channels
>>>
>>> Jonathan, if you need me to rebase this on top of testing, let me
>know=2E
>>>
>>> Changes in previous versions are presented at the end of the cover
>letter below=2E
>>> Thanks everyone for the feedback=2E Below is the original v2 cover
>letter:
>>>
>>> In few words, this is the implementation of splitting the
>functionality
>>> of the IP block ADC device in SAMA5D2 SoC from ADC with touchscreen
>>> support=2E In order to avoid having a MFD device, two separate
>>> drivers that would work on same register base and split the IRQ,etc,
>>> as advised on the mailing list, I created a consumer driver for the
>>> channels, that will connect to the ADC as described in the device
>tree=2E
>>>
>>> I have collected feedback from everyone and here is the result:
>>> I have added a new generic resistive touchscreen driver, which acts
>>> as a iio consumer for the given channels and will create an input
>>> device and report the events=2E It uses a callback buffer to register
>>> to the IIO device and waits for data to be pushed=2E
>>> Inside the IIO device, I have kept a similar approach with the first
>version
>>> of the series, except that now the driver can take multiple buffers,
>and
>>> will configure the touchscreen part of the hardware device if the
>specific
>>> channels are requested=2E
>>>
>>> The SAMA5D2 ADC driver registers three new channels: two for the
>>> position on the X and Y axis, and one for the touch pressure=2E
>>> When channels are requested, it will check if the touchscreen
>channel mask
>>> includes the requested channels (it is possible that the consumer
>driver
>>> will not request pressure for example)=2E If it's the case, it will
>work
>>> in touchscreen mode, and will refuse to do usual analog-digital
>conversion,
>>> because we have a single trigger and the touchscreen needs it=2E
>>> When the scan mask will include only old channels, the driver will
>function
>>> in the same way as before=2E If the scan mask somehow is a mix of the
>two (the
>>> masks intersect), the driver will refuse to work whatsoever (cannot
>have both
>>> in the same time)=2E
>>> The driver allows reading raw data for the new channels, if claim
>direct
>>> mode works: no touchscreen driver requested anything=2E The new
>channels can
>>> act like the old ones=2E However, when requesting these channels, the
>usual
>>> trigger will not work and will not be enabled=2E The touchscreen
>channels
>>> require special trigger and irq configuration: pen detect, no pen
>detect
>>> and a periodic trigger to sample the touchscreen position and
>pressure=2E
>>> If the user attempts to use another trigger while there is a buffer
>>> that already requested the touchscreen channels (thus the trigger),
>the
>>> driver will refuse to comply=2E
>>>
>>> In order to have defines for the channel numbers, I added a bindings
>include
>>> file that goes on a separate commit :
>>> dt-bindings: iio: adc: at91-sama5d2_adc: add channel specific
>consumer info
>>> This should go in the same tree with the following commits :
>>>    ARM: dts: at91: sama5d2: add channel cells for ADC device
>>>    ARM: dts: at91: sama5d2: Add resistive touch device
>>>
>>> as build will break because these commits depend on the binding one
>>> which creates the included header file=2E
>>> V5 update: After discussing with Alexandre Belloni on Mailing list,
>the two
>>> DTS patches are to be taken in the next version after bindings reach
>mainline=2E
>>>
>>> Changes in v7:
>>>   - Addressed some feedback from Dmitry, explained in input driver
>patch
>>> changelog=2E
>>>   - Added Acked-by Dmitry=2E
>>>
>>> Changes in v6:
>>>   - Fixed a crash in ADC driver , explained in driver patch
>changelog=2E
>>>   - changed a dev_err to dev_dbg in input driver=2E
>>>   - added Reviewed-by Rob Herring=2E
>>>
>>> Changes in v5:
>>>   - renamed property touchscreen-threshold-pressure to
>touchscreen-min-pressure
>>>   - added one return in touchscreen driver
>>>
>>> Changes in v4:
>>>   - removed patch for inkern module get/set kref
>>>   - addressed feedback on both the ADC and the touchscreen driver=2E
>each
>>> patch has a history inside the patch file for the specific changes=2E
>>>   - patch that fixes the channel fix
>>> [PATCH v3 01/11] iio: adc: at91-sama5d2_adc:
>>>   fix channel configuration for differential channels
>>> was accepted in fixes-togreg branch thus removed from this series=2E
>>>   - added Reviewed-by for the bindings by Rob Herring
>>>
>>> Changes in v3:
>>>   - changed input driver name according to feedback and reworked in
>commits
>>> to adapt to binding changes and new name=2E
>>>   - moved channel index fix in at91-sama5d2_adc at the beginning of
>the series
>>> (PATCH 01/11)
>>>   - created a new optional binding for the touchscreen as a separate
>commit
>>> and added it to the series :
>>>   [PATCH v3 04/11] dt-bindings: input: touchscreen: add pressure
>>>   threshold touchscreen property
>>>   - changed at91-sama5d2_adc driver patch to address the comments=2E
>Exact changes
>>> are in the patch file for the driver source file=2E
>>>
>>> Eugen Hristev (9):
>>>    MAINTAINERS: add generic resistive touchscreen adc
>>>    iio: Add channel for Position Relative
>>>    dt-bindings: input: touchscreen: add minimum pressure touchscreen
>>>      property
>>>    dt-bindings: input: touchscreen: resistive-adc-touch: create
>bindings
>>>    iio: adc: at91-sama5d2_adc: add support for position and pressure
>>>      channels
>>>    input: touchscreen: resistive-adc-touch: add generic resistive
>ADC
>>>      touchscreen
>>>    dt-bindings: iio: adc: at91-sama5d2_adc: add channel specific
>consumer
>>>      info
>>>    ARM: dts: at91: sama5d2: add channel cells for ADC device
>>>    ARM: dts: at91: sama5d2: Add resistive touch device
>>>
>>>   Documentation/ABI/testing/sysfs-bus-iio            |  12 +
>>>   =2E=2E=2E/bindings/iio/adc/at91-sama5d2_adc=2Etxt          |   9 +
>>>   =2E=2E=2E/input/touchscreen/resistive-adc-touch=2Etxt      |  30 +
>>>   =2E=2E=2E/bindings/input/touchscreen/touchscreen=2Etxt     |   3 +
>>>   MAINTAINERS                                        |   6 +
>>>   arch/arm/boot/dts/sama5d2=2Edtsi                     |  12 +
>>>   drivers/iio/adc/at91-sama5d2_adc=2Ec                 | 609
>+++++++++++++++++++--
>>>   drivers/iio/industrialio-core=2Ec                    |   1 +
>>>   drivers/input/touchscreen/Kconfig                  |  13 +
>>>   drivers/input/touchscreen/Makefile                 |   1 +
>>>   drivers/input/touchscreen/resistive-adc-touch=2Ec    | 204 +++++++
>>>   include/dt-bindings/iio/adc/at91-sama5d2_adc=2Eh     |  16 +
>>>   include/uapi/linux/iio/types=2Eh                     |   1 +
>>>   tools/iio/iio_event_monitor=2Ec                      |   2 +
>>>   14 files changed, 861 insertions(+), 58 deletions(-)
>>>   create mode 100644
>Documentation/devicetree/bindings/input/touchscreen/resistive-adc-touch=
=2Etxt
>>>   create mode 100644 drivers/input/touchscreen/resistive-adc-touch=2Ec
>>>   create mode 100644 include/dt-bindings/iio/adc/at91-sama5d2_adc=2Eh
>>>
>>=20
>> Hi All,
>>=20
>> I'm happy to take this, but there is a slight issue that we have a
>fix working
>> it's way in which this is dependent on=2E
>>=20
>> I'll see if we can get this sorted before the merge window, but we
>may be
>> cutting it fine=2E
>>=20
>> Jonathan
>>=20
>
>Hello Jonathan,
>
>I can see the dependency fix made it to 4=2E17=2E What is the plan for th=
is
>
>series? Getting into this merge window ?

Sorry, no=2E We were to tight on time=2E Will get it into linux-next in a =
few weeks, ready for the next merge window=2E

Jonathan
>
>Thanks,
>Eugen
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger=2Ekernel=2Eorg
>More majordomo info at  http://vger=2Ekernel=2Eorg/majordomo-info=2Ehtml

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
