Return-Path: <SRS0=FLeV=AT=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@st.com>,
        <benjamin.gaignard@linaro.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: [PATCH 0/3] iio: trigger: stm32-timers fixes
Date: Mon, 18 Sep 2017 12:05:29 +0200
Message-ID: <1505729132-1369-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This fixes misc corner cases observed when using stm32-timers:
- reload value is shadowed, after 1st write, or when doing successive 
  configurations (using sampling_frequency, then counter)
- clock needs to be enabled before using master->slave configuration

Fabrice Gasnier (3):
  iio: trigger: stm32-timer: preset shouldn't be buffered
  iio: trigger: stm32-timer: fix a corner case to write preset
  iio: trigger: stm32-timer: enable clock when in master mode

 drivers/iio/trigger/stm32-timer-trigger.c | 64 ++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 19 deletions(-)

-- 
1.9.1
