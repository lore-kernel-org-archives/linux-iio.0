Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54097 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758191Ab2DMJY0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 05:24:26 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/4] staging:iio: chan_spec - take extend_name constant.
Date: Fri, 13 Apr 2012 10:24:21 +0100
Message-Id: <1334309061-21073-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1334309061-21073-1-git-send-email-jic23@kernel.org>
References: <1334309061-21073-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I can't envision a case where this is not constant and we
don't seem to have any in tree, so lets clear up this loose
end.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/iio.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
1.7.0.4

