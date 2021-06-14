Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3096C48BE8
	for <linux-iio@archiver.kernel.org>; Mon, 14 Jun 2021 11:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93CF36023F
	for <linux-iio@archiver.kernel.org>; Mon, 14 Jun 2021 11:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhFNLmB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 14 Jun 2021 07:42:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233249AbhFNLh0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:37:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D6B6611C1;
        Mon, 14 Jun 2021 11:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670422;
        bh=uX4j8Em0DfN95DWXSZS5TrQWrJs4W3Wt3k4zYml5GE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GBXCongJgimP2/ps4fwpZBjFJYOSiNyxtEYE6aNNFI8XmtG4MWfG6cQgpSQ2uSvrv
         Xc7+Ih9z9SUn+ly9ERkP6oxw1d6TD9sTpVJ2dw09tIL+FqTCYzhuswMTPmSZ+cmdbN
         AeUzn7zn5vm3vDlmyZnATtlMvA5ypVwSajNo2Qk9w/s7+rBbLcmhigcfzkPRIdNQ90
         iBzt7cmoE7LVLbOB/m4FxQrxLC7yzWGzy9bRFE42b4SeQH1IqsRuoUe4ukRaGOF4lY
         9514bRzpKv/W8SqiIhD2i4V1T76Gni4lrqIebavpQi/NflXC+SL6eNhI1Ci7z8nV8c
         S2PQ2NkfWaVpA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 09/17] staging:iio:adc:ad7280a: Trivial comment formatting cleanup
Date:   Mon, 14 Jun 2021 12:34:59 +0100
Message-Id: <20210614113507.897732-10-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614113507.897732-1-jic23@kernel.org>
References: <20210614113507.897732-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

IIO uses the
/*
 * stuff
 * more stuff
 */

multi-line style, so use that here as well.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 58bddd07df0c..b186dda03432 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -139,9 +139,10 @@ static unsigned int ad7280a_devaddr(unsigned int addr)
 	       ((addr & 0x10) >> 4);
 }
 
-/* During a read a valid write is mandatory.
- * So writing to the highest available address (Address 0x1F)
- * and setting the address all parts bit to 0 is recommended
+/*
+ * During a read a valid write is mandatory.
+ * So writing to the highest available address (Address 0x1F) and setting the
+ * address all parts bit to 0 is recommended.
  * So the TXVAL is AD7280A_DEVADDR_ALL + CRC
  */
 #define AD7280A_READ_TXVAL	0xF800030A
@@ -180,7 +181,7 @@ static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigned int val)
 	crc = crc_tab[val >> 16 & 0xFF];
 	crc = crc_tab[crc ^ (val >> 8 & 0xFF)];
 
-	return  crc ^ (val & 0xFF);
+	return crc ^ (val & 0xFF);
 }
 
 static int ad7280_check_crc(struct ad7280_state *st, unsigned int val)
@@ -193,12 +194,12 @@ static int ad7280_check_crc(struct ad7280_state *st, unsigned int val)
 	return 0;
 }
 
-/* After initiating a conversion sequence we need to wait until the
- * conversion is done. The delay is typically in the range of 15..30 us
- * however depending an the number of devices in the daisy chain and the
- * number of averages taken, conversion delays and acquisition time options
- * it may take up to 250us, in this case we better sleep instead of busy
- * wait.
+/*
+ * After initiating a conversion sequence we need to wait until the conversion
+ * is done. The delay is typically in the range of 15..30us however depending on
+ * the number of devices in the daisy chain, the number of averages taken,
+ * conversion delays and acquisition time options it may take up to 250us, in
+ * this case we better sleep instead of busy wait.
  */
 
 static void ad7280_delay(struct ad7280_state *st)
-- 
2.32.0

