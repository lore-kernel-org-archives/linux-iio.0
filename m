Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH] iio: trigger: iio-trig-bfin-timer: select missing dependency
Date: Thu, 12 May 2011 13:15:09 +0200
Message-ID: <1305198909-2078-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

This driver requires CONFIG_BFIN_GPTIMERS.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/trigger/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
index c33777e..b8abf54 100644
--- a/drivers/staging/iio/trigger/Kconfig
+++ b/drivers/staging/iio/trigger/Kconfig
@@ -31,6 +31,7 @@ config IIO_SYSFS_TRIGGER
 config IIO_BFIN_TMR_TRIGGER
 	tristate "Blackfin TIMER trigger"
 	depends on BLACKFIN
+	select BFIN_GPTIMERS
 	help
 	  Provides support for using a Blackfin timer as IIO triggers.
 	  If unsure, say N (but it's safe to say "Y").
-- 
1.6.0.2
