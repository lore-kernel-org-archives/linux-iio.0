Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBDFCD4941
	for <linux-iio@archiver.kernel.org>; Thu, 21 Sep 2023 03:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjIUDQI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Sep 2023 23:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjIUDQH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Sep 2023 23:16:07 -0400
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Sep 2023 20:15:58 PDT
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB96ED;
        Wed, 20 Sep 2023 20:15:58 -0700 (PDT)
Received: from ssh248.corpemail.net
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id QCJ00047;
        Thu, 21 Sep 2023 11:14:47 +0800
Received: from localhost.localdomain (10.180.205.246) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.32; Thu, 21 Sep 2023 11:14:47 +0800
From:   Andy Shen Shen <shengaoya@inspur.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andy Shen Shen <shengaoya@inspur.com>
Subject: [PATCH] iio: adc: for kernel comment
Date:   Thu, 21 Sep 2023 11:14:44 +0800
Message-ID: <20230921031444.63594-1-shengaoya@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.180.205.246]
tUid:   20239211114473753a10c5d5c4983b2e6654ef98be0c0
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In line 460 of the palmas_gpadc.c file, fix kernel comment errors.

Signed-off-by: Andy Shen Shen <shengaoya@inspur.com>
---
 drivers/iio/adc/palmas_gpadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index e202ea18af10..203cbbc70719 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -457,7 +457,7 @@ static int palmas_gpadc_get_calibrated_code(struct palmas_gpadc *adc,
  *
  * The gain error include both gain error, as specified in the datasheet, and
  * the gain error drift. These paramenters vary depending on device and whether
- * the the channel is calibrated (trimmed) or not.
+ * the channel is calibrated (trimmed) or not.
  */
 static int palmas_gpadc_threshold_with_tolerance(int val, const int INL,
 						 const int gain_error,
-- 
2.31.1

