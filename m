Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:55280 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755823Ab2FYVMT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 25 Jun 2012 17:12:19 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/7] iio staging: remove unused variable
Date: Mon, 25 Jun 2012 23:12:12 +0200
Message-Id: <1340658737-5529-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340658737-5529-1-git-send-email-pmeerw@pmeerw.net>
References: <1340658737-5529-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 drivers/staging/iio/Documentation/generic_buffer.c |    2 --
 drivers/staging/iio/Documentation/iio_utils.h      |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index 361e481..7b2a12c 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -131,8 +131,6 @@ int main(int argc, char **argv)
 
 
 	int ret, c, i, j, toread;
-
-	FILE *fp_ev;
 	int fp;
 
 	int num_channels;
diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 6f3a392..6fe8540 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -280,7 +280,7 @@ inline int build_channel_array(const char *device_dir,
 {
 	DIR *dp;
 	FILE *sysfsfp;
-	int count, temp, i;
+	int count, i;
 	struct iio_channel_info *current;
 	int ret;
 	const struct dirent *ent;
-- 
1.7.9.5

