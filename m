Return-Path: <SRS0=Ip9B=JE=arndb.de=arnd@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: y2038@lists.linaro.org,
	Arnd Bergmann <arnd@arndb.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>,
	Matt Fornero <matt.fornero@mathworks.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: use timespec64 based interfaces for iio_get_time_ns()
Date: Mon, 18 Jun 2018 17:31:36 +0200
Message-Id: <20180618153153.1903178-1-arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

We have replacements for all the deprecated timespec based interfaces now,
so this can finally convert iio_get_time_ns() to consistently use the
nanosecond or timespec64 based interfaces instead, avoiding the y2038
overflow.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/industrialio-core.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 19bdf3d2962a..fcbe92c34a3d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -207,35 +207,27 @@ static int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
  */
 s64 iio_get_time_ns(const struct iio_dev *indio_dev)
 {
-	struct timespec tp;
+	struct timespec64 tp;
 
 	switch (iio_device_get_clock(indio_dev)) {
 	case CLOCK_REALTIME:
-		ktime_get_real_ts(&tp);
-		break;
+		return ktime_get_real_ns();
 	case CLOCK_MONOTONIC:
-		ktime_get_ts(&tp);
-		break;
+		return ktime_get_ns();
 	case CLOCK_MONOTONIC_RAW:
-		getrawmonotonic(&tp);
-		break;
+		return ktime_get_raw_ns();
 	case CLOCK_REALTIME_COARSE:
-		tp = current_kernel_time();
-		break;
+		return ktime_to_ns(ktime_get_coarse_real());
 	case CLOCK_MONOTONIC_COARSE:
-		tp = get_monotonic_coarse();
-		break;
+		ktime_get_coarse_ts64(&tp);
+		return timespec64_to_ns(&tp);
 	case CLOCK_BOOTTIME:
-		get_monotonic_boottime(&tp);
-		break;
+		return ktime_get_boot_ns();
 	case CLOCK_TAI:
-		timekeeping_clocktai(&tp);
-		break;
+		return ktime_get_tai_ns();
 	default:
 		BUG();
 	}
-
-	return timespec_to_ns(&tp);
 }
 EXPORT_SYMBOL(iio_get_time_ns);
 
-- 
2.9.0
