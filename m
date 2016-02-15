Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	"Andrew F . Davis" <afd@ti.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: health/afe4403: mark suspend/resume functions __maybe_unused
Date: Mon, 15 Feb 2016 10:02:51 +0100
Message-Id: <1455526993-2132098-1-git-send-email-arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

The newly added afe4403 driver implements suspend/resume using the
SIMPLE_DEV_PM_OPS() macro, which leaves out references to the actual
functions when CONFIG_PM is disabled, causing a harmless warning:

health/afe4403.c:509:12: error: 'afe4403_suspend' defined but not used
health/afe4403.c:530:12: error: 'afe4403_resume' defined but not used

This marks the functions as __maybe_unused so we don't get those
warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: eec96d1e2d31 ("iio: health: Add driver for the TI AFE4403 heart monitor")
---
 drivers/iio/health/afe4403.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 91c046e40d2f..88e43f87b926 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -506,7 +506,7 @@ static const struct of_device_id afe4403_of_match[] = {
 MODULE_DEVICE_TABLE(of, afe4403_of_match);
 #endif
 
-static int afe4403_suspend(struct device *dev)
+static int __maybe_unused afe4403_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct afe4403_data *afe = iio_priv(indio_dev);
@@ -527,7 +527,7 @@ static int afe4403_suspend(struct device *dev)
 	return 0;
 }
 
-static int afe4403_resume(struct device *dev)
+static int __maybe_unused afe4403_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct afe4403_data *afe = iio_priv(indio_dev);
-- 
2.7.0
