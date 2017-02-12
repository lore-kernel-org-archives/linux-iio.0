Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33251 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdBLHWy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Feb 2017 02:22:54 -0500
From: Derek Robson <robsonde@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Derek Robson <robsonde@gmail.com>
Subject: [PATCH] Staging: iio: impedance-analyzer: ad5933.c - style fix
Date: Sun, 12 Feb 2017 20:22:40 +1300
Message-Id: <20170212072240.30147-1-robsonde@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Change permissions to octal style.
Found using checkpatch

Signed-off-by: Derek Robson <robsonde@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 5e96352fa4ac..297665d3fe11 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -345,12 +345,12 @@ static ssize_t ad5933_store_frequency(struct device *dev,
 	return ret ? ret : len;
 }
 
-static IIO_DEVICE_ATTR(out_voltage0_freq_start, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(out_voltage0_freq_start, 0644,
 			ad5933_show_frequency,
 			ad5933_store_frequency,
 			AD5933_REG_FREQ_START);
 
-static IIO_DEVICE_ATTR(out_voltage0_freq_increment, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(out_voltage0_freq_increment, 0644,
 			ad5933_show_frequency,
 			ad5933_store_frequency,
 			AD5933_REG_FREQ_INC);
@@ -469,32 +469,32 @@ static ssize_t ad5933_store(struct device *dev,
 	return ret ? ret : len;
 }
 
-static IIO_DEVICE_ATTR(out_voltage0_scale, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(out_voltage0_scale, 0644,
 			ad5933_show,
 			ad5933_store,
 			AD5933_OUT_RANGE);
 
-static IIO_DEVICE_ATTR(out_voltage0_scale_available, S_IRUGO,
+static IIO_DEVICE_ATTR(out_voltage0_scale_available, 0444,
 			ad5933_show,
 			NULL,
 			AD5933_OUT_RANGE_AVAIL);
 
-static IIO_DEVICE_ATTR(in_voltage0_scale, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(in_voltage0_scale, 0644,
 			ad5933_show,
 			ad5933_store,
 			AD5933_IN_PGA_GAIN);
 
-static IIO_DEVICE_ATTR(in_voltage0_scale_available, S_IRUGO,
+static IIO_DEVICE_ATTR(in_voltage0_scale_available, 0444,
 			ad5933_show,
 			NULL,
 			AD5933_IN_PGA_GAIN_AVAIL);
 
-static IIO_DEVICE_ATTR(out_voltage0_freq_points, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(out_voltage0_freq_points, 0644,
 			ad5933_show,
 			ad5933_store,
 			AD5933_FREQ_POINTS);
 
-static IIO_DEVICE_ATTR(out_voltage0_settling_cycles, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(out_voltage0_settling_cycles, 0644,
 			ad5933_show,
 			ad5933_store,
 			AD5933_OUT_SETTLING_CYCLES);
-- 
2.11.1

