Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45800 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933535AbdC3Prp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Mar 2017 11:47:45 -0400
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: jic23@kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcin Niestroj <m.niestroj@grinn-global.com>,
        Rob Herring <rob@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] iio: st_pressure: initialize lps22hb bootime
Date: Thu, 30 Mar 2017 23:47:21 +0800
Message-Id: <20170330154723.9612-1-shrirang.bagul@canonical.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch initializes the bootime in struct st_sensor_settings for
lps22hb sensor. Without this, sensor channels read from sysfs always
report stale values.

Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
---
 drivers/iio/pressure/st_pressure_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 5f26808..fd0edca 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -457,6 +457,7 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
 		},
 		.multi_read_bit = true,
+		.bootime = 2,
 	},
 };
 
-- 
2.9.3

