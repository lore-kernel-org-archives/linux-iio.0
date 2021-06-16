Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F79C48BE5
	for <linux-iio@archiver.kernel.org>; Wed, 16 Jun 2021 15:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8A761042
	for <linux-iio@archiver.kernel.org>; Wed, 16 Jun 2021 15:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhFPQAA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 16 Jun 2021 12:00:00 -0400
Received: from aposti.net ([89.234.176.197]:51006 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235183AbhFPP7b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 11:59:31 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 0/2] Add "extended_name" to label
Date:   Wed, 16 Jun 2021 16:57:04 +0100
Message-Id: <20210616155706.17444-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Here's the v2 of my previous patchset which added an "extended_name"
attribute.

Following the discussion on the v1, here's a set of two patches that
1. make sure we will never have channels with both labels and extended
   names,
2. make the extended name available to userspace as the channel's label.

Cheers,
-Paul

Paul Cercueil (2):
  iio: core: Forbid use of both labels and extended names
  iio: core: Support reading extended name as label

 drivers/iio/industrialio-core.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

-- 
2.30.2

