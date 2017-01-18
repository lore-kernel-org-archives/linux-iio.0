Return-Path: <SRS0=a6Lu=ZA=gmail.com=amsfield22@kernel.org>
Date: Tue, 17 Jan 2017 19:00:28 -0800
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org
Subject: [PATCH] iio: trigger: free trigger resource correctly
Message-ID: <20170118030016.GA23724@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Using iio_trigger_put() to free a trigger leads to release of
a resource we never held.  Replace with iio_trigger_free().

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
Patches to use devm_* funcs are ready to follow this for
the interrupt & bfin-timer triggers.

 drivers/iio/trigger/iio-trig-interrupt.c          | 4 ++--
 drivers/iio/trigger/iio-trig-sysfs.c              | 2 +-
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
index 572bc6f..b18e50d 100644
--- a/drivers/iio/trigger/iio-trig-interrupt.c
+++ b/drivers/iio/trigger/iio-trig-interrupt.c
@@ -84,7 +84,7 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
 error_free_trig_info:
 	kfree(trig_info);
 error_put_trigger:
-	iio_trigger_put(trig);
+	iio_trigger_free(trig);
 error_ret:
 	return ret;
 }
@@ -99,7 +99,7 @@ static int iio_interrupt_trigger_remove(struct platform_device *pdev)
 	iio_trigger_unregister(trig);
 	free_irq(trig_info->irq, trig);
 	kfree(trig_info);
-	iio_trigger_put(trig);
+	iio_trigger_free(trig);
 
 	return 0;
 }
diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index 3dfab2b..202e8b8 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -174,7 +174,7 @@ static int iio_sysfs_trigger_probe(int id)
 	return 0;
 
 out2:
-	iio_trigger_put(t->trig);
+	iio_trigger_free(t->trig);
 free_t:
 	kfree(t);
 out1:
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 9658f20..4e0b4ee 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -260,7 +260,7 @@ static int iio_bfin_tmr_trigger_probe(struct platform_device *pdev)
 out1:
 	iio_trigger_unregister(st->trig);
 out:
-	iio_trigger_put(st->trig);
+	iio_trigger_free(st->trig);
 	return ret;
 }
 
@@ -273,7 +273,7 @@ static int iio_bfin_tmr_trigger_remove(struct platform_device *pdev)
 		peripheral_free(st->t->pin);
 	free_irq(st->irq, st);
 	iio_trigger_unregister(st->trig);
-	iio_trigger_put(st->trig);
+	iio_trigger_free(st->trig);
 
 	return 0;
 }
-- 
2.1.4
