Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34960 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023Ab2LNMHw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Dec 2012 07:07:52 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so2384050pad.19
        for <linux-iio@vger.kernel.org>; Fri, 14 Dec 2012 04:07:52 -0800 (PST)
Message-ID: <1355486867.3475.3.camel@phoenix>
Subject: [PATCH v2 4/6] iio: dac: ad5624r_spi: Don't set error code to
 voltage_uv
From: Axel Lin <axel.lin@ingics.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 14 Dec 2012 20:07:47 +0800
In-Reply-To: <1355486789.3475.1.camel@phoenix>
References: <1355486789.3475.1.camel@phoenix>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

regulator_get_voltage() may return negative error code.
Add error checking to avoid setting error code to voltage_uv.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
v2: check if ret is negative value
 drivers/iio/dac/ad5624r_spi.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index 6a7d6a4..ae7fb64 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -238,7 +238,11 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
 		if (ret)
 			goto error_put_reg;
 
-		voltage_uv = regulator_get_voltage(st->reg);
+		ret = regulator_get_voltage(st->reg);
+		if (ret < 0)
+			goto error_disable_reg;
+
+		voltage_uv = ret;
 	}
 
 	spi_set_drvdata(spi, indio_dev);
-- 
1.7.9.5



