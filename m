Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60728A1E6
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867972; cv=none; b=W1aIZqDGOU+kWo6oNUXp4sCdCSae4qsWi8BTyikRHV+0WZPTelrIdTG72pv/QHDkDFNJZP/TPMR8GZe++BE/Df2MYQlAtGxm72MDx5cJOciFsH930mRm/sJ7BF5sXkJrf5sIWaxuFHrFYPcZCEqM5TiGSA1enfvzgH0pMspo2cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867972; c=relaxed/simple;
	bh=htdelNWDPK1h9voUhXP24C/rSnHgDpw31fhwSXtf1zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NsWqv1DTZay1NPWfAQyT33nCIbZHPPv7BeiqWaqLGwfrS1u5eGdWP27ZpLbq4UDse2l5xKPp82L5h68r6/t4dfTo3T7WnQ7n359MoI+qkF+MzKYX49OM6M0ojVWDxntgtO+qCbvXFx9gVPFpN9HdHBrzh5SFozIhHmWIewMlhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs0A173k; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs0A173k"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cf7190580so480638f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776867969; x=1777472769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nA/Qsic7tn3FJI7mCYVyNzkZbREQ3JqwDGoh/Arrujc=;
        b=fs0A173k4BNehgz3wZ/yPp2bbxBuyZfb97OVJKaCX95/V8nMGX4DsbRvAV9AwWrWxQ
         2W6bxgCQdOw2YzCfgfN+dP6tvq3dxW0loBpo2vgMWm8HWmCCSUmO8lJtSReLlVsF37gq
         lNXlO1aC/lgZz+zGCP+E1iaYvfzb+Y6YsUPdPKX9DncrIZoyEwTjxElE2j1/cnaGIH+y
         5h8v+CRZzSo+okJaWqBZVSlKVHtOxx/KXGaiwK6p+t2qPeAEVtx+celk4KBEnGL2MsI9
         Womu57OXP7lazhqVjnr8GDgsrYGhwNY41adyN0R1bS2hyMtZxKQBXacngQJLWfeE8Xrx
         1uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776867969; x=1777472769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nA/Qsic7tn3FJI7mCYVyNzkZbREQ3JqwDGoh/Arrujc=;
        b=jVQVNZFQhACPMJi6rZPykmYIXBuLfz9ZZebOFF05Udx0NuX/n4j1QQncAuYjJrZIPI
         NXkajOyKx/5XC5L/i4Qc8wJf/V+Cr4xhKToThlECur8TDC+BPlcskHbAZxleTJ5vHebX
         ltBFIPaMjVxjH4mXOwobpS6xIkHi51CsJqSSLmj0hUhQAH7LhOYEsrDQMgnvmSSWYWc/
         ToUEnmSOvhLQwF8CGiTxgGl0N0o7/0PXUCjkLoii662A9WIblImYNa1qF3nqL+TBOqUx
         m3EE45dqDQ7r5i3Se9kk3U/IcV9r0ZUcc66EmpOaluo8J2DJ9fRg1m+FNJVFtYtdK/e5
         OqXg==
X-Forwarded-Encrypted: i=1; AFNElJ8oSTO3o4jpYpdz2vCHir/L4MT40zC2cvoV1jy7Nlg+RKKcPEpGN2IXVHgkkk8XG1BX3gC7/QcDSSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+2FYVMyDS/5sNBKWMvgJhn2WND6I6Z7kKZCpNBga9qmxp8b2
	hRJLjb6oe8b4uj+IcI0TuQXNKjavgs38thplRPpWabARKZe/qBSIHgrk
X-Gm-Gg: AeBDievkU9wCLiHkTtiT6tgbFJfLEbx1IttTw8EQxCxUDBlrMnT/e4tlkCKOVa7OJ95
	saKM3cWjd2UESLVGtrQKr28JxlhcaOqYHw43gr/0NIOmHwjRtjQjVFrob/FHCV8HSAZ0Xz1yc8J
	XRgv5D6x0m3mBHvgRvPMrLWw02hOlUhJRWIszECNBn2q1WqEA0XlfOu4XGxro2/q9UsH74b0Gto
	jx5yFtnNOb8Eha1i1CggAMDC7BhXi4Ukfhf73Ln8FP2qV+d0IDRJjhQaA/ULvlu9ACSzORK7k/b
	exPaPLjUHbZxd0DX3amGVgE2s1QiVvuugDEoaECPxf4+uugM+ZrHFZ14X1hnAgKoP1hqTjSbNKG
	LBHlerzoo+ub70cZ8MyJXVr/Ik3TFRql23VV9+uc3GdPk7UZcWXKNionX+960sk4bHDjWL2BxoC
	z1+PSXU4jrLqxPsP21RKz2ry4MRXXqlP214NCiTj3en6FtCnMlrhwnlWE8r4BbwNs5RhnfqPKpo
	gEpihy0wGtRCtJY8iYFepWvGOvLTAh+T4HiTI7If+DeVtB1G3sbByqeI7uPEIU=
X-Received: by 2002:a05:6000:25e1:b0:43d:3b74:b659 with SMTP id ffacd0b85a97d-43fe3e29bf5mr14858456f8f.8.1776867968741;
        Wed, 22 Apr 2026 07:26:08 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46898sm48204769f8f.27.2026.04.22.07.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 07:26:08 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: ad7625: fix type mismatch in clamp() macro
Date: Wed, 22 Apr 2026 18:25:42 +0400
Message-ID: <20260422142541.160365-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch reports a type mismatch warning in ad7625_set_sampling_freq()
where the clamp() macro is evaluating differing types:
- `target` is a u32
- `100` evaluates as a signed int
- `10 * KILO` evaluates as an unsigned long (due to KILO being 1000UL)

Replace clamp() with clamp_t(u32, ...) to explicitly cast the bounds
to match the u32 target variable.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/ad7625.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
index 0466c0c7eae4..fb0fe2434c68 100644
--- a/drivers/iio/adc/ad7625.c
+++ b/drivers/iio/adc/ad7625.c
@@ -180,7 +180,7 @@ static int ad7625_set_sampling_freq(struct ad7625_state *st, u32 freq)
 	int ret;
 
 	target = DIV_ROUND_UP(NSEC_PER_SEC, freq);
-	cnv_wf.period_length_ns = clamp(target, 100, 10 * KILO);
+	cnv_wf.period_length_ns = clamp_t(u32, target, 100, 10 * KILO);
 
 	/*
 	 * Use the maximum conversion time t_CNVH from the datasheet as
-- 
2.52.0

