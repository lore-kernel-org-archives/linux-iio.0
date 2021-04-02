Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6B7C433B4
	for <linux-iio@archiver.kernel.org>; Fri,  2 Apr 2021 18:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B871F61151
	for <linux-iio@archiver.kernel.org>; Fri,  2 Apr 2021 18:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhDBSro (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 2 Apr 2021 14:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhDBSro (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Apr 2021 14:47:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F3D6610F7;
        Fri,  2 Apr 2021 18:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617389262;
        bh=Xwky7C1/fM6TBbTqaNYAvyMsk5rcIoa5LN8GkkuDRQ0=;
        h=From:To:Cc:Subject:Date:From;
        b=O1V68RaViCpUXqYwcm71TyH7kI1K0OkT8P5vaErvsO8Ax+zh/n6RdmRM/UgGDmvre
         FEyk+gbkOl60m59EtwH2Y+ytkNX+e0P4ZpSW4iAnTP4ODldcr8f+c6rph/nkqebTrS
         CCqndq4Jy8LBDmtzUabmrvZW+Z1TITAVkijuCstUxph65wWs+R23t4fC9tPv9uRZ13
         V1uPF1MXuxq4Qz7C53iqQDBHF7aQd50pWoVbdIvXOQGOCMk3vsQsi8Yhz/zGOcBqJ4
         axiYtGvg8YAkb4vU7qdNy00Pd/VTj0mf09Hr7nu8I5bPhwG86msBnBAMRa5pDkN46Z
         PeiqcBKlw+BhQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/7] iio: Use IRQF_NO_AUTOEN 
Date:   Fri,  2 Apr 2021 19:45:37 +0100
Message-Id: <20210402184544.488862-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This series is dependant on
cbe16f35bee68 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
which is available in an immutable tag in the tip tree.
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tag/?h=irq-no-autoen-2021-03-25
which I'll merge in to the IIO tree if we need it before it's available
upstream.

That patch introduces a new IRQF_NO_AUTOEN flag for irq requests to avoid
the current dance where we either mark an irq as not to be autoenabled before
we know if we can actually request it succesfully, or (as IIO drivers seem to
have gone with) we disable the interrupt just after requesting it.
In short the flag stops the interrupt being autoenabled in the first place.

So this series applies this magic to IIO :)

Note these are all just compile tested and some of them aren't entirely
trivial because of other aspects of the irq flag handling.

Jonathan Cameron (7):
  iio:adc:ad7766: Use new IRQF_NO_AUTOEN to reduce boilerplate
  iio:adc:exynos-adc: Use new IRQF_NO_AUTOEN flag rather than separate
    irq_disable()
  iio:adc:nau7802: Use IRQF_NO_AUTOEN instead of request then disable
  iio:adc:sun4i-gpadc: Use new IRQF_NO_AUTOEN flag instead of request
    then disable
  iio:chemical:scd30: Use IRQF_NO_AUTOEN to avoid irq request then
    disable
  iio:imu:adis: Use IRQF_NO_AUTOEN instead of irq request then disable
  iio:adc:ad_sigma_delta: Use IRQF_NO_AUTOEN rather than request and
    disable

 drivers/iio/adc/ad7766.c          | 15 +++++++--------
 drivers/iio/adc/ad_sigma_delta.c  |  7 ++-----
 drivers/iio/adc/exynos_adc.c      |  4 ++--
 drivers/iio/adc/nau7802.c         |  6 +++---
 drivers/iio/adc/sun4i-gpadc-iio.c |  4 ++--
 drivers/iio/chemical/scd30_core.c | 16 ++++++++--------
 drivers/iio/imu/adis16460.c       |  4 ++--
 drivers/iio/imu/adis16475.c       |  5 +++--
 drivers/iio/imu/adis_trigger.c    | 11 ++++++-----
 9 files changed, 35 insertions(+), 37 deletions(-)

-- 
2.31.1

