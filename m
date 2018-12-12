Return-Path: <SRS0=Gvxw=OV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B795FC6783B
	for <linux-iio@archiver.kernel.org>; Wed, 12 Dec 2018 17:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F6E2087F
	for <linux-iio@archiver.kernel.org>; Wed, 12 Dec 2018 17:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="WThV9DDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F6E2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbeLLRBu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:01:50 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.155]:53102 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbeLLRBt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Dec 2018 12:01:49 -0500
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <localhost>
Received: from localhost (unknown [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Wed, 12 Dec 2018 18:01:44 +0100 (CET)
From:   Slawomir Stepien <sst@poczta.fm>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 1/2] staging: iio: adc: ad7280a: split ad7280_channel_init() to more functions
Date:   Wed, 12 Dec 2018 18:02:27 +0100
Message-Id: <20181212170228.28498-2-sst@poczta.fm>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181212170228.28498-1-sst@poczta.fm>
References: <20181212170228.28498-1-sst@poczta.fm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1544634106;
        bh=eHUqvb+j25Yo4vw2zDxDr8erU0EWQ50NHlmQDDrgHwo=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:From:To:Cc:Subject:
         Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
         Content-Transfer-Encoding:X-Interia-Antivirus;
        b=WThV9DDTSdsJ80UOkOqJL9wuB7EK84n0yq142KEyd2LsL2tPjeJEMxSCrE1myXFQx
         H7EzHvFVQZcBtWft24XjWeVocD8SYXO8kX5Xfn1oWNOxfwWR1/7kdeis5htBnbMR15
         0nfci4J/PNHsdlG61i/HouRT1vUNHxT4CZIxcavQ=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ad7280_channel_init function has been split into more specific
functions to increase the code readability.

The setting of channel's scan_type.shift to 0, has been removed, since
it is the default value.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
Since v1:
* Added ad7280_init_dev_channels function.
* New functions are now using struct iio_chan_spec rather than struct
  ad7280_state.
* Channel's number on device calculation has been moved to macros.
* scan_type.shift assigned has been removed.
---
 drivers/staging/iio/adc/ad7280a.c | 133 +++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 14f6a3ced060..8439a4e23228 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -97,6 +97,10 @@
 #define AD7280A_NUM_CH			(AD7280A_AUX_ADC_6 - \
 					AD7280A_CELL_VOLTAGE_1 + 1)
 
+#define AD7280A_CALC_VOLTAGE_CHAN_NUM(d, c) ((d * AD7280A_CELLS_PER_DEV) + c)
+#define AD7280A_CALC_TEMP_CHAN_NUM(d, c)    ((d * AD7280A_CELLS_PER_DEV) + \
+					     c - AD7280A_CELLS_PER_DEV)
+
 #define AD7280A_DEVADDR_MASTER		0
 #define AD7280A_DEVADDR_ALL		0x1F
 /* 5-bit device address is sent LSB first */
@@ -496,63 +500,98 @@ static const struct attribute_group ad7280_attrs_group = {
 	.attrs = ad7280_attributes,
 };
 
+static void ad7280_voltage_channel_init(struct iio_chan_spec *chan, int i)
+{
+	chan->type = IIO_VOLTAGE;
+	chan->differential = 1;
+	chan->channel = i;
+	chan->channel2 = chan->channel + 1;
+}
+
+static void ad7280_temp_channel_init(struct iio_chan_spec *chan, int i)
+{
+	chan->type = IIO_TEMP;
+	chan->channel = i;
+}
+
+static void ad7280_common_fields_init(struct iio_chan_spec *chan, int addr,
+				      int cnt)
+{
+	chan->indexed = 1;
+	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
+	chan->address = addr;
+	chan->scan_index = cnt;
+	chan->scan_type.sign = 'u';
+	chan->scan_type.realbits = 12;
+	chan->scan_type.storagebits = 32;
+}
+
+static void ad7280_total_voltage_channel_init(struct iio_chan_spec *chan,
+					      int cnt, int dev)
+{
+	chan->type = IIO_VOLTAGE;
+	chan->differential = 1;
+	chan->channel = 0;
+	chan->channel2 = dev * AD7280A_CELLS_PER_DEV;
+	chan->address = AD7280A_ALL_CELLS;
+	chan->indexed = 1;
+	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
+	chan->scan_index = cnt;
+	chan->scan_type.sign = 'u';
+	chan->scan_type.realbits = 32;
+	chan->scan_type.storagebits = 32;
+}
+
+static void ad7280_timestamp_channel_init(struct iio_chan_spec *chan, int cnt)
+{
+	chan->type = IIO_TIMESTAMP;
+	chan->channel = -1;
+	chan->scan_index = cnt;
+	chan->scan_type.sign = 's';
+	chan->scan_type.realbits = 64;
+	chan->scan_type.storagebits = 64;
+}
+
+static void ad7280_init_dev_channels(struct ad7280_state *st, int dev, int *cnt)
+{
+	int addr, ch, i;
+	struct iio_chan_spec *chan;
+
+	for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_AUX_ADC_6; ch++) {
+		chan = &st->channels[*cnt];
+
+		if (ch < AD7280A_AUX_ADC_1) {
+			i = AD7280A_CALC_VOLTAGE_CHAN_NUM(dev, ch);
+			ad7280_voltage_channel_init(chan, i);
+		} else {
+			i = AD7280A_CALC_TEMP_CHAN_NUM(dev, ch);
+			ad7280_temp_channel_init(chan, i);
+		}
+
+		addr = ad7280a_devaddr(dev) << 8 | ch;
+		ad7280_common_fields_init(chan, addr, *cnt);
+
+		(*cnt)++;
+	}
+}
+
 static int ad7280_channel_init(struct ad7280_state *st)
 {
-	int dev, ch, cnt;
+	int dev, cnt = 0;
 
 	st->channels = devm_kcalloc(&st->spi->dev, (st->slave_num + 1) * 12 + 2,
 				    sizeof(*st->channels), GFP_KERNEL);
 	if (!st->channels)
 		return -ENOMEM;
 
-	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
-		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_AUX_ADC_6;
-			ch++, cnt++) {
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
-		}
+	for (dev = 0; dev <= st->slave_num; dev++)
+		ad7280_init_dev_channels(st, dev, &cnt);
 
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
+	ad7280_total_voltage_channel_init(&st->channels[cnt], cnt, dev);
 	cnt++;
-	st->channels[cnt].type = IIO_TIMESTAMP;
-	st->channels[cnt].channel = -1;
-	st->channels[cnt].scan_index = cnt;
-	st->channels[cnt].scan_type.sign = 's';
-	st->channels[cnt].scan_type.realbits = 64;
-	st->channels[cnt].scan_type.storagebits = 64;
-	st->channels[cnt].scan_type.shift = 0;
+	ad7280_timestamp_channel_init(&st->channels[cnt], cnt);
 
 	return cnt + 1;
 }
-- 
2.19.2

