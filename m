Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-125.synserver.de ([212.40.185.125]:1066 "EHLO
	smtp-out-125.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab2JVLPY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 22 Oct 2012 07:15:24 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] iio: Accept a leading '+' sign when parsing fixed point numbers
Date: Mon, 22 Oct 2012 13:15:15 +0200
Message-Id: <1350904515-696-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1350904515-696-1-git-send-email-lars@metafoo.de>
References: <1350904515-696-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If we encounter a leading '+' sign just skip over it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index fe593bf..5f8ff0d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -432,6 +432,8 @@ static ssize_t iio_write_channel_info(struct device *dev,
 	if (buf[0] == '-') {
 		negative = true;
 		buf++;
+	} else if (buf[0] == '+') {
+		buf++;
 	}
 
 	while (*buf) {
-- 
1.7.10.4

