Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/5] staging:iio:adc:max1363 fix missing update_scan_mask callback.
Date: Sat,  3 Mar 2012 11:39:14 +0000
Message-Id: <1330774755-18031-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1330774755-18031-1-git-send-email-jic23@kernel.org>
References: <1330774755-18031-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

When moving over to the new sw_ring_preenable I managed to add
this callback to only one of the two iio_info structures. As
such only some devices will currently work.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/max1363_core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 877995b..9d7db7f 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -831,6 +831,7 @@ static struct attribute_group max1363_event_attribute_group = {
 static const struct iio_info max1238_info = {
 	.read_raw = &max1363_read_raw,
 	.driver_module = THIS_MODULE,
+	.update_scan_mode = &max1363_update_scan_mode,
 };
 
 static const struct iio_info max1363_info = {
-- 
1.7.9.2
