Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39201 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935301AbcKJTkx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Nov 2016 14:40:53 -0500
Date: Thu, 10 Nov 2016 22:39:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] iio: cros_ec_sensors_core: signedness bug in
 cros_ec_sensors_read_lpc()
Message-ID: <20161110193957.GA18347@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

"status" is a u8 so checking for negatives doesn't work.  We can just
use "ret" here instead.

Fixes: 974e6f02e27e ("iio: cros_ec_sensors_core: Add common functions for the ChromeOS EC Sensor Hub.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

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
