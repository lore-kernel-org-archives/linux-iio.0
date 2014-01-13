Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48080 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068AbaAMV2h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 13 Jan 2014 16:28:37 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/6] staging:iio:accel:sca3000: Event_attribute_group seems to be missing for _info_with_temp
Date: Mon, 13 Jan 2014 22:28:31 +0100
Message-Id: <1389648514-31429-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389648514-31429-1-git-send-email-pmeerw@pmeerw.net>
References: <1389648514-31429-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

issue introduced here 6fe8135f:
staging:iio: implement an iio_info structure to take some of the constant elements out of iio_dev

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/accel/sca3000_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index b627d8f..159272e 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1141,6 +1141,7 @@ static const struct iio_info sca3000_info = {
 static const struct iio_info sca3000_info_with_temp = {
 	.attrs = &sca3000_attribute_group_with_temp,
 	.read_raw = &sca3000_read_raw,
+	.event_attrs = &sca3000_event_attribute_group,
 	.read_event_value = &sca3000_read_thresh,
 	.write_event_value = &sca3000_write_thresh,
 	.read_event_config = &sca3000_read_event_config,
-- 
1.8.3.2

