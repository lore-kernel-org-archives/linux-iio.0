Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511AE3A7189
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710332; cv=none; b=R87FaYcHRk8Ic01g9ZmoYUdgnfZ8S38hho62oC2ibnXG0+O0bLF4l4XoShBW/sNuiyJ27mAZuSsU/r/JCDOD/ZCfXbMzpe6nzbVq3U6lwe5A+b0om5oFpJEdt7pV4kgYKEGUuU8/FI9r+GXHdRo7vJbtZFvSDBfkqPJE37R0PqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710332; c=relaxed/simple;
	bh=c57ka5j8TQHkpX5FZRHB8vFerQ2Ws0Z0sbVGbrtSoUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KbQY9/loxYAnBU3GkohNSEt5TGDP2ndisUq8bfAPo4Hkwyd2goaCu8RAxs4qh000Sz7NssrIUaw/DFybCkdJJrKX7s6cBdfcHSWJWO3rKOWVmXJ7YhI6yqbfcYil0KOjHL9GCZzjuxWkI0MHkVlbXIh6Y7bHLejHEkC9fB5+5Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QndspX7y; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QndspX7y"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-398e9698a70so2338836a91.0
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788710326; x=1789315126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ViofCTK8v1s13H6Q1s8S3TeyG55pxUNWw4j4G5OCidI=;
        b=QndspX7y6hjuRe/H/QUhfJYShJXqI4dZrVZo2dFYzC3KR6kNTEKX2g1JsaFsBw4TF4
         H2Ovp6zEKv4DWcLOigb4OcgD8Bog7QIEuclE+O5UZ9Ll1lSqw3WaRDrzmFOek/YvPzsK
         yc6jLuswffAGXRKNw2FRUT2e3cIyIUaVE3aMvSQNtRtF5XOQndnqvHZ9s1zg7XvROHtG
         jK9yUT5gAtj3mozjZBc2KMcsVS0UdnV53GOlKSycZsMEp7gALTC5yI5kAk9OoRvqTJQb
         W/tMuS/rqyV3kJ7c3Lm4HvFv2/XA6vHJwA+jPqneVdMSvsnG/azSdamU6KBNeUYV9tEW
         L4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788710326; x=1789315126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ViofCTK8v1s13H6Q1s8S3TeyG55pxUNWw4j4G5OCidI=;
        b=W3lNhvO2ahbq61Lx59RxpmApijB/zmkt0SReg5C+V7qtsjy1hcpkjXbKmK/on0nNId
         IK7+P+cUwV3Pkl1vVALn1eIl3nba1ebpFG3tBtVCVefGEPq83ngXIZlXYmk8LCRDekSj
         pw6WjA42ufqcvaX4OrVqJAjF4VWT2l47UmJ6/NQkzRUdGa3tK5zWfuh/LOtTnJoetO7N
         2JPHX4unZBRUcQ7oC8wQcxQDsuUAE1ZmAxr2XFunwNy99penCr4w2XGQHBIcB0OGjfP0
         jPgVk4rNZBMSYbICwlLsw45XdDs9F8rSbh3ht8iX8xktMXQ6KhN3+ItEAQrFOhTHCgOE
         f8Pg==
X-Gm-Message-State: AFuF++moN7sYGZO5MyqIN9jWPc3aNIbzTzGFLAuveWrnZUsEdlDhsSkZ
	PFped37TQNlFhXz3Xfb+IS1i5wcyNzfdmU9CdWl9sQK1sNvkoDj/lU5h
X-Gm-Gg: AYBFou1FEJ7M6/+AuUVqI6I46sE+zqmECfai8Pdjot2SuW2qWiIeSRv969a6gmxL6qn
	6RTtGT2OrmCjWK1zpnB+nd3vIk5s406YSqhtnTRaMiqv/1KTaodLZgHMvedijxYkEeQQqcVTunc
	jo4uxENAjQvPITpkcZOhs4UXCvkfS0MLQbGzwkSCcW9epFgSRVap1Wvx628pGEJmvAHKtkH7jhB
	DsvCwE6ZNI7gs/hB0Zva4N6qzrTOIQ/QgVyJcK7TN92Oay+AaiInWfEFkxANPo4zXj7oYbRjnWs
	CyFPlwBW+1mZf2eVrAwClutodCiR1FGVmw6bCc6nDvqfV1YNzyAJhq/NZW4S21gWZrTJMXDT6N5
	MsV7rcKX6yskoOGxUW4zwAWdqsKv7zWIDx/QJvOBsbUfKD18PsVeGpFi2Lgr73v2huNxslzBjyN
	C0l4cMJcNLFwbVZGMNViUagZPkr5u8k2rQL/PdbOoIk+LdMBEV5DkBg6lSKutSmYl8eqPkFMJ0S
	rQozPdQiqVrA4k8txCVFBOXm992iBbVbiX/YsAX6L1isYGKsc4Kp86NrA6+nOiJsIw=
X-Received: by 2002:a17:90b:3852:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-39b26272d69mr27665796a91.16.1788710325448;
        Sun, 06 Sep 2026 08:58:45 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260f64ecsm15941401a91.8.2026.09.06.08.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 08:58:45 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 06 Sep 2026 23:58:34 +0800
Subject: [PATCH 1/2] iio: adc: sun4i-gpadc-iio: drop underflowing
 pm_runtime_put() calls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-gpadc-v1-1-92d3dc8ef355@gmail.com>
References: <20260906-gpadc-v1-0-92d3dc8ef355@gmail.com>
In-Reply-To: <20260906-gpadc-v1-0-92d3dc8ef355@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Quentin Schulz <quentin.schulz@free-electrons.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788710316; l=1267;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=c57ka5j8TQHkpX5FZRHB8vFerQ2Ws0Z0sbVGbrtSoUw=;
 b=RK5suJBjW/7xSEGUZXgfUBlPW2TReDkIU+aOrloVKr3mhcpiAxpWmhUE7ZU8jgfIYEVZ2MO7Z
 ioAF8OyoqLhARn7gFPEsWticTsfzL14FepGKSvjltcW7wOLyhMyhCXH
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Neither the error path in sun4i_gpadc_probe() nor sun4i_gpadc_remove()
ever holds a runtime PM usage count. So the pm_runtime_put() in both
places always triggers the "Runtime PM usage count underflow!" warning
on every failed probe and every unbind.

Drop both calls.

Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 203459ca9907..85382e435f2a 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -657,7 +657,6 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	if (!info->no_irq && IS_ENABLED(CONFIG_THERMAL_OF))
 		iio_map_array_unregister(indio_dev);
 
-	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return ret;
@@ -668,7 +667,6 @@ static void sun4i_gpadc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
 
-	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	if (!IS_ENABLED(CONFIG_THERMAL_OF))

-- 
2.53.0

