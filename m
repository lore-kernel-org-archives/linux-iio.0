Return-Path: <SRS0=hUzv=WJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B231CC433FF
	for <linux-iio@archiver.kernel.org>; Tue, 13 Aug 2019 13:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFDB206C2
	for <linux-iio@archiver.kernel.org>; Tue, 13 Aug 2019 13:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfHMNkD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:40:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4681 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728267AbfHMNkC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Aug 2019 09:40:02 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 48912E0C0EC2552A0403;
        Tue, 13 Aug 2019 21:39:38 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Tue, 13 Aug 2019 21:39:29 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <jonathan.cameron@huawei.com>, <linux-iio@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     Martyn Welch <martyn.welch@collabora.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio:light:noa1305: Fix missing break statement.
Date:   Tue, 13 Aug 2019 21:38:51 +0800
Message-ID: <20190813133851.14345-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This got caught by the implicit fall through detection but is
a bug rather than missing marking.

Reported-by: 0-DAY kernel test infrastructure
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: 741172d18e8a ("iio: light: noa1305: Add support for NOA1305")
---
 drivers/iio/light/noa1305.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
index 7b859ae1044d..5ebfbc52f541 100644
--- a/drivers/iio/light/noa1305.c
+++ b/drivers/iio/light/noa1305.c
@@ -85,6 +85,7 @@ static int noa1305_scale(struct noa1305_priv *priv, int *val, int *val2)
 	case NOA1305_INTEGR_TIME_400MS:
 		*val = 100;
 		*val2 = 77 * 4;
+		break;
 	case NOA1305_INTEGR_TIME_200MS:
 		*val = 100;
 		*val2 = 77 * 2;
-- 
2.20.1

