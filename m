Return-Path: <SRS0=TmfX=7F=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH 0/3] iio: trigger: stm32-timer: add STM32H7 variant
Date: Thu, 3 Aug 2017 11:14:11 +0200
Message-ID: <1501751654-14153-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

STM32H7 variant has additional timer instances, and slightly different
valid triggers.
This patchset introduces a new compatible for STM32H7 timers, to handle
this new variant, with appropriate configuration data.

Fabrice Gasnier (3):
  dt-bindings: iio: timer: stm32: add support for STM32H7
  iio: trigger: stm32-timer: add support for STM32H7
  iio: trigger: stm32-timer: add output compare triggers

 .../bindings/iio/timer/stm32-timer-trigger.txt     |  4 +-
 drivers/iio/trigger/stm32-timer-trigger.c          | 78 +++++++++++++++++++---
 include/linux/iio/timer/stm32-timer-trigger.h      | 14 ++++
 3 files changed, 84 insertions(+), 12 deletions(-)

-- 
1.9.1
