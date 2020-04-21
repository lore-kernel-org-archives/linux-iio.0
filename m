Return-Path: <SRS0=Mhlw=6F=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46FEC55186
	for <linux-iio@archiver.kernel.org>; Tue, 21 Apr 2020 00:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE7C2145D
	for <linux-iio@archiver.kernel.org>; Tue, 21 Apr 2020 00:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDUAbm (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:31:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:43075 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgDUAbl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:41 -0400
IronPort-SDR: xy+b+FcIGusK1VJRxyBUF6ew8aTC+qAmrODbaR5HQ6w4UVLFofEDne7GQtjwBG8j80gsSiiiJW
 5AcWbo4PvGGw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:31:41 -0700
IronPort-SDR: Y0Sac913DexQRxUYT+71bofMzSOE2YoK9DIpm8h9NC8HCyP/SkZvWL5g1bAppyKmkq0FNdoz+k
 YeIOKjyfDXNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="244002919"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 20 Apr 2020 17:31:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E1BC25F5; Tue, 21 Apr 2020 03:31:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 12/16] iio: pressure: hp206c: Use get_unaligned_be24()
Date:   Tue, 21 Apr 2020 03:31:31 +0300
Message-Id: <20200421003135.23060-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This makes the driver code slightly easier to read.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/pressure/hp206c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/hp206c.c b/drivers/iio/pressure/hp206c.c
index 3ac3632e7242..d746882eccc8 100644
--- a/drivers/iio/pressure/hp206c.c
+++ b/drivers/iio/pressure/hp206c.c
@@ -93,12 +93,12 @@ static int hp206c_read_20bit(struct i2c_client *client, u8 cmd)
 	int ret;
 	u8 values[3];
 
-	ret = i2c_smbus_read_i2c_block_data(client, cmd, 3, values);
+	ret = i2c_smbus_read_i2c_block_data(client, cmd, sizeof(values), values);
 	if (ret < 0)
 		return ret;
-	if (ret != 3)
+	if (ret != sizeof(values))
 		return -EIO;
-	return ((values[0] & 0xF) << 16) | (values[1] << 8) | (values[2]);
+	return get_unaligned_be24(&values[0]) & GENMASK(19, 0);
 }
 
 /* Spin for max 160ms until DEV_RDY is 1, or return error. */
-- 
2.26.1

