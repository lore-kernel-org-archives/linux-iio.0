Return-Path: <SRS0=y4pC=FR=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH 0/7] iio: adc: stm32-dfsdm: misc fixes and improvements
Date: Fri, 23 Feb 2018 13:50:54 +0100
Message-ID: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This series brings some fixes and improvements to STM32 DFSDM driver.

Fabrice Gasnier (7):
  iio: adc: stm32-dfsdm: fix compatible data use
  iio: adc: stm32-dfsdm: fix call to stop channel
  iio: adc: stm32-dfsdm: fix clock source selection
  iio: adc: stm32-dfsdm: fix multiple channel initialization
  iio: adc: stm32-dfsdm: misc style improvements and fixes
  iio: adc: stm32-dfsdm: add check on max filter id
  iio: adc: stm32-dfsdm: add check on spi-max-frequency

 drivers/iio/adc/stm32-dfsdm-adc.c  | 52 ++++++++++++++++++++------------------
 drivers/iio/adc/stm32-dfsdm-core.c | 17 +++++++++++--
 2 files changed, 42 insertions(+), 27 deletions(-)

-- 
1.9.1
