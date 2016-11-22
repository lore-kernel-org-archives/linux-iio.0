Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37168 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753804AbcKVQUH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Nov 2016 11:20:07 -0500
Received: by mail-wm0-f51.google.com with SMTP id t79so33409569wmt.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Nov 2016 08:20:06 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: fabrice.gasnier@st.com, gerald.baeza@st.com,
        arnaud.pouliquen@st.com, linus.walleij@linaro.org,
        linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 0/7] Add pwm and IIO timer drivers for stm32
Date: Tue, 22 Nov 2016 17:13:20 +0100
Message-Id: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following patches enable pwm and IIO Timer features for stm32 platforms.

Those two features are mixed into the registers of the same hardware block
(named timer) which lead to introduce a multifunctions driver on the top to
be able to share the registers.

In stm32 14 instances of timer hardware block exist, even if they all have
the same register mapping they could have a different number of pwm channels
and/or different triggers capabilities. To keep the code as simple as possible
we use compatible and platform_data to distinguish them.

The MFD (stm32-mfd-timer.c) takes care of clock, interrupt and register mapping
by using regmap. stm32_mfd_timer_dev structure is provided to its children to 
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

Timer hardware blocks can configure (through "master_mode" IIO device attribute)
which internal signal (counter enable, reset, comparison block, etc...) is
used to generate the trigger.

By using "slave_mode" IIO device attribute timer can also configure on which
event (level, rising edge) of the block is enabled.

Since we can use trigger from one hardware to control an other block, we can
use a pwm to control an other one. The following example shows how to configure
pwm1 and pwm3 to make pwm3 generate pulse only when pwm1 pulse level is high.

/sys/bus/iio/devices # ls
iio:device0  iio:device1  trigger0     trigger1

configure timer1 to use pwm1 channel 0 as output trigger
/sys/bus/iio/devices # echo 4 > iio\:device0/master_mode
configure timer3 to enable only when input is high
/sys/bus/iio/devices # echo 5 > iio\:device1/slave_mode
/sys/bus/iio/devices # cat trigger0/name
tim1_trgo
configure timer2 to use timer1 trigger is input
/sys/bus/iio/devices # echo "tim1_trgo" > iio\:device1/trigger/current_trigger

configure pwm3 channel 0 to generate a signal with a period of 100ms and a
duty cycle of 50%
/sys/devices/platform/soc/40000400.mfdtimer3/pwm3/pwm/pwmchip4 # echo 0 > export
/sys/devices/platform/soc/40000400.mfdtimer3/pwm3/pwm/pwmchip4 # echo 100000000 > pwm0/period
/sys/devices/platform/soc/40000400.mfdtimer3/pwm3/pwm/pwmchip4 # echo 50000000 > pwm0/duty_cycle
/sys/devices/platform/soc/40000400.mfdtimer3/pwm3/pwm/pwmchip4 # echo 1 > pwm0/enable
here pwm3 channel 0, as expected, doesn't start because has to be triggered by
pwm1 channel 0

configure pwm1 channel 0 to generate a signal with a period of 1s and a
duty cycle of 50%
/sys/devices/platform/soc/40010000.mfdtimer1/pwm1/pwm/pwmchip0 # echo 0 > export
/sys/devices/platform/soc/40010000.mfdtimer1/pwm1/pwm/pwmchip0 # echo 1000000000 > pwm0/period
/sys/devices/platform/soc/40010000.mfdtimer1/pwm1/pwm/pwmchip0 # echo 500000000 > pwm0/duty_cycle
/sys/devices/platform/soc/40010000.mfdtimer1/pwm1/pwm/pwmchip0 # echo 1 > pwm0/enable 
finally pwm1 starts and pwm3 only generates pulse when pwm1 signal is high

An other example to use a timer as source of clock for another device.
Here timer1 is used a source clock for pwm3:

/sys/bus/iio/devices # echo 100000 > trigger0/sampling_frequency 
/sys/bus/iio/devices # echo tim1_trgo > iio\:device1/trigger/current_trigger 
/sys/bus/iio/devices # echo 7 > iio\:device1/slave_mode
/sys/devices/platform/soc/40000400.mfdtimer3/pwm3/pwm/pwmchip4 # echo 0 > export 
/sys/devices/platform/soc/40000400.mfdtimer3/pwm3/pwm/pwmchip4 # echo 1000000 > pwm0/period 
/sys/devices/platform/soc/40000400.mfdtimer3/pwm3/pwm/pwmchip4 # echo 500000 > pwm0/duty_cycle 
/sys/devices/platform/soc/40000400.mfdtimer3/pwm3/pwm/pwmchip4 # echo 1 > pwm0/enable 

Benjamin Gaignard (7):
  add binding for stm32 multifunctions timer driver
  add MFD for stm32 timer IP
  add pwm-stm32 DT bindings
  add pwm driver for stm32 plaftorm
  add bindings for stm32 IIO timer drivers
  add STM32 IIO timer driver
  add stm32 multi-functions timer driver in DT

 .../bindings/iio/timer/stm32-iio-timer.txt         |  33 +
 .../devicetree/bindings/mfd/stm32-timer.txt        |  53 ++
 .../devicetree/bindings/pwm/pwm-stm32.txt          |  43 ++
 arch/arm/boot/dts/stm32f429.dtsi                   | 246 +++++++
 arch/arm/boot/dts/stm32f469-disco.dts              |  29 +
 drivers/iio/Kconfig                                |   2 +-
 drivers/iio/Makefile                               |   1 +
 drivers/iio/timer/Kconfig                          |  15 +
 drivers/iio/timer/Makefile                         |   1 +
 drivers/iio/timer/stm32-iio-timer.c                | 766 +++++++++++++++++++++
 drivers/iio/trigger/Kconfig                        |   1 -
 drivers/mfd/Kconfig                                |  10 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/stm32-mfd-timer.c                      | 236 +++++++
 drivers/pwm/Kconfig                                |   8 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-stm32.c                            | 358 ++++++++++
 include/linux/iio/timer/stm32-iio-timers.h         |  25 +
 include/linux/mfd/stm32-mfd-timer.h                |  78 +++
 19 files changed, 1906 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timer.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
 create mode 100644 drivers/iio/timer/Kconfig
 create mode 100644 drivers/iio/timer/Makefile
 create mode 100644 drivers/iio/timer/stm32-iio-timer.c
 create mode 100644 drivers/mfd/stm32-mfd-timer.c
 create mode 100644 drivers/pwm/pwm-stm32.c
 create mode 100644 include/linux/iio/timer/stm32-iio-timers.h
 create mode 100644 include/linux/mfd/stm32-mfd-timer.h

-- 
1.9.1

