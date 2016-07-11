Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: ad799x: Fix buffered capture for ad7991/ad7995/ad7999
Date: Mon, 11 Jul 2016 13:54:17 +0200
Message-Id: <1468238057-30373-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The data buffer for captured mode for the ad799x driver is allocated in the
update_scan_mode() callback. This callback is not set in the iio_info
struct for the ad7791/ad7995/ad7999, which means that the data buffer is
not allocated when a captured transfer is started. As a result the driver
crashes when the first sample is received. To fix this properly set the
update_scan_mode() callback.

Fixes: d8dca33027c1 ("staging:iio:ad799x: Preallocate sample buffer")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Appologies if you received this twice, forgot the list on the first try.
---
 drivers/iio/adc/ad799x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index b616376..9704090 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -527,6 +527,7 @@ static struct attribute_group ad799x_event_attrs_group = {
 static const struct iio_info ad7991_info = {
 	.read_raw = &ad799x_read_raw,
 	.driver_module = THIS_MODULE,
+	.update_scan_mode = ad799x_update_scan_mode,
 };
 
 static const struct iio_info ad7993_4_7_8_noirq_info = {
-- 
2.1.4
