Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:47857 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab1JXJna (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2011 05:43:30 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/6] staging:iio:light:tsl2563 both intensity channels have same chan_spec.
Date: Mon, 24 Oct 2011 10:43:30 +0100
Message-Id: <1319449415-23269-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319449415-23269-1-git-send-email-jic23@cam.ac.uk>
References: <1319449415-23269-1-git-send-email-jic23@cam.ac.uk>
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

