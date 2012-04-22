Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:35894 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab2DVMNg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Apr 2012 08:13:36 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 06/14] staging:iio:impedance-analyzer switch select kconfig elements to depends.
Date: Sun, 22 Apr 2012 13:13:31 +0100
Message-Id: <1335096819-19565-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1335096819-19565-1-git-send-email-jic23@kernel.org>
References: <1335096819-19565-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As we are moving the IIO core out of staging, we need to
stop drivers in staging controlling whether elements of the
core are built.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/impedance-analyzer/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/Kconfig b/drivers/staging/iio/impedance-analyzer/Kconfig
index ad0ff76..a036e16 100644
--- a/drivers/staging/iio/impedance-analyzer/Kconfig
+++ b/drivers/staging/iio/impedance-analyzer/Kconfig
@@ -6,8 +6,7 @@ menu "Network Analyzer, Impedance Converters"
 config AD5933
 	tristate "Analog Devices AD5933, AD5934 driver"
 	depends on I2C
-	select IIO_BUFFER
-	select IIO_SW_RING
+	depends on IIO_BUFFER && IIO_SW_RING
 	help
 	  Say yes here to build support for Analog Devices Impedance Converter,
 	  Network Analyzer, AD5933/4, provides direct access via sysfs.
-- 
1.7.9.4

