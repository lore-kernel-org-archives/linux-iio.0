Return-Path: <SRS0=Zetw=CE=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D64EC433E1
	for <linux-iio@archiver.kernel.org>; Wed, 26 Aug 2020 16:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387A1206FA
	for <linux-iio@archiver.kernel.org>; Wed, 26 Aug 2020 16:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598458574;
	bh=muQ+YCp+Vwe8eKdaduBpNI5ws078auP+0FO7/EUefYM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HQxeslx4HW3S9U55jNkgi/J8jySFLZJs/m4kEYoyAMjkfwJRWOH3+a4BODOKGmBgd
	 jqsrM4qXFqJCsShVSEuEDQS96TIV3ZjnorCUP2YP7mCB8EACL4lHtCD8b74GPc10Vc
	 6trvUZ8KQM/eFlJ/Hl/fhNoT3SIEstxk+U3jjm3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgHZQQE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:16:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbgHZQPs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Aug 2020 12:15:48 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FB9D214F1;
        Wed, 26 Aug 2020 16:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598458548;
        bh=muQ+YCp+Vwe8eKdaduBpNI5ws078auP+0FO7/EUefYM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=2RMtokFwNX+WAsnxMSIH4661Ej5NnRs5/t5ku3/QNZkvTtV7G6l+UcH63HvPRXioB
         HHretdDcIXmsOV+c4hIsJnVcLwzzM9m9e1huKm8sl+T5wWE5oKTNl1XBFVqkeqV7mG
         TCpzcKFTSmFL0v1j2VcWCfDCYiwy2/Nzgk3K5Jps=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: magnetometer: iio-mux: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 18:15:39 +0200
Message-Id: <20200826161539.20788-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826161539.20788-1-krzk@kernel.org>
References: <20200826161539.20788-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iio/multiplexer/iio-mux.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 6910218fdb00..d219d4a86657 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -354,11 +354,8 @@ static int mux_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	parent = devm_iio_channel_get(dev, "parent");
-	if (IS_ERR(parent)) {
-		if (PTR_ERR(parent) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get parent channel\n");
-		return PTR_ERR(parent);
-	}
+	if (IS_ERR(parent))
+		return dev_err_probe(dev, PTR_ERR(parent), "failed to get parent channel\n");
 
 	sizeof_ext_info = iio_get_channel_ext_info_count(parent);
 	if (sizeof_ext_info) {
-- 
2.17.1

