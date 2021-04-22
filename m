Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4383EC433B4
	for <linux-iio@archiver.kernel.org>; Thu, 22 Apr 2021 20:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1679160C3E
	for <linux-iio@archiver.kernel.org>; Thu, 22 Apr 2021 20:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhDVU0N (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 22 Apr 2021 16:26:13 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:40769 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236949AbhDVU0M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Apr 2021 16:26:12 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Apr 2021 16:26:11 EDT
Received: from pro2.mail.ovh.net (unknown [10.108.16.12])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id AED6BA1BA55D;
        Thu, 22 Apr 2021 22:18:26 +0200 (CEST)
Received: from arch.lan (89.70.221.198) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Apr
 2021 22:18:26 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH] iio: core: fix ioctl handlers removal
Date:   Thu, 22 Apr 2021 22:14:15 +0200
Message-ID: <20210422201415.46378-1-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.221.198]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 15713622053141568535
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvddutddgudegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffoggfgtghisehtkeertdertddtnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuggftrfgrthhtvghrnhephedtgefgkeduvdekheeggefghffhteekleetvdekvddtveeutdetueefueehieetnecukfhppedtrddtrddtrddtpdekledrjedtrddvvddurdduleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtoheplhgrrhhssehmvghtrghfohhordguvg
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently ioctl handlers are removed twice. For the first time during
iio_device_unregister() then later on inside
iio_device_unregister_eventset() and iio_buffers_free_sysfs_and_mask().
Double free leads to kernel panic.

Fix this by not touching ioctl handlers list directly but rather
letting code responsible for registration call the matching cleanup
routine itself.

Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
 drivers/iio/industrialio-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d92c58a94fe4..98944cfc7331 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1939,9 +1939,6 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 
 	indio_dev->info = NULL;
 
-	list_for_each_entry_safe(h, t, &iio_dev_opaque->ioctl_handlers, entry)
-		list_del(&h->entry);
-
 	iio_device_wakeup_eventset(indio_dev);
 	iio_buffer_wakeup_poll(indio_dev);
 
-- 
2.31.1

