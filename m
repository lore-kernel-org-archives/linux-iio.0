Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-125.synserver.de ([212.40.185.125]:1134 "EHLO
	smtp-out-125.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab2JVLPY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 22 Oct 2012 07:15:24 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] iio: Reject trailing garbage when parsing fixed point numbers
Date: Mon, 22 Oct 2012 13:15:14 +0200
Message-Id: <1350904515-696-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1350904515-696-1-git-send-email-lars@metafoo.de>
References: <1350904515-696-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When parsing a fixed point number IIO stops parsing the string once it has
reached the last requested decimal place. This means that the remainder of the
string is silently accepted regardless, of whether it is part of a valid number
or not. This patch modifies the code to scan the whole string and only accept
valid numbers. Since fract_mult is 0 after the last decimal place any digit that
may follows won't affect the result.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a2e9953..fe593bf 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -440,8 +440,6 @@ static ssize_t iio_write_channel_info(struct device *dev,
 				integer = integer*10 + *buf - '0';
 			else {
 				fract += fract_mult*(*buf - '0');
-				if (fract_mult == 1)
-					break;
 				fract_mult /= 10;
 			}
 		} else if (*buf == '\n') {
-- 
1.7.10.4

