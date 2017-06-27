Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36178 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdF0AZt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jun 2017 20:25:49 -0400
Received: by mail-pf0-f173.google.com with SMTP id q86so7765726pfl.3
        for <linux-iio@vger.kernel.org>; Mon, 26 Jun 2017 17:25:49 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] iio: magnetometer: Only declare ACPI table when ACPI is enable
Date: Mon, 26 Jun 2017 17:25:33 -0700
Message-Id: <20170627002533.97293-1-mka@chromium.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Don't inflate the kernel size with data that isn't used. The conditional
declaration also fixes the following warning when building with clang:

drivers/iio/magnetometer/ak8975.c:704:36: error: variable 'ak_acpi_match'
  is not needed and will not be emitted
  [-Werror,-Wunneeded-internal-declaration]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/iio/magnetometer/ak8975.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 825369fb1c57..4ff883942f7b 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -784,6 +784,7 @@ static const struct iio_info ak8975_info = {
 	.driver_module = THIS_MODULE,
 };
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id ak_acpi_match[] = {
 	{"AK8975", AK8975},
 	{"AK8963", AK8963},
@@ -793,6 +794,7 @@ static const struct acpi_device_id ak_acpi_match[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
+#endif
 
 static const char *ak8975_match_acpi_device(struct device *dev,
 					    enum asahi_compass_chipset *chipset)
-- 
2.13.1.611.g7e3b11ae1-goog

