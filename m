Return-Path: <SRS0=4vqF=OL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDF8C64EB4
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 11:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FAB2082F
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 11:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="TU2/0mXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FAB2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbeLBL6F (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:58:05 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.155]:50849 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeLBL6F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Dec 2018 06:58:05 -0500
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <localhost>
Received: from localhost (ipv4-188-121-17-172.net.internetunion.pl [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Sun,  2 Dec 2018 12:57:59 +0100 (CET)
From:   Slawomir Stepien <sst@poczta.fm>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 3/3] staging: iio: adc: ad7280a: add braces to complex for loops
Date:   Sun,  2 Dec 2018 12:58:30 +0100
Message-Id: <20181202115830.20363-4-sst@poczta.fm>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202115830.20363-1-sst@poczta.fm>
References: <20181202115830.20363-1-sst@poczta.fm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1543751881;
        bh=7rmLiO93f+95AnYpYYxjBuFgIEEN1U9AmK3x6MoM450=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:From:To:Cc:Subject:
         Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
         Content-Transfer-Encoding:X-Interia-Antivirus;
        b=TU2/0mXKwDu+ojEeBO3pATs1gzM8jDlNtk3h+A0jIBCVeR18XcGw1IEjX2AKk0Y1l
         gUF/zgkoo8HInXiOsoi46bNSdkcr6LwAHV02qJJpBWtLtTISjKVTUHJ3QIPmWzd+IO
         TWxFcxb4jTLekII9gFPGFMXR4mByeg+vqPq8avbg=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These for loops have just only one instruction as its body. However this
body is complex, so add braces to them.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/staging/iio/adc/ad7280a.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 6faa85bf6f7e..6ec5a0d2a438 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -574,7 +574,7 @@ static int ad7280_channel_init(struct ad7280_state *st)
 	if (!st->channels)
 		return -ENOMEM;
 
-	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
+	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++) {
 		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_AUX_ADC_6;
 			ch++, cnt++) {
 			if (ch < AD7280A_AUX_ADC_1)
@@ -584,6 +584,7 @@ static int ad7280_channel_init(struct ad7280_state *st)
 
 			ad7280_common_fields_init(st, cnt, dev, ch);
 		}
+	}
 
 	ad7280_all_voltage_channel_init(st, cnt, dev);
 	cnt++;
@@ -642,7 +643,7 @@ static int ad7280_attr_init(struct ad7280_state *st)
 	if (!st->iio_attr)
 		return -ENOMEM;
 
-	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++)
+	for (dev = 0, cnt = 0; dev <= st->slave_num; dev++) {
 		for (ch = AD7280A_CELL_VOLTAGE_1; ch <= AD7280A_CELL_VOLTAGE_6;
 			ch++, cnt++) {
 			ret = ad7280_balance_switch_attr_init(st, cnt, dev, ch);
@@ -654,6 +655,7 @@ static int ad7280_attr_init(struct ad7280_state *st)
 			if (ret < 0)
 				return ret;
 		}
+	}
 
 	ad7280_attributes[cnt] = NULL;
 
-- 
2.19.2

