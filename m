Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F24C433EF
	for <linux-iio@archiver.kernel.org>; Thu, 24 Mar 2022 11:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346345AbiCXLHl (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 24 Mar 2022 07:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347198AbiCXLHk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Mar 2022 07:07:40 -0400
X-Greylist: delayed 183 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 04:06:06 PDT
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [221.176.66.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55AF79A9BA
        for <linux-iio@vger.kernel.org>; Thu, 24 Mar 2022 04:06:05 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.85])
        by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7623c4fe2745-65e38;
        Thu, 24 Mar 2022 19:03:00 +0800 (CST)
X-RM-TRANSID: 2ee7623c4fe2745-65e38
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.97])
        by rmsmtp-syy-appsvrnew03-12028 (RichMail) with SMTP id 2efc623c4fdda26-ac1c3;
        Thu, 24 Mar 2022 19:02:59 +0800 (CST)
X-RM-TRANSID: 2efc623c4fdda26-ac1c3
From:   jianchunfu <jianchunfu@cmss.chinamobile.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
Subject: [PATCH] tools:iio: Fix the potential stack overflow risk
Date:   Thu, 24 Mar 2022 19:01:57 +0800
Message-Id: <20220324110157.13143-1-jianchunfu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add judgment to fix the potential stack overflow risk.

Signed-off-by: jianchunfu <jianchunfu@cmss.chinamobile.com>
---
 tools/iio/iio_generic_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 2491c54a5..733fc21c2 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -487,6 +487,10 @@ int main(int argc, char **argv)
 			return -ENOMEM;
 		}
 		trigger_name = malloc(IIO_MAX_NAME_LENGTH);
+		if (!trigger_name) {
+			ret = -ENOMEM;
+			goto error;
+		}
 		ret = read_sysfs_string("name", trig_dev_name, trigger_name);
 		free(trig_dev_name);
 		if (ret < 0) {
-- 
2.18.4



