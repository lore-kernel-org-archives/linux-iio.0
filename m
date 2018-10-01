Return-Path: <SRS0=Wg2O=MN=poczta.fm=sst@kernel.org>
Date: Mon, 1 Oct 2018 14:28:34 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org
Subject: [PATCH] staging: iio: adc: add missing spaces around minus sign
Message-ID: <20181001122834.GA13306@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The checkpatch.pl tool detected coding style problem:

    CHECK: spaces preferred around that '-' (ctx:VxV)

in two files inside the adc directory. This patch will remove this
problem.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/staging/iio/adc/ad7192.c  | 2 +-
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index acdbc07fd259..7c632cf1932b 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -355,7 +355,7 @@ ad7192_show_scale_available(struct device *dev,
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
-			     in_voltage-voltage_scale_available,
+			     in_voltage - voltage_scale_available,
 			     0444, ad7192_show_scale_available, NULL, 0);
 
 static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 58420dcb406d..a4b4f8678c56 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -750,14 +750,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
-		in_voltage-voltage_thresh_low_value,
+		in_voltage - voltage_thresh_low_value,
 		0644,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
 		AD7280A_CELL_UNDERVOLTAGE);
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
-		in_voltage-voltage_thresh_high_value,
+		in_voltage - voltage_thresh_high_value,
 		0644,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
-- 
2.19.0
