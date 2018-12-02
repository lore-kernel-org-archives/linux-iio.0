Return-Path: <SRS0=4vqF=OL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BA7C64EB4
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 11:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F139E2082F
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 11:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="gA0mUSQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F139E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbeLBL6C (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:58:02 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.155]:37210 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeLBL6C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Dec 2018 06:58:02 -0500
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <localhost>
Received: from localhost (ipv4-188-121-17-172.net.internetunion.pl [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Sun,  2 Dec 2018 12:57:57 +0100 (CET)
From:   Slawomir Stepien <sst@poczta.fm>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 1/3] staging: iio: adc: ad7280a: split ad7280_channel_init() to more functions
Date:   Sun,  2 Dec 2018 12:58:28 +0100
Message-Id: <20181202115830.20363-2-sst@poczta.fm>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202115830.20363-1-sst@poczta.fm>
References: <20181202115830.20363-1-sst@poczta.fm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1543751878;
        bh=LhAGj6TbkwmiLB28JOPwSaJg2h9MuARnwyTBn+R/sWQ=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:From:To:Cc:Subject:
         Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
         Content-Transfer-Encoding:X-Interia-Antivirus;
        b=gA0mUSQ7/hu6Z79M4n9aSZwEgmmkcpzrRoh865HDnngihF918w1U4xomQxkiR0MJP
         nEQ919hfsaN57TTdGgRBq6esUKLocx7qhHs9qv0i4gvt+kOdTAnuLNLOQPjyk0fKXX
         aIUaRSeYMW0KIYbU5Y7QuY4jsuJXyZR6i6WOOd0w=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ad7280_channel_init function has been split into more specific
functions to increase the code readability.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/staging/iio/adc/ad7280a.c | 119 +++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 7a0ba26f9fd9..a6b1bdd9f372 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -496,6 +496,75 @@ static const struct attribute_group ad7280_attrs_group = {
 	.attrs = ad7280_attributes,
 };
 
+static void ad7280_voltage_channel_init(struct ad7280_state *st, int cnt,
+					int dev, int ch)
+{
+	struct iio_chan_spec *chan = &st->channels[cnt];
+
+	chan->type = IIO_VOLTAGE;
+	chan->differential = 1;
+	chan->channel = (dev * 6) + ch;
+	chan->channel2 = chan->channel + 1;
+}
+
+static void ad7280_temp_channel_init(struct ad7280_state *st, int cnt, int dev,
+				     int ch)
+{
+	struct iio_chan_spec *chan = &st->channels[cnt];
+
+	chan->type = IIO_TEMP;
+	chan->channel = (dev * 6) + ch - 6;
+}
+
+static void ad7280_common_fields_init(struct ad7280_state *st, int cnt, int dev,
+				      int ch)
+{
+	struct iio_chan_spec *chan = &st->channels[cnt];
+
+	chan->indexed = 1;
+	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
+	chan->address = ad7280a_devaddr(dev) << 8 | ch;
+	chan->scan_index = cnt;
+	chan->scan_type.sign = 'u';
+	chan->scan_type.realbits = 12;
+	chan->scan_type.storagebits = 32;
+	chan->scan_type.shift = 0;
+}
+
+static void ad7280_all_voltage_channel_init(struct ad7280_state *st, int cnt,
+					    int dev)
+{
+	struct iio_chan_spec *chan = &st->channels[cnt];
+
+	chan->type = IIO_VOLTAGE;
+	chan->differential = 1;
+	chan->channel = 0;
+	chan->channel2 = dev * 6;
+	chan->address = AD7280A_ALL_CELLS;
+	chan->indexed = 1;
+	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
+	chan->scan_index = cnt;
+	chan->scan_type.sign = 'u';
+	chan->scan_type.realbits = 32;
+	chan->scan_type.storagebits = 32;
+	chan->scan_type.shift = 0;
+}
+
+static void ad7280_timestamp_channel_init(struct ad7280_state *st, int cnt)
+{
+	struct iio_chan_spec *chan = &st->channels[cnt];
+
+	chan->type = IIO_TIMESTAMP;
+	chan->channel = -1;
+	chan->scan_index = cnt;
+	chan->scan_type.sign = 's';
+	chan->scan_type.realbits = 64;
+	chan->scan_type.storagebits = 64;
+	chan->scan_type.shift = 0;
+}
+
 static int ad7280_channel_init(struct ad7280_state *st)
 {
 	int dev, ch, cnt;
@@ -508,51 +577,17 @@ static int ad7280_channel_init(struct ad7280_state *st)
 	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
 		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_AUX_ADC_6;
 			ch++, cnt++) {
-			if (ch < AD7280A_AUX_ADC_1) {
-				st->channels[cnt].type = IIO_VOLTAGE;
-				st->channels[cnt].differential = 1;
-				st->channels[cnt].channel = (dev * 6) + ch;
-				st->channels[cnt].channel2 =
-					st->channels[cnt].channel + 1;
-			} else {
-				st->channels[cnt].type = IIO_TEMP;
-				st->channels[cnt].channel = (dev * 6) + ch - 6;
-			}
-			st->channels[cnt].indexed = 1;
-			st->channels[cnt].info_mask_separate =
-				BIT(IIO_CHAN_INFO_RAW);
-			st->channels[cnt].info_mask_shared_by_type =
-				BIT(IIO_CHAN_INFO_SCALE);
-			st->channels[cnt].address =
-				ad7280a_devaddr(dev) << 8 | ch;
-			st->channels[cnt].scan_index = cnt;
-			st->channels[cnt].scan_type.sign = 'u';
-			st->channels[cnt].scan_type.realbits = 12;
-			st->channels[cnt].scan_type.storagebits = 32;
-			st->channels[cnt].scan_type.shift = 0;
+			if (ch < AD7280A_AUX_ADC_1)
+				ad7280_voltage_channel_init(st, cnt, dev, ch);
+			else
+				ad7280_temp_channel_init(st, cnt, dev, ch);
+
+			ad7280_common_fields_init(st, cnt, dev, ch);
 		}
 
-	st->channels[cnt].type = IIO_VOLTAGE;
-	st->channels[cnt].differential = 1;
-	st->channels[cnt].channel = 0;
-	st->channels[cnt].channel2 = dev * 6;
-	st->channels[cnt].address = AD7280A_ALL_CELLS;
-	st->channels[cnt].indexed = 1;
-	st->channels[cnt].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
-	st->channels[cnt].info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
-	st->channels[cnt].scan_index = cnt;
-	st->channels[cnt].scan_type.sign = 'u';
-	st->channels[cnt].scan_type.realbits = 32;
-	st->channels[cnt].scan_type.storagebits = 32;
-	st->channels[cnt].scan_type.shift = 0;
+	ad7280_all_voltage_channel_init(st, cnt, dev);
 	cnt++;
-	st->channels[cnt].type = IIO_TIMESTAMP;
-	st->channels[cnt].channel = -1;
-	st->channels[cnt].scan_index = cnt;
-	st->channels[cnt].scan_type.sign = 's';
-	st->channels[cnt].scan_type.realbits = 64;
-	st->channels[cnt].scan_type.storagebits = 64;
-	st->channels[cnt].scan_type.shift = 0;
+	ad7280_timestamp_channel_init(st, cnt);
 
 	return cnt + 1;
 }
-- 
2.19.2

