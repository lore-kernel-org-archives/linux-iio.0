Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35570 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751536AbdAYQkz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Jan 2017 11:40:55 -0500
Received: by mail-wm0-f44.google.com with SMTP id r126so34672699wmr.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Jan 2017 08:40:54 -0800 (PST)
Date: Wed, 25 Jan 2017 16:40:50 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
        gerald.baeza@st.com, arnaud.pouliquen@st.com,
        linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [GIT PULL] Immutable branch between MFD, ARM, IIO and PWM due
 for the v4.10 merge window
Message-ID: <20170125164050.GC19242@dell>
References: <1484903709-11650-1-git-send-email-benjamin.gaignard@st.com>
 <20170123121222.GJ16020@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170123121222.GJ16020@dell>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As promised.

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-pwm-4.11

for you to fetch changes up to 93fbe91b552194af970256ce72934745d01df435:

  iio: Add STM32 timer trigger driver (2017-01-25 16:11:56 +0000)

----------------------------------------------------------------
Immutable branch between MFD, IIO and PWM due for the v4.11 merge window

----------------------------------------------------------------
Benjamin Gaignard (6):
      dt-bindings: mfd: Add bindings for STM32 Timers driver
      mfd: Add STM32 Timers driver
      dt-bindings: pwm: Add STM32 bindings
      pwm: Add driver for STM32 plaftorm
      iio: Add bindings for STM32 timer trigger driver
      iio: Add STM32 timer trigger driver

 .../ABI/testing/sysfs-bus-iio-timer-stm32          |  29 ++
 .../bindings/iio/timer/stm32-timer-trigger.txt     |  23 ++
 .../devicetree/bindings/mfd/stm32-timers.txt       |  46 +++
 .../devicetree/bindings/pwm/pwm-stm32.txt          |  35 ++
 drivers/iio/trigger/Kconfig                        |   9 +
 drivers/iio/trigger/Makefile                       |   1 +
 drivers/iio/trigger/stm32-timer-trigger.c          | 342 ++++++++++++++++++
 drivers/mfd/Kconfig                                |  11 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/stm32-timers.c                         |  80 +++++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-stm32.c                            | 397 +++++++++++++++++++++
 include/linux/iio/timer/stm32-timer-trigger.h      |  62 ++++
 include/linux/mfd/stm32-timers.h                   |  71 ++++
 15 files changed, 1118 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
 create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
 create mode 100644 drivers/iio/trigger/stm32-timer-trigger.c
 create mode 100644 drivers/mfd/stm32-timers.c
 create mode 100644 drivers/pwm/pwm-stm32.c
 create mode 100644 include/linux/iio/timer/stm32-timer-trigger.h
 create mode 100644 include/linux/mfd/stm32-timers.h
 
-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
