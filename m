Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:60844 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994Ab3IJMty (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 08:49:54 -0400
Received: by mail-ee0-f51.google.com with SMTP id c1so3797205eek.24
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 05:49:53 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 06/38] ARM: ux500: CONFIG: Enable ST's IIO Pressure Sensors by default
Date: Tue, 10 Sep 2013 13:49:07 +0100
Message-Id: <1378817379-8238-7-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/u8500_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index a0025dc..6b29109 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -37,6 +37,8 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_SENSORS_BH1780=y
+CONFIG_IIO=y
+CONFIG_IIO_ST_PRESS=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC911X=y
 CONFIG_SMSC_PHY=y
-- 
1.8.1.2

