Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45680 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751532AbdFIHik (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jun 2017 03:38:40 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>,
        <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Fix STM32 timers dt-bindings
Date: Fri, 9 Jun 2017 09:37:52 +0200
Message-ID: <1496993874-9870-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

STM32 timers clock names has been updated during driver/DT binding review:
https://lkml.org/lkml/2016/12/13/718

STM32 timers driver has been fixed with these remarks. It looks like it's
been missed on DT binding part.
Update DT binding doc to reflect this as well.

Fabrice Gasnier (2):
  dt-bindings: mfd: update STM32 timers clock names
  dt-bindings: iio: update STM32 timers clock names

 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 2 +-
 Documentation/devicetree/bindings/mfd/stm32-timers.txt              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1

