Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406095;
	b=b2B+ANYiXgycbMxUSARYiMfR2pOnglddunzBTC1xH9M0VftVW17pw4MmvKDdmnDkn1Pz
	 uiiuwLLb6d1BH5RuZO3jW92O56bJeGwOkFCTleGZuTRC+U+muW8eEmrUerKGZ3BPjP1j8
	 gu/v5clHTezAJ6pYz/F3qU4RUwnZ2EAr+nWbyx4V9OixuLNO/+BKQ0csznUZIvbasxt5o
	 yNoGsIZozDAQcKeX323BbF8VGOwGdtmGnOoVTKuDjkAJLpsh9DFMF7DDeGH5PdEbnLn+I
	 CbIH7dF5ZbVbrvj7njllWzxNJ+ywdZgT51um+nXgtdWMgRFW3APfnM95/EFkrP7j2Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406095;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=M4TQkS/4uRsaf+2um8+K1isR7Sts+By3YzjOStk6Rdo=;
	b=rDUHq0Jj1OqM2GgisJiC445e2VpcyBfBmMBkSK3aPluDUdpM1uDlZ8reU19uhh3497Xl
	 c29WivjYVoRcm5HdOmb+DGjFijo0rQHZxX1bk8H5pK8mu0VxUWVGJdTPN1ecKxICfZhS/
	 CCLzAvlkbkSzt40g8pyg6yeqjiRjfXChdK/3oRm/KHAglqvVMXZtp+8zX/fpgN/OvHlCc
	 xCab4v1Uf36N4daiYrjqrL8MdJKz1pKRYBHjApsQY+5TO7B0WYJ7xc2VCkkAfG+y75F8m
	 m98MSJpnyGpGvSXJDCHVsFmrkuEW/2bhgNOwmevP7ULqxMEXLb2TcEkPJvOB2s0e6eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ErUTvQno;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F22606A32A;
	Mon, 23 Nov 2026 03:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1F22606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ErUTvQno
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=M4
	TQkS/4uRsaf+2um8+K1isR7Sts+By3YzjOStk6Rdo=; b=ErUTvQnoDRnb/RlhAA
	aN7EXUmmlohlSNmaHGfh7NKEHWF42Z30rWMgmqS3/vRJULM2P5rMIO14/xXLtYGl
	UfD698ut1BB6xpyoxBD0sPYh+tIPWsLM9GG3vtCIx/X7Rp9iftbVQbifN0Kit/Cr
	kCeVZe7qcHNC5dzM+hN5MnoMc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBX3UDhuANrzxO8Hg--.53023S3;
	Mon, 23 Nov 2026 11:54:15 +0800 (CST)
From: Wanhui Fu <fuwh1120@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Wanhui Fu <fuwh1120@163.com>
Subject: [PATCH v2 1/3] iio: adc: twl6030-gpadc: use devm_add_action_or_reset() to disable IRQ
Date: Mon, 23 Nov 2026 11:53:29 +0800
Message-Id: <20261123035331.1871875-2-fuwh1120@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261123035331.1871875-1-fuwh1120@163.com>
References: <20261123035331.1871875-1-fuwh1120@163.com>
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
X-CM-TRANSID:PigvCgBX3UDhuANrzxO8Hg--.53023S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFyfKFyrAF48Zr13Xr4rGrg_yoW8tF48pF
	4UJa4qkFWjqa1S9F48JF1DAryUCrsrGr92q3y7G3WSva45Arn8WF1kJFyIvF4UJryrGryf
	XaySyFs8uw47AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UyT5dUUUUU=
X-CM-SenderInfo: xixzxiqrsqqiywtou0bp/xtbC7QcDomsDuOfItAAA3A

Register twl6030_gpadc_disable_irq() via devm_add_action_or_reset()
and remove the manual call from twl6030_gpadc_remove().

Modify twl6030_gpadc_enable_irq() and twl6030_gpadc_disable_irq() to
not take a mask argument, since the mask is always the same.

Fixes: 1696f36482e7 ("iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver")
Signed-off-by: Wanhui Fu <fuwh1120@163.com>
---
 drivers/iio/adc/twl6030-gpadc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index e7fd371b3404..786059cf7513 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -360,8 +360,9 @@ static inline int twl6030_gpadc_read(u8 reg, u8 *val)
 	return twl_i2c_read(TWL6030_MODULE_GPADC, val, reg, 2);
 }
 
-static int twl6030_gpadc_enable_irq(u8 mask)
+static int twl6030_gpadc_enable_irq(void)
 {
+	u8 mask = TWL6030_GPADC_RT_SW1_EOC_MASK;
 	int ret;
 
 	ret = twl6030_interrupt_unmask(mask, REG_INT_MSK_LINE_B);
@@ -373,8 +374,10 @@ static int twl6030_gpadc_enable_irq(u8 mask)
 	return ret;
 }
 
-static void twl6030_gpadc_disable_irq(u8 mask)
+static void twl6030_gpadc_disable_irq(void *data)
 {
+	u8 mask = TWL6030_GPADC_RT_SW1_EOC_MASK;
+
 	twl6030_interrupt_mask(mask, REG_INT_MSK_LINE_B);
 	twl6030_interrupt_mask(mask, REG_INT_MSK_STS_B);
 }
@@ -921,12 +924,16 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = twl6030_gpadc_enable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
+	ret = twl6030_gpadc_enable_irq();
 	if (ret < 0) {
 		dev_err(dev, "failed to enable GPADC interrupt\n");
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(dev, twl6030_gpadc_disable_irq, NULL);
+	if (ret)
+		return ret;
+
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCS,
 					TWL6030_REG_TOGGLE1);
 	if (ret < 0) {
@@ -967,7 +974,6 @@ static void twl6030_gpadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 
-	twl6030_gpadc_disable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
 	iio_device_unregister(indio_dev);
 }
 
-- 
2.25.1

