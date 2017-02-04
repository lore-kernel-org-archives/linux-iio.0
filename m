Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36167 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbdBDBqf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2017 20:46:35 -0500
From: Derek Robson <robsonde@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Derek Robson <robsonde@gmail.com>
Subject: [PATCH] Staging: iio: resolver: ad2s1210.c - style fix
Date: Sat,  4 Feb 2017 14:45:41 +1300
Message-Id: <20170204014541.30023-1-robsonde@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changed symbolic permissions to octal permissions.
Found using checkpatch

Signed-off-by: Derek Robson <robsonde@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 6b992634f009..90b57c03609c 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -531,36 +531,36 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(fclkin, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(fclkin, 0644,
 		       ad2s1210_show_fclkin, ad2s1210_store_fclkin, 0);
-static IIO_DEVICE_ATTR(fexcit, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(fexcit, 0644,
 		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
-static IIO_DEVICE_ATTR(control, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(control, 0644,
 		       ad2s1210_show_control, ad2s1210_store_control, 0);
-static IIO_DEVICE_ATTR(bits, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(bits, 0644,
 		       ad2s1210_show_resolution, ad2s1210_store_resolution, 0);
-static IIO_DEVICE_ATTR(fault, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(fault, 0644,
 		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
 
-static IIO_DEVICE_ATTR(los_thrd, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(los_thrd, 0644,
 		       ad2s1210_show_reg, ad2s1210_store_reg,
 		       AD2S1210_REG_LOS_THRD);
-static IIO_DEVICE_ATTR(dos_ovr_thrd, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(dos_ovr_thrd, 0644,
 		       ad2s1210_show_reg, ad2s1210_store_reg,
 		       AD2S1210_REG_DOS_OVR_THRD);
-static IIO_DEVICE_ATTR(dos_mis_thrd, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(dos_mis_thrd, 0644,
 		       ad2s1210_show_reg, ad2s1210_store_reg,
 		       AD2S1210_REG_DOS_MIS_THRD);
-static IIO_DEVICE_ATTR(dos_rst_max_thrd, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(dos_rst_max_thrd, 0644,
 		       ad2s1210_show_reg, ad2s1210_store_reg,
 		       AD2S1210_REG_DOS_RST_MAX_THRD);
-static IIO_DEVICE_ATTR(dos_rst_min_thrd, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(dos_rst_min_thrd, 0644,
 		       ad2s1210_show_reg, ad2s1210_store_reg,
 		       AD2S1210_REG_DOS_RST_MIN_THRD);
-static IIO_DEVICE_ATTR(lot_high_thrd, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(lot_high_thrd, 0644,
 		       ad2s1210_show_reg, ad2s1210_store_reg,
 		       AD2S1210_REG_LOT_HIGH_THRD);
-static IIO_DEVICE_ATTR(lot_low_thrd, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(lot_low_thrd, 0644,
 		       ad2s1210_show_reg, ad2s1210_store_reg,
 		       AD2S1210_REG_LOT_LOW_THRD);
 
-- 
2.11.1

