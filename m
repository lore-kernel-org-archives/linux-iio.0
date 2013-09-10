Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47096 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab3IJMt4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 08:49:56 -0400
Received: by mail-ee0-f46.google.com with SMTP id c13so3420246eek.5
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 05:49:55 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 08/38] ARM: ux500: CONFIG: Enable ST's IIO Magnetometer Sensors by default
Date: Tue, 10 Sep 2013 13:49:09 +0100
Message-Id: <1378817379-8238-9-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/u8500_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 24f88d6..4b94b42 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -40,6 +40,7 @@ CONFIG_SENSORS_BH1780=y
 CONFIG_IIO=y
 CONFIG_IIO_ST_PRESS=y
 CONFIG_IIO_ST_ACCEL_3AXIS=y
+CONFIG_IIO_ST_MAGN_3AXIS=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC911X=y
 CONFIG_SMSC_PHY=y
-- 
1.8.1.2

