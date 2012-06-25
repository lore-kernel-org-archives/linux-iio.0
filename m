Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/7] iio staging: move comment
Date: Mon, 25 Jun 2012 21:11:41 +0200
Message-Id: <1340651505-31081-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net>
References: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/Documentation/iio_utils.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 6fe8540..d9439f8 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -7,7 +7,6 @@
  * the Free Software Foundation.
  */
 
-/* Made up value to limit allocation sizes */
 #include <string.h>
 #include <stdlib.h>
 #include <ctype.h>
@@ -15,6 +14,7 @@
 #include <stdint.h>
 #include <dirent.h>
 
+/* Made up value to limit allocation sizes */
 #define IIO_MAX_NAME_LENGTH 30
 
 #define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
-- 
1.7.9.5
