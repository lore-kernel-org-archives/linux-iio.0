Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33760 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755824AbcJ2QL3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2016 12:11:29 -0400
Received: by mail-pf0-f195.google.com with SMTP id a136so856270pfa.0
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2016 09:11:28 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH -next] iio: humidity: remove duplicated include from hts221_buffer.c
Date: Sat, 29 Oct 2016 16:11:20 +0000
Message-Id: <1477757480-26388-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Remove duplicated include.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/humidity/hts221_buffer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 76b2e81..72ddcda 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -15,7 +15,6 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
-#include <linux/interrupt.h>
 #include <linux/iio/events.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>



