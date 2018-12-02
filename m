Return-Path: <SRS0=4vqF=OL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68BFC04EB8
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 11:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0B62082F
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 11:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="JhBAqgsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0B62082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbeLBL6E (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:58:04 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.155]:60099 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeLBL6E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Dec 2018 06:58:04 -0500
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <localhost>
Received: from localhost (ipv4-188-121-17-172.net.internetunion.pl [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Sun,  2 Dec 2018 12:57:58 +0100 (CET)
From:   Slawomir Stepien <sst@poczta.fm>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 2/3] staging: iio: adc: ad7280a: split ad7280_attr_init() to more functions
Date:   Sun,  2 Dec 2018 12:58:29 +0100
Message-Id: <20181202115830.20363-3-sst@poczta.fm>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202115830.20363-1-sst@poczta.fm>
References: <20181202115830.20363-1-sst@poczta.fm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1543751879;
        bh=yCueciNFpEuYCq7SWVxbArq57j8ed3j8acHbqH1LNJ8=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:From:To:Cc:Subject:
         Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
         Content-Transfer-Encoding:X-Interia-Antivirus;
        b=JhBAqgsScjiNGUs03OCGbRVvu/04WOHEg7VWq3xKZzTo99Emx3xtYVIYkwz6Ur+FV
         lZKOE6VG/zOo/TQ0mu+9ABUIZrxjlmbgmWyQrSAzQ37rG9oepH6dMvmIb6X+SmNgUY
         yXV/59+3mseL/Eva4rV8LyAFOUOZA+CjrF98J1+g=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ad7280_attr_init function has been split into more specific
functions to increase the code readability.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/staging/iio/adc/ad7280a.c | 79 +++++++++++++++++++------------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index a6b1bdd9f372..6faa85bf6f7e 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -592,11 +592,49 @@ static int ad7280_channel_init(struct ad7280_state *st)
 	return cnt + 1;
 }
 
+static int ad7280_balance_switch_attr_init(struct ad7280_state *st, int cnt,
+					   int dev, int ch)
+{
+	struct iio_dev_attr *attr = &st->iio_attr[cnt];
+
+	attr->address = ad7280a_devaddr(dev) << 8 | ch;
+	attr->dev_attr.attr.mode = 0644;
+	attr->dev_attr.show = ad7280_show_balance_sw;
+	attr->dev_attr.store = ad7280_store_balance_sw;
+	attr->dev_attr.attr.name = devm_kasprintf(&st->spi->dev, GFP_KERNEL,
+						  "in%d-in%d_balance_switch_en",
+						  ch, ch + 1);
+	if (!attr->dev_attr.attr.name)
+		return -ENOMEM;
+
+	ad7280_attributes[cnt] = &attr->dev_attr.attr;
+
+	return 0;
+}
+
+static int ad7280_balance_timer_attr_init(struct ad7280_state *st, int cnt,
+					  int dev, int ch)
+{
+	struct iio_dev_attr *attr = &st->iio_attr[cnt];
+
+	attr->address = ad7280a_devaddr(dev) << 8 | (AD7280A_CB1_TIMER + ch);
+	attr->dev_attr.attr.mode = 0644;
+	attr->dev_attr.show = ad7280_show_balance_timer;
+	attr->dev_attr.store = ad7280_store_balance_timer;
+	attr->dev_attr.attr.name = devm_kasprintf(&st->spi->dev, GFP_KERNEL,
+						  "in%d-in%d_balance_timer",
+						  ch, ch + 1);
+	if (!attr->dev_attr.attr.name)
+		return -ENOMEM;
+
+	ad7280_attributes[cnt] = &attr->dev_attr.attr;
+
+	return 0;
+}
+
 static int ad7280_attr_init(struct ad7280_state *st)
 {
-	int dev, ch, cnt;
-	unsigned int index;
-	struct iio_dev_attr *iio_attr;
+	int dev, ch, cnt, ret;
 
 	st->iio_attr = devm_kcalloc(&st->spi->dev, 2, sizeof(*st->iio_attr) *
 				    (st->slave_num + 1) * AD7280A_CELLS_PER_DEV,
@@ -607,35 +645,14 @@ static int ad7280_attr_init(struct ad7280_state *st)
 	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
 		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_CELL_VOLTAGE_6;
 			ch++, cnt++) {
-			iio_attr = &st->iio_attr[cnt];
-			index = dev * AD7280A_CELLS_PER_DEV + ch;
-			iio_attr->address = ad7280a_devaddr(dev) << 8 | ch;
-			iio_attr->dev_attr.attr.mode = 0644;
-			iio_attr->dev_attr.show = ad7280_show_balance_sw;
-			iio_attr->dev_attr.store = ad7280_store_balance_sw;
-			iio_attr->dev_attr.attr.name =
-				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
-					       "in%d-in%d_balance_switch_en",
-					       index, index + 1);
-			if (!iio_attr->dev_attr.attr.name)
-				return -ENOMEM;
-
-			ad7280_attributes[cnt] = &iio_attr->dev_attr.attr;
+			ret = ad7280_balance_switch_attr_init(st, cnt, dev, ch);
+			if (ret < 0)
+				return ret;
+
 			cnt++;
-			iio_attr = &st->iio_attr[cnt];
-			iio_attr->address = ad7280a_devaddr(dev) << 8 |
-				(AD7280A_CB1_TIMER + ch);
-			iio_attr->dev_attr.attr.mode = 0644;
-			iio_attr->dev_attr.show = ad7280_show_balance_timer;
-			iio_attr->dev_attr.store = ad7280_store_balance_timer;
-			iio_attr->dev_attr.attr.name =
-				devm_kasprintf(&st->spi->dev, GFP_KERNEL,
-					       "in%d-in%d_balance_timer",
-					       index, index + 1);
-			if (!iio_attr->dev_attr.attr.name)
-				return -ENOMEM;
-
-			ad7280_attributes[cnt] = &iio_attr->dev_attr.attr;
+			ret = ad7280_balance_timer_attr_init(st, cnt, dev, ch);
+			if (ret < 0)
+				return ret;
 		}
 
 	ad7280_attributes[cnt] = NULL;
-- 
2.19.2

