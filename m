Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C165C433ED
	for <linux-iio@archiver.kernel.org>; Sat,  8 May 2021 18:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175D3611CE
	for <linux-iio@archiver.kernel.org>; Sat,  8 May 2021 18:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhEHSZe (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 8 May 2021 14:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhEHSZe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 May 2021 14:25:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E6A0611F0;
        Sat,  8 May 2021 18:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620498272;
        bh=o6AcEC5gZ9R0JeyIyFwtu2+y4zcToKFUsojaGZ+iB4s=;
        h=From:To:Cc:Subject:Date:From;
        b=YZc3hLNXiQrxCaTI2TUWHCzyqdNSlTv8tQlYgU5m9TQZWEKcz1xc25RqKYMQujz5G
         lMUtTljbXpOzCVITAz3pI7ZS3Gip0P5MgjJo/N+6b6GCKpjvoeBO1zp4mwq+q2CSDE
         t2+WqZ9JbH1q1/ZwZDFnyxAE4YXjoR2RjHmWys62jrhsWdI6Jmry77lctNw4j/0Cne
         Z5XcXqt/HK54BoB2PPYXKAOiH0Go8teWydYrIOEa9AWPDZ0truucXvkNj2QIAjC8tP
         baSHEbaea92orXVrTSPtWFBTIBtutlb6ZphHzh/sZsxIMz0xbF5WZNJxgguxyPDXJn
         nKd5KM11D+fxQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>, alexandru.tachici@analog.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/3] iio: adc: ad7124: Fixes and devm_ for all of probe
Date:   Sat,  8 May 2021 19:23:16 +0100
Message-Id: <20210508182319.488551-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I noticed an issue around regulator error handling and managed to
hit another with my hacked together test setup.  Hence let's fix
those two issues first then we might as well follow up by converting
the last few bits of this driver to use device managed functions so
we can simplify the error handling and cleanup.

Testing conducted with QEMU hacking and insertion of errors at relevant
locations in the code.

Jonathan Cameron (3):
  iio: adc: ad7124: Fix missbalanced regulator enable / disable on
    error.
  iio: adc: ad7124: Fix potential overflow due to non sequential channel
    numbers
  iio: adc: ad7124: Use devm_ managed calls for all of probe() + drop
    remove()

 drivers/iio/adc/ad7124.c | 89 ++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 45 deletions(-)

-- 
2.31.1

