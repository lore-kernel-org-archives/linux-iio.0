Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B24358373
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 08:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773302905; cv=none; b=HCmYiF5th3iLgN7mFlNpFjAw65YFMYmbA+aWUO1UdatM73Biigfa7Qfzvx/+zFbC6Ix3zr17qeNWnIGYDGLPSKmRc2W7F4T8hY8i8FNebpmJizVmzyQ2G81s9rYzZGPmNYbLDjixs2SWOW3GMqFzAQflyc+iWCsh4Qgnm4KqB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773302905; c=relaxed/simple;
	bh=V8LOdWrzuBSqf3jM4SPoAg2VaQaU66FAPo0nJ4BBoVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNIgrVRrUjU/6h2sdFCohJvtPz9Q85kORf5iRA3F4WXcpnmQKGHpdeD6LfecSipsVgBHMXLWzSy/4cbVHdrjTHFfINAdLKucC53FZbbMMo+U8N+GMSPAkdvwUYK1brFrh74FE5220SVXBPznuIw4n5CU28fav6es4FSWQVlcOiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2UWCaMe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2UWCaMe"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4832c8f9d87so540515e9.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 01:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773302903; x=1773907703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7dabi0tEsSZVtMFaeNapFH8+nODVlADSPJ2BaknK20M=;
        b=R2UWCaMeopCcE7aZ0yyGUXUT/675FnHs6pa9Hqed9Y5kdg8g5gOYUGF9pvv9FJy3Lh
         kcOm/feZNoeOcfaFuvD7QImMCrqevrj1noEpuijyyURMVi/nzNxAcCUXqsJquFY1x3rm
         9PgrLaTQ0hq7PYol15scNjY41TyGKj3xCzPUdMA8ecyaUF47+BQUslxyKkslHDh6k0l0
         Xz7COgnbMzSOfgM6Fjq04vJuTK+hfYgYndUjSK6SG16W+Vb1xhd7A8+aNjnZWQXtQe+c
         ynqJyQpXcEyDNO226iT9Cj4PK4jjEEkb7EXLaB1stmgWb3aEgrSq70gZUThAllejTZ7Y
         mrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773302903; x=1773907703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dabi0tEsSZVtMFaeNapFH8+nODVlADSPJ2BaknK20M=;
        b=lM9Kn8L+9xnGbHm4FHMiod59aKjAifJ9CSNoSPZisC4TMbctY3f8PprbjiPMHHQGp3
         5g6+OP21BF9SkN1Xg4eXYDW2qm3Y2bzEQ7R4TkR2j+3Na7zdOqajIYOHVyB/hxkU1P3Z
         /qP3NeLQCNmBhF/hEHeSocsKcbIQ3r5Tlapw7Ec0zGswOwiR8JTfp17DjVGmbLksfuj3
         QhnGtm8aMcjj0eDLsCfg5gwq0J9v8tuI3F04UFUWqR8AWWi9Pz2aQAlbe3xBnSH8Qpzy
         OqGWrSU3cYAcKBcYe8AczdlWNN2kVe4AV7pYbvG2z/sdx9jjibg2ecsQsa1xeUg+5wVS
         UZ5w==
X-Forwarded-Encrypted: i=1; AJvYcCV/TAGY/sXfCf5WrxlrquoV0Yz5lC4VxuwQss8CekbYtj90clOFk+qVfpXg0RfmQ78+SwTkDuFvkfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTCd3mIADgbYW6SNHLjCrqQlmfdPeGaX7pvLgx9Oz/tUxdFk/
	wy9H2/HOysT7h3hyVKxdfQqeGtilOkAj+AWNS5TTaxk376MnnW/34oR7
X-Gm-Gg: ATEYQzzlstkMkm0lq+G8PquNotMemr5ikgclHK7QkvO4xlzphzlHBhUBZCdgh5xI1oW
	UEV9N194sVyeT7vf/zhqho9TJCr240D8/AjChObqFuMWVSxVzmF4BpmbOqBPJKcZcxXcNVHtF1x
	Je+35+2ZUkLqw+NbXdfhSspUcs4mDtrnaAqOvM2SZCzWe+qXL1FrtgENny0gznnTkCKccjmlnvg
	VkDNnKT0sPJQy+XboJ1ETC/buZd6ALkdgSxQE4DU+ksAwgp2QhjNLMl5SK012gdhjLb/TgYObkE
	cW+RYucq/hyXYh7apfrevyS9P/38SLBdUeh+9C8IeTLuJTwiGk5+MPBYCfhxZvJBGlyQtdey/Lk
	7gN0L8nj1A1qzDjIdLO/sO5WwL55FIcpcPcCzhQdfOSSzTSv0Fd5K4mJ6eHIQRwBWKUbtXpCl14
	mNOEomX2+Gc/fI+XrRAoNg+TMuE85uQLSS+pocbB4EtFIP5ToUWTykZPA0Jf9lxaqoEMwIDZaoP
	v8adWz96bogwIykJYrUeDIUaxHj7yTx0+KPh1NsMn2dHTq0YCip
X-Received: by 2002:a05:600c:37cc:b0:485:385f:674f with SMTP id 5b1f17b1804b1-4854b104a8bmr50021235e9.6.1773302902652;
        Thu, 12 Mar 2026 01:08:22 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6b95sm106160155e9.6.2026.03.12.01.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:08:22 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH 1/3] iio: adc: ad_sigma_delta: Format block comments
Date: Thu, 12 Mar 2026 12:07:51 +0400
Message-ID: <20260312080752.48091-3-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the trailing "*/" of multi-line block comments to a separate
line to comply with the kernel comment style.

This resolves checkpatch warnings:

  WARNING: Block comments use a trailing */ on a separate line

No functional change.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 7852884703b0..4ece2a0093ec 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -52,7 +52,8 @@
 void ad_sd_set_comm(struct ad_sigma_delta *sigma_delta, u8 comm)
 {
 	/* Some variants use the lower two bits of the communications register
-	 * to select the channel */
+	 * to select the channel
+	 */
 	sigma_delta->comm = comm & AD_SD_COMM_CHAN_MASK;
 }
 EXPORT_SYMBOL_NS_GPL(ad_sd_set_comm, "IIO_AD_SIGMA_DELTA");
-- 
2.52.0

