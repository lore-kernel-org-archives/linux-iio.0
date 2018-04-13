Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44641 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbeDMQiD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2018 12:38:03 -0400
Received: by mail-qt0-f196.google.com with SMTP id j26so8625468qtl.11
        for <linux-iio@vger.kernel.org>; Fri, 13 Apr 2018 09:38:02 -0700 (PDT)
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 04/14] staging: iio: ad7746: Fix multiple line dereference
Date: Fri, 13 Apr 2018 13:36:41 -0300
Message-Id: <1523637411-8531-5-git-send-email-hernan@vanguardiasur.com.ar>
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Clear checkpatch.pl WARNING about multiple line derefence but creates a
new one of line over 80 characters. In my opinion, it improves
readability.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index d793785..82fac76 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -410,8 +410,7 @@ static struct attribute *ad7746_attributes[] = {
 	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
 	&iio_dev_attr_in_voltage0_calibscale_calibration.dev_attr.attr,
 	&iio_const_attr_in_voltage_sampling_frequency_available.dev_attr.attr,
-	&iio_const_attr_in_capacitance_sampling_frequency_available.
-	dev_attr.attr,
+	&iio_const_attr_in_capacitance_sampling_frequency_available.dev_attr.attr,
 	NULL,
 };
 
-- 
2.7.4

