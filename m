Return-Path: <SRS0=AxCn=52=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>, <jic23@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH v2 0/8] Add STM32 LPTimer: PWM, trigger and counter
Date: Wed, 21 Jun 2017 16:30:07 +0200
Message-ID: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This series adds support for Low-Power Timer that can be found on
some STM32 devices.

STM32 LPTimer (LPTIM) is a 16-bit timer that provides several
functionalities. This series adds support for following features:
- PWM output (with programmable prescaler, configurable polarity)
- Trigger source for STM32 ADC or DAC (LPTIM_OUT)
- Quadrature encoder and counter

The MFD core is used to manage common resources (clock, register map)
and to detect encoder feature. "stm32_lptimer" structure is provided
to its sub-nodes to share those information:
- PWM driver is used to implement single PWM channel
- IIO trigger
- IIO quadrature encoder and counter

---
Changes in v2:
- Various remarks from Lee, on MFD part, extended to the full series,
  such as: clock name, use "Low-Power Timer", file headers, dt-bindings
  props descriptions, fix dt example.

Fabrice Gasnier (8):
  dt-bindings: mfd: Add STM32 LPTimer binding
  mfd: Add STM32 LPTimer driver
  dt-bindings: pwm: Add STM32 LPTimer PWM binding
  pwm: Add STM32 LPTimer PWM driver
  dt-bindings: iio: Add STM32 LPTimer trigger binding
  iio: trigger: Add STM32 LPTimer trigger driver
  dt-bindings: iio: Add STM32 LPTimer quadrature encoder and counter
  iio: counter: Add support for STM32 LPTimer

 .../ABI/testing/sysfs-bus-iio-lptimer-stm32        |  57 +++
 .../bindings/iio/counter/stm32-lptimer-cnt.txt     |  27 ++
 .../bindings/iio/timer/stm32-lptimer-trigger.txt   |  23 ++
 .../devicetree/bindings/mfd/stm32-lptimer.txt      |  48 +++
 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  24 ++
 drivers/iio/counter/Kconfig                        |   9 +
 drivers/iio/counter/Makefile                       |   1 +
 drivers/iio/counter/stm32-lptimer-cnt.c            | 383 +++++++++++++++++++++
 drivers/iio/trigger/Kconfig                        |  11 +
 drivers/iio/trigger/Makefile                       |   1 +
 drivers/iio/trigger/stm32-lptimer-trigger.c        | 110 ++++++
 drivers/mfd/Kconfig                                |  14 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/stm32-lptimer.c                        | 107 ++++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-stm32-lp.c                         | 216 ++++++++++++
 include/linux/iio/timer/stm32-lptim-trigger.h      |  24 ++
 include/linux/mfd/stm32-lptimer.h                  |  62 ++++
 19 files changed, 1129 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32
 create mode 100644 Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
 create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
 create mode 100644 drivers/iio/counter/stm32-lptimer-cnt.c
 create mode 100644 drivers/iio/trigger/stm32-lptimer-trigger.c
 create mode 100644 drivers/mfd/stm32-lptimer.c
 create mode 100644 drivers/pwm/pwm-stm32-lp.c
 create mode 100644 include/linux/iio/timer/stm32-lptim-trigger.h
 create mode 100644 include/linux/mfd/stm32-lptimer.h

-- 
1.9.1
