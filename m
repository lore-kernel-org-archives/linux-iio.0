Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:42656 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363Ab3AVQQr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Jan 2013 11:16:47 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, denis.ciocca@st.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 08/10] iio:accel:st_accel drop incorrect line from kconfig comment
Date: Tue, 22 Jan 2013 16:16:37 +0000
Message-Id: <1358871399-11216-9-git-send-email-jic23@kernel.org>
In-Reply-To: <1358871399-11216-1-git-send-email-jic23@kernel.org>
References: <50FEBB20.7070407@kernel.org>
 <1358871399-11216-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

---
 drivers/iio/accel/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 52b8956..bb59496 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -39,7 +39,6 @@ config IIO_ST_ACCEL_3AXIS
 	  - st_accel (core functions for the driver [it is mandatory]);
 	  - st_accel_i2c (necessary for the I2C devices [optional*]);
 	  - st_accel_spi (necessary for the SPI devices [optional*]);
-	  - st_accel_buffer (necessary for triggered buffer [optional]);
 
 	  (*) one of these is necessary to do something.
 
-- 
1.8.1.1

