Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35916 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbcIXMCL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2016 08:02:11 -0400
Received: by mail-pa0-f68.google.com with SMTP id my20so6257600pab.3
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2016 05:02:11 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Constantin Musca <constantin.musca@intel.com>,
        Martin Klepplinger <martink@posteo.de>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH -next] iio: accel: mma7660: fix non static symbol warning
Date: Sat, 24 Sep 2016 12:01:54 +0000
Message-Id: <1474718514-13815-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

drivers/iio/accel/mma7660.c:42:11: warning:
 symbol 'mma7660_nscale' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/accel/mma7660.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 03beadf..3a40774 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -39,7 +39,7 @@
 
 #define MMA7660_SCALE_AVAIL	"0.467142857"
 
-const int mma7660_nscale = 467142857;
+static const int mma7660_nscale = 467142857;
 
 #define MMA7660_CHANNEL(reg, axis) {	\
 	.type = IIO_ACCEL,	\



