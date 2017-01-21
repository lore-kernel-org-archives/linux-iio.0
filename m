Return-Path: <SRS0=VXjD=ZD=gmail.com=bhumirks@kernel.org>
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] iio: industrialio-trigger: constify device_type structures
Date: Sat, 21 Jan 2017 22:29:49 +0530
Message-Id: <1485017989-22670-1-git-send-email-bhumirks@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Declare device_type structure as const as it is only stored in the
type field of a device structure. This field is of type const, so add
const to declaration of device_type structure.

File size before:
   text	   data	    bss	    dec	    hex	filename
   5389	    208	     48	   5645	   160d	iio/industrialio-trigger.o

File size after:
   text	   data	    bss	    dec	    hex	filename
   5453	    176	     48	   5677	   162d	iio/industrialio-trigger.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 978729f..3257f0e 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -487,7 +487,7 @@ static void iio_trig_release(struct device *device)
 	kfree(trig);
 }
 
-static struct device_type iio_trig_type = {
+static const struct device_type iio_trig_type = {
 	.release = iio_trig_release,
 	.groups = iio_trig_dev_groups,
 };
-- 
2.7.4
