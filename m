Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO-onwards: trigger: iio-trig-sysfs: Avoid double free.
Date: Fri, 15 Apr 2011 14:29:42 +0200
Message-ID: <1302870582-14958-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/trigger/iio-trig-sysfs.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c b/drivers/staging/iio/trigger/iio-trig-sysfs.c
index 5cd55ac..6d3dee3 100644
--- a/drivers/staging/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
@@ -134,7 +134,6 @@ static int iio_sysfs_trigger_probe(int id)
 	t->id = id;
 	t->trig = iio_allocate_trigger_named(name);
 	if (!t->trig) {
-		kfree(name);
 		ret = -ENOMEM;
 		goto free_t;
 	}
-- 
1.6.0.2
