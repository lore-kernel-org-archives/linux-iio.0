Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:45130 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146AbcANPkP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jan 2016 10:40:15 -0500
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: <jic23@kernel.org>, <nicolas.ferre@atmel.com>,
	<alexandre.belloni@free-electrons.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<linux-arm-kernel@lists.infradead.org>, <pmeerw@pmeerw.net>,
	<robh@kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v3 5/5] ARM: at91/defconfig: add sama5d2 adc support in sama5_defconfig
Date: Thu, 14 Jan 2016 16:38:17 +0100
Message-ID: <1452785897-16270-6-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <1452785897-16270-1-git-send-email-ludovic.desroches@atmel.com>
References: <1452785897-16270-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index c11bab7..afbda41 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -187,6 +187,7 @@ CONFIG_AT_XDMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_AT91_ADC=y
+CONFIG_AT91_SAMA5D2_ADC=y
 CONFIG_PWM=y
 CONFIG_PWM_ATMEL=y
 CONFIG_PWM_ATMEL_TCB=y
-- 
2.5.0

