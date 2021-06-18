Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2554CC48BDF
	for <linux-iio@archiver.kernel.org>; Fri, 18 Jun 2021 12:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0877661248
	for <linux-iio@archiver.kernel.org>; Fri, 18 Jun 2021 12:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhFRMc6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 18 Jun 2021 08:32:58 -0400
Received: from aposti.net ([89.234.176.197]:41084 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234445AbhFRMcY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Jun 2021 08:32:24 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 0/2] Add "extended_name" to label
Date:   Fri, 18 Jun 2021 13:30:03 +0100
Message-Id: <20210618123005.49867-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

This is the v3 of my patchset that sets the label attribute to the
"extended_name".

v3 only refactors the code of patch [2/2] to make it look a bit better.

Cheers,
-Paul

Paul Cercueil (2):
  iio: core: Forbid use of both labels and extended names
  iio: core: Support reading extended name as label

 drivers/iio/industrialio-core.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

-- 
2.30.2

