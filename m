Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:39934 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757124Ab3IOPwk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 15 Sep 2013 11:52:40 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: Fix tcs3472 buffer size
Date: Sun, 15 Sep 2013 17:52:36 +0200
Message-Id: <1379260356-25851-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <5234CB23.3050902@kernel.org>
References: <5234CB23.3050902@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

and drop obsolete #define

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/tcs3472.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 95510bd..dc7d823 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -55,12 +55,9 @@ struct tcs3472_data {
 	u8 enable;
 	u8 control;
 	u8 atime;
-	u16 buffer[4];
+	u16 buffer[8]; /* 4 16-bit channels + 64-bit timestamp */
 };
 
-/* 4 16-bit channels + timestamp = 16 bytes */
-#define TSL3472_BUFFER_SIZE 16
-
 #define TCS3472_CHANNEL(_color, _si, _addr) { \
 	.type = IIO_INTENSITY, \
 	.modified = 1, \
-- 
1.8.4

