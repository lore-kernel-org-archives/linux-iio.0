Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:23930 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S979630AbdDYBp5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2017 21:45:57 -0400
From: Orson Zhai <orson.zhai@spreadtrum.com>
To: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Orson Zhai <orson.zhai@spreadtrum.com>
Subject: [PATCH] iio: core: Fix suspicious sizeof usage
Date: Tue, 25 Apr 2017 09:16:56 +0800
Message-ID: <1493083016-20571-1-git-send-email-orson.zhai@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Pointer size is variours in different system, say 32bit for 4 and 64bit
for 8. The 'sizeof(infomask)' may lead to wrong bit numbers.

Signed-off-by: Orson Zhai <orson.zhai@spreadtrum.com>
---
 drivers/iio/industrialio-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 3ff91e0..795f53c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1089,7 +1089,7 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
 {
 	int i, ret, attrcount = 0;
 
-	for_each_set_bit(i, infomask, sizeof(infomask)*8) {
+	for_each_set_bit(i, infomask, sizeof(*infomask)*8) {
 		if (i >= ARRAY_SIZE(iio_chan_info_postfix))
 			return -EINVAL;
 		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i],
@@ -1118,7 +1118,7 @@ static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
 	int i, ret, attrcount = 0;
 	char *avail_postfix;
 
-	for_each_set_bit(i, infomask, sizeof(infomask) * 8) {
+	for_each_set_bit(i, infomask, sizeof(*infomask) * 8) {
 		avail_postfix = kasprintf(GFP_KERNEL,
 					  "%s_available",
 					  iio_chan_info_postfix[i]);
-- 
1.9.1

