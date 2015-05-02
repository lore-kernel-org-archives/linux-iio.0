Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?= <vianney.leclement@essensium.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio:temp:mlx90614 trivial drop of unnecessary ret return from write_raw.
Date: Sat,  2 May 2015 11:35:02 +0100
Message-Id: <1430562902-28068-1-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

This is mostly part of an effort to clean out our current warnings
and make the autobuilder build reports more useful.

Still a worthwhile if trivial cleanup!

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/temperature/mlx90614.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index b2d3b56f1260..cb2e8ad8bfdc 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -254,9 +254,7 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&data->lock);
 		mlx90614_power_put(data);
 
-		if (ret < 0)
-			return ret;
-		return 0;
+		return ret;
 	default:
 		return -EINVAL;
 	}
-- 
2.3.5
