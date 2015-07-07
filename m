Return-Path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Jonathan Bell <jonathan@raspberrypi.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Harald Geyer <harald@ccbib.org>
Subject: [PATCHv3 2/4] iio: dht11: add comment to make checkpatch.pl --strict happy
Date: Tue,  7 Jul 2015 13:39:29 +0000
Message-Id: <1436276371-7480-2-git-send-email-harald@ccbib.org>
In-Reply-To: <1436276371-7480-1-git-send-email-harald@ccbib.org>
References: <55991FEA.50703@kernel.org>
 <1436276371-7480-1-git-send-email-harald@ccbib.org>
List-ID: <linux-iio@vger.kernel.org>

Explain why the driver needs a mutex.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
 drivers/iio/humidity/dht11.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 343d26a..bb5ad57 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -63,6 +63,7 @@ struct dht11 {
 	int				irq;
 
 	struct completion		completion;
+	/* The iio sysfs interface doesn't prevent concurrent reads: */
 	struct mutex			lock;
 
 	s64				timestamp;
-- 
1.7.10.4
