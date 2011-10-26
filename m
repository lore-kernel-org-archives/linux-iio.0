Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46249 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933582Ab1JZQ1j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 26 Oct 2011 12:27:39 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 01/10] staging:iio:light:tsl2563 both intensity channels have same chan_spec.
Date: Wed, 26 Oct 2011 17:27:36 +0100
Message-Id: <1319646465-2788-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319646465-2788-1-git-send-email-jic23@cam.ac.uk>
References: <1319646465-2788-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Bug has been fixed for some time in the outofstaging tree, but
didn't propogate back to here.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/tsl2563.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 7e984bc..be99925 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -544,7 +544,7 @@ static const struct iio_chan_spec tsl2563_channels[] = {
 	}, {
 		.type = IIO_INTENSITY,
 		.modified = 1,
-		.channel2 = IIO_MOD_LIGHT_BOTH,
+		.channel2 = IIO_MOD_LIGHT_IR,
 		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE),
 	}
 };
-- 
1.7.7

