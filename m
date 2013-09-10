Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:64627 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab3IJMt5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 08:49:57 -0400
Received: by mail-ea0-f171.google.com with SMTP id n15so3868802ead.30
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 05:49:56 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 09/38] ARM: ux500: CONFIG: Enable ST's IIO Gyroscope Sensors by default
Date: Tue, 10 Sep 2013 13:49:10 +0100
Message-Id: <1378817379-8238-10-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/configs/u8500_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 4b94b42..aaa6c0a 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -41,6 +41,7 @@ CONFIG_IIO=y
 CONFIG_IIO_ST_PRESS=y
 CONFIG_IIO_ST_ACCEL_3AXIS=y
 CONFIG_IIO_ST_MAGN_3AXIS=y
+CONFIG_IIO_ST_GYRO_3AXIS=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC911X=y
 CONFIG_SMSC_PHY=y
-- 
1.8.1.2

