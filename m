Return-Path: <SRS0=TPgR=R5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B698BC43381
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 13:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0082075C
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 13:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbfCZNrE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:47:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:15068 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730697AbfCZNrE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 Mar 2019 09:47:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 06:47:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,271,1549958400"; 
   d="scan'208";a="125984671"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 26 Mar 2019 06:47:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 01A352E7; Tue, 26 Mar 2019 15:47:00 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] iio: Make possible to include driver.h first
Date:   Tue, 26 Mar 2019 15:47:00 +0200
Message-Id: <20190326134700.24800-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If we put headers alphabetically sorted in the IIO driver,
the compilation will abort because of unknown type to handle.

Simple add a forward declaration of opaque struct iio_dev.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/iio/driver.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iio/driver.h b/include/linux/iio/driver.h
index 7dfb10ee2669..f54a7bcdefe3 100644
--- a/include/linux/iio/driver.h
+++ b/include/linux/iio/driver.h
@@ -11,6 +11,7 @@
 #ifndef _IIO_INKERN_H_
 #define _IIO_INKERN_H_
 
+struct iio_dev;
 struct iio_map;
 
 /**
-- 
2.20.1

