Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:37034 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbeIOXCU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Sep 2018 19:02:20 -0400
From: ryang <decatf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ryang <decatf@gmail.com>
Subject: [PATCH 2/2] iio: light: bh1750: Add device tree support
Date: Sat, 15 Sep 2018 13:42:14 -0400
Message-Id: <387c145949692c0318f90d98426be95c82ea2e58.1537033044.git.decatf@gmail.com>
In-Reply-To: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
References: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
In-Reply-To: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
References: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add device tree support for ROHM BH1750 series ambient light sensors.

Signed-off-by: ryang <decatf@gmail.com>
---
 drivers/iio/light/bh1750.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index a814828e69f5..50b599abb383 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -315,9 +315,19 @@ static const struct i2c_device_id bh1750_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, bh1750_id);
 
+static const struct of_device_id bh1750_of_match[] = {
+	{ .compatible = "rohm,bh1710", },
+	{ .compatible = "rohm,bh1715", },
+	{ .compatible = "rohm,bh1721", },
+	{ .compatible = "rohm,bh1750", },
+	{ .compatible = "rohm,bh1751", },
+	{ }
+};
+
 static struct i2c_driver bh1750_driver = {
 	.driver = {
 		.name = "bh1750",
+		.of_match_table = of_match_ptr(bh1750_of_match),
 		.pm = BH1750_PM_OPS,
 	},
 	.probe = bh1750_probe,
-- 
2.17.1
