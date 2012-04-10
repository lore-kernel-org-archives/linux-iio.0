Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:36262 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab2DJULQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:11:16 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/6] staging:iio:buffer example fix typos
Date: Tue, 10 Apr 2012 21:11:04 +0100
Message-Id: <1334088669-21032-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1334088669-21032-1-git-send-email-jic23@kernel.org>
References: <1334088669-21032-1-git-send-email-jic23@kernel.org>
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
1.7.9.4

