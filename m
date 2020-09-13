Return-Path: <SRS0=2qef=CW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378E1C43461
	for <linux-iio@archiver.kernel.org>; Sun, 13 Sep 2020 13:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2757221E2
	for <linux-iio@archiver.kernel.org>; Sun, 13 Sep 2020 13:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600003403;
	bh=0MH5RLcV90CpGM/tGn4yY/SACOinQCFTbq2WtuYgwDU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=KUKZE6JRN+Qme0reUO9eDoOGRp3D4cxiKdZHbR85BL5eqpo/pxkRmMyx+BIl0WT1q
	 PsyCDWsSR9FQDjd8Mg1MFnPW1eOIj8zHDIJq/OIIUdHA1NYcAQ5Qx/S2njwUqeLRuF
	 0WW83WI4te/+OPO1+gP38XGaA/lAmJCzsqA11oJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgIMNXU (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Sep 2020 09:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgIMNXT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 09:23:19 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A01502158C;
        Sun, 13 Sep 2020 13:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600003399;
        bh=0MH5RLcV90CpGM/tGn4yY/SACOinQCFTbq2WtuYgwDU=;
        h=From:To:Cc:Subject:Date:From;
        b=axy8m2tlQ/MA+rlCXQfzFOKCZ/qO6xqxEMm90QCL6ByawCQrUnzL3oSNCZ3rZBRgC
         eJoCEkh76KgTeXPEHL+vkzMv7MDR7c6z+mOHA8U0vbKsxU9N2MXAgazJCFlW9eJP+b
         Cx2rkF0XNeJndT5ByNmgR91rhjIKYGNXAwcGKxRg=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/3] IIO get to warning free for W=1 C=1
Date:   Sun, 13 Sep 2020 14:21:12 +0100
Message-Id: <20200913132115.800131-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi All,

Lee did most of the leg work for this last cycle, but there were a few
things left.  This set only gets us to warning free if we also have the
half dozen more significant fixes on the mailing list, remains of Lee's
early 2 patch sets and
[PATCH] kernel-doc: add support for ____cacheline_aligned attribute

I have a local version of the left over parts of Lee's series with the
____cacheline_aligned bits dropped but see no reason to waste review
bandwidth by posting that again.  Assuming the above patch is accepted
I'll apply those directly to the togreg branch and reply to the original
thread.

Note of course that this is warning free on my particular setup with
gcc x86_64 10.2 on other peoples particular configurations there
may still be warnings. If there are let me know or send a fix!

I have also deliberately not cleaned up the warnings in the drivers still
in staging as they make good tasks for people new to sending patches.

Jonathan Cameron (3):
  iio:imu:adis16400: Sort out missing kernel doc.
  iio: Add __printf() attributes to various allocation functions
  iio:core: Tidy up kernel-doc.

 drivers/iio/imu/adis16400.c          | 2 ++
 drivers/iio/industrialio-core.c      | 3 ++-
 drivers/iio/industrialio-trigger.c   | 2 +-
 include/linux/iio/iio.h              | 4 ++--
 include/linux/iio/trigger_consumer.h | 2 +-
 5 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.28.0

