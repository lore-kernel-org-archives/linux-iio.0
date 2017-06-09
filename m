Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53983 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751560AbdFIHim (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jun 2017 03:38:42 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <benjamin.gaignard@linaro.org>,
        <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <mark.rutland@arm.com>, <alexandre.torgue@st.com>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] dt-bindings: iio: update STM32 timers clock names
Date: Fri, 9 Jun 2017 09:37:54 +0200
Message-ID: <1496993874-9870-3-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1496993874-9870-1-git-send-email-fabrice.gasnier@st.com>
References: <1496993874-9870-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Clock name has been updated during driver/DT binding review:
https://lkml.org/lkml/2016/12/13/718
Update DT binding doc to reflect this.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
index 55a653d..6abc755 100644
--- a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
+++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
@@ -14,7 +14,7 @@ Example:
 		compatible = "st,stm32-timers";
 		reg = <0x40010000 0x400>;
 		clocks = <&rcc 0 160>;
-		clock-names = "clk_int";
+		clock-names = "int";
 
 		timer@0 {
 			compatible = "st,stm32-timer-trigger";
-- 
1.9.1

