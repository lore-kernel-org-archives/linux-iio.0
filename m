Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com, jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, stable@kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 5/6] IIO: IMU: ADIS16400: Fix product ID check, skip embedded revision number
Date: Mon, 21 Mar 2011 16:44:39 +0100
Message-ID: <1300722280-10720-5-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1300722280-10720-1-git-send-email-michael.hennerich@analog.com>
References: <1300722280-10720-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16400_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 2107edb..0d8df62 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -469,7 +469,7 @@ static int adis16400_initial_setup(struct adis16400_state *st)
 	if (ret)
 		goto err_ret;

-	if (prod_id != ADIS16400_PRODUCT_ID_DEFAULT)
+	if ((prod_id & 0xF000) != ADIS16400_PRODUCT_ID_DEFAULT)
 		dev_warn(dev, "unknown product id");

 	printk(KERN_INFO DRIVER_NAME ": prod_id 0x%04x at CS%d (irq %d)\n",
--
1.6.0.2
