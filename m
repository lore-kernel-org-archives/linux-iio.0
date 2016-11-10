Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35280 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934615AbcKJQUe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Nov 2016 11:20:34 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lee.jones@linaro.org>,
        <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>
Subject: [PATCH v2 4/6] ARM: configs: stm32: enable ADC driver
Date: Thu, 10 Nov 2016 17:18:56 +0100
Message-ID: <1478794738-28933-5-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1478794738-28933-1-git-send-email-fabrice.gasnier@st.com>
References: <1478794738-28933-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/configs/stm32_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 1e5ec2a..e012570 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -49,6 +49,7 @@ CONFIG_SERIAL_STM32=y
 CONFIG_SERIAL_STM32_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
+CONFIG_MFD_STM32_ADC=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
@@ -57,6 +58,8 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_DMADEVICES=y
 CONFIG_STM32_DMA=y
+CONFIG_IIO=y
+CONFIG_STM32_ADC=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
-- 
1.9.1

