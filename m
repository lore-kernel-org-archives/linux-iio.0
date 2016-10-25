Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:49868 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752744AbcJYP40 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 11:56:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>,
        sayli karnik <karniksayli1995@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: maxim_thermocouple: detect invalid storage size in read()
Date: Tue, 25 Oct 2016 17:55:04 +0200
Message-Id: <20161025155538.38037-1-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As found by gcc -Wmaybe-uninitialized, having a storage_bytes value other
than 2 or 4 will result in undefined behavior:

drivers/iio/temperature/maxim_thermocouple.c: In function 'maxim_thermocouple_read':
drivers/iio/temperature/maxim_thermocouple.c:141:5: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This probably cannot happen, but returning -EINVAL here is appropriate
and makes gcc happy and the code more robust.

Fixes: 231147ee77f3 ("iio: maxim_thermocouple: Align 16 bit big endian value of raw reads")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/temperature/maxim_thermocouple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index 066161a4bccd..f962f31a5eb2 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -136,6 +136,8 @@ static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
 		ret = spi_read(data->spi, (void *)&buf32, storage_bytes);
 		*val = be32_to_cpu(buf32);
 		break;
+	default:
+		ret = -EINVAL;
 	}
 
 	if (ret)
-- 
2.9.0

