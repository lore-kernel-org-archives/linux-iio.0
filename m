Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33507 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbbGXPXu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2015 11:23:50 -0400
Received: by padck2 with SMTP id ck2so16028218pad.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2015 08:23:50 -0700 (PDT)
From: Joo Aun Saw <jasaw@dius.com.au>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Joo Aun Saw <jasaw@dius.com.au>
Subject: [PATCH 2/2] tools: iio: remove unnecessary double pointer
Date: Sat, 25 Jul 2015 01:23:29 +1000
Message-Id: <1437751409-28837-3-git-send-email-jasaw@dius.com.au>
In-Reply-To: <1437751409-28837-1-git-send-email-jasaw@dius.com.au>
References: <1437751409-28837-1-git-send-email-jasaw@dius.com.au>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Joo Aun Saw <jasaw@dius.com.au>

Remove unnecessary double pointer from channel sorting function.

Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
---
 tools/iio/iio_utils.c | 12 ++++++------
 tools/iio/iio_utils.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 8731905..5b0beea 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -289,17 +289,17 @@ error_free_builtname:
  * @cnt: the amount of array elements
  **/
 
-void bsort_channel_array_by_index(struct iio_channel_info **ci_array, int cnt)
+void bsort_channel_array_by_index(struct iio_channel_info *ci_array, int cnt)
 {
 	struct iio_channel_info temp;
 	int x, y;
 
 	for (x = 0; x < cnt; x++)
 		for (y = 0; y < (cnt - 1); y++)
-			if ((*ci_array)[y].index > (*ci_array)[y + 1].index) {
-				temp = (*ci_array)[y + 1];
-				(*ci_array)[y + 1] = (*ci_array)[y];
-				(*ci_array)[y] = temp;
+			if (ci_array[y].index > ci_array[y + 1].index) {
+				temp = ci_array[y + 1];
+				ci_array[y + 1] = ci_array[y];
+				ci_array[y] = temp;
 			}
 }
 
@@ -519,7 +519,7 @@ int build_channel_array(const char *device_dir,
 
 	free(scan_el_dir);
 	/* reorder so that the array is in index order */
-	bsort_channel_array_by_index(ci_array, *counter);
+	bsort_channel_array_by_index(*ci_array, *counter);
 
 	return 0;
 
diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
index f30a109..e3503bf 100644
--- a/tools/iio/iio_utils.h
+++ b/tools/iio/iio_utils.h
@@ -60,7 +60,7 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
 int iioutils_get_param_float(float *output, const char *param_name,
 			     const char *device_dir, const char *name,
 			     const char *generic_name);
-void bsort_channel_array_by_index(struct iio_channel_info **ci_array, int cnt);
+void bsort_channel_array_by_index(struct iio_channel_info *ci_array, int cnt);
 int build_channel_array(const char *device_dir,
 			struct iio_channel_info **ci_array, int *counter);
 int find_type_by_name(const char *name, const char *type);
-- 
1.9.1

