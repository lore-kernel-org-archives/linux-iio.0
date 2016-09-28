Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33408 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932824AbcI1QRJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Sep 2016 12:17:09 -0400
Received: by mail-pa0-f66.google.com with SMTP id oz2so2251373pac.0
        for <linux-iio@vger.kernel.org>; Wed, 28 Sep 2016 09:17:09 -0700 (PDT)
Date: Wed, 28 Sep 2016 21:46:51 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org, mranostay@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: [PATCH v4] iio: maxim_thermocouple: Align 16 bit big endian value of
 raw reads
Message-ID: <20160928161651.GA28186@sayli-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver was reporting invalid raw read values for MAX6675 on big
endian architectures. MAX6675 buffered mode is not affected, nor
is the MAX31855.

The driver was losing a 2 byte read value when it used a 32 bit
integer buffer to store a 16 bit big endian value. Use big endian
types to properly align buffers on big endian architectures.

Fixes following sparse endianness warnings:
warning: cast to restricted __be16
warning: cast to restricted __be32
Fixes checkpatch issue:
CHECK: No space is necessary after a cast

Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
Fixes: 1f25ca11d84a ("iio: temperature: add support for Maxim
thermocouple chips")
---
Changes in v4:
Reverted back to v2 with changed names for buffers

Changes in v3:
Updated the commit message
Updated the changelog to include explanation to the bug fix
Fixed the checkpatch issue: CHECK: No space is necessary after a cast
Added the fixes tag

 drivers/iio/temperature/maxim_thermocouple.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index 39dd202..066161a 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -123,22 +123,24 @@ static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
 {
 	unsigned int storage_bytes = data->chip->read_size;
 	unsigned int shift = chan->scan_type.shift + (chan->address * 8);
-	unsigned int buf;
+	__be16 buf16;
+	__be32 buf32;
 	int ret;
 
-	ret = spi_read(data->spi, (void *) &buf, storage_bytes);
-	if (ret)
-		return ret;
-
 	switch (storage_bytes) {
 	case 2:
-		*val = be16_to_cpu(buf);
+		ret = spi_read(data->spi, (void *)&buf16, storage_bytes);
+		*val = be16_to_cpu(buf16);
 		break;
 	case 4:
-		*val = be32_to_cpu(buf);
+		ret = spi_read(data->spi, (void *)&buf32, storage_bytes);
+		*val = be32_to_cpu(buf32);
 		break;
 	}
 
+	if (ret)
+		return ret;
+
 	/* check to be sure this is a valid reading */
 	if (*val & data->chip->status_bit)
 		return -EINVAL;
-- 
2.7.4

