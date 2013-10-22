Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:47018 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753454Ab3JVSct (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Oct 2013 14:32:49 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: lee.jones@linaro.org, denis.ciocca@gmail.com,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 1/1] iio:pressure: Adds LPS001WP support also on spi interface and Kconfig fix
Date: Tue, 22 Oct 2013 20:32:36 +0200
Message-Id: <1382466756-21172-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/pressure/Kconfig           |    2 +-
 drivers/iio/pressure/st_pressure_spi.c |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 26fdc0b..4f2e0f9 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -14,7 +14,7 @@ config IIO_ST_PRESS
 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
 	help
 	  Say yes here to build support for STMicroelectronics pressure
-	  sensors: LPS331AP.
+	  sensors: LPS001WP, LPS331AP.
 
 	  This driver can also be built as a module. If so, these modules
 	  will be created:
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 399a29b..27322af 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -48,6 +48,7 @@ static int st_press_spi_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id st_press_id_table[] = {
+	{ LPS001WP_PRESS_DEV_NAME },
 	{ LPS331AP_PRESS_DEV_NAME },
 	{},
 };
-- 
1.7.9.5

