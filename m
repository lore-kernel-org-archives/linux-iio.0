Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34545 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbdDAIRz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2017 04:17:55 -0400
Date: Sat, 1 Apr 2017 13:47:51 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: hx711: constify attribute_group structures
Message-ID: <20170401081751.GA30133@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Check for attribute_group structures that are only stored in the
attrs filed of iio_info structure. As the attrs field of iio_info
structures is constant, so these attribute_group structures can also be
declared constant.
Done using coccinelle:

@r1 disable optional_qualifier @
identifier i;
position p;
@@
static struct attribute_group i@p = {...};

@ok1@
identifier r1.i;
position p;
struct iio_info x;
@@
x.attrs=&i@p;

@bad@
position p!={r1.p,ok1.p};
identifier r1.i;
@@
i@p

@depends on !bad disable optional_qualifier@
identifier r1.i;
@@
static
+const
struct attribute_group i={...};

@depends on !bad disable optional_qualifier@
identifier r1.i;
@@
+const
struct attribute_group i;

File size before:
   text	   data	    bss	    dec	    hex	filename
   3042	    480	      0	   3522	    dc2	drivers/iio/adc/hx711.o

File size after:
   text	   data	    bss	    dec	    hex	filename
   3098	    416	      0	   3514	    dba	drivers/iio/adc/hx711.o

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/adc/hx711.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 139639f..27005d8 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -369,7 +369,7 @@ static struct attribute *hx711_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group hx711_attribute_group = {
+static const struct attribute_group hx711_attribute_group = {
 	.attrs = hx711_attributes,
 };
 
-- 
2.7.4

