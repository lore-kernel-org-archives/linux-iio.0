Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39966 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S940999AbcKOPdR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Nov 2016 10:33:17 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>
Subject: [PATCH v3 4/6] ARM: configs: stm32: enable ADC driver
Date: Tue, 15 Nov 2016 16:30:59 +0100
Message-ID: <1479223861-21747-5-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1479223861-21747-1-git-send-email-fabrice.gasnier@st.com>
References: <1479223861-21747-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/configs/stm32_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 1e5ec2a..5d241e0 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -57,6 +57,9 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_DMADEVICES=y
 CONFIG_STM32_DMA=y
+CONFIG_IIO=y
+CONFIG_STM32_ADC_CORE=y
+CONFIG_STM32_ADC=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
-- 
1.9.1

