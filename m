Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:59762 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237AbbFUKQK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 21 Jun 2015 06:16:10 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Naidu Tellapati <naidu.tellapati@imgtec.com>,
	Phani Movva <Phani.Movva@imgtec.com>
Subject: [PATCH 1/2] iio:adc:cc10001_adc: fix Kconfig dependency
Date: Sun, 21 Jun 2015 12:15:50 +0200
Message-Id: <9554701f1ada5bdee392c079e8c0de0e1faf45c9.1434844874.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434844874.git.knaack.h@gmx.de>
References: <cover.1434844874.git.knaack.h@gmx.de>
In-Reply-To: <cover.1434844874.git.knaack.h@gmx.de>
References: <cover.1434844874.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Cosmic Circuits 10001 ADC driver depends on HAS_IOMEM, HAVE_CLK and
REGULATOR together, not just any of these.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/adc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7c55658..eb0cd89 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -153,8 +153,7 @@ config DA9150_GPADC
 
 config CC10001_ADC
 	tristate "Cosmic Circuits 10001 ADC driver"
-	depends on HAVE_CLK || REGULATOR
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && HAVE_CLK && REGULATOR
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-- 
2.3.6

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
