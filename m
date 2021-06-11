Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D65AC48BD1
	for <linux-iio@archiver.kernel.org>; Fri, 11 Jun 2021 15:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2819361400
	for <linux-iio@archiver.kernel.org>; Fri, 11 Jun 2021 15:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhFKP0V (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 11 Jun 2021 11:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhFKP0U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 11:26:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4D07613DE;
        Fri, 11 Jun 2021 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623425062;
        bh=X0RgP0J30vQZb6J/CFFzai416GIShJeuxefxYh44suo=;
        h=From:To:Cc:Subject:Date:From;
        b=o8391QTCfkSbvioQMm4AT3iD6exaE4z268ETeyH2stH8JLo/MrZCixAMf+q6JvkZH
         VQfw45hkSOPBv3ZSAXNXT43wiu1Kx7gFkPS1q9F2UXxBuL9KLqPBlGlnrDKJtiM/Vp
         uhaxTVnHuPd+JvzXqHkZe9FgszV2WOMzoIIwB22GfmSekVbWh4VnBDE2CcSV3VQm49
         0ZtRC43SbLd3zjqmqX0rNQ2mPRRvZNWkB1gYLQ545w0NeVafCZIS+wprpl8wZWG7CJ
         h0cszKs6o6w+ZZ4Lq8H7j1fcYJq2E7rTptEr5PnEFCxsEdiBOHbcFp6mK264u8f6ZU
         Q+HEx+p8RCVwQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Nuno Sa <Nuno.Sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/7] staging:iio: Header cleanup
Date:   Fri, 11 Jun 2021 16:26:07 +0100
Message-Id: <20210611152614.109361-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

0-day recently started giving some reports from the include-what-you-use
tool (needs LLVM builds).

I was curious so decided to give it a spin.  It produces a wealth of
information, but the suggestions require a high degree of interpretation
and some choices are down to personal taste.

This set covers resulting changes that I think make sense for remaining
IIO drivers in staging (which I just noticed are all Analog devices ones :)

Jonathan Cameron (7):
  staging:iio:adc: Cleanup includes
  staging:iio:addac:adt7316: Cleanup includes
  staging:iio:cdc:ad7746: Cleanup includes
  staging:iio:frequency: Cleanup includes
  staging:iio:impedance-analyzer: Cleanup includes
  staging:iio:meter:ade7854: Cleanup includes
  staging:iio:resolver:ad2s1210: Cleanup includes

 drivers/staging/iio/adc/ad7280a.c               | 2 ++
 drivers/staging/iio/adc/ad7816.c                | 3 +--
 drivers/staging/iio/addac/adt7316.c             | 5 -----
 drivers/staging/iio/addac/adt7316.h             | 1 +
 drivers/staging/iio/cdc/ad7746.c                | 6 +++---
 drivers/staging/iio/frequency/ad9832.c          | 3 ++-
 drivers/staging/iio/frequency/ad9834.c          | 6 ++----
 drivers/staging/iio/impedance-analyzer/ad5933.c | 5 ++++-
 drivers/staging/iio/meter/ade7854-i2c.c         | 3 ++-
 drivers/staging/iio/meter/ade7854-spi.c         | 3 ++-
 drivers/staging/iio/meter/ade7854.c             | 4 ----
 drivers/staging/iio/meter/ade7854.h             | 5 +++++
 drivers/staging/iio/resolver/ad2s1210.c         | 5 +++--
 13 files changed, 27 insertions(+), 24 deletions(-)

-- 
2.31.1

