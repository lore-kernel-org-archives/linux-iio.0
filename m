Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:56849 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301Ab3IQVdr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 17 Sep 2013 17:33:47 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: Make available scan_masks const in ad7266
Date: Tue, 17 Sep 2013 23:33:34 +0200
Message-Id: <1379453614-6935-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7266.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 5bfed23..c304966 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -293,7 +293,7 @@ static const struct iio_info ad7266_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static unsigned long ad7266_available_scan_masks[] = {
+static const unsigned long ad7266_available_scan_masks[] = {
 	0x003,
 	0x00c,
 	0x030,
@@ -303,14 +303,14 @@ static unsigned long ad7266_available_scan_masks[] = {
 	0x000,
 };
 
-static unsigned long ad7266_available_scan_masks_diff[] = {
+static const unsigned long ad7266_available_scan_masks_diff[] = {
 	0x003,
 	0x00c,
 	0x030,
 	0x000,
 };
 
-static unsigned long ad7266_available_scan_masks_fixed[] = {
+static const unsigned long ad7266_available_scan_masks_fixed[] = {
 	0x003,
 	0x000,
 };
@@ -318,7 +318,7 @@ static unsigned long ad7266_available_scan_masks_fixed[] = {
 struct ad7266_chan_info {
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
-	unsigned long *scan_masks;
+	const unsigned long *scan_masks;
 };
 
 #define AD7266_CHAN_INFO_INDEX(_differential, _signed, _fixed) \
-- 
1.8.4

