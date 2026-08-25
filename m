Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5587F3563EB
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678578; cv=none; b=OZ3hPO785qw1yDhqfo4XMAtyO52U9NqcoLLzNPYxuRAeqkJ1uRc4Gj5NfWkVaNIck9XEx7zRXss8R7o/Hos1VVIneeRDXoEG8pmX7O/4AXlOzcBtGFMANJ1PoPIQNdX9xviOjV4NdI/DB7pnHOCFuBtb+rSY9JMUcCT540oTXB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678578; c=relaxed/simple;
	bh=FTDw6KP24f+3OVYmcqHs4SD5PXqCZhgRkOppyLuNvzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJZk/+4+vOP1O6lEQkHgJt09En8DWxKMiTKioai1guRSUbopdzo/YsBUBkoPzU7DeFdOwtI3AZ9qSd8QHaP0VZ07bQbwRx+XneGkZMZF2f5DvLi3WNTaXNLadeNJy6MUOlp0ReTF4wC1utgxk1m/d8QkAgNZnJDe/YZRvM4P96Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR5zfQrD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR5zfQrD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cedda2ce6fso819145ad.1
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787678576; x=1788283376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TJH31Ij0uvxdhOs3xzrIR/KHtOQuioLd2XCJCFGaywI=;
        b=fR5zfQrDNs4AaUl0Y3RZQMC6zINfx0f+MgSHYy8zDWRCHJ2HQ/k1qfnzEu+C3wmP1G
         /USARnDA03gMMA4T+sQG0pYY5dKFbWBICtWrT+G4z2gsaNhSllr3Cv0aRgqpLbDLo4zo
         DukZq/C5IEND8LExLwzx4KNTpIjzRUL+MMzEMhCvDnyFtNkmEybsqs8wT29xZPY+Nwm3
         8kzAD7Ul+u8fyomeT4VsTbfISKfimJgXr84uKP57HRpkbqsptSnwgCcqa+K60lAytJFY
         83JSpQizY9Gtde3ATUr4qwxVvIknsD247BaOIOAE5JX25uU8h3wGWsoSMD4paaA/QqVy
         q3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787678576; x=1788283376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TJH31Ij0uvxdhOs3xzrIR/KHtOQuioLd2XCJCFGaywI=;
        b=Lapf/U48H5PelAE8uScsi8AfVRo7ArcgGa7HInEIIYUP4eDpsPLMJD1GhvqYjOuuNr
         rrEgKpkbchkpCuTwdw9dWMVG3WpL6hE5rs+Is/dRCyFP/i2Stjw9tMrcyIbU/Y8OP9bB
         J8E5T+DdVHzaAOgPhC65xXLrEQ1JPgg4HnOWm59+3UlIimyS8yjGp5tn+DV6wBuJvh6w
         Kk5/BTFkUwSoakA1EpyarC+XGA4RUftg1zgHT92JrxS5Z0HSQU5hSBwG+7V0GK85fu7H
         Rxf5KA/CMEkYbIyekCKUl5gVpyfNSamE5hO9c/We8Xh8CHScKbSR4k9mGaVb6UjWvUf0
         RD2w==
X-Forwarded-Encrypted: i=1; AHgh+RrR66ruI+CahGO5NjCDbgCF1QxuACtV/wDoVG/k8upNIrR6r560DqQCzrRK13G8SpEm4Jn6lahXYHA=@vger.kernel.org
X-Gm-Message-State: AFuF++kdCEWYCYeQYoY5V/7UFVAeeR3ZD7qRGchNUMmB+YGqorprjFPY
	u5RzBuSjrj/nb9Xl231cRr1x3utuAvibJuMgW3P5N4m+a9RZ2PleaIGT3SArtZfdqhI=
X-Gm-Gg: AR+sD13ggHWhWfXWPKSYXkX54W2bJLBM37K/wt64c6/NxQxFvXVx4DKpeetiHREocrX
	P5SKIWO8KN7r65oGH33BRroIu5kxq16Vuj6Hmh9XYVUlCFi8CKNEHSCHO4OjJa+gPspsAcO1dz+
	vP4qYbKXQ7/Y/yfmAgB+twpSfa5/xua9rtNO3eD1LPlZAmPrKfyXKbvF0v0glj8ePQny9vedoL/
	2CECLPBAeruFIDfOQOlVcp48zBv+cJnS01gKRqu4kUXxzTqpRiDoPc8o745fzD2881LY4sCsEP6
	2OOkUfbYpWJfE2y9yzMDwrtGhKBjfQwnh7HicXtFkL0Y1qKcLB8wHKtJmtaQdrBqtfH8Y5Ep32S
	wD744ucHc230MthyHr7g6Sm8ZF9OtpLOfbRPzfgKB3/QlU4KHEEdlbRt5jjsrl/MqVVCMZNlpWf
	hp45prE88bw1inb999iweYDtMUoo7pXQyvS0PwgBnqG/FMa91/qvCqZW5fCWM=
X-Received: by 2002:a17:90b:1845:b0:395:4e0d:bc60 with SMTP id 98e67ed59e1d1-3966d85dd8dmr1276632a91.9.1787678576579;
        Tue, 25 Aug 2026 10:22:56 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:7ed1:605d:3bd6:fefb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8d208csm327637eec.23.2026.08.25.10.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:22:56 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v1 3/3] iio: adc: bcm_iproc_adc: use devm-managed mutex initialization
Date: Tue, 25 Aug 2026 22:51:55 +0530
Message-ID: <20260825172155.250484-4-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825172155.250484-1-mdshahid03@gmail.com>
References: <20260825172155.250484-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Use devm_mutex_init() to tie the mutex lifetime to the device and
improve debugging when CONFIG_DEBUG_MUTEXES is enabled.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 1464c60bc83e..9b299e2c3e0c 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -530,7 +530,9 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	adc_priv = iio_priv(indio_dev);
 	platform_set_drvdata(pdev, indio_dev);
 
-	mutex_init(&adc_priv->mutex);
+	ret = devm_mutex_init(dev, &adc_priv->mutex);
+	if (ret)
+		return ret;
 
 	init_completion(&adc_priv->completion);
 
-- 
2.43.0

