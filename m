Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:36269 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab2DJULR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:11:17 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/6] staging:iio:adc:max1363 fix missing update_scan_mask callback.
Date: Tue, 10 Apr 2012 21:11:05 +0100
Message-Id: <1334088669-21032-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1334088669-21032-1-git-send-email-jic23@kernel.org>
References: <1334088669-21032-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When moving over to the new sw_ring_preenable I managed to add
this callback to only one of the two iio_info structures. As
such only some devices will currently work.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/max1363_core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index cf3e2ca..2536b63 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -830,6 +830,7 @@ static struct attribute_group max1363_event_attribute_group = {
 static const struct iio_info max1238_info = {
 	.read_raw = &max1363_read_raw,
 	.driver_module = THIS_MODULE,
+	.update_scan_mode = &max1363_update_scan_mode,
 };
 
 static const struct iio_info max1363_info = {
-- 
1.7.9.4

