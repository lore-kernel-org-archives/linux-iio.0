Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35219 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387548AbeKOTSG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Nov 2018 14:18:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15-v6so17270987wmt.0
        for <linux-iio@vger.kernel.org>; Thu, 15 Nov 2018 01:11:09 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: add entry in MAINTAINERS file
Date: Thu, 15 Nov 2018 10:10:57 +0100
Message-Id: <c0cc8171a7bde81b19ccb31d21be4cd9833f32cb.1542272678.git.lorenzo.bianconi@redhat.com>
In-Reply-To: <cover.1542272678.git.lorenzo.bianconi@redhat.com>
References: <cover.1542272678.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add entry for st_lsm6dsx imu driver in MAINTAINERS file

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0951c9dc3c3..6689f6feb52d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13767,6 +13767,14 @@ M:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
 S:	Maintained
 F:	arch/alpha/kernel/srm_env.c
 
+ST LSM6DSx IMU IIO DRIVER
+M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
+L:	linux-iio@vger.kernel.org
+W:	http://www.st.com/
+S:	Maintained
+F:	drivers/iio/imu/st_lsm6dsx/
+F:	Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+
 ST STM32 I2C/SMBUS DRIVER
 M:	Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
 L:	linux-i2c@vger.kernel.org
-- 
2.19.1
