Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34780 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbdDAIj6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2017 04:39:58 -0400
Date: Sat, 1 Apr 2017 14:09:55 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: proximity: as3935: constify attribute_group structures
Message-ID: <20170401083955.GA17655@singhal-Inspiron-5558>
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
   4037	    288	      0	   4325	   10e5	drivers/iio/proximity/as3935.o

File size after:
   text	   data	    bss	    dec	    hex	filename
   4101	    256	      0	   4357	   1105	drivers/iio/proximity/as3935.o

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/proximity/as3935.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 5656deb..1b8b472 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -155,7 +155,7 @@ static struct attribute *as3935_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group as3935_attribute_group = {
+static const struct attribute_group as3935_attribute_group = {
 	.attrs = as3935_attributes,
 };
 
-- 
2.7.4

