Return-Path: <SRS0=Mhlw=6F=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B10BC54FCB
	for <linux-iio@archiver.kernel.org>; Tue, 21 Apr 2020 00:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AAD722240
	for <linux-iio@archiver.kernel.org>; Tue, 21 Apr 2020 00:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgDUAbl (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:31:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:54521 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbgDUAbl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:41 -0400
IronPort-SDR: ptrFF53BKQJ1L71TuP8DUSWp3L3AiJHlArusSARncOiBQVmr+gDYzOz02XU4uuN38CjwyHLkAD
 esyG602530lA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:31:40 -0700
IronPort-SDR: KMBMpteIQPdTFsV9ys07O2aEzfXwNCEE6WWZ3ggwNaUOFjlXtvS+cY/SrQHbzVNKtDaBq/DtnJ
 VjGxf+PbkLHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="300437802"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Apr 2020 17:31:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C932C556; Tue, 21 Apr 2020 03:31:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= 
        <maxime.roussinbelanger@gmail.com>
Subject: [PATCH v1 09/16] iio: light: si1133: Use get_unaligned_be24()
Date:   Tue, 21 Apr 2020 03:31:28 +0300
Message-Id: <20200421003135.23060-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This makes the driver code slightly easier to read.

Cc: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/si1133.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index 9174ab928880..8931a8afbafc 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -104,8 +104,6 @@
 #define SI1133_LUX_BUFFER_SIZE		9
 #define SI1133_MEASURE_BUFFER_SIZE	3
 
-#define SI1133_SIGN_BIT_INDEX 23
-
 static const int si1133_scale_available[] = {
 	1, 2, 4, 8, 16, 32, 64, 128};
 
@@ -633,8 +631,7 @@ static int si1133_measure(struct si1133_data *data,
 	if (err)
 		return err;
 
-	*val = sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | buffer[2],
-			     SI1133_SIGN_BIT_INDEX);
+	*val = sign_extend32(get_unaligned_be24(&buffer[0]), 23);
 
 	return err;
 }
@@ -723,16 +720,11 @@ static int si1133_get_lux(struct si1133_data *data, int *val)
 	if (err)
 		return err;
 
-	high_vis =
-		sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | buffer[2],
-			      SI1133_SIGN_BIT_INDEX);
+	high_vis = sign_extend32(get_unaligned_be24(&buffer[0]), 23);
 
-	low_vis =
-		sign_extend32((buffer[3] << 16) | (buffer[4] << 8) | buffer[5],
-			      SI1133_SIGN_BIT_INDEX);
+	low_vis = sign_extend32(get_unaligned_be24(&buffer[3]), 23);
 
-	ir = sign_extend32((buffer[6] << 16) | (buffer[7] << 8) | buffer[8],
-			   SI1133_SIGN_BIT_INDEX);
+	ir = sign_extend32(get_unaligned_be24(&buffer[6]), 23);
 
 	if (high_vis > SI1133_ADC_THRESHOLD || ir > SI1133_ADC_THRESHOLD)
 		lux = si1133_calc_polynomial(high_vis, ir,
-- 
2.26.1

