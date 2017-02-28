Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33484 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbdB1Qes (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Feb 2017 11:34:48 -0500
Received: by mail-wr0-f195.google.com with SMTP id g10so2286769wrg.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Feb 2017 08:34:47 -0800 (PST)
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH] staging: iio: Deleted TODO file which contained redundant information
Date: Tue, 28 Feb 2017 18:34:29 +0200
Message-Id: <1488299669-22372-1-git-send-email-narcisaanamaria12@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The TODO file contained redundant information which can be obtained
using ./scripts/get_maintainer.pl.

Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
 drivers/staging/iio/TODO | 8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 drivers/staging/iio/TODO

diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
deleted file mode 100644
index 4922402..0000000
--- a/drivers/staging/iio/TODO
+++ /dev/null
@@ -1,8 +0,0 @@
-2016 10/09
-
-ADI Drivers:
-CC the device-drivers-devel@blackfin.uclinux.org mailing list when
-e-mailing the normal IIO list (see below).
-
-Contact: Jonathan Cameron <jic23@kernel.org>.
-Mailing list: linux-iio@vger.kernel.org
-- 
1.9.1

