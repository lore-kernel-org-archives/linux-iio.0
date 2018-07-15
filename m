Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f196.google.com ([209.85.213.196]:43398 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeGOVLg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jul 2018 17:11:36 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org, jic23@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        Mark Rutland <mark.rutland@arm.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v8 10/11] dt-bindings: counter: Adjust dt-bindings for STM32 lptimer move
Date: Sun, 15 Jul 2018 16:47:19 -0400
Message-Id: <d208e0b18c05fdbf900a2098991cf35b51bf70b5.1531685025.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1531685024.git.vilhelm.gray@gmail.com>
References: <cover.1531685024.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

The STM32 LP Timer counter driver now resides under the Counter
subsystem. This patch adjusts dt-bindings to account for the STM32
lptimer driver move.

Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt | 0
 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt         | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)

diff --git a/Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
similarity index 100%
rename from Documentation/devicetree/bindings/iio/counter/stm32-lptimer-cnt.txt
rename to Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
diff --git a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
index 2a9ff29db9c9..fb54e4dad5b3 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
@@ -16,7 +16,7 @@ Required properties:
 
 Optional subnodes:
 - pwm:			See ../pwm/pwm-stm32-lp.txt
-- counter:		See ../iio/timer/stm32-lptimer-cnt.txt
+- counter:		See ../counter/stm32-lptimer-cnt.txt
 - trigger:		See ../iio/timer/stm32-lptimer-trigger.txt
 
 Example:
-- 
2.18.0

