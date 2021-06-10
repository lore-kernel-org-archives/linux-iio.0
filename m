Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06036C47094
	for <linux-iio@archiver.kernel.org>; Thu, 10 Jun 2021 12:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB41D61184
	for <linux-iio@archiver.kernel.org>; Thu, 10 Jun 2021 12:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFJMsF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 10 Jun 2021 08:48:05 -0400
Received: from aposti.net ([89.234.176.197]:54484 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhFJMsF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Jun 2021 08:48:05 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/2] iio: Add "extended_name" attribute
Date:   Thu, 10 Jun 2021 13:45:54 +0100
Message-Id: <20210610124556.34507-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Here's a small change to address an issue I've been facing since the
beginning in libiio, namely that the IIO tree in sysfs is not easily
parsable (read more about it in patch #2's summary).

Any feedback welcome.

Cheers,
-Paul

Paul Cercueil (2):
  iio: core: Support removing extended name in attribute filename
  iio: core: Add "extended_name" attribute to all channels

 drivers/iio/iio_core.h            |  3 +-
 drivers/iio/industrialio-buffer.c | 12 +++--
 drivers/iio/industrialio-core.c   | 73 ++++++++++++++++++++++++++-----
 drivers/iio/industrialio-event.c  |  3 +-
 4 files changed, 74 insertions(+), 17 deletions(-)

-- 
2.30.2

