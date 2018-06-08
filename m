Return-Path: <SRS0=rDR4=I2=micronovasrl.com=giulio.benetti@kernel.org>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: Greg Kroah-Hartman <greg@kroah.com>
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH] staging: iio: adc: ad7606: fix function pointer parameter names missing.
Date: Sat,  9 Jun 2018 00:13:31 +0200
Message-Id: <20180608221331.116928-1-giulio.benetti@micronovasrl.com>
List-ID: <linux-iio@vger.kernel.org>

Checkpatch.pl complains about function pointer parameter names missing.

Add parameter names.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/staging/iio/adc/ad7606.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
index acaed8d5379c..9716ee9d94a7 100644
--- a/drivers/staging/iio/adc/ad7606.h
+++ b/drivers/staging/iio/adc/ad7606.h
@@ -57,7 +57,7 @@ struct ad7606_state {
 
 struct ad7606_bus_ops {
 	/* more methods added in future? */
-	int (*read_block)(struct device *, int, void *);
+	int (*read_block)(struct device *dev, int num, void *data);
 };
 
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
-- 
2.17.1
