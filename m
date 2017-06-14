Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44241 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752181AbdFNPOJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jun 2017 11:14:09 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>,
        <jic23@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH v2 0/3] Fix STM32 timers dt-bindings
Date: Wed, 14 Jun 2017 17:13:13 +0200
Message-ID: <1497453196-31470-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

STM32 timers clock names has been updated during driver/DT binding review:
https://lkml.org/lkml/2016/12/13/718

STM32 timers driver has been fixed with these remarks. It looks like it's
been missed on DT binding part.
Update DT binding doc to reflect this as well.
---
Changes in v2:
- Also fix stm32 pwm dt-bindings
- Add Fixes tags

Fabrice Gasnier (3):
  dt-bindings: mfd: update STM32 timers clock names
  dt-bindings: iio: update STM32 timers clock names
  dt-bindings: pwm: update STM32 timers clock names

 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 2 +-
 Documentation/devicetree/bindings/mfd/stm32-timers.txt              | 2 +-
 Documentation/devicetree/bindings/pwm/pwm-stm32.txt                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1

