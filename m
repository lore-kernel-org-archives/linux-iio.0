Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34584 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757390AbdCUSEF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 14:04:05 -0400
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH v3 1/2] staging: iio: ade7753: Remove trailing whitespaces
Date: Tue, 21 Mar 2017 23:33:55 +0530
Message-Id: <1490119436-20042-2-git-send-email-singhalsimran0@gmail.com>
In-Reply-To: <1490119436-20042-1-git-send-email-singhalsimran0@gmail.com>
References: <1490119436-20042-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch removes trailing whitespaces in order to follow the Linux
coding style.

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/staging/iio/meter/ade7753.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index dfd8b71..b71fbd3 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -83,10 +83,10 @@
  * @buf_lock:       mutex to protect tx and rx
  **/
 struct ade7753_state {
-	    struct spi_device   *us;
-		    struct mutex        buf_lock;
-			    u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
-				    u8          rx[ADE7753_MAX_RX];
+	struct spi_device   *us;
+	struct mutex        buf_lock;
+	u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
+	u8          rx[ADE7753_MAX_RX];
 };
 
 static int ade7753_spi_write_reg_8(struct device *dev,
-- 
2.7.4

