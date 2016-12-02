Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38678 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759366AbcLBKRk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2016 05:17:40 -0500
Received: by mail-wm0-f50.google.com with SMTP id f82so11306570wmf.1
        for <linux-iio@vger.kernel.org>; Fri, 02 Dec 2016 02:17:39 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: fabrice.gasnier@st.com, gerald.baeza@st.com,
        arnaud.pouliquen@st.com, linus.walleij@linaro.org,
        linaro-kernel@lists.linaro.org, benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 0/7] Add pwm and IIO timer drivers for stm32
Date: Fri,  2 Dec 2016 11:17:15 +0100
Message-Id: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

version 3:
- no change on mfd and pwm divers patches
- add cross reference between bindings
- change compatible to "st,stm32-timer-trigger"
- fix attributes access rights
- use string instead of int for master_mode and slave_mode
- document device attributes in sysfs-bus-iio-timer-stm32
- udpate DT with the new compatible

version 2:
- keep only one compatible per driver
- use DT parameters to describe hardware block configuration:
  - pwm channels, complementary output, counter size, break input
  - triggers accepted and create by IIO timers
- change DT to limite use of reference to the node
- interrupt is now in IIO timer driver
- rename stm32-mfd-timer to stm32-gptimer (for general purpose timer)

The following patches enable pwm and IIO Timer features for stm32 platforms.

Those two features are mixed into the registers of the same hardware block
(named general purpose timer) which lead to introduce a multifunctions driver 
on the top of them to be able to share the registers.

In stm32 14 instances of timer hardware block exist, even if they all have
the same register mapping they could have a different number of pwm channels
and/or different triggers capabilities. We use various parameters in DT to 
describe the differences between hardware blocks

The MFD (stm32-gptimer.c) takes care of clock and register mapping
by using regmap. stm32_gptimer_dev structure is provided to its sub-node to
share those information.

PWM driver is implemented into pwm-stm32.c. Depending of the instance we may
have up to 4 channels, sometime with complementary outputs or 32 bits counter
instead of 16 bits. Some hardware blocks may also have a break input function
which allows to stop pwm depending of a level, defined in devicetree, on an
external pin.

IIO timer driver (stm32-iio-timer.c and stm32-iio-timers.h) define a list of 
hardware triggers usable by hardware blocks like ADC, DAC or other timers. 

The matrix of possible connections between blocks is quite complex so we use 
trigger names and is_stm32_iio_timer_trigger() function to be sure that
triggers are valid and configure the IPs.
Possible triggers ar listed in include/dt-bindings/iio/timer/st,stm32-iio-timer.h

At run time IIO timer hardware blocks can configure (through "master_mode" 
IIO device attribute) which internal signal (counter enable, reset,
comparison block, etc...) is used to generate the trigger.

By using "slave_mode" IIO device attribute timer can also configure on which
event (level, rising edge) of the block is enabled.

Since we can use trigger from one hardware to control an other block, we can
use a pwm to control an other one. The following example shows how to configure
pwm1 and pwm3 to make pwm3 generate pulse only when pwm1 pulse level is high.

/sys/bus/iio/devices # ls
iio:device0  iio:device1  trigger0     trigger1

configure timer1 to use pwm1 channel 0 as output trigger
/sys/bus/iio/devices # echo 'OC1REF' > iio\:device0/master_mode
configure timer3 to enable only when input is high
/sys/bus/iio/devices # echo 'gated' > iio\:device1/slave_mode
/sys/bus/iio/devices # cat trigger0/name
tim1_trgo
configure timer2 to use timer1 trigger is input
/sys/bus/iio/devices # echo "tim1_trgo" > iio\:device1/trigger/current_trigger

configure pwm3 channel 0 to generate a signal with a period of 100ms and a
duty cycle of 50%
/sys/devices/platform/soc/40000400.gptimer3/40000400.gptimer3:pwm3@0/pwm/pwmchip4 # echo 0 > export
/sys/devices/platform/soc/40000400.gptimer3/40000400.gptimer3:pwm3@0/pwm/pwmchip4 # echo 100000000 > pwm0/period
/sys/devices/platform/soc/40000400.gptimer3/40000400.gptimer3:pwm3@0/pwm/pwmchip4 # echo 50000000 > pwm0/duty_cycle
/sys/devices/platform/soc/40000400.gptimer3/40000400.gptimer3:pwm3@0/pwm/pwmchip4# echo 1 > pwm0/enable
here pwm3 channel 0, as expected, doesn't start because has to be triggered by
pwm1 channel 0

configure pwm1 channel 0 to generate a signal with a period of 1s and a
duty cycle of 50%
/sys/devices/platform/soc/40010000.gptimer1/40010000.gptimer1:pwm1@0/pwm/pwmchip0 # echo 0 > export
/sys/devices/platform/soc/40010000.gptimer1/40010000.gptimer1:pwm1@0/pwm/pwmchip0 # echo 1000000000 > pwm0/period
/sys/devices/platform/soc/40010000.gptimer1/40010000.gptimer1:pwm1@0/pwm/pwmchip0 # echo 500000000 > pwm0/duty_cycle
/sys/devices/platform/soc/40010000.gptimer1/40010000.gptimer1:pwm1@0/pwm/pwmchip0 # echo 1 > pwm0/enable 
finally pwm1 starts and pwm3 only generates pulse when pwm1 signal is high

An other example to use a timer as source of clock for another device.
Here timer1 is used a source clock for pwm3:

/sys/bus/iio/devices # echo 100000 > trigger0/sampling_frequency 
/sys/bus/iio/devices # echo tim1_trgo > iio\:device1/trigger/current_trigger 
/sys/bus/iio/devices # echo 'external_clock' > iio\:device1/slave_mode
/sys/devices/platform/soc/40000400.gptimer3/40000400.gptimer3:pwm3@0/pwm/pwmchip4 # echo 0 > export 
/sys/devices/platform/soc/40000400.gptimer3/40000400.gptimer3:pwm3@0/pwm/pwmchip4 # echo 1000000 > pwm0/period 
/sys/devices/platform/soc/40000400.gptimer3/40000400.gptimer3:pwm3@0/pwm/pwmchip4 # echo 500000 > pwm0/duty_cycle 
/sys/devices/platform/soc/40000400.gptimer3/40000400.gptimer3:pwm3@0/pwm/pwmchip4 # echo 1 > pwm0/enable 

Benjamin Gaignard (7):
  MFD: add bindings for stm32 general purpose timer driver
  MFD: add stm32 general purpose timer driver
  PWM: add pwm-stm32 DT bindings
  PWM: add pwm driver for stm32 plaftorm
  IIO: add bindings for stm32 timer trigger driver
  IIO: add STM32 timer trigger driver
  ARM: dts: stm32: add stm32 general purpose timer driver in DT

 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  47 ++
 .../bindings/iio/timer/stm32-timer-trigger.txt     |  39 ++
 .../bindings/mfd/stm32-general-purpose-timer.txt   |  47 ++
 .../devicetree/bindings/pwm/pwm-stm32.txt          |  38 ++
 arch/arm/boot/dts/stm32f429.dtsi                   | 333 +++++++++++++-
 arch/arm/boot/dts/stm32f469-disco.dts              |  28 ++
 drivers/iio/Kconfig                                |   2 +-
 drivers/iio/Makefile                               |   1 +
 drivers/iio/timer/Kconfig                          |  15 +
 drivers/iio/timer/Makefile                         |   1 +
 drivers/iio/timer/stm32-timer-trigger.c            | 477 +++++++++++++++++++++
 drivers/iio/trigger/Kconfig                        |   1 -
 drivers/mfd/Kconfig                                |  10 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/stm32-gptimer.c                        |  73 ++++
 drivers/pwm/Kconfig                                |   8 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-stm32.c                            | 285 ++++++++++++
 .../iio/timer/st,stm32-timer-triggers.h            |  60 +++
 include/linux/iio/timer/stm32-timer-trigger.h      |  16 +
 include/linux/mfd/stm32-gptimer.h                  |  62 +++
 21 files changed, 1543 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
 create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
 create mode 100644 drivers/iio/timer/Kconfig
 create mode 100644 drivers/iio/timer/Makefile
 create mode 100644 drivers/iio/timer/stm32-timer-trigger.c
 create mode 100644 drivers/mfd/stm32-gptimer.c
 create mode 100644 drivers/pwm/pwm-stm32.c
 create mode 100644 include/dt-bindings/iio/timer/st,stm32-timer-triggers.h
 create mode 100644 include/linux/iio/timer/stm32-timer-trigger.h
 create mode 100644 include/linux/mfd/stm32-gptimer.h

-- 
1.9.1

