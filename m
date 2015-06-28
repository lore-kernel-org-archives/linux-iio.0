Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:51207 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354AbbF1KcJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 28 Jun 2015 06:32:09 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH 1/2] iio:light:ltr501: fix regmap dependency
Date: Sun, 28 Jun 2015 12:31:52 +0200
Message-Id: <06cf34cbbfd8c82272c885ff3aab8f44dc72cb41.1435487041.git.knaack.h@gmx.de>
In-Reply-To: <cover.1435487041.git.knaack.h@gmx.de>
References: <cover.1435487041.git.knaack.h@gmx.de>
In-Reply-To: <cover.1435487041.git.knaack.h@gmx.de>
References: <cover.1435487041.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The use of regmap in commit [1] requires REGMAP_I2C to be selected, in
order to meet all dependencies.

[1] 	2f2c96338afc9f90aa5a0fca04ece1a5c389ee31
	"iio: ltr501: Add regmap support."

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/light/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 730fa80..1f1e103 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -199,6 +199,7 @@ config SENSORS_LM3533
 config LTR501
 	tristate "LTR-501ALS-01 light sensor"
 	depends on I2C
+	select REGMAP_I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-- 
2.3.6

