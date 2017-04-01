Return-Path: <SRS0=bHRo=3J=gmail.com=singhalsimran0@kernel.org>
Date: Sat, 1 Apr 2017 13:59:10 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: apds9960: constify attribute_group structures
Message-ID: <20170401082910.GA10374@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

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
   8503	    488	      0	   8991	   231f	drivers/iio/light/apds9960.o

File size after:
   text	   data	    bss	    dec	    hex	filename
   8567	    424	      0	   8991	   231f	drivers/iio/light/apds9960.o

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/light/apds9960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 90bc98d..c7af36d 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -343,7 +343,7 @@ static struct attribute *apds9960_attributes[] = {
 	NULL,
 };
 
-static struct attribute_group apds9960_attribute_group = {
+static const struct attribute_group apds9960_attribute_group = {
 	.attrs = apds9960_attributes,
 };
 
-- 
2.7.4
