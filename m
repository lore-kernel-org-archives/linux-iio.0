Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.steuer-voss.de ([85.183.69.95]:51594 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935467AbeF2LPd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jun 2018 07:15:33 -0400
Message-Id: <cd02d632857c0c1e351c86cfe58af023d75c6e86.1530268235.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date: Fri, 29 Jun 2018 10:19:58 +0200
Subject: [PATCH 2/3] IIO: st_sensors_i2c.c: Don't print error on failed ACPI
 match
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If there is a ACPI node for a i2c device but HID/CID doesn't match, there
could still be a ACPI_DT_NAMESPACE_HID / PRP0001 HID entry which is
matched against the i2c device ID table, so don't print an error
message.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/iio/common/st_sensors/st_sensors_i2c.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index b81e48e9f27e..0c1a77f9b08c 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -87,10 +87,9 @@ int st_sensors_match_acpi_device(struct device *dev)
 
 	if (ACPI_HANDLE(dev)) {
 		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
-		if (!acpi_id) {
-			dev_err(dev, "No driver data\n");
+		if (!acpi_id)
 			return -EINVAL;
-		}
+
 		driver_data = acpi_id->driver_data;
 	}
 	return driver_data;
-- 
2.17.1

