Return-Path: <SRS0=kBuR=AF=linaro.org=lee.jones@kernel.org>
Date: Mon, 4 Sep 2017 14:51:39 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: benjamin.gaignard@linaro.org, jic23@kernel.org,
	thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
	alexandre.torgue@st.com, mcoquelin.stm32@gmail.com,
	benjamin.gaignard@st.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	vilhelm.gray@gmail.com
Subject: [GIT PULL] Immutable branch between MFD, IIO and PWM due for the
 v4.14 merge window
Message-ID: <20170904135139.mfsoh5k4kifrhldq@dell>
References: <1503914654-19963-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1503914654-19963-1-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>

Enjoy!

The following changes since commit 569dbb88e80deb68974ef6fdd6a13edb9d686261:

  Linux 4.13 (2017-09-03 13:56:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-pwm-v4.14

for you to fetch changes up to f0b638a7f6dba2eb6bf99fc648eab77f7ad5e59f:

  iio: adc: stm32: add support for lptimer triggers (2017-09-04 14:49:34 +0100)

----------------------------------------------------------------
Immutable branch between MFD, IIO and PWM due for the v4.14 merge window

----------------------------------------------------------------
Fabrice Gasnier (9):
      dt-bindings: mfd: Add STM32 LPTimer binding
      mfd: Add STM32 LPTimer driver
      pwm: Add STM32 LPTimer PWM driver
      dt-bindings: pwm: Add STM32 LPTimer PWM binding
      dt-bindings: iio: Add STM32 LPTimer trigger binding
      iio: trigger: Add STM32 LPTimer trigger driver
      dt-bindings: iio: Add STM32 LPTimer quadrature encoder and counter
      iio: counter: Add support for STM32 LPTimer
      iio: adc: stm32: add support for lptimer triggers

 .../ABI/testing/sysfs-bus-iio-lptimer-stm32        |  57 +++
 .../bindings/iio/counter/stm32-lptimer-cnt.txt     |  27 ++
 .../bindings/iio/timer/stm32-lptimer-trigger.txt   |  23 ++
 .../devicetree/bindings/mfd/stm32-lptimer.txt      |  48 +++
 .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  24 ++
 drivers/iio/adc/stm32-adc.c                        |  14 +-
 drivers/iio/counter/Kconfig                        |   9 +
 drivers/iio/counter/Makefile                       |   1 +
 drivers/iio/counter/stm32-lptimer-cnt.c            | 383 +++++++++++++++++++++
 drivers/iio/trigger/Kconfig                        |  11 +
 drivers/iio/trigger/Makefile                       |   1 +
 drivers/iio/trigger/stm32-lptimer-trigger.c        | 118 +++++++
 drivers/mfd/Kconfig                                |  14 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/stm32-lptimer.c                        | 107 ++++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-stm32-lp.c                         | 246 +++++++++++++
 include/linux/iio/timer/stm32-lptim-trigger.h      |  27 ++
 include/linux/mfd/stm32-lptimer.h                  |  62 ++++
 20 files changed, 1182 insertions(+), 2 deletions(-)
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
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
