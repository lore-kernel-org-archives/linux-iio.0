Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E10D31986C
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 02:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983982; cv=none; b=T3LvsIhHYArFSi80eGZUcJjA7t0VVvHN12Lo8i40hONqLlV2z2t1Vk9cuaZjLXFNz50mP0J8qOfxn0Y9w4lbLmzPyQgdGqzFKYogFzVniGOeO6sxwSZloRFV4HF+69Wh51nFZS/LGa/wV77l2h2LDxxGsKrwV/o2s8l1o0et35c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983982; c=relaxed/simple;
	bh=5C7wceqaQFO2f4qXEFx21ohpcplYEZ+eV+kQkbGuCaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqut1iUtEquFGEgDmwb4uVEQ4c5Fy47OACCTLYUjZXBZhM+jfJUMUXRTl72yjZPMrbDYtywO7fB9U19cDEt8rJ/tbdGQHRDtlBarDwn0B9bZEmpiyTyYi34lSWkDKa1BNlbFrCuVRI2mJAAcJ3wjNcjepJRh6tms3uSD9SAbR7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0FA+eSA; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0FA+eSA"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1843751a91.2
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 19:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785983979; x=1786588779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+19O7nuCCtomwWmgwH/WqZ+QVpHVmBP+p+odMSd16YE=;
        b=g0FA+eSADRw2B6119f5psjPTMxSFsLI71y2D96eZDdxzSErTKUVi9TlvLcLanOm2va
         X/18z8nqaHoRzu2QiQ6h+94I2cngetdRuNdg9cP3Rk1x56d46OFQcr+075Uthx7L+n4h
         Tsz7uyKmt2us2tkI60bY4lm335es1ODUNVdqY3JsNIGTb/pbr+Ef7MzjPtKnRwL/ufx+
         7CTIMPuhiAkn183BcWEM292JD1NURmj0BhLcW5l/dRmoPXe9mhPFAIGL5ISUfHsm7+xh
         3S8ZQi87ZodZJE7aMMbgSU2AQ/i43bImLWqe3wJda5SILd2AYSJgCouLtbANl0EznlqC
         3csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785983979; x=1786588779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+19O7nuCCtomwWmgwH/WqZ+QVpHVmBP+p+odMSd16YE=;
        b=La+g72jFCgC8C/wHhFyFPdhpYqeiL5qmuM/wdFmLU/7hPD5XYfMFyIXrAwh6INq7S9
         6GwWnJH+wZiXQFqvc9TnpGpmf4NQiXFs71m8caxEAZp48FihybxcbsGGfXsEkLYD1h3i
         7y3BV2siEhgEJGZB/gv3dTMDZTK3SsJWoiSJV5g14HNWes82kea8EbcOd0YWBltrjqId
         0wRo7KxZXpcsKI80QB6ffCZhpZqqTOt924vhyLnxM6xs73HLnxmplIOewQffJxPvhbhP
         2nsEOhbr/kccIYXrZZdf5RTZ+9VRwnf4KKgKbZmpReJSmiNgNb3dsrWaBSiwXbkmWXBl
         QwMg==
X-Forwarded-Encrypted: i=1; AHgh+RoVMcxg7HIyNgOarpZcZf8tYIAMNg+PmnbMbxwuz6BOTsoY4QgZGmo9aYPAhbGSeZwwJmZyp89tm58=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW8QoHVnhk2coPIPShYU/pyUiyRgBDGWLPeYx+7PFNharFPQer
	xfFtlJDvroG9qaR/UMERNUIYRmeVK/9cQ+EKUekrZP8rDpnZOMYrr2sN
X-Gm-Gg: AR+sD13dZ070EMoR9sr4arr6n1+xE4UDNOAHdNe5Aj+6kiC3KaFgCXgREo0EY3MzRx+
	CbEEKbD6jzKkS0JprbHhI8Q1x9h94QSqkhEnNLIl/nKHccHXaV/IWq0Fq3lKvqj+lZvYVmRRYP2
	q+LbMziRhuvQcOoJiY9W7oUx9zwsFJ6Mx1Dd1vdxxCHyYJXbllIma7SWrDoaUEBCGCYEKsDI8KC
	8/CSlgJDkWeCNxjzrdXgBqIzkBQwxtkWnwhaq6HA/9CPeQdE8LW6Fr1964NdqaAWoj69O67qbjh
	Em0eoVptv+0oSaPpUiopo1U1uhKziVoGtuS9YCpoJeFojLkhs1kIfUcWKPAhUkUDb2MUEXkcWZX
	sqNYRjo9D04aDXNzD1MskIKulUPzNzpYVJm8uLIE/EEENGqgliuxYIjvrEU6zqwiwPRm0BUwF9y
	5AwVUj8x8J+6jvrMdFirGuyZvgWR3wKYhX0HEk21qMBitzUu8XnHiwZBokD+LPAluW03yUkw==
X-Received: by 2002:a05:6a20:430b:b0:3bf:9b3d:61bb with SMTP id adf61e73a8af0-3cb85ee779fmr13430627637.16.1785983978646;
        Wed, 05 Aug 2026 19:39:38 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:3194:1e48:e141:80ab])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867d4929sm22404383eec.30.2026.08.05.19.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 19:39:38 -0700 (PDT)
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
Subject: [PATCH v6 1/3] iio: adc: bcm_iproc_adc: Remove redundant probe error messages
Date: Thu,  6 Aug 2026 08:09:00 +0530
Message-ID: <20260806023902.8608-2-mdshahid03@gmail.com>
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

devm_request_threaded_irq() already logs an error when the request
fails, making the explicit dev_err() redundant.

Similarly, iproc_adc_enable() already reports failures, making the
additional dev_err() in the probe path redundant.

Remove both duplicate messages.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index cf4738b16e62..7c2e2770cd61 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -551,10 +551,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 				iproc_adc_interrupt_handler,
 				iproc_adc_interrupt_thread,
 				IRQF_SHARED, "iproc-adc", indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "request_irq error %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	ret = clk_prepare_enable(adc_priv->adc_clk);
 	if (ret) {
@@ -564,10 +562,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	}
 
 	ret = iproc_adc_enable(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable adc %d\n", ret);
+	if (ret)
 		goto err_adc_enable;
-	}
 
 	indio_dev->name = "iproc-static-adc";
 	indio_dev->info = &iproc_adc_iio_info;
-- 
2.43.0

