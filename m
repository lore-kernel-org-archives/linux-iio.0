Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:49667 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327AbbFTVwv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 20 Jun 2015 17:52:51 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/3] iio: Add missing modifier names to core
Date: Sat, 20 Jun 2015 23:52:30 +0200
Message-Id: <1434837152-30830-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

some are documented, others are in iio_event_monitor.c which
was recently moved from staging

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/industrialio-core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4df97f6..f3bf00c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -81,6 +81,14 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_X] = "x",
 	[IIO_MOD_Y] = "y",
 	[IIO_MOD_Z] = "z",
+	[IIO_MOD_X_AND_Y] = "x&y",
+	[IIO_MOD_X_AND_Z] = "x&z",
+	[IIO_MOD_Y_AND_Z] = "y&z",
+	[IIO_MOD_X_AND_Y_AND_Z] = "x&y&z",
+	[IIO_MOD_X_OR_Y] = "x|y",
+	[IIO_MOD_X_OR_Z] = "x|z",
+	[IIO_MOD_Y_OR_Z] = "y|z",
+	[IIO_MOD_X_OR_Y_OR_Z] = "x|y|z",
 	[IIO_MOD_ROOT_SUM_SQUARED_X_Y] = "sqrt(x^2+y^2)",
 	[IIO_MOD_SUM_SQUARED_X_Y_Z] = "x^2+y^2+z^2",
 	[IIO_MOD_LIGHT_BOTH] = "both",
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
