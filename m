Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821E7C43461
	for <linux-iio@archiver.kernel.org>; Sat,  8 May 2021 18:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AF7561249
	for <linux-iio@archiver.kernel.org>; Sat,  8 May 2021 18:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhEHSZj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 8 May 2021 14:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhEHSZi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 May 2021 14:25:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8901D611F1;
        Sat,  8 May 2021 18:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620498277;
        bh=YFu5qLBoHuMq0a+gUKgwrvIxd0Z4E24hZmQnyzuOkzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bu4Ci8cdREZQqXGiJH4soCNpq/PbbfpAr4KVAeH5Ss+MQ6Gxi2QzeeShSiqCaIW4H
         vbGjWsJindzTSGmv/fGuwYnsugriRbwXKNqgrt/VDKkvIQNRQTFv4wqFbegHHq//HG
         3uF21WupJYw5GWAaCZYihIYmoUmEl0hdL1EOhwnUft22fRMnC2XF95UdYtpY7jxplv
         FwrKp6U4GBSMesb7eRd5AsbVQMgDo3Otjfb+EgLsZWkQ6WUUP9W6fedLniCTVM7FFD
         dkhyTT/v2U/YiNIaV5oW7iJClHHgEDX6/L6UXt7zJpOm48Vf0YQzTnUW7ePIwYuQV4
         UwGO036dYO9Og==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>, alexandru.tachici@analog.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/3] iio: adc: ad7124: Fix potential overflow due to non sequential channel numbers
Date:   Sat,  8 May 2021 19:23:18 +0100
Message-Id: <20210508182319.488551-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210508182319.488551-1-jic23@kernel.org>
References: <20210508182319.488551-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Channel numbering must start at 0 and then not have any holes, or
it is possible to overflow the available storage.  Note this bug was
introduced as part of a fix to ensure we didn't rely on the ordering
of child nodes.  So we need to support arbitrary ordering but they all
need to be there somewhere.

Note I hit this when using qemu to test the rest of this series.
Arguably this isn't the best fix, but it is probably the most minimal
option for backporting etc.

Fixes: d7857e4ee1ba6 ("iio: adc: ad7124: Fix DT channel configuration")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7124.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index c0d0870a29ff..9c2401c5848e 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -616,6 +616,13 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 		if (ret)
 			goto err;
 
+		if (channel >= indio_dev->num_channels) {
+			dev_err(indio_dev->dev.parent,
+				"Channel index >= number of channels\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
 		ret = of_property_read_u32_array(child, "diff-channels",
 						 ain, 2);
 		if (ret)
-- 
2.31.1

