Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2021C11F66
	for <linux-iio@archiver.kernel.org>; Tue, 29 Jun 2021 11:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C067261DD2
	for <linux-iio@archiver.kernel.org>; Tue, 29 Jun 2021 11:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhF2LTa (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 29 Jun 2021 07:19:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:17846 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233362AbhF2LT3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Jun 2021 07:19:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="293763703"
X-IronPort-AV: E=Sophos;i="5.83,308,1616482800"; 
   d="scan'208";a="293763703"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 04:17:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,308,1616482800"; 
   d="scan'208";a="492655862"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2021 04:17:01 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-iio@vger.kernel.org
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] counter: intel-qep: Remove linux/bitops.h include
Date:   Tue, 29 Jun 2021 14:16:57 +0300
Message-Id: <20210629111657.2655688-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

0-DAY CI Kernel Test Service reported following iwyu warning:

drivers/counter/intel-qep.c:11:1: iwyu: warning: superfluous #include <linux/bitops.h>

Remove that include since we don't seem to use anything from it.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/counter/intel-qep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index 8d7ae28fbd67..1a9512e28519 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -8,7 +8,6 @@
  * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
  * Author: Raymond Tan <raymond.tan@intel.com>
  */
-#include <linux/bitops.h>
 #include <linux/counter.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.30.2

