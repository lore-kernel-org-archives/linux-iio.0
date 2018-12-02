Return-Path: <SRS0=4vqF=OL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B66C04EB8
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 18:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037142082F
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 18:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 037142082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=etezian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbeLBSra (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 Dec 2018 13:47:30 -0500
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:59225 "EHLO
        8.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbeLBSra (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Dec 2018 13:47:30 -0500
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Dec 2018 13:47:29 EST
Received: from player159.ha.ovh.net (unknown [10.109.143.183])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id 0FBEC35ADD
        for <linux-iio@vger.kernel.org>; Sun,  2 Dec 2018 19:31:06 +0100 (CET)
Received: from etezian.org (81-175-223-118.bb.dnainternet.fi [81.175.223.118])
        (Authenticated sender: andi@etezian.org)
        by player159.ha.ovh.net (Postfix) with ESMTPSA id 23059516F8E;
        Sun,  2 Dec 2018 18:31:01 +0000 (UTC)
From:   Andi Shyti <andi@etezian.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Andi Shyti <andi@etezian.org>
Subject: [PATCH] iio: core: check 'info' value before registering the device
Date:   Sun,  2 Dec 2018 20:30:31 +0200
Message-Id: <20181202183031.2471-1-andi@etezian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2659938533753078354
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedruddvledgvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the 'info' structure inside indio_dev is left uninitialized,
a segmentation fault occurs.

Check the 'info' value before using it and if it is equal to
NULL, return with -EINVAL.

Signed-off-by: Andi Shyti <andi@etezian.org>
---
 drivers/iio/industrialio-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a062cfddc5af..4f5cd9f60870 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1671,6 +1671,9 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	if (ret < 0)
 		return ret;
 
+	if (!indio_dev->info)
+		return -EINVAL;
+
 	/* configure elements for the chrdev */
 	indio_dev->dev.devt = MKDEV(MAJOR(iio_devt), indio_dev->id);
 
-- 
2.20.0.rc1

