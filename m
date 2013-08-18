Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:55569 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755310Ab3HRM7S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 18 Aug 2013 08:59:18 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/2] iio: adjd_s311: Cleanup unused #defines
Date: Sun, 18 Aug 2013 14:59:13 +0200
Message-Id: <1376830753-2430-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1376830753-2430-1-git-send-email-pmeerw@pmeerw.net>
References: <1376830753-2430-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

using word reads, no need for HI/LO register #defines

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/adjd_s311.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index c4b730d..23cff79 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -37,22 +37,14 @@
 #define ADJD_S311_CAP_GREEN	0x07
 #define ADJD_S311_CAP_BLUE	0x08
 #define ADJD_S311_CAP_CLEAR	0x09
-#define ADJD_S311_INT_RED_LO	0x0a
-#define ADJD_S311_INT_RED_HI	0x0b
-#define ADJD_S311_INT_GREEN_LO	0x0c
-#define ADJD_S311_INT_GREEN_HI	0x0d
-#define ADJD_S311_INT_BLUE_LO	0x0e
-#define ADJD_S311_INT_BLUE_HI	0x0f
-#define ADJD_S311_INT_CLEAR_LO	0x10
-#define ADJD_S311_INT_CLEAR_HI	0x11
-#define ADJD_S311_DATA_RED_LO	0x40
-#define ADJD_S311_DATA_RED_HI	0x41
-#define ADJD_S311_DATA_GREEN_LO	0x42
-#define ADJD_S311_DATA_GREEN_HI	0x43
-#define ADJD_S311_DATA_BLUE_LO	0x44
-#define ADJD_S311_DATA_BLUE_HI	0x45
-#define ADJD_S311_DATA_CLEAR_LO	0x46
-#define ADJD_S311_DATA_CLEAR_HI	0x47
+#define ADJD_S311_INT_RED	0x0a
+#define ADJD_S311_INT_GREEN	0x0c
+#define ADJD_S311_INT_BLUE	0x0e
+#define ADJD_S311_INT_CLEAR	0x10
+#define ADJD_S311_DATA_RED	0x40
+#define ADJD_S311_DATA_GREEN	0x42
+#define ADJD_S311_DATA_BLUE	0x44
+#define ADJD_S311_DATA_CLEAR	0x46
 #define ADJD_S311_OFFSET_RED	0x48
 #define ADJD_S311_OFFSET_GREEN	0x49
 #define ADJD_S311_OFFSET_BLUE	0x4a
@@ -73,8 +65,8 @@ enum adjd_s311_channel_idx {
 	IDX_RED, IDX_GREEN, IDX_BLUE, IDX_CLEAR
 };
 
-#define ADJD_S311_DATA_REG(chan) (ADJD_S311_DATA_RED_LO + (chan) * 2)
-#define ADJD_S311_INT_REG(chan) (ADJD_S311_INT_RED_LO + (chan) * 2)
+#define ADJD_S311_DATA_REG(chan) (ADJD_S311_DATA_RED + (chan) * 2)
+#define ADJD_S311_INT_REG(chan) (ADJD_S311_INT_RED + (chan) * 2)
 #define ADJD_S311_CAP_REG(chan) (ADJD_S311_CAP_RED + (chan))
 
 static int adjd_s311_req_data(struct iio_dev *indio_dev)
-- 
1.8.3.4

