Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35101 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbGMNUz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2015 09:20:55 -0400
Date: Mon, 13 Jul 2015 16:20:11 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com, octavian.purdila@intel.com
Subject: [PATCH 3/3] tools: iio: Add ARRAY_SIZE macro
Message-ID: <d636b387c2cee14901733a3d768d10f9cb6782b9.1436789446.git.cristina.opriceana@gmail.com>
References: <cover.1436789446.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1436789446.git.cristina.opriceana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Calculation of the length of an array can be done with the ARRAY_SIZE
macro to make code more abstract and remove the associated
checkpatch.pl warning.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 tools/iio/iio_utils.c | 2 +-
 tools/iio/iio_utils.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 4a7e480..e177f40 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -39,7 +39,7 @@ int iioutils_break_up_name(const char *full_name, char **generic_name)
 	char *working, *prefix = "";
 	int i, ret;
 
-	for (i = 0; i < sizeof(iio_direction) / sizeof(iio_direction[0]); i++)
+	for (i = 0; i < ARRAY_SIZE(iio_direction); i++)
 		if (!strncmp(full_name, iio_direction[i],
 			     strlen(iio_direction[i]))) {
 			prefix = iio_direction[i];
diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
index 0866101..f30a109 100644
--- a/tools/iio/iio_utils.h
+++ b/tools/iio/iio_utils.h
@@ -18,6 +18,8 @@
 #define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
 #define FORMAT_TYPE_FILE "%s_type"
 
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
+
 extern const char *iio_dir;
 
 /**
-- 
1.9.1

