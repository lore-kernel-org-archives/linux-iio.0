Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-177.synserver.de ([212.40.185.177]:1075 "EHLO
	smtp-out-171.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754909Ab2BJSNp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Feb 2012 13:13:45 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] staging:iio: Rename IIO_EVENT_CODE_EXTRACT_NUM to IIO_EVENT_CODE_EXTRACT_CHAN
Date: Fri, 10 Feb 2012 19:14:59 +0100
Message-Id: <1328897701-24032-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1328897701-24032-1-git-send-email-lars@metafoo.de>
References: <1328897701-24032-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We call this field "chan" throughout IIO with the exception of this one macro.
Rename it to be more consistent.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/events.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
index bfb6340..416800e 100644
--- a/drivers/staging/iio/events.h
+++ b/drivers/staging/iio/events.h
@@ -96,7 +96,7 @@ enum iio_event_direction {
 
 /* Event code number extraction depends on which type of event we have.
  * Perhaps review this function in the future*/
-#define IIO_EVENT_CODE_EXTRACT_NUM(mask) ((__s16)(mask & 0xFFFF))
+#define IIO_EVENT_CODE_EXTRACT_CHAN(mask) ((__s16)(mask & 0xFFFF))
 
 #define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 40) & 0xFF)
 
-- 
1.7.9

