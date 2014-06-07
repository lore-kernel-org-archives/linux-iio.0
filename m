Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43405 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935AbaFGPnD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 11:43:03 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 09/12] staging:iio: Fix mention of INDIO_RING_TRIGGERED to INDIO_BUFFER_TRIGGERED
Date: Sat,  7 Jun 2014 17:42:49 +0200
Message-Id: <1402155772-1373-10-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net>
References: <1402155772-1373-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/Documentation/trigger.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/Documentation/trigger.txt b/drivers/staging/iio/Documentation/trigger.txt
index 64e2e08..7c0e505 100644
--- a/drivers/staging/iio/Documentation/trigger.txt
+++ b/drivers/staging/iio/Documentation/trigger.txt
@@ -31,5 +31,5 @@ consumers.
 Trigger Consumers
 
 Currently triggers are only used for the filling of software
-buffers and as such any device supporting INDIO_RING_TRIGGERED has the
+buffers and as such any device supporting INDIO_BUFFER_TRIGGERED has the
 consumer interface automatically created.
-- 
1.9.1

