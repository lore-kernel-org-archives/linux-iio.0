Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD94386C04
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651709; cv=none; b=K2YfolnMqsdhOOJq5FsD5+CB+pC4CHCNOgLfhJrgBGib9CgiJHrcFbgeyEgG/WidS9Ogl/aHvUg3s2iuv6OihZyPbIEWtIzR5qUa3EZs8um/VzvnRCowDECE+hzUHz6B+Me5qah31CdEJme4UqEkydTlizLcJs01xsM2Gt377V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651709; c=relaxed/simple;
	bh=HSu3xx2lCjtWg88R5qvzBlH/MUVbsV39zZtLxvUYB/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNLn33I4F8NfxpE0Iltwl1lfmJ+3jRr33rW+a5WuNUoobWhxk7outIJwWwZDEDf1aSILJEQn0KI7jUY0SgbtEN9WmWGLuxOquOtEUyNwbRkNBujH29QuQASGF5fbxnj3XPPlFJrbsPIvoixMD4/aER/0tVsoOK+ZYEjvIdFtY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zmk2SjD2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zmk2SjD2"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aaed195901so20038095ad.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651707; x=1774256507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImzEfHYzjQqMQH44oXgmZ23YQ1PrMrF+t43BBl3cQAU=;
        b=Zmk2SjD2e4JaYQGfLjaRMFXcY4rlEPEw2p1rnUAeXXxGzXC+2584wqmFiYhbk9Io2Y
         SxxGN+25NmK3Eh8LIZgjacH8Vg2E+Y9XN9xxjzpUsbdXIqAHY7dsdfONyNlPUQDiuWKL
         trkIdUEAQw6yO7unTAk4eD5U9F1VthZrdG8yjl5W3Rc5VNSdEEGwIa15ogppjg7FRvuc
         SsD8oAhv8HDXOLo7W8fVhScgjpX6iKpN78S3XrlemJTesIFa5ZvovvjSSToQLEHvi64H
         +EG90x1i9F6kDCm+Jf85sCTzNCAQLsm4f8IIb61yDDSKGkiLXomhn3xEBJXqtm8Ate6q
         5E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651707; x=1774256507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ImzEfHYzjQqMQH44oXgmZ23YQ1PrMrF+t43BBl3cQAU=;
        b=i5IbkGLj6zOtKyONh9z6vn+jKmBrkk4ubcOubOuVz38CFuqFLpxlqreThNRZ4YI1cf
         kBiAVBddpKclFmgH1aW7HIJ7VxuJmrSISOp1byG7ivZiuHEzEGUxSDGLhIfYBEo9g30p
         yV6tauhTnFkojVeEwrdQyoaFcSNVp9/JzvnW9MMy+pvRg5x2ccEF1TZo1tDglKx+zgKn
         ZEOT9L2SVvEWmRya2wxoPpBNSfQ89KVjo3N72dDCExY+5CpEbyiH6EzBAxx5jUFxZ4uq
         4ZrsN26sT91YL7ejy0igvU5m7CVMH0KaFVRZDKet0RpyZhFEMnvBkLOUthXjJujlvAjy
         ED9w==
X-Forwarded-Encrypted: i=1; AJvYcCVNvwla2lQHYJiMhUvgys9THtosLtDll8y05KyQuFhrhRtjwQJqh7WZb8klFZ/F+c3tZh/o9Q8GzL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjythP7ZEPSdQFZvr9M1Io6IJ1QVF8E4lQ+/figHsWu/A9yI6v
	Baoj1ENFDVkpg62sQjuh9VhX8javWr4rwtgvrDnxBacyo+iTa5Ge8dSH
X-Gm-Gg: ATEYQzxv0mNC1Crz/1MEOQ46AJfELQLlB7bhAY/cRj0mAvJx8HhAW9EJ2Xgk3tVyivA
	mZCQFbkf+YMBg0z7naUqfQg8gpoEAx1zZTU61N/g1UGHuR3run5UXz1Bmt/KmfcplcK2Y1XR802
	gj+h22R+FkSgwuGSeoTLWdrU5KamIyUyVzRHue8lB5nZb8i0dcGbOi+xOE/LyQIJcQNmNxKS57l
	h9cl0NzQ8GG9HCC7ib93vxe8n94I9o4UgUaTR7WUAja5EdxLE5lDgyf0lR/muXRM0AR3JncRY0U
	3gfWQo8tWcLQxcDp7aCtvSFNFLSZEVyKa4ACuLUhDGhT525VgmRs2SR4LpI3MGCQswOdaaqghDY
	jstQAS5KspQSCjwD/rbP1LP+CmUCki2WeZhtRPwH/gfhNUkJOWtFfF2wRxr0CgGpBsabZ30EQ6L
	BjUPnooxseytcZTA21kGTV8U+J
X-Received: by 2002:a17:903:907:b0:2ab:230d:2d96 with SMTP id d9443c01a7336-2aeca92e633mr118469405ad.11.1773651707117;
        Mon, 16 Mar 2026 02:01:47 -0700 (PDT)
Received: from fedora ([2401:4900:1f33:4eeb:289f:fcde:6da5:35e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece868172sm98105835ad.89.2026.03.16.02.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:01:46 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: [PATCH v5 12/14] iio: chemical: rephrase comment and fix a typo
Date: Mon, 16 Mar 2026 14:30:20 +0530
Message-ID: <20260316090023.14691-13-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316090023.14691-1-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rephrase the comment and fix a spelling mistake.

- insuffient -> insufficient

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 24e0b59e2fdf..6aeac132394c 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -807,7 +807,7 @@ static int bme680_read_gas(struct bme680_data *data, int *comp_gas_res)
	adc_gas_res = FIELD_GET(BME680_ADC_GAS_RES, gas_regs_val);

	/*
-	 * occurs if either the gas heating duration was insuffient
+	 * This may occur if either the gas heating duration was insufficient
	 * to reach the target heater temperature or the target
	 * heater temperature was too high for the heater sink to
	 * reach.
--
2.53.0
