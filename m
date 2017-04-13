Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32904 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbdDMVye (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2017 17:54:34 -0400
Received: by mail-pf0-f193.google.com with SMTP id c198so12910462pfc.0
        for <linux-iio@vger.kernel.org>; Thu, 13 Apr 2017 14:54:33 -0700 (PDT)
From: plroskin@gmail.com
To: linux-iio@vger.kernel.org
Cc: Pavel Roskin <plroskin@gmail.com>
Subject: [PATCH] iio: dac: ad7303: fix channel description
Date: Thu, 13 Apr 2017 14:54:23 -0700
Message-Id: <20170413215423.22070-1-plroskin@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Pavel Roskin <plroskin@gmail.com>

realbits, storagebits and shift should be numbers, not ASCII characters.

Signed-off-by: Pavel Roskin <plroskin@gmail.com>
---
 drivers/iio/dac/ad7303.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
index e690dd11e99f..4b0f942b8914 100644
--- a/drivers/iio/dac/ad7303.c
+++ b/drivers/iio/dac/ad7303.c
@@ -184,9 +184,9 @@ static const struct iio_chan_spec_ext_info ad7303_ext_info[] = {
 	.address = (chan),					\
 	.scan_type = {						\
 		.sign = 'u',					\
-		.realbits = '8',				\
-		.storagebits = '8',				\
-		.shift = '0',					\
+		.realbits = 8,					\
+		.storagebits = 8,				\
+		.shift = 0,					\
 	},							\
 	.ext_info = ad7303_ext_info,				\
 }
-- 
2.12.2

