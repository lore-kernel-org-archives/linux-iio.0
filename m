Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA7F23393A
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785575432; cv=none; b=s64qjV0UI/Lay9ZtOep7jEatLZyyS3h21LgVxsETfzEV4XIS7NIC/RMREjgdzxcSk+jBncTg36VR76RrlvGxihCRI+oCe/lCzfG04SVNqTKj8n79xBaKjpNSUqwf5BdO9iwR47GwAyNKagEDVovqcWhLRjWyHbBpPDniaumrHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785575432; c=relaxed/simple;
	bh=5C7wceqaQFO2f4qXEFx21ohpcplYEZ+eV+kQkbGuCaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNYSHXacq6oG/vYUN8Tk5XIUZuuZ2JR99WhYq93mJb8bU7T9u1woqXR0Jqib+7+SfTq+IjhDO1l56mknj5Tilm1ILbLNjtE/znL1fsip7aZq8qQIyNHKAckak4HlLhZpZn0mZV6JubCTiLQR2VkGfIGiN+2vCeOWiyuNnjpq0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1N6Znfe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1N6Znfe"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ccf2360620so15516785ad.3
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575430; x=1786180230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+19O7nuCCtomwWmgwH/WqZ+QVpHVmBP+p+odMSd16YE=;
        b=C1N6ZnfetAIrX5h3uPn7KmNzP2Gq0EPz8Y3Mv1unnNC1XywqmkyNiL2uUi+V68X4qQ
         deZ1+mqD4B3EdJKEGNKDDIakuJxsJxQ9e8sHbhObsrv2jj7e1WI+amrHDPi14IBWBDX3
         S/3dP4qSBiM6ag7T60BCHtIePHw21ar0ssbM21n0es4d8JYTfeafLegkSEgDrbJaVo6q
         e4JsKrpvwBLrI7KlI58CzGBUUYiOsHuTWxxtK8MuNiiPOY2p3uOrORq7LNLE7e9R2yct
         pXueVk2+AkrBkxAzSJUpbY0adLr7t42uXbHCD/jFo4KnqiDjsdk85csL6Shagqet6Kr8
         vjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575430; x=1786180230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+19O7nuCCtomwWmgwH/WqZ+QVpHVmBP+p+odMSd16YE=;
        b=GTHAURqXWJCXguwevZSl8V40kQayIC/AgBtNzZkh5DWT/OonGa1SteU0kPO2tyIHBf
         k9wSmk2LSAnXyARCjFSXGrwC2OfgcMVMABfVrCVtir3UipAaYFBOPqv2TAdujBYA9TrJ
         v1bE/0b/6aAqHr8Bv4oyzjk6TBHIhmSkkWMY/4aaX8DGua250fhSQk6vgHunK6Y1V8tA
         oX9DyR22yPKZAHh06sXDzA8Z2lrIWIGStxjE8yr0bHY4pZ/R//Y1Kt1ILlKR0rN9jvQ7
         nlM4NBIpDXErPqC8jHHbzsjgAgGiBct6+eQmQ2Q/dUvItmN/EzRsHdZ20DLbcrPkC5h1
         3U3A==
X-Forwarded-Encrypted: i=1; AHgh+RqPHSmjsLhu5rf+1vcnYAOj0kj0Sr5CSCceVCu0Weyrnt/fwIbAt28rOakVzSL5y7GXJEaULgX1Lvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPxwGDXyeDN5YVsbU3Qad1JykWPNiw36rDlqa1Hs4CHioc8O8
	XAZy4p77htxbW8WbYPvML8wwuvUGsJImcG5t5EiOYZaREccukK5l8JIv
X-Gm-Gg: AR+sD12hLLezV3oPJxq4iu6Wrd1R1AsQqGzBCqu37K9FgWk1fBVLe1UPc5v3uLfA77u
	XPZHHn9tA7E1N+3jk5zAveNWfJPkFcTTKkTTMLoJdrWMQ98c9UTIeHI0vRmVYngWd02YdarPSgz
	si8HHh6FEPzHbdCKcb/oheGtH/2WSBo8F8rwPDDi+ooI8KX7IccBhbtJeS98FwQFVyMdN/0c8Ac
	Hu4FGD2EKI5juIGtBqd7HAQP5LJW4U/qXlOQi0q/7K05YxMiJfietdsWvWXQMxEpRHprLPWSJvT
	JVBQQysGHRctXybV6/J4Aa8bYeSx/uieMEqnSSeFXbNqtK8JRjnycSpOmzYeK5SvHDZ69ZuMJwm
	IMHVw1rfGrfn2b4510cMtqmAXX4OUJwrm4lc+aAQKGnyvDPUOL5xufXOxNW7ZZug36ZU2GNEaui
	6JDVEb0mdCIVNaAo88aIBK1JciTiKg2n+EKzGUQWwhw9yqIEVwRMGThSh4cg==
X-Received: by 2002:a05:6a21:d88:b0:3c3:6544:5eb2 with SMTP id adf61e73a8af0-3c92aa5d51emr3029824637.55.1785575430377;
        Sat, 01 Aug 2026 02:10:30 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:36ae:7de2:5cca:938])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9c96asm15432431eec.7.2026.08.01.02.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:10:29 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joshua Crofts <joshua.crofts@broadcom.com>,
	Broadcom internal kernel list <bcm-kernel-feedback-list@broadcom.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v4 1/3] iio: adc: bcm_iproc_adc: Remove redundant probe error messages
Date: Sat,  1 Aug 2026 14:39:51 +0530
Message-ID: <20260801090953.61603-2-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801090953.61603-1-mdshahid03@gmail.com>
References: <20260801090953.61603-1-mdshahid03@gmail.com>
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

