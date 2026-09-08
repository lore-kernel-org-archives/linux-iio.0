Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AA58E2B6
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888329; cv=none; b=qnJV39ypBdU3ookiKxsqdqPlFz0TBu9zXQ/zf+O+KtKx9vcxRJMKPtJRXVTmumaPzhNUwmr0NPJrrF2NVKEZW3adVUDRrgW21V0kgIHv/ZlMyvSycejfAeETUCGGyBXjEY02xHQfScbaAedfTIOg81J8Ew7XFbth1mRQJ01TPjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888329; c=relaxed/simple;
	bh=iSm6gUUkWSpkXgJjmPimBp+kKrGEEM4tZY4iWPBzihA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ce3nEuW0UvRcME/JkvhzB5BkXEMGU6wZBPMIkMw1HZPa7etyl1F1AozF/QxMLQDevz2uAmrRELlEpG2hq/fhL8fY7e+jBmKjckEXKWvQ8qKECG1zlMeM/9HEICGxWheNbiDwIy9bFnR/HmRjHMtC8CmEdHQXxGExZdc6d1C8FSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rcw43/vu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rcw43/vu"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8558c0b26a8so3351553b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788888326; x=1789493126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zs21gAo4QkiJe7skjL4wk3AEQvdIKI9ChNhU3Egus/E=;
        b=Rcw43/vu1YmIaY5oX0YN3GoRK1JiKCJFZRLhoi8pZB7AHYsniJpDy1eTIG7W2WNoaJ
         RkuGlv9jAunXkDubDJCNLLcc+SCzniu604EWp7OIMhZeNY/0hYT4reBdkK4kk30UoxJ2
         BKwjaE1b30t9Rsc8CnnNel2jAb2a0Ptr4vGCrg6a2gQi0Nl7whUrSz3JTCj5HSfra7ez
         YdWL46YlgwaEmXBCDWPtJ8lRcJAwbL3qxRxABsPWg1gYHzx1KqVME6ssQZv+Zayhouj3
         AUUb+up7RbUjQZMajo7RiHtQAkleL89VSwnQDsjQb1POnYyR+lPlXnjzGLZJ23JWb6AO
         vrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888326; x=1789493126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zs21gAo4QkiJe7skjL4wk3AEQvdIKI9ChNhU3Egus/E=;
        b=O+dhxGwvISWWw9uYb1lOfmrNeqZGsRigxf8GwBo+cdMf5QeYUee45M4x0nHsWN6jzu
         CrI/5QJcdg4iZH/L3o+GHjepbRXSAwzSPGVrgL8J5tRk7GiUjq0LGPF6dvteA5s1zwQJ
         1SYgLeIsrlcomjbMvucsfGWF2dTi+/7RhHdlko1dV+6LI87WmPR+qe+PPuAVNxvMgLro
         AhNL/s9Lmwss/EUOR2HzeGlwGAqco0y8bitrBOyKc8MPSaAzBIMMem3PJBj3GGU2WJLN
         iawa3YBUQftESAyala2SkXQIZOWnMoSqSEwI/b2DW1e/Xy8NlQhY4q8HGoOjjyHpjl2H
         70Jg==
X-Forwarded-Encrypted: i=1; AKwUvBzrLHO1BBOxnhkxmqfM7vsBr76T1DfizlhdAhHPsP57pS5CDah+xJmyt3lffO5pKTmvgrhCQEo4Mmg=@vger.kernel.org
X-Gm-Message-State: AFuF++m8mr6cLNun56ZhgEuyPg0pemELph4q6MFbHSnKukJHhl76LsD7
	r4/Sq5Mn3zY221AByTm5+aPCg8aYZGzkcHm2fCB15itc2+ITN6xB6Kz8
X-Gm-Gg: AYBFou3DUdhTSxGvEq2eKclM6sfa8KaZAAosGv7fgWu2CEHjG9qxA8Y4Ut+/uFNKdfE
	t6SY08e/xzjXoQ/hBoo2gx7GAZtPd89A21pLQHaI6gxpmTny032NUu0RDLqStARdnFBJaG+dK7M
	tjO4puz23INUig8N6NT8y5S+HB4VsskvRTO1W8YyIpRnHuKHNfzVYam/OaQz8O8COXLpVd15gLv
	Lf2vIJuVQpJ2EuQrhcIb/TEyiv8XrtsgteVECsTN1BYkiPY02AtzvpjlLPQfeGjMAFqgMd+TIF+
	1/VjjvWCSU+/O0Wcv1UyE1ogvog27a+7JXv1X20gsqkxJ0FFHdPABYjA2bo1dF+XHRUJ48/Q7Xa
	IW7GS4afihH5fOMEOd7tkGqQo9LuAxTmL40Q7GqEPsH4+j9wb4DxUiUkt7Yf/GyqtTxwNAzUVGY
	Jx+l5sT391W4InpnxX0w2KbnsI/EzJQ7vq7cJrHqbewdmmzeKyNFMM1R57gng=
X-Received: by 2002:a05:6a21:2291:b0:3d0:88f5:f812 with SMTP id adf61e73a8af0-3da39d147e0mr44672625637.10.1788888325834;
        Tue, 08 Sep 2026 10:25:25 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:43ae:bf76:d99a:e5ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33688cfc714sm19297176eec.20.2026.09.08.10.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:25:25 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v4 4/6] iio: adc: bcm_iproc_adc: use devm-managed ADC cleanup
Date: Tue,  8 Sep 2026 22:53:57 +0530
Message-ID: <20260908172359.30003-5-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908172359.30003-1-mdshahid03@gmail.com>
References: <20260908172359.30003-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Use devm_add_action_or_reset() to disable the ADC automatically when
the device is detached or probe fails.

This removes the manual ADC cleanup from the remove and error paths
and ties the ADC cleanup to the device lifetime.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index d6f82f8ddee1..ff271c7fb2de 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -451,6 +451,11 @@ static void iproc_adc_disable(struct iio_dev *indio_dev)
 	}
 }
 
+static void iproc_adc_disable_action(void *indio_dev)
+{
+	iproc_adc_disable(indio_dev);
+}
+
 static int iproc_adc_read_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan,
 			  int *val,
@@ -554,6 +559,10 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, iproc_adc_disable_action, indio_dev);
+	if (ret)
+		return ret;
+
 	indio_dev->name = "iproc-static-adc";
 	indio_dev->info = &iproc_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -561,17 +570,10 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	indio_dev->num_channels = ARRAY_SIZE(iproc_adc_iio_channels);
 
 	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "iio_device_register failed:err %d\n", ret);
-		goto err_clk;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "iio_device_register failed\n");
 
 	return 0;
-
-err_clk:
-	iproc_adc_disable(indio_dev);
-
-	return ret;
 }
 
 static void iproc_adc_remove(struct platform_device *pdev)
@@ -579,7 +581,6 @@ static void iproc_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 
 	iio_device_unregister(indio_dev);
-	iproc_adc_disable(indio_dev);
 }
 
 static const struct of_device_id iproc_adc_of_match[] = {
-- 
2.43.0

