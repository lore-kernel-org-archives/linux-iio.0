Return-Path: <SRS0=5MmI=4N=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03342C35E04
	for <linux-iio@archiver.kernel.org>; Tue, 25 Feb 2020 14:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C593021744
	for <linux-iio@archiver.kernel.org>; Tue, 25 Feb 2020 14:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgBYO7f (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:59:35 -0500
Received: from broadband.actcorp.in ([49.207.57.206]:7696 "EHLO SARKAR"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729390AbgBYO7f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 Feb 2020 09:59:35 -0500
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Feb 2020 09:59:33 EST
Received: by SARKAR (Postfix, from userid 1001)
        id 4B09E7427DC; Tue, 25 Feb 2020 20:19:35 +0530 (IST)
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     rohitsarkar5398@gmail.com, jic23@kernel.org
Subject: [PATCH v2] staging: iio: update TODO
Date:   Tue, 25 Feb 2020 20:19:33 +0530
Message-Id: <20200225144933.19876-1-rohitsarkar5398@gmail.com>
X-Mailer: git-send-email 2.23.0.385.gbc12974a89
In-Reply-To: <20200224195915.GA8371@SARKAR>
References: <20200224195915.GA8371@SARKAR>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

since there are no uses of the old GPIO API, remove the item from the
TODO and some new items.

Changes from v1:
Add work item mentioned by Alexandru in https://marc.info/?l=linux-iio&m=158261515624212&w=2

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/staging/iio/TODO | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
index 1b8ebf2c1b69..e54510c2ef5f 100644
--- a/drivers/staging/iio/TODO
+++ b/drivers/staging/iio/TODO
@@ -1,11 +1,17 @@
-2018-04-15
+2020-02-25
 
-All affected drivers:
-Convert all uses of the old GPIO API from <linux/gpio.h> to the
-GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
-lines from device tree, ACPI or board files, board files should
-use <linux/gpio/machine.h>.
+- Documentation
+  - Binding docs for devices that are obviously used via device tree
+  - Yaml conversions for abandoned drivers
+  - ABI Documentation
+  - Audit driviers/iio/staging/Documentation
 
+- Replace iio_dev->mlock by either a local lock or use iio_claim_direct.
+  (Requires analysis of the purpose of the lock.)
+
+- Converting drivers from device tree centric to more generic property handlers
+  Refactor old platform_data constructs from drivers and convert it to state
+  struct and using property handlers and readers.
 
 ADI Drivers:
 CC the device-drivers-devel@blackfin.uclinux.org mailing list when
-- 
2.23.0.385.gbc12974a89

