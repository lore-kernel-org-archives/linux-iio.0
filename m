Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7027F3AB285
	for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788109841; cv=none; b=sJ+7pI9FEwYfhxmXgd9iGygwfeW0UQxv0gKeFmFhaaKZxDHkxddeKrfMyyWcr5IQ7VwSrSlpaxxV+ogT/95vqKHQzFg9cHQvMO72v+QHhfKp7Bn9M6iBkpnsr+LZEhc7YURn7owj+Ipm7Shp6QYocX33G45f7qWbBo5jzZl60mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788109841; c=relaxed/simple;
	bh=MHHJQfeJIqObhw73w1UomEbR7+LOBj+txdDKfQKR74M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQz55gKjh4kYZWHpDyZJPG2tttCQBcKeMSj8UoFY/xDNs0ph3vDimBKQjVZmSGzV1OsKor4ArqGcU+1/vhE6kOdz3Rkxw8tQQZCB5m87tSbFurzsT8vHqg5JDbVvY/BVEM9JoIr2gmK2qAvX/BZIKc4/lYSbfHUteGu1nH963Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIwltraJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIwltraJ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-398d2b28acfso325123a91.1
        for <linux-iio@vger.kernel.org>; Sun, 30 Aug 2026 10:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788109838; x=1788714638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFh7tNrhnkyS5rc0tyeCiGcCiB45l4CkB+Wkyp1hfZg=;
        b=DIwltraJ0W1MbYBY+dMOYG2YuZd5V2UQPF3x+Y4AohgLDcUyzuFEUTEMn1dRtPSk36
         R0zLY6B8sovCPgmugDOzlJ6OAKdv7icblcSvgasiimwU8sR9LMtJsgpMJeNcwEsoKzAo
         //qdyQ+L8InvT8A8tYgK3uTsf2o39hXoZB+xVt+d3s+DARKhj/unkSAXR3MpDMX75BjN
         tePN1rkfrWCIxN+cHyXRvEUTTQg82SU2ULY5OynNMgR7+VAg6/+e4nyg0QtzTGnJMLUT
         J1h51fBa+Pkv2yDrTCz692N1RH4DtrJyqdZAAlybsGZiiQLpDPbFt2nsXYngcjElir2F
         Ut8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788109838; x=1788714638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TFh7tNrhnkyS5rc0tyeCiGcCiB45l4CkB+Wkyp1hfZg=;
        b=Lb+IsN91Y8QEVsIj+bcBxoU/pN37UFaFtvbIzB3eelll/abRrczXI5XfLFGuGzQXZ4
         gwMo0tXDJd/JXPrGnUeXrFu0vgvUim18pty6dYOPKn8DQW4pdfpxgQccvXJWMOXW7H9L
         QbFLKnh+eeJkPvOk9Hdwt3W8QJmLug6wysoyzjf/n58LzxcHKBDYgKNUKuw2/4ZkSy+t
         6yWiyngQMy9auyeF1h7rvOIco6skQD+Kg85yNkvgr9YgLT/0KuWUGueGI8DOMUJfrl2A
         Afm0VTUwGcq4wbU5JcNV4Uk4OVYPFBZ+hjDcRkMvmT3QZnQjPXMc/UyAoE29dcciQS6a
         uNLg==
X-Forwarded-Encrypted: i=1; AKwUvBzFQqf/Uhz0f4nM039YcrjVDDlalYaeeHcGt60lGBU3FUG9aF+b1aaHM0l0qQg1VjeIuoXTKXwTZi4=@vger.kernel.org
X-Gm-Message-State: AFuF++mN++kh9eyE2vER+Nf1k8O75wsP3Zs/ar2aLl2VdduUslTIEd+/
	hgemuZWm7//YbsSKBe3jKOoUBufDDhlW/IF5GmLMN2+o5c6V3OPeBjE/
X-Gm-Gg: AYBFou28KA+7hMv/MDspQnXVOBL/QmH2Dh1bkr1nAw26rcwD1vE3eNL35kkg9DSXoqH
	B6jNped1HvDMLFdMAerqm+J2cG+F1+PAGnEg0gH36b/y8FFi8ES2vFpQBdNdCOMvE0LPnQWy5tY
	r42duTIaPI0JKRcT3fWpOvu7YMdV7OeZ8+I/e1pOV1t6utMqliwmEFN3xIjCgGE0ZztMXI1z5c9
	YXUvaJ9aTgMn64BbGAxShl9UTWCGsEsHds3X2be2W96Yn0Jekd+y0VSmUulZbiQUeIipTq+8bHL
	ny8KKbaYOABEvMYqA2bd+SZxBOJjkhnozz8g7/1IlfpFPBFhKRgu9YkkcAxlJRB1nLGMfqnA3Iw
	S7D1ktUHZSSgk93MrbP2Ahqpk9et/ScgjmLDEVmjCuBBvekH1fKwtPZ70SmzD/gtaNsk6Zvi5cI
	+5Fhggyj0NMUrGfRYnKMeEc8GXqjJk0GbOpi8vzoTcDwDQC4C9tm/T31WhIeVc6wH2ODMI
X-Received: by 2002:a17:90b:6c5:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-396d0f9d0famr35772568a91.12.1788109837836;
        Sun, 30 Aug 2026 10:10:37 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:88d5:45ce:40e:490f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fcfa3asm17047101a91.6.2026.08.30.10.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 10:10:37 -0700 (PDT)
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
Subject: [PATCH v2 4/5] iio: adc: bcm_iproc_adc: use devm-managed mutex initialization
Date: Sun, 30 Aug 2026 22:39:17 +0530
Message-ID: <20260830170919.470974-5-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830170919.470974-1-mdshahid03@gmail.com>
References: <20260830170919.470974-1-mdshahid03@gmail.com>
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
index c7fbdc21f8cc..11f2bc12c19a 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -524,7 +524,9 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	adc_priv = iio_priv(indio_dev);
 	platform_set_drvdata(pdev, indio_dev);
 
-	mutex_init(&adc_priv->mutex);
+	ret = devm_mutex_init(dev, &adc_priv->mutex);
+	if (ret)
+		return ret;
 
 	init_completion(&adc_priv->completion);
 
-- 
2.43.0

