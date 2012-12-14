Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40037 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945Ab2LNHzi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Dec 2012 02:55:38 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2182336pbc.19
        for <linux-iio@vger.kernel.org>; Thu, 13 Dec 2012 23:55:38 -0800 (PST)
Message-ID: <1355471733.11297.11.camel@phoenix>
Subject: [PATCH 6/6] iio: dac: ad5791: Don't set error code to
 [pos|neg]_voltage_uv
From: Axel Lin <axel.lin@ingics.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 14 Dec 2012 15:55:33 +0800
In-Reply-To: <1355471245.11297.1.camel@phoenix>
References: <1355471245.11297.1.camel@phoenix>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

regulator_get_voltage() may return negative error code.
Don't set error code to to pos_voltage_uv and neg_voltage_uv.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/iio/dac/ad5791.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 2bd2e37..6efe83e 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -365,7 +365,11 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 		if (ret)
 			goto error_put_reg_pos;
 
-		pos_voltage_uv = regulator_get_voltage(st->reg_vdd);
+		ret = regulator_get_voltage(st->reg_vdd);
+		if (ret < 0)
+			goto error_disable_reg_pos;
+
+		pos_voltage_uv = ret;
 	}
 
 	st->reg_vss = regulator_get(&spi->dev, "vss");
@@ -374,7 +378,11 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 		if (ret)
 			goto error_put_reg_neg;
 
-		neg_voltage_uv = regulator_get_voltage(st->reg_vss);
+		ret = regulator_get_voltage(st->reg_vss);
+		if (ret < 0)
+			goto error_disable_reg_neg;
+
+		neg_voltage_uv = ret;
 	}
 
 	st->pwr_down = true;
@@ -428,6 +436,7 @@ error_put_reg_neg:
 	if (!IS_ERR(st->reg_vss))
 		regulator_put(st->reg_vss);
 
+error_disable_reg_pos:
 	if (!IS_ERR(st->reg_vdd))
 		regulator_disable(st->reg_vdd);
 error_put_reg_pos:
-- 
1.7.9.5



