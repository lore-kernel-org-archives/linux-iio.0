Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417303;
	b=ODKc48Y767e4NBcfa7BtVFzGiDlnhkO1Qs7zCPFgXRLdajtMnxRCw+OgTDhAmZ3a64oT
	 ukXhqOW3if86kfvRB9ILJ+HWlmPlo+Ew+SlSMWhQdXnMGFmN0ysYcOMmXaZhmZrFVibgh
	 GmNk+NX5+CWyOpjidBwu4LBko26SCWiNTLDFas11gk1uWT/DCSB9iOxzv7vugUGB89s+E
	 wzjPcU+q+4NvQtbidvQMxamGZfQI8nlLZS45ZN53q+lelRtQdDMMRpha2lSCCBUoeC9aI
	 5+iPakmdU5+YqX5Q+O8tWhDH4SCE/0Iit8oY6dbXRA0+7ONgbAo+OVy8AGoY1I6FGog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7+UTTu55kRQmUMdXJ+fvljsspj1Aytx1XWkYCAQNT5E=;
	b=SqP23mstrhURgrFr39OA0BGzf3QE/NbqUXrCeYOp+JJtrasjuFPzh4Vic+N7+5ueNd3p
	 pqg15h7v3f8BFdfy3PbuedD1vUZjRtMcTD7gmPh8vBA73zpy02khR7t9QX2suPLUrpxAv
	 +vbJUSuh/GQohCyxWN/7kHcjkGTvEClQxO31GUUPYURqOPnlry/23XXzmXtedQPzk5npq
	 joz3B3mzjdbFa6UFSC1ZlOhD5FgDfdzHzWM+dHABE14n7zmbYSjIS//UCqbvQ2Uz3dkpc
	 l/uoMrWsGh7qC9VYEBG7xaSrwB+jaiyeKHZiCZwhXovJUSZ2VZvQ2kxYwp+U/0waiyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EMuYwgcu;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E24606A331
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 07:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25E24606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EMuYwgcu
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4aa5833c263so2744637f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 23:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795417300; x=1796022100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+UTTu55kRQmUMdXJ+fvljsspj1Aytx1XWkYCAQNT5E=;
        b=EMuYwgcu4aXZ1yW0w/zqheN21Qp2qjOnboDqh3MH9Zjnh+8HaFazGiz69xCzzHjkJ3
         HZHacHIrj5VcQ1gR/5vQbQrVL4d1MbGcFpWK42ORVo5o3MR9aPmBBjJYdxySNFcwYpOs
         RqAQGkwgtEl+4AG3jkUzVHjMBJjbgeonUICyUluhfVOlf/T5fkVKs/22di0ACYDZxf7G
         5Ae12OupStszu/fNlTZItgLZ/8zHOoxMsEmB+Dx6nlv9O6doCXFFPVknpK1SE/Z/WRQj
         QPMJQ/MBQpCRlddEKK1a6iHQSdNsoH3F77PGQ3yVYGN9IesRDTfa+q+tqYWzs50p6P6o
         kepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417300; x=1796022100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7+UTTu55kRQmUMdXJ+fvljsspj1Aytx1XWkYCAQNT5E=;
        b=ihHCQxiAzdxl4MM5IAPsenibZlEiq/zeTa4ZZbTxQpJG2mjatIxnp2nawILogJ23gm
         6q6Wc5Y4DsTEnG95kS+PDXWMND0SSseno2mlPiTcKA9q/I1ZigAnLiBQZXUf1jsHhoqU
         Ek/HN6rZd4ORUI7t8EvZRJf/3QyqFzpfdw9CsUBEL4+0hp6t5zakIoA0Wln+p2Ed/8f5
         WwjjxwDjyjToTzEGudYZTsJHn/tOfwe+ISZfdTE7dox/CJ4Tw0u6DRewSbEsvNVQeWHZ
         ZJqSI8QamNrH0SdWI0tDMOnoU7xSFt8WMByl1PVODo5pU9HnNpnG7Y86xWruAHFFVckh
         OdNA==
X-Forwarded-Encrypted: i=1; AL+hErGF/oLYxoSnvrSJyi8TBIjHK6J5ZmLrrz8MktQW3BslLHRYEpCuZyF8YZh3QWkYyiN6ZSOnXeMhq0c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fomIRu3pSMkyljk6/8ix50TmEkXBWrsYRfg0GPkGM9cV3Ipbg
	l7xP9cRnehO8a4VjE25t3TMtiWRzGdYZZiFwPIH/wKsBm7qngjvgT/uD
X-Gm-Gg: AZFdTZdzfd7teijmQIs6QkDI9BcYQ3YUqdagbzL4J2Lcp51MGY2c/7m7DnBJsHRWskV
	JYB7ibQr3wIF0+NPQaE1eDv48ZDqPfNYlLaf+Msq77L2DRAVNEsjB/TqMNIjJh1/6uoK27QKCVC
	XKPRRYqxvTo7p2Re5iuMYFB1TrLUABo7v2XcqPZ0UsR0e1M2RT57FyChfNmzZULNFvecZYK48Of
	N54jOqUvomDOEZQsKbvIYejtiD5w3mtjyhQQh71rms45FTo1J24gNvBaaUSmR/dEBZtMpR6/Eae
	Hs399qlg9uIj6lyHwxXZaIjpbOZU1TT7vXSXvXCa9yi4ePXkm/kpbBtwa0wFZhBMq01ChXWMhQW
	IrJH4kqXoZFzb/WVS+18Y2JAbj7kpG/jh7RJPHvGaMy0yFN1k2DCD6aiveAiwSAqkSd12/CU7sH
	mymMs3ho7vyf/NIdu5chnLmVg/o4NFk+f4MlR8Pf5shEJqiU1rTwp8dcDQuuTGokoY1OKYv3U8Q
	y1kEWiZGV8p6l1XOvTx7A9oWUG6alI9iQKmHSbYqyFA1wb6sSRwW+fgXbo1pG75ewv9tqfFAEsR
	BQ3EjfwMHRchouHSdrWzHO3neQ3tmjpLTXco
X-Received: by 2002:a05:6000:1a86:b0:4ad:d65:aaf9 with SMTP id ffacd0b85a97d-4ad0d65afa1mr19754515f8f.56.1795417300486;
        Sun, 22 Nov 2026 23:01:40 -0800 (PST)
Received: from fedora ([154.182.66.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm20779007f8f.3.2026.11.22.23.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:01:40 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com,
	amin.gattout@gmail.com,
	antoniu.miclaus@analog.com,
	gregkh@linuxfoundation.org,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v5 2/8] iio: adc: at91_adc: drop duplicate IRQ allocation error message
Date: Mon, 23 Nov 2026 09:00:55 +0200
Message-ID: <20261123070101.53868-3-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_request_irq() already logs an error message when it fails.  Drop the
additional dev_err_probe() wrapper and simply return the error code to
avoid reporting the same failure twice.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 9ecf8ca362f5..76000486b17a 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1074,8 +1074,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 				       at91_adc_rl_interrupt, 0,
 				       pdev->dev.driver->name, idev);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "Failed to allocate IRQ.\n");
+		return ret;
 
 	st->clk = devm_clk_get_enabled(&pdev->dev, "adc_clk");
 	if (IS_ERR(st->clk))
-- 
2.56.0

