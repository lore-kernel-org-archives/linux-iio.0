Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:47337 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754573AbbJ0IwQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 27 Oct 2015 04:52:16 -0400
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: [PATCH] iio: core: added support for IIO_VAL_INT
Date: Tue, 27 Oct 2015 09:51:55 +0100
Message-ID: <1445935915-7765-1-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Addded core support for IIO_VAL_INT in write_raw_get_fmt function.

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
 drivers/iio/industrialio-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 208358f..2d08c3c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -571,6 +571,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
 	if (indio_dev->info->write_raw_get_fmt)
 		switch (indio_dev->info->write_raw_get_fmt(indio_dev,
 			this_attr->c, this_attr->address)) {
+		case IIO_VAL_INT:
+			fract_mult = 1;
+			break;
 		case IIO_VAL_INT_PLUS_MICRO:
 			fract_mult = 100000;
 			break;
-- 
2.6.2

