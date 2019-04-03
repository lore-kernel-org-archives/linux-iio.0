Return-Path: <SRS0=2YCt=SF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF90C4360F
	for <linux-iio@archiver.kernel.org>; Wed,  3 Apr 2019 10:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EC22148E
	for <linux-iio@archiver.kernel.org>; Wed,  3 Apr 2019 10:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDCKVB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:21:01 -0400
Received: from www.osadl.org ([62.245.132.105]:47369 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfDCKVB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Apr 2019 06:21:01 -0400
X-Greylist: delayed 2020 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Apr 2019 06:21:01 EDT
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x339kfBr026880;
        Wed, 3 Apr 2019 11:46:41 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/2] staging:iio:accel:adis16203: add SPDX license identifier tag
Date:   Wed,  3 Apr 2019 11:41:28 +0200
Message-Id: <1554284489-5023-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Pop in the SPDX tag as the license is clearly indicated
as GPL V2 or later this should also be indicated with a SPDX license
identifier tag.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

chackpatch.pl was warning:
WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

Patch was compile tested with: X86_64_defconfig + SPI=y, IIO=m
STAGING=y, ADIS16203=m

Patch is against 5.1-rc3 (localversion-next is next-20190403)

 drivers/staging/iio/accel/adis16203.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index 5cc96c80..cf9d41a 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * ADIS16203 Programmable 360 Degrees Inclinometer
  *
-- 
2.1.4

