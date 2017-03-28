Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33732 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752840AbdC1UVv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Mar 2017 16:21:51 -0400
Date: Wed, 29 Mar 2017 01:51:48 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] iio: dac: ad5504: constify attribute_group structures
Message-ID: <20170328202147.GA21830@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Check for attribute_group structures that are only stored in the
event_attrs filed of iio_info structure. As the event_attrs field of
iio_info structures is constant, so these attribute_group structures can
also be declared constant. Done using coccinelle:

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
x.event_attrs=&i@p;

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
   text    data     bss     dec     hex filename
   3046     360       0    3406     d4e drivers/iio/dac/ad5504.o

File size after:
   text	   data	    bss	    dec	    hex	filename
   3110	    296	      0	   3406	    d4e	drivers/iio/dac/ad5504.o

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/dac/ad5504.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 788b3d6..22a027d 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -212,7 +212,7 @@ static struct attribute *ad5504_ev_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group ad5504_ev_attribute_group = {
+static const struct attribute_group ad5504_ev_attribute_group = {
 	.attrs = ad5504_ev_attributes,
 };
 
-- 
2.7.4

