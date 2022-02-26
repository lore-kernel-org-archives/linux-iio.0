Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB401C433EF
	for <linux-iio@archiver.kernel.org>; Sat, 26 Feb 2022 17:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiBZRtu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Feb 2022 12:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiBZRtu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Feb 2022 12:49:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B6D27D142
        for <linux-iio@vger.kernel.org>; Sat, 26 Feb 2022 09:49:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64E8660DBD
        for <linux-iio@vger.kernel.org>; Sat, 26 Feb 2022 17:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63CDC340E8;
        Sat, 26 Feb 2022 17:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645897754;
        bh=1OkYZYuIgoRCMnhYZvRSXAQmebHB4Fg/K+A1zy4eck0=;
        h=From:To:Cc:Subject:Date:From;
        b=C8/d+DkWdJtV/77ERjmfaRzy5MDw+7uo/mTLjX3flYAs2A8XC/ODVbIt1XJBTMnxs
         Z6hxlb9t5zvCp2BGgdaDIN8Cr/ip4hNt7/XohUAYqLcrGflFrDaZNv0xnB6Z9GZI9L
         Rf9Vt5FW028BROzbLrZbak4NVGIgIOyJskXRfanmHhjTQPksKznsgU57tN015+7IJD
         ztbemmy7gFoBUBTl7VsT+G5F+wWHkTqi20MBHkbV8TqtTH9yAHttaGdJ9Oug90qGiA
         1dDU5koUGqDheaeS1jbNF+hrPtqLz1uVqGZ2hYdXsBHHOiiAvn3VKExakHnayXYZgC
         c0eXJjxLNZLuQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH] iio: adc: ad7280a: Fix wrong variable used when setting thresholds.
Date:   Sat, 26 Feb 2022 17:56:04 +0000
Message-Id: <20220226175604.662422-1-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Name of variable change missed in refactoring patch.

Fixes: 112bf4aa4afb ("staging:iio:adc:ad7280a: Switch to standard event control")
Reported-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---

Note that the fixes tag may not be stable. I'll update when applying if
it has changed.

 drivers/iio/adc/ad7280a.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index ef9d27759961..ec9acbf12b9a 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -745,7 +745,7 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 		case IIO_EV_DIR_RISING:
 			addr = AD7280A_CELL_OVERVOLTAGE_REG;
 			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
-					   1, val);
+					   1, value);
 			if (ret)
 				break;
 			st->cell_threshhigh = value;
@@ -753,7 +753,7 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 		case IIO_EV_DIR_FALLING:
 			addr = AD7280A_CELL_UNDERVOLTAGE_REG;
 			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
-					   1, val);
+					   1, value);
 			if (ret)
 				break;
 			st->cell_threshlow = value;
@@ -770,18 +770,18 @@ static int ad7280a_write_thresh(struct iio_dev *indio_dev,
 		case IIO_EV_DIR_RISING:
 			addr = AD7280A_AUX_ADC_OVERVOLTAGE_REG;
 			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
-					   1, val);
+					   1, value);
 			if (ret)
 				break;
-			st->aux_threshhigh = val;
+			st->aux_threshhigh = value;
 			break;
 		case IIO_EV_DIR_FALLING:
 			addr = AD7280A_AUX_ADC_UNDERVOLTAGE_REG;
 			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
-					   1, val);
+					   1, value);
 			if (ret)
 				break;
-			st->aux_threshlow = val;
+			st->aux_threshlow = value;
 			break;
 		default:
 			ret = -EINVAL;
-- 
2.35.1

