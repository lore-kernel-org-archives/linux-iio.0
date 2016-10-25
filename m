Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42905 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932538AbcJYTEV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 15:04:21 -0400
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        sayli karnik <karniksayli1995@gmail.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] iio: maxim_thermocouple: return -EINVAL on invalid read size
Date: Tue, 25 Oct 2016 20:04:08 +0100
Message-Id: <20161025190408.5012-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case that the read size is not 2 or 4 bytes
then maxim_thermocouple_read is not initializing ret and
hence may return early with a bogus error return or
just through to return with a bogos unread value in *val.
Fix this by setting ret to -EINVAL for invalid (unhandled)
read sizes.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index 066161a..f962f31 100644
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
2.9.3

