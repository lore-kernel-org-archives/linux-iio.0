Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39253 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeCEHt7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Mar 2018 02:49:59 -0500
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 02/11] Staging: iio: accel: Add a blank space before returns
Date: Mon,  5 Mar 2018 13:19:21 +0530
Message-Id: <1520236170-14668-3-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adding a blank space before/after some returns improves readability.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 0f6a204..0fae8aa 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -232,6 +232,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		*val = val16;
 		return IIO_VAL_INT;
 	}
+
 	return -EINVAL;
 }
 
@@ -262,6 +263,7 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
 		addr = adis16201_addresses[chan->scan_index];
 		return adis_write_reg_16(st, addr, val16);
 	}
+
 	return -EINVAL;
 }
 
@@ -336,6 +338,7 @@ static int adis16201_probe(struct spi_device *spi)
 	ret = adis_init(st, indio_dev, spi, &adis16201_data);
 	if (ret)
 		return ret;
+
 	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
 	if (ret)
 		return ret;
@@ -348,6 +351,7 @@ static int adis16201_probe(struct spi_device *spi)
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
 		goto error_cleanup_buffer_trigger;
+
 	return 0;
 
 error_cleanup_buffer_trigger:
-- 
2.7.4

