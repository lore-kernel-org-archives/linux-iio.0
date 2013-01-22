Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:42681 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692Ab3AVQQr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Jan 2013 11:16:47 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, denis.ciocca@st.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 10/10] iio:magn:st_magn drop incorrect line from Kconfig
Date: Tue, 22 Jan 2013 16:16:39 +0000
Message-Id: <1358871399-11216-11-git-send-email-jic23@kernel.org>
In-Reply-To: <1358871399-11216-1-git-send-email-jic23@kernel.org>
References: <50FEBB20.7070407@kernel.org>
 <1358871399-11216-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

---
 drivers/iio/magnetometer/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index d252e0d..cd29be5 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -31,7 +31,6 @@ config IIO_ST_MAGN_3AXIS
 	  - st_magn (core functions for the driver [it is mandatory]);
 	  - st_magn_i2c (necessary for the I2C devices [optional*]);
 	  - st_magn_spi (necessary for the SPI devices [optional*]);
-	  - st_magn_buffer (necessary for triggered buffer [optional]);
 
 	  (*) one of these is necessary to do something.
 
-- 
1.8.1.1

