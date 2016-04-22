Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:27269 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbcDVKFD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Apr 2016 06:05:03 -0400
Date: Fri, 22 Apr 2016 13:04:14 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] iio: light: apds9960: silence uninitialized variable warning
Message-ID: <20160422100414.GG11398@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It causes a static checker warning if we use "buf" on the failure path
so move that inside the if statement.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index a6af56a..fbdd172 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -491,9 +491,10 @@ static int apds9960_read_raw(struct iio_dev *indio_dev,
 		case IIO_INTENSITY:
 			ret = regmap_bulk_read(data->regmap, chan->address,
 					       &buf, 2);
-			if (!ret)
+			if (!ret) {
 				ret = IIO_VAL_INT;
-			*val = le16_to_cpu(buf);
+				*val = le16_to_cpu(buf);
+			}
 			break;
 		default:
 			ret = -EINVAL;
