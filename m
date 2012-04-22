Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:35901 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab2DVMNg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Apr 2012 08:13:36 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 08/14] staging:iio:meter switch select kconfig elements to depends.
Date: Sun, 22 Apr 2012 13:13:33 +0100
Message-Id: <1335096819-19565-9-git-send-email-jic23@kernel.org>
In-Reply-To: <1335096819-19565-1-git-send-email-jic23@kernel.org>
References: <1335096819-19565-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As we are moving the IIO core out of staging, we need to
stop drivers in staging controlling whether elements of the
core are built.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/meter/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/meter/Kconfig b/drivers/staging/iio/meter/Kconfig
index d290d27..ae0e1fd 100644
--- a/drivers/staging/iio/meter/Kconfig
+++ b/drivers/staging/iio/meter/Kconfig
@@ -20,8 +20,7 @@ config ADE7754
 config ADE7758
 	tristate "Analog Devices ADE7758 Poly Phase Multifunction Energy Metering IC Driver"
 	depends on SPI
-	select IIO_TRIGGER if IIO_BUFFER
-	select IIO_SW_RING if IIO_BUFFER
+	depends on !IIO_BUFFER || ( IIO_TRIGGER && IIO_SW_RING)
 	help
 	  Say yes here to build support for Analog Devices ADE7758 Polyphase
 	  Multifunction Energy Metering IC with Per Phase Information Driver.
-- 
1.7.9.4

