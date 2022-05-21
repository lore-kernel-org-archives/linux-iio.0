Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F38AC433EF
	for <linux-iio@archiver.kernel.org>; Sat, 21 May 2022 11:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242534AbiEULOk (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 May 2022 07:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354908AbiEULM5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 May 2022 07:12:57 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1AD57B06;
        Sat, 21 May 2022 04:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Pj8CLWvJWySucqqRsGRS5/KgmbYhAg/eJuA1XFa9eQY=;
  b=JhgeavRxxl1FrzcwzttSY4W0TDGF/wBWegsAijcoUZfCvtcOpiyk3Ood
   5YdEktlduBh+GLXtzSyqS+M+NnNp17TNseUr7scWZKT8FPzC/jxNx0s+L
   6HHrqQgqiWwU322sRVT2nyoun3aCkWgTsdIHHXeZK7sKrctchDmKhlQb4
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727975"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:12:04 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: chemical: bme680: fix typo in comment
Date:   Sat, 21 May 2022 13:11:18 +0200
Message-Id: <20220521111145.81697-68-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/iio/chemical/bme680_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 16ff7a98c9f0..ef5e0e46fd34 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -638,7 +638,7 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 	comp_temp = bme680_compensate_temp(data, adc_temp);
 	/*
 	 * val might be NULL if we're called by the read_press/read_humid
-	 * routine which is callled to get t_fine value used in
+	 * routine which is called to get t_fine value used in
 	 * compensate_press/compensate_humid to get compensated
 	 * pressure/humidity readings.
 	 */

