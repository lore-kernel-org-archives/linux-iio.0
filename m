Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406092;
	b=JfKZkabgq4v3iSsRG7DDHK17waEi3MJKrhQcxLMmsU4yJCl7Kec61vxh4EZWqDf31NFa
	 ora87SzprKy+MCR/NB0P2WEuP4J+W27nTFtikYqg4oJIpV7PPHPp5ARj3FXXoXhyvYBwd
	 wODKOMYV0uipCVlr3BTZXzKL1WeP6FKKtaSgx2US8vanS1A4oOKLpMFnVzs809O2I+kfV
	 4kmkWOj2LytzzNuAPFEg9cdvJ9AFaidKC8f/fQKCewgO5w46YWh/kPWTAqZAdTSHW8jSk
	 EM4ld1pxIixeeJAIL2Vnklv4lW+JWN5NZsvyGhCndgbsQksJRUkOavLlCba88FmLzxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406092;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=ZCCdezeAyN0rcDEr4JRHky12zUlsRDIWan/Mi8xo6lg=;
	b=gKwHaTadQI0lDk2jHUdd6ohmiyZhARFVanhkrWhL8lyp7sM6GQ6a/gsqekhFpjhfE1ob
	 ErnI/5RnOwSDxMDwVeIVndx9M4nVURcfCmVGONYz0s5q9vMyR8QtGZHd6KK1YlUHIXzOk
	 nYoXVv6JIGLQJ3qsPL1MOSZ6jXSeTaFRVtA8+xMoQ7pc6DCiyL0vfRac+bPIxAcJKdUD6
	 uNOWqPgV2M0TwThqXfUyJesTu4hWq6UUHSgoPU86WmtLO+dgAjuNd41+jv7reiSQdc3C/
	 Lqd5DRLS7uqlirdDnw0OhWIkXdsNF2JoJ5XmRISQDU2HQOLH6Wa6uFwiF1HuYoYVI8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XoQAYHFE;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64B8606A320;
	Mon, 23 Nov 2026 03:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E64B8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XoQAYHFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZC
	CdezeAyN0rcDEr4JRHky12zUlsRDIWan/Mi8xo6lg=; b=XoQAYHFEC6k3h6ioMc
	9zn+Gaiu7fkMiBiTUvYMmowyB4LNiQkv26kGV+S7awA/5HAMamGfYPuWtofWqb3+
	isF3uuqZbydO00A1Bn0QNRl6M6Nki96G0AuNRPV7B0KgPcyVo0GNdjcBSza/0Pgx
	ddRJdwR3U2Bvh2gVDv4SCpEGQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBX3UDhuANrzxO8Hg--.53023S4;
	Mon, 23 Nov 2026 11:54:17 +0800 (CST)
From: Wanhui Fu <fuwh1120@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Wanhui Fu <fuwh1120@163.com>
Subject: [PATCH v2 2/3] iio: adc: twl6030-gpadc: switch to devm_iio_device_register()
Date: Mon, 23 Nov 2026 11:53:30 +0800
Message-Id: <20261123035331.1871875-3-fuwh1120@163.com>
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
X-CM-TRANSID:PigvCgBX3UDhuANrzxO8Hg--.53023S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyDZr4Dur15GF45WrWxWFg_yoW8Ww1UpF
	yDXasakrWUKa13t3W8X3WDZFyjkFnakw10qrWxWw1S9as5Ar1Yvr1rtF1IyF1rJFWkCF17
	X3y3Cr4UuF47ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UvzutUUUUU=
X-CM-SenderInfo: xixzxiqrsqqiywtou0bp/xtbC7QkEo2sDuOnJEAAA3j

Convert iio_device_register() to devm_iio_device_register().
This allows dropping the now-empty twl6030_gpadc_remove() and
the unused platform_set_drvdata() call.

Signed-off-by: Wanhui Fu <fuwh1120@163.com>
---
 drivers/iio/adc/twl6030-gpadc.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 786059cf7513..591c7b3322c7 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -904,7 +904,6 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 	gpadc->dev = dev;
 	gpadc->pdata = pdata;
 
-	platform_set_drvdata(pdev, indio_dev);
 	mutex_init(&gpadc->lock);
 	init_completion(&gpadc->irq_complete);
 
@@ -967,14 +966,7 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 	indio_dev->channels = pdata->iio_channels;
 	indio_dev->num_channels = pdata->nchannels;
 
-	return iio_device_register(indio_dev);
-}
-
-static void twl6030_gpadc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-
-	iio_device_unregister(indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int twl6030_gpadc_suspend(struct device *pdev)
@@ -1006,7 +998,6 @@ static DEFINE_SIMPLE_DEV_PM_OPS(twl6030_gpadc_pm_ops, twl6030_gpadc_suspend,
 
 static struct platform_driver twl6030_gpadc_driver = {
 	.probe		= twl6030_gpadc_probe,
-	.remove		= twl6030_gpadc_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.pm	= pm_sleep_ptr(&twl6030_gpadc_pm_ops),
-- 
2.25.1

