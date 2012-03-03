Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:51742 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab2CCMN0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Mar 2012 07:13:26 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging:iio:buffer example fix typos
Date: Sat,  3 Mar 2012 12:14:30 +0000
Message-Id: <1330776870-20535-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I have no idea how I managed to munge the previous
patch related to this.  Sorry all.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/Documentation/generic_buffer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index 69a05b9..bf55335 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -60,9 +60,9 @@ void print2byte(int input, struct iio_channel_info *info)
 	/* First swap if incorrect endian */
 
 	if (info->be)
-		input = be16toh((uint_16t)input);
+		input = be16toh((uint16_t)input);
 	else
-		input = le16toh((uint_16t)input);
+		input = le16toh((uint16_t)input);
 
 	/* shift before conversion to avoid sign extension
 	   of left aligned data */
-- 
1.7.9.2

