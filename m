Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A383BC25B06
	for <linux-iio@archiver.kernel.org>; Sun, 14 Aug 2022 17:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiHNR3j (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Aug 2022 13:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNR3i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Aug 2022 13:29:38 -0400
X-Greylist: delayed 1732 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 Aug 2022 10:29:35 PDT
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F631EC53
        for <linux-iio@vger.kernel.org>; Sun, 14 Aug 2022 10:29:35 -0700 (PDT)
Received: from ipservice-092-217-070-211.092.217.pools.vodafone-ip.de ([92.217.70.211] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oNGyV-0000Vv-GT; Sun, 14 Aug 2022 19:00:31 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] iio: potentiometer: max5432: use KBUILD_MODNAME as driver name
Date:   Sun, 14 Aug 2022 19:00:16 +0200
Message-Id: <20220814170016.479976-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

KBUILD_MODNAME evaulates to "max5432". Replace the hard coded driver name
with KBUILD_MODNAME.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/iio/potentiometer/max5432.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/max5432.c b/drivers/iio/potentiometer/max5432.c
index aed3b6ab82a2..a970bf9c99a7 100644
--- a/drivers/iio/potentiometer/max5432.c
+++ b/drivers/iio/potentiometer/max5432.c
@@ -121,7 +121,7 @@ MODULE_DEVICE_TABLE(of, max5432_dt_ids);
 
 static struct i2c_driver max5432_driver = {
 	.driver = {
-		.name = "max5432",
+		.name = KBUILD_MODNAME,
 		.of_match_table = max5432_dt_ids,
 	},
 	.probe = max5432_probe,
-- 
2.30.2

