Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:56574 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864Ab2DJURi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:17:38 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: jbrenner@TAOSinc.com, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/4] staging:iio: chan_spec - take extend_name constant.
Date: Tue, 10 Apr 2012 21:17:32 +0100
Message-Id: <1334089052-22304-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089052-22304-1-git-send-email-jic23@kernel.org>
References: <1334089052-22304-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I can't envision a case where this is not constant and we
don't seem to have any in tree, so lets clear up this loose
end.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/iio.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 833a849..4824812 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -164,7 +164,7 @@ struct iio_chan_spec {
 	long			info_mask;
 	long			event_mask;
 	const struct iio_chan_spec_ext_info *ext_info;
-	char			*extend_name;
+	const char		*extend_name;
 	const char		*datasheet_name;
 	unsigned		processed_val:1;
 	unsigned		modified:1;
-- 
1.7.9.4

