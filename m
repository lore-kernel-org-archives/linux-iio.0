Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:53643 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009Ab2FLJtt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 12 Jun 2012 05:49:49 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/2] iio: drop comment about 'real' channels
Date: Tue, 12 Jun 2012 11:49:00 +0200
Message-Id: <1339494541-15018-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Peter Meerwald <p.meerwald@bct-electronic.com>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

---
 include/linux/iio/types.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 1b073b1..d086736 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -11,7 +11,6 @@
 #define _IIO_TYPES_H_
 
 enum iio_chan_type {
-	/* real channel types */
 	IIO_VOLTAGE,
 	IIO_CURRENT,
 	IIO_POWER,
-- 
1.7.5.4

