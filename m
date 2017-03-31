Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57506 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933126AbdCaMdq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2017 08:33:46 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linus.walleij@linaro.org>
Subject: [PATCH v2 0/2] iio: allow to set STM32 ADC resolution 
Date: Fri, 31 Mar 2017 14:32:36 +0200
Message-ID: <1490963559-32159-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

STM32 ADC supports several resolution. Add dt option so resolution
can be tuned at probe time. By default, maximum resolution is used
when it isn't set.

---
Changes in v2:
 - rename property from 'st,adc-res' to 'assigned-resolution-bits' so it
 is more common.

Fabrice Gasnier (2):
  dt-bindings: iio: stm32-adc: add option to set resolution
  iio: adc: stm32: add dt option to set resolution

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  4 ++
 drivers/iio/adc/stm32-adc.c                        | 50 +++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

-- 
1.9.1

