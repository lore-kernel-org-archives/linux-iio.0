Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DBBC77B75
	for <linux-iio@archiver.kernel.org>; Fri, 21 Apr 2023 11:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjDULyy (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 21 Apr 2023 07:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjDULyw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2023 07:54:52 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Apr 2023 04:54:50 PDT
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B96F5240;
        Fri, 21 Apr 2023 04:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1682078088;
        bh=SPAxblZvKKJ5DPvEvp/Zc+WVGLSRgLatTuULry+hGtE=;
        h=From:To:Cc:Subject:Date;
        b=xKS9uWXKkcC/guX9ewhyeCTEc5AWv6Mt75C5GqWEoK4D3DD4NWTrEGwvlr56ydgqo
         o97wozug90LBFraOSuVZreqIQMfJwXAwjzc/1OIL1LjypweqBpFrpX0FYEpnypelSM
         9MBGw0ArHPwjbIVZfk6AdLSxv2zCllQEaOJ+1yeE=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id BDB80A15; Fri, 21 Apr 2023 19:47:27 +0800
X-QQ-mid: xmsmtpt1682077647t18dlrzv3
Message-ID: <tencent_FA682F628E818DD04B96C3E5A94ACFABE206@qq.com>
X-QQ-XMAILINFO: OW4JKxETGMY2qiFAJlCBZ+SJ7xf/loy8yMMJhYceZoAF5W8XZY5rivVQysrZ6p
         SmKhlfX4QXZnf5x4pu0UC4zBy8k6oBn99/yVv/dwbQVXX0CYPVCkCJ4OwmucloFPHkl1inrjQds2
         yju1tPK4/NTjD5eoJQBjDeriJpEVKOezaPbq/2vrQlXTN5uopN75FA0NsgTdjowM1An+GcZ5xfla
         g5a60jP5YJUS0vJoaDbDW1Y624XJQAFKzFktICLmUH1Dmn8F7dc8J4RKn0FIRtMPXDWPs500GWZM
         2clQJbBkkVXuTHZBjenJ56CJq07jKLLIuK9ndupD1opfi31kaTwf97Hlc8H7F0+Oz5opnr0/oKT4
         wLAEkul4X5durZ0fNTztUDN2/VniZU+6URMhrJeDoQ9SjZ0UfJ+KZAojkQ3Ij1nao9ggOUNnHo/H
         wsdiBimf3mEuudP/q/2Z9XHmxfLDNbtK0e85U3VkwBO5cwFtLepvOZ7Jw+UoeC+oW2iwn99VnZmt
         Rx+u1aI7eAFKhqfjHwv4H1m+AWzC7OrCmoDPHTmevpnZK0FurDEoNwIkMqLRLyrAtb1P/0BKM/4I
         nh+F8Ilq5YHLcnZ2uYLpKAYRd//obQpUoBQ6RmG29hTICmNvekhjs4K9ndlmeyWA3tNupyNcUfEq
         MiyTvOXoy3iiHXX3z13tj6KNcsKgvlx0Vfdu0BSU20+3oj2yMxrd4XNw0Z1WD6dfCdhRdu2ycsaq
         DBcw4P7mFe+EIV/Nh4Xr3MleUtbPDsFoxR7KMLzo1prOqXuj1bj3n1WiC0oBn1hFmzU47h70R6Av
         YF/BrLzQNnFOibnWhC2TdTSA3HfKXaXEavZ/WyyB0go5y7bcISrO7o6dvYa7HezkbwNJeZivijs1
         fORfzZcFb14w9Y2LK3WYm5JFTiCI1rNu99SOvGaHmg8tKLgpsGKKWuTbcbf+5J7YB2aQykLCi75w
         rRKn2JB/dVbIn2c+tM/p+vD4JumWOrpRmxHq9PVUY=
From:   Rong Tao <rtoax@foxmail.com>
To:     william.gray@linaro.org
Cc:     rongtao@cestc.cn,
        linux-iio@vger.kernel.org (open list:COUNTER SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tools/counter: Makefile: Remove useless 'include' when make clean
Date:   Fri, 21 Apr 2023 19:47:25 +0800
X-OQ-MSGID: <20230421114725.235671-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

'make' create 'include' directory, we should remove it when 'make clean'.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/counter/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/counter/Makefile b/tools/counter/Makefile
index 8843f0fa6119..e2475a1f10d8 100644
--- a/tools/counter/Makefile
+++ b/tools/counter/Makefile
@@ -39,7 +39,7 @@ $(OUTPUT)counter_example: $(COUNTER_EXAMPLE)
 
 clean:
 	rm -f $(ALL_PROGRAMS)
-	rm -rf $(OUTPUT)include/linux/counter.h
+	rm -rf $(OUTPUT)include
 	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
 
 install: $(ALL_PROGRAMS)
-- 
2.40.0

