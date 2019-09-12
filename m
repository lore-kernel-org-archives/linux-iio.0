Return-Path: <SRS0=G7X0=XH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B86C4CEC7
	for <linux-iio@archiver.kernel.org>; Thu, 12 Sep 2019 14:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDD6206A5
	for <linux-iio@archiver.kernel.org>; Thu, 12 Sep 2019 14:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiw6Ha65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbfILOnj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:43:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46199 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732722AbfILOnj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2019 10:43:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so15988261wrq.13
        for <linux-iio@vger.kernel.org>; Thu, 12 Sep 2019 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0S5huaYKgRvwr4SWApclRaTXV4uX21BxatCAo87A5Sw=;
        b=eiw6Ha65281PYedEzUJ6eCGWsRU8vMM9yb2R4gDzPkWQ3PeKZOZPdMEwQKAyvsXD/2
         F6+H+0eQAlqUTFfy03CcTWXcclPCTGW3Wfhz8nPkuyFRucNjgnUcB6atJg7wYt+VcWam
         6Kh1dQY014qV2XmUxgfDDodHztwA4kBxRVVnVwV7cH7GO23LuE9D4gn/8DZ/A3U2/T81
         mpIreyCP/33owO3a0D06RQAgTgCv4TaZc7hZV95MrocYpuNe4zlbi5H1qbuFj70d5LYa
         LizkVDr76XyJztC50ZH8bHvIF34+zIbP3hUC0m6JUzEEMAVRcXhQ4QPmIKDvkDEleIWz
         mhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0S5huaYKgRvwr4SWApclRaTXV4uX21BxatCAo87A5Sw=;
        b=n2sGj3/hRwIr+r29pnREUG+kQ1e6DzOZO3nTkJrrXlEqugYks6PmVUv29nyNYDpCUJ
         MeElIvQ00fWEpldwSSGq5qAr9zF0kwXpa0SxIyzI08W9mIfPAvxksF8qu+32fYm8Ytad
         CdOey04+/2PbHZUgSqLM8cUr232RFDJhJ5MfESiiqWsNFkoV2gM9FaDEHB88rfUczBk4
         9OaWF5gZnjCif33jk5NFBXab9Iz0F77HNWuCFUWEfgKkFoErFEZKJTFfcrt7Gb2Vx0O1
         yJekFnFFWtohKi6+SaKubonNYEO2DPXl0vP8rve3NSewfaFdm3GY3mnAiiWcC7LYfBhs
         n2DA==
X-Gm-Message-State: APjAAAWewNPHXMlW1IQF+xrJvyPVplGnH7OF+E50SSLRKZD1tf6zHRqg
        yhb53RGBA5dxJ7ZyBnGIFU8=
X-Google-Smtp-Source: APXvYqzOEii8Hz5BW3kZOjyQVBUN/zAP+E7Q7hVE9sHFvH4SPiGHp8dwjVYoeUKwT+H8oRAw2X0zHA==
X-Received: by 2002:a5d:5281:: with SMTP id c1mr3770078wrv.339.1568299416955;
        Thu, 12 Sep 2019 07:43:36 -0700 (PDT)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id q19sm35175256wra.89.2019.09.12.07.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 07:43:36 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org,
        Andrea Merello <andrea.merello@gmail.com>
Subject: [PATCH 3/4] iio: ad7949: fix SPI xfer delays
Date:   Thu, 12 Sep 2019 16:43:09 +0200
Message-Id: <20190912144310.7458-4-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912144310.7458-1-andrea.merello@gmail.com>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The driver calls udelay(2) after each SPI xfer. However, according to
the specifications, the SPI timing should be as follows:

1- The end of SPI xfer (CNV/CS rising edge) causes the device to initiate
   the conversion phase, which takes up to 2.2uS.

2- At the end of the conversion phase, the device starts the acquisition
   phase for the next conversion automatically (regardless to the state of
   CNV pin); the conversion phase should last at least 1.8 uS

The whole cycle timing is thus 4uS long. The SPI data is read during the
acquisition phase (RAC mode, no need to worry about "Tdata").

In order to be compliant wrt these timing specifications we should wait
4uS after each SPI xfer (that is conservative, because there is also the
SPI xfer duration itself - which at the maximum supported clock should be
about 320nS).

This patch enlarges the delay up to 4uS and it also removes the explicit
calls to udelay(), relying on spi_transfer->delay_usecs.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 drivers/iio/adc/ad7949.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 5c2b3446fa4a..25d1e1b24257 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -69,6 +69,7 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
 			.tx_buf = &ad7949_adc->buffer,
 			.len = 2,
 			.bits_per_word = bits_per_word,
+			.delay_usecs = 4,
 		},
 	};
 
@@ -77,11 +78,6 @@ static int ad7949_spi_write_cfg(struct ad7949_adc_chip *ad7949_adc, u16 val,
 	spi_message_init_with_transfers(&msg, tx, 1);
 	ret = spi_sync(ad7949_adc->spi, &msg);
 
-	/*
-	 * This delay is to avoid a new request before the required time to
-	 * send a new command to the device
-	 */
-	udelay(2);
 	return ret;
 }
 
@@ -97,6 +93,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 			.rx_buf = &ad7949_adc->buffer,
 			.len = 2,
 			.bits_per_word = bits_per_word,
+			.delay_usecs = 4,
 		},
 	};
 
@@ -112,12 +109,6 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 	if (ret)
 		return ret;
 
-	/*
-	 * This delay is to avoid a new request before the required time to
-	 * send a new command to the device
-	 */
-	udelay(2);
-
 	ad7949_adc->current_channel = channel;
 
 	*val = ad7949_adc->buffer & mask;
-- 
2.17.1

