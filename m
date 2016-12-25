Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36167 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932760AbcLYTm3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Dec 2016 14:42:29 -0500
Received: by mail-oi0-f65.google.com with SMTP id u15so43032297oie.3
        for <linux-iio@vger.kernel.org>; Sun, 25 Dec 2016 11:42:29 -0800 (PST)
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
Subject: [PATCHv4 5/8] Remove line after closing braces
Date: Sun, 25 Dec 2016 13:41:09 -0600
Message-Id: <1482694902-7400-6-git-send-email-scott@matheina.com>
In-Reply-To: <1482694902-7400-1-git-send-email-scott@matheina.com>
References: <1482694902-7400-1-git-send-email-scott@matheina.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There was an additional line which was un-needed, removed that line.

Signed-off-by: Scott Matheina <scott@matheina.com>
---
 drivers/staging/iio/addac/adt7316.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index e78d302..4678a64 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -434,7 +434,6 @@ static ssize_t adt7316_store_ad_channel(struct device *dev,
 		config2 = chip->config2 & (~ADT7316_AD_SINGLE_CH_MASK);
 	}
 
-
 	config2 |= data;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
-- 
2.7.4

