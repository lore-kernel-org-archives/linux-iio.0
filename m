Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2nam02on0059.outbound.protection.outlook.com ([104.47.38.59]:47949
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751880AbeEQXQd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 May 2018 19:16:33 -0400
From: Martin Kelly <mkelly@xevo.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Martin Kelly <mkelly@xevo.com>
Subject: [PATCH 1/2] tools: iio: iio_generic_buffer: fix types to match
Date: Thu, 17 May 2018 16:16:06 -0700
Message-Id: <20180517231607.10856-1-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Several types are mismatched and causing implicit conversions.  Fix them
up so the types match.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
 tools/iio/iio_generic_buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index f0c6f54a8b2f..aa765c11992b 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -334,7 +334,10 @@ int main(int argc, char **argv)
 	unsigned long timedelay = 1000000;
 	unsigned long buf_len = 128;
 
-	int ret, c, i, j, toread;
+	ssize_t i;
+	unsigned long j;
+	unsigned long toread;
+	int ret, c;
 	int fp = -1;
 
 	int num_channels = 0;
-- 
2.11.0

