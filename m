Return-Path: <SRS0=4vqF=OL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0DEC04EB8
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 11:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555422081C
	for <linux-iio@archiver.kernel.org>; Sun,  2 Dec 2018 11:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="cq9sCRko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555422081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbeLBLmL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 Dec 2018 06:42:11 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.155]:40624 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeLBLmK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Dec 2018 06:42:10 -0500
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <localhost>
Received: from localhost (unknown [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Sun,  2 Dec 2018 12:42:01 +0100 (CET)
From:   Slawomir Stepien <sst@poczta.fm>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 1/1] staging: iio: adc: ad7280a: fix overwrite of the returned value
Date:   Sun,  2 Dec 2018 12:42:35 +0100
Message-Id: <20181202114235.12443-1-sst@poczta.fm>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1543750923;
        bh=P+SsVY66WxW4HLzbTuD/HVSn4eAJsp8aPHuUDX6DARc=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:From:To:Cc:Subject:
         Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
         Content-Transfer-Encoding:X-Interia-Antivirus;
        b=cq9sCRkoEHmp4yKq+C8DE3ULGkNnEdtdd3IbflzNW+5HKlrx3429JMrE6Cdj6/a++
         JEEPjyNIFBHH2oyw3pfkT/MIQPPacQHAJkV/jRuYhsWUns2SSTREs6VJyNb+jGhfSX
         1zvk0RxY+czcU9q8V5s7C2hfbnSHDfdIM6L0kfxk=
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ret returned from ad7280_chain_setup() is needed to initialize the
slave_num. Don't overwrite it with call to devm_add_action_or_reset().

Fixes: cc9c58ef6e06 ("staging: iio: adc: ad7280a: use devm_* APIs")
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/staging/iio/adc/ad7280a.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 7a0ba26f9fd9..14f6a3ced060 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -879,15 +879,15 @@ static int ad7280_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	ret = devm_add_action_or_reset(&spi->dev, ad7280_sw_power_down, st);
-	if (ret)
-		return ret;
-
 	st->slave_num = ret;
 	st->scan_cnt = (st->slave_num + 1) * AD7280A_NUM_CH;
 	st->cell_threshhigh = 0xFF;
 	st->aux_threshhigh = 0xFF;
 
+	ret = devm_add_action_or_reset(&spi->dev, ad7280_sw_power_down, st);
+	if (ret)
+		return ret;
+
 	/*
 	 * Total Conversion Time = ((tACQ + tCONV) *
 	 *			   (Number of Conversions per Part)) −
-- 
2.19.2

