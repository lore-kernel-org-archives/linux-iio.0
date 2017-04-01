Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32909 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbdDAC3A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Mar 2017 22:29:00 -0400
Date: Sat, 1 Apr 2017 07:58:56 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: light: constify attribute_group structures
Message-ID: <20170401022856.GA9305@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As the event_attrs field of iio_info structures is constant, so these
attribute_group structures can also be declared constant.

File size before:
   text	   data	    bss	    dec	    hex	filename
  15064	   1528	      0	  16592	   40d0
drivers/staging/iio/light/tsl2x7x_core.o

File size after:
   text	   data	    bss	    dec	    hex	filename
  15192	   1400	      0	  16592	   40d0
drivers/staging/iio/light/tsl2x7x_core.o

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/staging/iio/light/tsl2x7x_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 0490c1d..9a0046a 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -1676,7 +1676,7 @@ static const struct attribute_group tsl2X7X_device_attr_group_tbl[] = {
 	},
 };
 
-static struct attribute_group tsl2X7X_event_attr_group_tbl[] = {
+static const struct attribute_group tsl2X7X_event_attr_group_tbl[] = {
 	[ALS] = {
 		.attrs = tsl2X7X_ALS_event_attrs,
 		.name = "events",
-- 
2.7.4

