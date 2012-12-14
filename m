Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:48169 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491Ab2LNHyK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Dec 2012 02:54:10 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1331250dak.19
        for <linux-iio@vger.kernel.org>; Thu, 13 Dec 2012 23:54:09 -0800 (PST)
Message-ID: <1355471644.11297.9.camel@phoenix>
Subject: [PATCH 5/6] iio: dac: ad5686: Don't set error code to voltage_uv
From: Axel Lin <axel.lin@ingics.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 14 Dec 2012 15:54:04 +0800
In-Reply-To: <1355471245.11297.1.camel@phoenix>
References: <1355471245.11297.1.camel@phoenix>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

regulator_get_voltage() may return negative error code.
Add error checking to avoid setting error code to voltage_uv.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/iio/dac/ad5686.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index bc92ff9..28f2e59 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -332,7 +332,11 @@ static int __devinit ad5686_probe(struct spi_device *spi)
 		if (ret)
 			goto error_put_reg;
 
-		voltage_uv = regulator_get_voltage(st->reg);
+		ret = regulator_get_voltage(st->reg);
+		if (ret)
+			goto error_disable_reg;
+
+		voltage_uv = ret;
 	}
 
 	st->chip_info =
-- 
1.7.9.5



