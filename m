Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] iio: cros_ec_sensors_core: fix unsigned compared less than zero on status
Date: Wed,  9 Nov 2016 23:12:31 +0000
Message-Id: <20161109231231.6223-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

status is a u8 hence the check if status is less than zero has no effect.
Fix this by replacing status with int ret so the less than zero compare
will correctly detect errors.

Issue found with static analysis with CoverityScan, CID 1375919

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index a3be799..416cae5 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -291,15 +291,15 @@ int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev,
 			return -EIO;
 
 		/* Read status byte until EC is not busy. */
-		status = cros_ec_sensors_read_until_not_busy(st);
-		if (status < 0)
-			return status;
+		ret = cros_ec_sensors_read_until_not_busy(st);
+		if (ret < 0)
+			return ret;
 
 		/*
 		 * Store the current sample id so that we can compare to the
 		 * sample id after reading the data.
 		 */
-		samp_id = status & EC_MEMMAP_ACC_STATUS_SAMPLE_ID_MASK;
+		samp_id = ret & EC_MEMMAP_ACC_STATUS_SAMPLE_ID_MASK;
 
 		/* Read all EC data, format it, and store it into data. */
 		ret = cros_ec_sensors_read_data_unsafe(indio_dev, scan_mask,
-- 
2.10.2
