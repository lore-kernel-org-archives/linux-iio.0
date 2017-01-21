Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35227 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdAURDV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 12:03:21 -0500
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] iio: adc: constify iio_info structures
Date: Sat, 21 Jan 2017 22:33:00 +0530
Message-Id: <1485018180-22799-1-git-send-email-bhumirks@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Declare iio_info structures as const as they are only stored in
the info field of a iio_dev structure. This field is of type const,
so iio_info structures having similar properties can be made const too.

File size before:
   text	   data	    bss	    dec	    hex	filename
   6944	    792	      0	   7736	   1e38	drivers/iio/adc/ti-ads1015.o

File size after:
   text   data	    bss	    dec	    hex	filename
   7264	    472	      0	   7736	   1e38	drivers/iio/adc/ti-ads1015.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index cde6f13..422b314 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -472,14 +472,14 @@ static const struct attribute_group ads1115_attribute_group = {
 	.attrs = ads1115_attributes,
 };
 
-static struct iio_info ads1015_info = {
+static const struct iio_info ads1015_info = {
 	.driver_module	= THIS_MODULE,
 	.read_raw	= ads1015_read_raw,
 	.write_raw	= ads1015_write_raw,
 	.attrs          = &ads1015_attribute_group,
 };
 
-static struct iio_info ads1115_info = {
+static const struct iio_info ads1115_info = {
 	.driver_module	= THIS_MODULE,
 	.read_raw	= ads1015_read_raw,
 	.write_raw	= ads1015_write_raw,
-- 
2.7.4

