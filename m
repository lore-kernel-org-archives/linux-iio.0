Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BBCFC0A
	for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771753547; cv=none; b=m4N4jQENac3cqNWpe6/8hIe7WwzHJ/Lm3QdrAzs1tneR61POQYdAzsYu7HsJG5gyM9yPg1Ot2rMzKOTFkffgiy1e79L0DIzsnGHJ08goUCYHnZVhhq3lrqLpSJOX7FjsG52GTiPjzDUBtwQ5qFlGBy2EgWT9tnuAo/qSLFmJHaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771753547; c=relaxed/simple;
	bh=Q58s3FaYS+W1+PdVhrq3Ap+aQAsxjqwX2JUo4/L8TAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XNk4uSKp+Tsrz/UZzug6fh/o9MnZzEFx0T9GX6K+zCHnOXaFYDcedhkG3cIQhbqyTsnIU2anIRQoHRsz4blMiAxKmY5dVM4ZYuqk9UOCD+zYat9/svkGBUmRsGdxnYkRL4fWEHV3WdMhJ/TW7Y4ITD+3jxdRgREvfrKnQS0MiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2/rz2E2; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2/rz2E2"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so2165020a91.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 01:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771753545; x=1772358345; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e02DHxFr8gMzpHf2FtukLIqFujOEG5T0tla5YfzjmpI=;
        b=a2/rz2E2Lk2HmCXne5LELh1plK/cmmoNbr2Nfy5DNpBD33Tq/jWChXf0LNJ4lu0qfa
         mewa5Mc5Y7KC1sgKNGYkcBKRNgwxgcSyTo3zK6MhOYIsI7R00wY072hn2DaCVz9BTkvE
         yi/z15um7YFbOxhJC+huFvIPSwiwCslUzbyR3Gye/N4DEOdA5GhTxRghojGrog6qtdiM
         Nld4yE9oW7iGR9sFwSSMQb835oN8dlqolcWtVZgV7KRPwiNWtPclAO3J98Wi1pHXnzND
         cHse4UXtmHu0R6XrUZEqDsLd7vRg1fCq6quwSXeulyG7hHUr/NZ/EXN0KsNbDD4Uq/eh
         r//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771753545; x=1772358345;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e02DHxFr8gMzpHf2FtukLIqFujOEG5T0tla5YfzjmpI=;
        b=KHQvsD4QODi1Cm5s+NWK/HZcfyGQE5V4mvdTxQwz3KJlEaaiIcjFo15NcLm48sn5it
         9qDcGr6Dz3VbLw4l1RdG4RQOcF8YL13duAj3GiMwWtB4c8BDrVcmT0LST78CEwmTasgR
         uQqg3T+igVlu+guxt9CFxr3iVIFj8yuLwutpvCcSd4b3nnfKHLo1ARnQs37rbg1vTPzq
         +UioHqdZAH69VMOi589gjxIv+7JZjybFprXz5u4SEAtki+b4fj6Vd0tBI30oE8GV6OS3
         naHFMeyk8+ia37pAqt2dHlxCQrMi/J2ux9K+BdUnI5qrRQSpPwNamYEGA3Lhi/ajCrcP
         lSSg==
X-Forwarded-Encrypted: i=1; AJvYcCXbNzTd5qMoBS5JxzBwKm2LRDVLKPkhLatW93CAGbL1sCnplEHenA0lrAxl+ULZJSh8r6efJUTLXec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHJlV4rCz8iV6G1e6pEzp4jAQzyu/rOTtMYlhXYx2wbw1pkX5C
	V70vC4v2/ntkKLsJNoTnS/OJ+6SXe0KHlm/2PCyNu8CY5VzdEMTS7PmF
X-Gm-Gg: AZuq6aKKODZI3UT+V18wqvHU5oHMC+CH3TFk02utx8sryuhCpnI0lbDcSbe9skXTnMS
	P4Ol2em7l7FdNndqzxqWkGJpgLO5iXu+l1/6lcfEsmK+gHx/I4F5KCN+mcH7nz1uU8rbLofu1ph
	+5UyePZkQnU3VGU/XKcJVOMjuuAikcOBg6gZ9e84QKCPofgo7nnImy/Dpl4qesDGmUxQdo5yWEw
	cqwiRY0MNICsXauracMLbXqCm8+QSejuPx0LzHzQQoWA8yDdwrkD+KQObS7n3oVF2HIY9LsBs4I
	vYOsrh8GgHwO1JpKxfhMEuQrMKss/9tgkHOX5ZF2weavi3FLQtjffZv63wqPt6V1sCLwE3bZyxM
	HN1Q1rPvzkTI6yVZ/+LHBsuofSGbiSSbAUbptX5ErmY9f22+l2x4on7KybybIyZWpr1jtjJBnB2
	OgMwAWeXt7/Nj1r+T0kXJ+ayS+m3xzXvyYYg==
X-Received: by 2002:a17:90b:4cc7:b0:34c:718c:5448 with SMTP id 98e67ed59e1d1-358984ea764mr7749218a91.4.1771753545462;
        Sun, 22 Feb 2026 01:45:45 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9008:ba52:1:8bf1:8197:6d5f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358a2b39b66sm3278995a91.11.2026.02.22.01.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 01:45:45 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 22 Feb 2026 17:45:39 +0800
Subject: [PATCH] iio: adc: nxp-sar-adc: Fix DMA channel leak in trigger
 mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260222-nxp-sar-adc-1-v1-1-0ec0e00b25cb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAELQmmkC/x3MQQqAIBBA0avIrBvQWZR1lWhhNtVsTBRCEO+et
 HyL/ytkTsIZFlUh8StZntBhBgX+duFilKMbSNOoiQhDiZhdQnd4NLh7N5lT23n3FnoTE59S/t+
 6tfYBluUCdF8AAAA=
X-Change-ID: 20260222-nxp-sar-adc-1-bca71f089bc8
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Ciprian Costea <ciprianmarian.costea@nxp.com>, 
 Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771753541; l=2021;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=Q58s3FaYS+W1+PdVhrq3Ap+aQAsxjqwX2JUo4/L8TAE=;
 b=5xmjjIQ/cHPtbQPy2j6CtxJ7urk8r2qt1qoTlij1+jRB9PJkPG0E1vRI3b+DMPAmsEW20amqR
 HBIhxgNd7GFBzQuZowMSNZq4NDKk40C3nXcuMKar05qwirtGhLIe2S8
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The DMA channel was requested in nxp_sar_adc_buffer_postenable() but
was only released in nxp_sar_adc_buffer_software_do_predisable().
This caused a DMA channel resource leak when operating in trigger mode.

Fix this by moving dma_request_chan() from
nxp_sar_adc_buffer_postenable() into
nxp_sar_adc_buffer_software_do_postenable(), ensuring the DMA channel
is only requested in software mode.

Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/iio/adc/nxp-sar-adc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 9efa883c277d..890c8ef3132f 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -718,6 +718,10 @@ static int nxp_sar_adc_buffer_software_do_postenable(struct iio_dev *indio_dev)
 	struct nxp_sar_adc *info = iio_priv(indio_dev);
 	int ret;
 
+	info->dma_chan = dma_request_chan(indio_dev->dev.parent, "rx");
+	if (IS_ERR(info->dma_chan))
+		return PTR_ERR(info->dma_chan);
+
 	nxp_sar_adc_dma_channels_enable(info, *indio_dev->active_scan_mask);
 
 	nxp_sar_adc_dma_cfg(info, true);
@@ -738,7 +742,7 @@ static int nxp_sar_adc_buffer_software_do_postenable(struct iio_dev *indio_dev)
 out_dma_channels_disable:
 	nxp_sar_adc_dma_cfg(info, false);
 	nxp_sar_adc_dma_channels_disable(info, *indio_dev->active_scan_mask);
-
+	dma_release_channel(info->dma_chan);
 	return ret;
 }
 
@@ -765,10 +769,6 @@ static int nxp_sar_adc_buffer_postenable(struct iio_dev *indio_dev)
 	unsigned long channel;
 	int ret;
 
-	info->dma_chan = dma_request_chan(indio_dev->dev.parent, "rx");
-	if (IS_ERR(info->dma_chan))
-		return PTR_ERR(info->dma_chan);
-
 	info->channels_used = 0;
 
 	/*

---
base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
change-id: 20260222-nxp-sar-adc-1-bca71f089bc8

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

