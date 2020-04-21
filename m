Return-Path: <SRS0=Mhlw=6F=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81F2C55189
	for <linux-iio@archiver.kernel.org>; Tue, 21 Apr 2020 00:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2642145D
	for <linux-iio@archiver.kernel.org>; Tue, 21 Apr 2020 00:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgDUAbn (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:31:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:14368 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgDUAbl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:41 -0400
IronPort-SDR: eLDQb+hPgZ+mpfelpYuGsuH5dCwn/nzFh6WWI3ImnFyMvWZNUYZMs+rKuje50B5rlsTeKOiWTN
 tSgpa3GMHSig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:31:40 -0700
IronPort-SDR: 2OKV5EqA48DG5SAYMSuF/3f0YLoZtHAIRQA2Uj1ofyRJMzGs/vj98YUQN2+fb//djDgqKDPero
 LBk8a516XPWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="290282134"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2020 17:31:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A5F24238; Tue, 21 Apr 2020 03:31:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v1 06/16] iio: dac: ad5446: Use put_unaligned_be24()
Date:   Tue, 21 Apr 2020 03:31:25 +0300
Message-Id: <20200421003135.23060-6-andriy.shevchenko@linux.intel.com>
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

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/dac/ad5446.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 61c670f7fc5f..87ff863bdc10 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -302,9 +302,7 @@ static int ad5660_write(struct ad5446_state *st, unsigned val)
 	struct spi_device *spi = to_spi_device(st->dev);
 	uint8_t data[3];
 
-	data[0] = (val >> 16) & 0xFF;
-	data[1] = (val >> 8) & 0xFF;
-	data[2] = val & 0xFF;
+	put_unaligned_be24(val, &data[0]);
 
 	return spi_write(spi, data, sizeof(data));
 }
-- 
2.26.1

