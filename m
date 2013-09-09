Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:63706 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab3IIKK0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2013 06:10:26 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so3008237ead.21
        for <linux-iio@vger.kernel.org>; Mon, 09 Sep 2013 03:10:25 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 03/14] ARM: ux500: CONFIG: Enable ST's IIO Pressure Sensors by default
Date: Mon,  9 Sep 2013 11:09:59 +0100
Message-Id: <1378721410-30937-4-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378721410-30937-1-git-send-email-lee.jones@linaro.org>
References: <1378721410-30937-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/u8500_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index a0025dc..d77aa57 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -37,6 +37,10 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_SENSORS_BH1780=y
+CONFIG_IIO=y
+CONFIG_IIO_ST_PRESS=y
+CONFIG_IIO_ST_PRESS_I2C=y
+CONFIG_IIO_ST_SENSORS_I2C=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC911X=y
 CONFIG_SMSC_PHY=y
-- 
1.8.1.2

