Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32930 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932566AbcLYTmJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Dec 2016 14:42:09 -0500
Received: by mail-oi0-f68.google.com with SMTP id f201so43085539oib.0
        for <linux-iio@vger.kernel.org>; Sun, 25 Dec 2016 11:42:09 -0800 (PST)
From: Scott Matheina <scott@matheina.com>
To: linux-kernel@vger.kernel.org
Cc: Scott Matheina <scott@matheina.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCHv4 1/8] fixed long description text exceeding 80 characters
Date: Sun, 25 Dec 2016 13:41:05 -0600
Message-Id: <1482694902-7400-2-git-send-email-scott@matheina.com>
In-Reply-To: <1482694902-7400-1-git-send-email-scott@matheina.com>
References: <1482694902-7400-1-git-send-email-scott@matheina.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The description was split into 2 lines due to the line greatly
exceeding the 80 character soft limit.

Signed-off-by: Scott Matheina <scott@matheina.com>
---
 drivers/staging/iio/addac/adt7316.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index a7d90c8..08413a8 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2181,5 +2181,6 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 EXPORT_SYMBOL(adt7316_probe);
 
 MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
-MODULE_DESCRIPTION("Analog Devices ADT7316/7/8 and ADT7516/7/9 digital temperature sensor, ADC and DAC driver");
+MODULE_DESCRIPTION("Analog Devices ADT7316/7/8 and ADT7516/7/9 digital\n"
+		   "temperature sensor, ADC and DAC driver");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4

