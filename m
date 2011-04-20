Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO-onwards: TRIGGER: iio-trig-bfin-timer: Fix build issues
Date: Wed, 20 Apr 2011 16:41:43 +0200
Message-ID: <1303310503-4137-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Fix typos
select BFIN_GPTIMERS

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/trigger/Kconfig               |    1 +
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
index c33777e..b8abf54 100644
--- a/drivers/staging/iio/trigger/Kconfig
+++ b/drivers/staging/iio/trigger/Kconfig
@@ -31,6 +31,7 @@ config IIO_SYSFS_TRIGGER
 config IIO_BFIN_TMR_TRIGGER
 	tristate "Blackfin TIMER trigger"
 	depends on BLACKFIN
+	select BFIN_GPTIMERS
 	help
 	  Provides support for using a Blackfin timer as IIO triggers.
 	  If unsure, say N (but it's safe to say "Y").
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 096559d..43b3605 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -116,7 +116,7 @@ static const struct attribute_group iio_bfin_tmr_trigger_attr_group = {
 	.attrs = iio_bfin_tmr_trigger_attrs,
 };
 
-static const sturc attribute_group *iio_bfin_tmr_trigger_attr_groups[] = {
+static const struct attribute_group *iio_bfin_tmr_trigger_attr_groups[] = {
 	&iio_bfin_tmr_trigger_attr_group,
 	NULL
 };
@@ -176,7 +176,7 @@ static int __devinit iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
 
 	st->trig->private_data = st;
 	st->trig->owner = THIS_MODULE;
-	trig->dev.groups = iio_bfin_tmr_trigger_attr_groups;
+	st->trig->dev.groups = iio_bfin_tmr_trigger_attr_groups;
 	ret = iio_trigger_register(st->trig);
 	if (ret)
 		goto out2;
-- 
1.6.0.2
