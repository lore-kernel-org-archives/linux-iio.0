Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36806 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752348AbdBIPEf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Feb 2017 10:04:35 -0500
Date: Thu, 9 Feb 2017 10:03:41 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: 104-quad-8: Fix off-by-one error when addressing flag
 register
Message-ID: <20170209150341.GA29292@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The flag register is offset by 1 from the respective channel data
register. This patch fixes an off-by-one error when attempting to read a
channel flag register where the base address was not properly offset.

Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8")
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/counter/104-quad-8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
index a5913e97945e..f9b8fc9ae13f 100644
--- a/drivers/iio/counter/104-quad-8.c
+++ b/drivers/iio/counter/104-quad-8.c
@@ -76,7 +76,7 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT;
 		}
 
-		flags = inb(base_offset);
+		flags = inb(base_offset + 1);
 		borrow = flags & BIT(0);
 		carry = !!(flags & BIT(1));
 
-- 
2.11.1

