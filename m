Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-125.synserver.de ([212.40.185.125]:1106 "EHLO
	smtp-out-125.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab2JVLPY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 22 Oct 2012 07:15:24 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] iio: Do not accept multiple '.' in fixed point numbers
Date: Mon, 22 Oct 2012 13:15:13 +0200
Message-Id: <1350904515-696-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently when parsing a fix-point number we silently skip any additional '.'
found in the string.  E.g. '1.2.3.4' gets parsed as '1.234'. This patch
disallows this and returns an error if more than one '.' is encountered.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6eb24db..a2e9953 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -449,7 +449,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
 				break;
 			else
 				return -EINVAL;
-		} else if (*buf == '.') {
+		} else if (*buf == '.' && integer_part) {
 			integer_part = false;
 		} else {
 			return -EINVAL;
-- 
1.7.10.4

