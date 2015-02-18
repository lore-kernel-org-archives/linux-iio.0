Return-Path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Karol Wrona <k.wrona@samsung.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] iio: common: ssp_sensors: Protect PM-only functions to kill warning
Date: Wed, 18 Feb 2015 12:39:46 +0100
Message-Id: <1424259586-29334-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

If CONFIG_PM_SLEEP=n:

    drivers/iio/common/ssp_sensors/ssp_dev.c:644: warning: ‘ssp_suspend’ defined but not used
    drivers/iio/common/ssp_sensors/ssp_dev.c:669: warning: ‘ssp_resume’ defined but not used

Protect the unused functions by #ifdef CONFIG_PM_SLEEP to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Fix driver name in one-line summary
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 52d70435f5a11c55..55a90082a29bd484 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -640,6 +640,7 @@ static int ssp_remove(struct spi_device *spi)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int ssp_suspend(struct device *dev)
 {
 	int ret;
@@ -688,6 +689,7 @@ static int ssp_resume(struct device *dev)
 
 	return 0;
 }
+#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops ssp_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ssp_suspend, ssp_resume)
-- 
1.9.1
