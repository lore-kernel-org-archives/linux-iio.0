Return-Path: <SRS0=bFjq=GD=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH 0/2] iio: stm32-dfsdm-adc: fix filter & rate setting
Date: Tue, 13 Mar 2018 15:23:04 +0100
Message-ID: <1520950986-23116-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This series brings fixes to STM32 DFSDM ADC driver.

Fabrice Gasnier (2):
  iio: adc: stm32-dfsdm: fix successive oversampling settings
  iio: adc: stm32-dfsdm: fix sample rate for div2 spi clock

 drivers/iio/adc/stm32-dfsdm-adc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
1.9.1
