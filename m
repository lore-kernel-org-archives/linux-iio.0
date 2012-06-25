Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:55284 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756682Ab2FYVMT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 25 Jun 2012 17:12:19 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/7] iio staging: move comment
Date: Mon, 25 Jun 2012 23:12:13 +0200
Message-Id: <1340658737-5529-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340658737-5529-1-git-send-email-pmeerw@pmeerw.net>
References: <1340658737-5529-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

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

