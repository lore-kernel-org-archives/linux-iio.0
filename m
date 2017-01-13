Return-Path: <SRS0=2clN=Y3=linaro.org=benjamin.gaignard@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+M3ks43GYEQo6Sev9oB5RfSF3fYNLixESSceXpu2CtKPnpB1Q@mail.gmail.com>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <20170105144953.GT24225@dell> <CA+M3ks43GYEQo6Sev9oB5RfSF3fYNLixESSceXpu2CtKPnpB1Q@mail.gmail.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Fri, 13 Jan 2017 13:30:27 +0100
Message-ID: <CA+M3ks6CK7PtqrMUC=Hpy8kELyo3hT9mjn-hkUq-Na8D0ySaSQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add PWM and IIO timer drivers for STM32
To: Lee Jones <lee.jones@linaro.org>
Cc: robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Alexandre Torgue <alexandre.torgue@st.com>, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
	Linux PWM List <linux-pwm@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Gerald Baeza <gerald.baeza@st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>, Linus Walleij <linus.walleij@linaro.org>,
	Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2017-01-06 8:58 GMT+01:00 Benjamin Gaignard <benjamin.gaignard@linaro.org>:
> 2017-01-05 15:49 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
>> On Thu, 05 Jan 2017, Benjamin Gaignard wrote:
>>
>>> version 7:
>>> - rebase on v4.10-rc2
>>> - remove iio_device code from driver and keep only the trigger part

Version 7 got ACK for MFD (binding and driver), PWM (bindings), IIO (driver=
).

I would like to progress on this series but I there is still 2 blocking poi=
nts:
1) usage of reg in IIO driver as an hardware block index, Rob does it
sound reasonable for you ?
2) PWM driver haven't receive comments (neither ack), Thierry do you
think you will be able to find time to review it ?

Benjamin

>>>
>>> version 6:
>>> - rename stm32-gptimer in stm32-timers.
>>> - change "st,stm32-gptimer" compatible to "st,stm32-timers".
>>> - modify "st,breakinput" parameter in pwm part.
>>> - split DT patch in 2
>>>
>>> version 5:
>>> - fix comments done on version 4
>>> - rebased on kernel 4.9-rc8
>>> - change nodes names and re-order then by addresses
>>>
>>> version 4:
>>> - fix comments done on version 3
>>> - don't use interrupts anymore in IIO timer
>>> - detect hardware capabilities at probe time to simplify binding
>>>
>>> version 3:
>>> - no change on mfd and pwm divers patches
>>> - add cross reference between bindings
>>> - change compatible to "st,stm32-timer-trigger"
>>> - fix attributes access rights
>>> - use string instead of int for master_mode and slave_mode
>>> - document device attributes in sysfs-bus-iio-timer-stm32
>>> - update DT with the new compatible
>>>
>>> version 2:
>>> - keep only one compatible per driver
>>> - use DT parameters to describe hardware block configuration:
>>>   - pwm channels, complementary output, counter size, break input
>>>   - triggers accepted and create by IIO timers
>>> - change DT to limite use of reference to the node
>>> - interrupt is now in IIO timer driver
>>> - rename stm32-mfd-timer to stm32-timers (for general purpose timer)
>>>
>>> The following patches enable PWM and IIO Timer features for STM32 platf=
orms.
>>>
>>> Those two features are mixed into the registers of the same hardware bl=
ock
>>> (named general purpose timer) which lead to introduce a multifunctions =
driver
>>> on the top of them to be able to share the registers.
>>>
>>> In STM32f4 14 instances of timer hardware block exist, even if they all=
 have
>>> the same register mapping they could have a different number of pwm cha=
nnels
>>> and/or different triggers capabilities. We use various parameters in DT=
 to
>>> describe the differences between hardware blocks
>>>
>>> The MFD (stm32-timers.c) takes care of clock and register mapping
>>> by using regmap. stm32_timers structure is provided to its sub-node to
>>> share those information.
>>>
>>> PWM driver is implemented into pwm-stm32.c. Depending of the instance w=
e may
>>> have up to 4 channels, sometime with complementary outputs or 32 bits c=
ounter
>>> instead of 16 bits. Some hardware blocks may also have a break input fu=
nction
>>> which allows to stop pwm depending of a level, defined in devicetree, o=
n an
>>> external pin.
>>>
>>> IIO timer driver (stm32-timer-trigger.c and stm32-timer-trigger.h) defi=
ne a list
>>> of hardware triggers usable by hardware blocks like ADC, DAC or other t=
imers.
>>>
>>> The matrix of possible connections between blocks is quite complex so w=
e use
>>> trigger names and is_stm32_iio_timer_trigger() function to be sure that
>>> triggers are valid and configure the IPs.
>>>
>>> At run time IIO timer hardware blocks can configure (through "master_mo=
de"
>>> IIO device attribute) which internal signal (counter enable, reset,
>>> comparison block, etc...) is used to generate the trigger.
>>>
>>> Benjamin Gaignard (8):
>>>   MFD: add bindings for STM32 Timers driver
>>>   MFD: add STM32 Timers driver
>>>   PWM: add pwm-stm32 DT bindings
>>>   PWM: add PWM driver for STM32 plaftorm
>>>   IIO: add bindings for STM32 timer trigger driver
>>>   IIO: add STM32 timer trigger driver
>>>   ARM: dts: stm32: add Timers driver for stm32f429 MCU
>>>   ARM: dts: stm32: Enable pwm1 and pwm3 for stm32f469-disco
>>
>> Any reason why you've dropped all your Acks?
>>
>> I don't really want to review it again if little is different.
>>
>> How much MFD related code has changed since the last review?
>
> All my apologies I forgot to add your Acks for MFD parts.
>
> Sorry for that
>
>>
>>>  .../ABI/testing/sysfs-bus-iio-timer-stm32          |  29 ++
>>>  .../bindings/iio/timer/stm32-timer-trigger.txt     |  23 ++
>>>  .../devicetree/bindings/mfd/stm32-timers.txt       |  46 +++
>>>  .../devicetree/bindings/pwm/pwm-stm32.txt          |  33 ++
>>>  arch/arm/boot/dts/stm32f429.dtsi                   | 275 +++++++++++++
>>>  arch/arm/boot/dts/stm32f469-disco.dts              |  28 ++
>>>  drivers/iio/Kconfig                                |   1 -
>>>  drivers/iio/trigger/Kconfig                        |  10 +
>>>  drivers/iio/trigger/Makefile                       |   1 +
>>>  drivers/iio/trigger/stm32-timer-trigger.c          | 340 +++++++++++++=
+++
>>>  drivers/mfd/Kconfig                                |  11 +
>>>  drivers/mfd/Makefile                               |   2 +
>>>  drivers/mfd/stm32-timers.c                         |  80 ++++
>>>  drivers/pwm/Kconfig                                |   9 +
>>>  drivers/pwm/Makefile                               |   1 +
>>>  drivers/pwm/pwm-stm32.c                            | 434 +++++++++++++=
++++++++
>>>  include/linux/iio/timer/stm32-timer-trigger.h      |  62 +++
>>>  include/linux/mfd/stm32-timers.h                   |  71 ++++
>>>  18 files changed, 1455 insertions(+), 1 deletion(-)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
>>>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-t=
imer-trigger.txt
>>>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.=
txt
>>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
>>>  create mode 100644 drivers/iio/trigger/stm32-timer-trigger.c
>>>  create mode 100644 drivers/mfd/stm32-timers.c
>>>  create mode 100644 drivers/pwm/pwm-stm32.c
>>>  create mode 100644 include/linux/iio/timer/stm32-timer-trigger.h
>>>  create mode 100644 include/linux/mfd/stm32-timers.h
>>>
>>
>> --
>> Lee Jones
>> Linaro STMicroelectronics Landing Team Lead
>> Linaro.org =E2=94=82 Open source software for ARM SoCs
>> Follow Linaro: Facebook | Twitter | Blog
>
>
>
> --
> Benjamin Gaignard
>
> Graphic Study Group
>
> Linaro.org =E2=94=82 Open source software for ARM SoCs
>
> Follow Linaro: Facebook | Twitter | Blog



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
