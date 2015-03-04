Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:40162 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756987AbbCDDou (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Mar 2015 22:44:50 -0500
Received: by pdbfp1 with SMTP id fp1so16668969pdb.7
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2015 19:44:50 -0800 (PST)
From: Masanari Iida <standby24x7@gmail.com>
To: jic23@kernel.org, linux-kernel.vger.kernel.org@masabert,
	linux-iio@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] iio:adc: Fix typo in MODULE_DESCRIPTION in ad7793.c
Date: Wed,  4 Mar 2015 12:44:33 +0900
Message-Id: <1425440673-12400-1-git-send-email-standby24x7@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fix spelling typo in MODULE_DESCRIPTION

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/iio/adc/ad7793.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 4dddeab..b84922a 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -861,5 +861,5 @@ static struct spi_driver ad7793_driver = {
 module_spi_driver(ad7793_driver);
 
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("Analog Devices AD7793 and simialr ADCs");
+MODULE_DESCRIPTION("Analog Devices AD7793 and similar ADCs");
 MODULE_LICENSE("GPL v2");
-- 
2.3.1.167.g7f4ba4b

