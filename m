Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35676 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbbKNCpP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Nov 2015 21:45:15 -0500
From: Nizam Haider <nizamhaider786@gmail.com>
To: lars@metafoo.de
Cc: knaack.h@gmx.de, jic23@kernel.org, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	Nizam Haider <nizamhaider786@gmail.com>,
	Nizam Haider <nijamh@cdac.in>
Subject: [PATCH] Staging: iio: iio_simple_dummy_buffer: Typo in comments area
Date: Sat, 14 Nov 2015 08:14:01 +0530
Message-Id: <1447469041-5751-1-git-send-email-nizamhaider786@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix simple typo in comments

Signed-off-by: Nizam Haider <nijamh@cdac.in>
---
 drivers/staging/iio/iio_simple_dummy_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index cf44a6f..c8f889b 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -64,7 +64,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 		 * software scans: can be considered to be random access
 		 *   so efficient reading is just a case of minimal bus
 		 *   transactions.
-		 * software culled hardware scans:
+		 * software called hardware scans:
 		 *   occasionally a driver may process the nearest hardware
 		 *   scan to avoid storing elements that are not desired. This
 		 *   is the fiddliest option by far.
-- 
1.8.1.4

