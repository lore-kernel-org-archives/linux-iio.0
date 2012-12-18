Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-da0-f45.google.com ([209.85.210.45]:65032 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab2LRDll (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Dec 2012 22:41:41 -0500
Received: by mail-da0-f45.google.com with SMTP id w4so81005dam.32
        for <linux-iio@vger.kernel.org>; Mon, 17 Dec 2012 19:41:40 -0800 (PST)
Message-ID: <1355801617.11880.1.camel@phoenix>
Subject: [PATCH v2] iio: dac: ad5446: Don't set error code to voltage_uv
From: Axel Lin <axel.lin@ingics.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 18 Dec 2012 11:33:37 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

regulator_get_voltage() may return negative error code.
Add error checking to avoid setting error code to voltage_uv.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Sorry. Just found I made the same mistake again.
Here is v2, should check if ret is negative value.
 drivers/iio/dac/ad5446.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 3310cbb..607378f 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -226,7 +226,11 @@ static int __devinit ad5446_probe(struct device *dev, const char *name,
 		if (ret)
 			goto error_put_reg;
 
-		voltage_uv = regulator_get_voltage(reg);
+		ret = regulator_get_voltage(reg);
+		if (ret < 0)
+			goto error_disable_reg;
+
+		voltage_uv = ret;
 	}
 
 	indio_dev = iio_device_alloc(sizeof(*st));
-- 
1.7.9.5



