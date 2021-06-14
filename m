Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252E9C49EA5
	for <linux-iio@archiver.kernel.org>; Mon, 14 Jun 2021 11:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B96D611CA
	for <linux-iio@archiver.kernel.org>; Mon, 14 Jun 2021 11:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhFNLhg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 14 Jun 2021 07:37:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235588AbhFNLfb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:35:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8328461245;
        Mon, 14 Jun 2021 11:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670408;
        bh=zCr5830WhpGcT+eno1aibI0vVU9Q2xLsA8NPToLzKMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pdCTVfP8QvLL9nX9ewbRx8llgsdcGWvH7Loevr9alhJd1Znfefq8oD58RSn6owrLD
         3hHXCBE/0ZJVZ1IIW9XW/jqOZogKvI6QtYKF9lSMmDfbsRNj2ZUxokyGg6EKLlvQaA
         2apAa7jkBUmINJag8mkO1VPS6zAnU+fjoaNifXxiMdNidfL3TJtaEC+XCl8tjqclNV
         zbssQdmg8lSy0XoxobKUhT/vPQStIY5ZXvTrPjxd0Rz7j+4oj+BMmhUCA51LJCHw7i
         rA3oZlboE8jLSNq8bx44TqLIBxiJH3/BHRgyZf8UldL3IwtZwiId9yWtynzbxDSZyg
         Ix6b4C8HFQFSw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/17] staging:iio:adc:ad7280a: Split buff[2] into tx and rx parts
Date:   Mon, 14 Jun 2021 12:34:54 +0100
Message-Id: <20210614113507.897732-5-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614113507.897732-1-jic23@kernel.org>
References: <20210614113507.897732-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As the __cacheline_aligned will ensure that the first of these two buffers
is appropriate aligned, there is no need to keep them as a single array
which is confusing given the first element is always tx and the second
rx.  Hence let us just have two parts and name them separately.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 4d866e5fe43c..1f7ea5fb1e20 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -153,7 +153,8 @@ struct ad7280_state {
 	unsigned char			cb_mask[AD7280A_MAX_CHAIN];
 	struct mutex			lock; /* protect sensor state */
 
-	__be32				buf[2] ____cacheline_aligned;
+	__be32				tx ____cacheline_aligned;
+	__be32				rx;
 };
 
 static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigned int val)
@@ -196,18 +197,18 @@ static int __ad7280_read32(struct ad7280_state *st, unsigned int *val)
 {
 	int ret;
 	struct spi_transfer t = {
-		.tx_buf	= &st->buf[0],
-		.rx_buf = &st->buf[1],
-		.len = 4,
+		.tx_buf	= &st->tx,
+		.rx_buf = &st->rx,
+		.len = sizeof(st->tx),
 	};
 
-	st->buf[0] = cpu_to_be32(AD7280A_READ_TXVAL);
+	st->tx = cpu_to_be32(AD7280A_READ_TXVAL);
 
 	ret = spi_sync_transfer(st->spi, &t, 1);
 	if (ret)
 		return ret;
 
-	*val = be32_to_cpu(st->buf[1]);
+	*val = be32_to_cpu(st->rx);
 
 	return 0;
 }
@@ -219,9 +220,9 @@ static int ad7280_write(struct ad7280_state *st, unsigned int devaddr,
 			(val & 0xFF) << 13 | all << 12;
 
 	reg |= ad7280_calc_crc8(st->crc_tab, reg >> 11) << 3 | 0x2;
-	st->buf[0] = cpu_to_be32(reg);
+	st->tx = cpu_to_be32(reg);
 
-	return spi_write(st->spi, &st->buf[0], 4);
+	return spi_write(st->spi, &st->tx, sizeof(st->tx));
 }
 
 static int ad7280_read_reg(struct ad7280_state *st, unsigned int devaddr,
-- 
2.32.0

