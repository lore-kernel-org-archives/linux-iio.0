Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27999 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751551AbdG0QUC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jul 2017 12:20:02 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <benjamin.gaignard@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: [PATCH 0/4] iio: trigger: stm32-timer fixes
Date: Thu, 27 Jul 2017 18:18:56 +0200
Message-ID: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Miscellaneous fixes for stm32-timer-trigger driver.
Last patch adds enable attribute, which unlocks use of
encoder mode.

Fabrice Gasnier (4):
  iio: trigger: stm32-timer: fix quadrature mode get routine
  iio: trigger: stm32-timer: fix write_raw return value
  iio: trigger: stm32-timer: fix get/set down count direction
  iio: trigger: stm32-timer: add enable attribute

 drivers/iio/trigger/stm32-timer-trigger.c | 80 ++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 22 deletions(-)

-- 
1.9.1

