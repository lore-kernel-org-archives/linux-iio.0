Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36467 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbdDAIXh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2017 04:23:37 -0400
Date: Sat, 1 Apr 2017 13:53:33 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: humidity: hdc100x: constify attribute_group structures
Message-ID: <20170401082333.GA3515@singhal-Inspiron-5558>
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
   3459	    488	      0	   3947	    f6b	drivers/iio/humidity/hdc100x.o

File size after:
   text	   data	    bss	    dec	    hex	filename
   3507	    424	      0	   3931	    f5b	drivers/iio/humidity/hdc100x.o

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/humidity/hdc100x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 265c34d..aa17115 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -79,7 +79,7 @@ static struct attribute *hdc100x_attributes[] = {
 	NULL
 };
 
-static struct attribute_group hdc100x_attribute_group = {
+static const struct attribute_group hdc100x_attribute_group = {
 	.attrs = hdc100x_attributes,
 };
 
-- 
2.7.4

