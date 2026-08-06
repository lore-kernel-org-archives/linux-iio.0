Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B831986C
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 02:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983989; cv=none; b=g8VLJPTiCt8BPZMPoy+eMnjTL42o23oVeu9v3EKZFKAU+wXJTir4KVfMjzOFmSm7KzzP9W29NNZT53p9gx0qrm5fblkGrsRLl3DO74ZTnMuKHSqIb6txsWJA0xczFdC9Wk0/lyaOH8p9vheqjCMMqLOD2+NGM5ABNtROEXL7o0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983989; c=relaxed/simple;
	bh=YFBQMGpv/fzc68+3vSr4+6oulYuybifQYme219waj9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijptWr7W98THPYJe7y9xmWjujV8Ib4NCcdE8EQ3GcAQpsXHPljKLMwjvckRy63IM/A80YF9VuljlNzcVOj6M5ijzoD62ivp5656nNNIcIMVBnaRfmxG51e3hupkvmf/YtYAjoqTqlAIM6VjJmjj5rPMX7JRJSChyZFHY4Ui7Tew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cx9Z2X9p; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx9Z2X9p"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ce98cb8165so5986215ad.1
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 19:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785983987; x=1786588787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xYUmODFIR/IRQId3RZvFC3D9rE53RZwWUE1u52S9Ovc=;
        b=Cx9Z2X9prG439Qpc1BuI/mdzQ0g/aNXm6fqBbRIwslDjNMB07dYiavSAntdw62kRcc
         f75lIqRP5JJucDPXMR0gm4yDJUWiBlVstD5oFzFByoSL9byl9lzMVGX0HBFvAt5pTNtX
         jgEB0qR1cqJAFajTITa6s7A+ymQC8WmBt/rvyYSlcqRaFBL/1rOY2gSq6fUAqlLSbBDc
         atzYttF+u4P5wH1XftEZSggWvs1yCT+evqykA200DXuJcjo4sQXy5rlRyRKrNTJo4FMN
         GTLSkDOkkHb2+k+JlWT3kKDciVisRKc7Ioif60mbahDbBuKcBYQwnzR5BJyXKinnqumz
         n4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785983987; x=1786588787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xYUmODFIR/IRQId3RZvFC3D9rE53RZwWUE1u52S9Ovc=;
        b=jr8WkxCLajcAOgwkkwUyqWFChgpChiUgm+3cWEWG2e4g1xWfPKIjN87VtSqA+sspan
         MKEP1qYtuxc+l0lV8j+f7srSn9crErb3HpEtlGgIBQTkq/CSHngu4/ZPq62YiSCCdHuD
         WlK81lLH1H04VNmXQAfKVc/ixpzypkXvY0BpDo//BYc0JJuAODslBptI1SweVWDd3on6
         FfxgHJie2vhQW77W6xpRFsCIvRR0mci5lo7OONH0IDc4V8S85zUZoE/WwagdfZMlAKnk
         54skBAITWtpmMK7/0LVV2qT6I0uFsLh9463LfHUShcU039t3/JPkQHjpSMBQKn5cXRH8
         0DXw==
X-Forwarded-Encrypted: i=1; AHgh+RqRcfofcNIk+aKk3JGwdilYKMKGBMHJ4kZOja/hMh8FNhUPpaAs69+nCJmaPzclSvS+Uv8/SRPvjRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmZWzAorKD6dHrcF0gXlVkzczwV4y2bvYimJ/O+b0mJq6pkA1E
	QRHqqyu4kgU3Y+XBr25UcgFPEM1MLi/DA67o50K2qTmuQvRkON853FHn
X-Gm-Gg: AR+sD12Vjs41+l/KcvDnJXjdCOc0H1c63GgR5yMRmwCF+fOvbh8I24a/Y5qxub3OntX
	uAmHZWmW2HRDOZuFKSr0Urh17ef0cGSTfV7GWEWGUjL0l2PxQ2I2JM/85kMXXFORF+MyBYcqm33
	ZhzU+3S/4/LawNBUoCuLM3yR7REGQ84BRYl+AK0syCJg7KQumocBnhXmU05FwCvpi6e8deDsXnE
	enxK7XIC3Myx9F4QJRi990VWycnag6+0JHk72C4g0LP5Qjf/nqZPzhPpbj2sn6H7uQOdXWlL3le
	WBMFn5G57sGyEFaolaMpx4Dri3KnXttCjxKBgc7Z7wKpa+GDNDLosV5JIyMSUY8TWaH/1vgGGiB
	qyhEsbt26y81aL1BPRRhXsP110yDN7SHpMmVKvD3TFPYZGf6eiKQ02xGFsKbQdyUrX94AG6d9wR
	AJKW+Dx7T6SaD4HydWnioFXwToBcxIt/QTdSLIeyNSqA71NtwbyXXUllbL1gU=
X-Received: by 2002:a17:903:38c4:b0:2ce:a6a4:451b with SMTP id d9443c01a7336-2d0f1c130bamr41161845ad.11.1785983986900;
        Wed, 05 Aug 2026 19:39:46 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:3194:1e48:e141:80ab])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867d4929sm22404383eec.30.2026.08.05.19.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 19:39:46 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v6 2/3] iio: adc: bcm_iproc_adc: Introduce local device pointer
Date: Thu,  6 Aug 2026 08:09:01 +0530
Message-ID: <20260806023902.8608-3-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806023902.8608-1-mdshahid03@gmail.com>
References: <20260806023902.8608-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Introduce a local 'struct device *dev' variable in iproc_adc_probe()
and use it for device-managed helper calls instead of repeatedly
referencing '&pdev->dev'.

No functional change intended.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 7c2e2770cd61..a07a590662c4 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -506,10 +506,10 @@ static int iproc_adc_probe(struct platform_device *pdev)
 {
 	struct iproc_adc_priv *adc_priv;
 	struct iio_dev *indio_dev = NULL;
+	struct device *dev = &pdev->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev,
-					sizeof(*adc_priv));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc_priv));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -528,7 +528,7 @@ static int iproc_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	adc_priv->adc_clk = devm_clk_get(&pdev->dev, "tsc_clk");
+	adc_priv->adc_clk = devm_clk_get(dev, "tsc_clk");
 	if (IS_ERR(adc_priv->adc_clk)) {
 		dev_err(&pdev->dev,
 			"failed getting clock tsc_clk\n");
@@ -547,7 +547,7 @@ static int iproc_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, adc_priv->irqno,
+	ret = devm_request_threaded_irq(dev, adc_priv->irqno,
 				iproc_adc_interrupt_handler,
 				iproc_adc_interrupt_thread,
 				IRQF_SHARED, "iproc-adc", indio_dev);
-- 
2.43.0

