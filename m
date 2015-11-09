Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:22999 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040AbbKIMzp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 9 Nov 2015 07:55:45 -0500
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: [PATCH v3] iio: core: added support for IIO_VAL_INT
Date: Mon, 9 Nov 2015 13:55:34 +0100
Message-ID: <1447073734-18602-1-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added core support for IIO_VAL_INT in write_raw_get_fmt function.

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
Sorry for v1, i've missed the "too many 'd's" comment

Changes since v2:
 - Fixed commit msg

Changes since v1:
 - fract_mult set to 0
 - iio_str_to_fixpoint uses kstrtoint for fract_mult = 0

 drivers/iio/industrialio-core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 208358f..d0a84fe 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -512,6 +512,12 @@ int iio_str_to_fixpoint(const char *str, int fract_mult,
 	int i = 0, f = 0;
 	bool integer_part = true, negative = false;
 
+	if (fract_mult == 0) {
+		*fract = 0;
+
+		return kstrtoint(str, 0, integer);
+	}
+
 	if (str[0] == '-') {
 		negative = true;
 		str++;
@@ -571,6 +577,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
 	if (indio_dev->info->write_raw_get_fmt)
 		switch (indio_dev->info->write_raw_get_fmt(indio_dev,
 			this_attr->c, this_attr->address)) {
+		case IIO_VAL_INT:
+			fract_mult = 0;
+			break;
 		case IIO_VAL_INT_PLUS_MICRO:
 			fract_mult = 100000;
 			break;
-- 
2.6.2

