Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:19170 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755305Ab2BMJYS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 13 Feb 2012 04:24:18 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	<devel@driverdev.osuosl.org>, <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/4] staging:iio: Add missing event code extract macros
Date: Mon, 13 Feb 2012 10:25:33 +0100
Message-ID: <1329125134-24150-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1329125134-24150-1-git-send-email-lars@metafoo.de>
References: <1329125134-24150-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add macros for extracting whether the event is for a differential channel and
the second channel number from the event code. These were the only two fields
which did not have such an macro yet.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/events.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/events.h b/drivers/staging/iio/events.h
index 416800e..c25f0e3 100644
--- a/drivers/staging/iio/events.h
+++ b/drivers/staging/iio/events.h
@@ -97,7 +97,9 @@ enum iio_event_direction {
 /* Event code number extraction depends on which type of event we have.
  * Perhaps review this function in the future*/
 #define IIO_EVENT_CODE_EXTRACT_CHAN(mask) ((__s16)(mask & 0xFFFF))
+#define IIO_EVENT_CODE_EXTRACT_CHAN2(mask) ((__s16)(((mask) >> 16) & 0xFFFF))
 
 #define IIO_EVENT_CODE_EXTRACT_MODIFIER(mask) ((mask >> 40) & 0xFF)
+#define IIO_EVENT_CODE_EXTRACT_DIFF(mask) (((mask) >> 55) & 0x1)
 
 #endif
-- 
1.7.9


