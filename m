Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:19546
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752648Ab1LHRUZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2011 12:20:25 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2] staging:iio: Fix typo
Date: Thu, 8 Dec 2011 18:20:37 +0100
Message-ID: <1323364837-6355-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix a small typo in the iio_modifer enum.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
Changes since v1:
	* Fix up the order of subsystem is the subject line.
---
 drivers/staging/iio/types.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/types.h b/drivers/staging/iio/types.h
index b2ab217..0c32136 100644
--- a/drivers/staging/iio/types.h
+++ b/drivers/staging/iio/types.h
@@ -35,7 +35,7 @@ enum iio_modifier {
 	IIO_MOD_Y,
 	IIO_MOD_Z,
 	IIO_MOD_X_AND_Y,
-	IIO_MOD_X_ANX_Z,
+	IIO_MOD_X_AND_Z,
 	IIO_MOD_Y_AND_Z,
 	IIO_MOD_X_AND_Y_AND_Z,
 	IIO_MOD_X_OR_Y,
-- 
1.7.7.3


