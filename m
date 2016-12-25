Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32972 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932708AbcLYTmX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Dec 2016 14:42:23 -0500
Received: by mail-oi0-f68.google.com with SMTP id f201so43085834oib.0
        for <linux-iio@vger.kernel.org>; Sun, 25 Dec 2016 11:42:23 -0800 (PST)
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
Subject: [PATCHv4 4/8] Fix braces not present on all arms of if else statement
Date: Sun, 25 Dec 2016 13:41:08 -0600
Message-Id: <1482694902-7400-5-git-send-email-scott@matheina.com>
In-Reply-To: <1482694902-7400-1-git-send-email-scott@matheina.com>
References: <1482694902-7400-1-git-send-email-scott@matheina.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Adds braces to second arm of if else statement.

Signed-off-by: Scott Matheina <scott@matheina.com>
---
 drivers/staging/iio/addac/adt7316.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 2b584a0..e78d302 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -661,8 +661,9 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
 			chip->dac_bits = 12;
 		else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
 			chip->dac_bits = 10;
-	} else
+	} else {
 		config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
+	}
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
 	if (ret)
-- 
2.7.4

