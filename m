Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F83AE1BC
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385840; cv=none; b=YKKmemP4kG2GocMxeOP55HEgZZPcFr0OoZOQMTqdKMI7kv/NyMTRXJ6qIZcL3m9LO67U5xQLo+qvlZERwhaM6NQOE2x0SEs/SJ8wV7mvAI+PBUmWBpyIhyv+JJ+h0aTyVlIBhR8YFMzD9bHn7EQMnom2Avfzy8quY0Mzab+Fdcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385840; c=relaxed/simple;
	bh=OxiqvW6PRLQsOVphmE5v5j3F9oU3VHEQDJ4OMIfY9pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkTro/lK651LHs0+R+86Ntg05yK9C0KM47kJ26yQl9rnP3h77ieGU5eLFhKGRp31/Xj711TFa+TFSeDLnv6TGgAIrLkfzLxKgeGt7ss7lLbqoIWOSPELuauyG/1WEmkQ4OzsgU51siMFPhmPxTEBgGFxgj6b2uRmk3exgjw8OY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/6eBo7g; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/6eBo7g"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c197eaaab00so290975166b.0
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385834; x=1787990634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Shn+LztVw6jGLCcUfRZADiOvpqCHILXDPAzkxavgseE=;
        b=k/6eBo7gV47kpAbKmDhdTIOfExu1k0VfIEVOUXNjN0YHSeFuyMNC9drxQ1xYI+dW1M
         l+/luo7jz7oJOLbUb39NnnxFszs/AsmmvY1z2bLg2hoq6YNOCq98cLNpgfb1w7g84Rat
         B8lVagULgnSnoTgf2vKxvZXEPsnhGk8prg0leeiSVxq34Ky8e34OHBeyBJUmss8mO7wd
         +dGp3awrYEyUGn7ZqSaYGIof0roNizrTBylfgHyIYCmAK0cHRUq3LoZrafRcSTbig7sU
         1kKnB4PB1FF4R2Llr+3gJlaF0fda5nf+hkhfEs+6ochbXQwX1/gMi8lqdtSX2kjkf9zj
         fymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385834; x=1787990634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Shn+LztVw6jGLCcUfRZADiOvpqCHILXDPAzkxavgseE=;
        b=eqpxeGMhacT94yQYb1Za5o2MYw/MCudVqt8so/PO3LTZqZYNR2JWjjIO+C/aPYGAFl
         iVS2pJgUZH1rKLumjrO1+vD06NtJ1cM4497jFx3lHsM4C4d3+MwsjCpojREXqv5bR+5G
         IwMjdzlJ/aFzGPawGf9sxl5gWC+J3SGrb403xvmZr1vfVzj+fgnkGnO5c57hJNQTPctd
         TMe0e8iCNbo6xOhAfL/gOIwuWyowMw2ctjfLtcqPd9T3sMniHW+LU3FWuNfff3UAfFVo
         xWRQZoZxz7efbZsrGQrpPpC2QITfIg+uEJDISOFBnNcdW5pWWZubcDEtfzCQq290qBRt
         owGQ==
X-Gm-Message-State: AFuF++laEXJl8Hc4WS+WYQxBa6YpbQwK27YZOX3+e2REpsDRMuUrZD6X
	Z1zT3jTEaOYKArJyGS1ywTUAFfAOz4Dkx2GHmb2E61H6KInfiuRwtiRs
X-Gm-Gg: AR+sD10rSPWnBZKTpmovgGNL6on1U8S7zh4SvxhsXJpaN8oxB+FkOiL1wooSCq6JHrl
	ZTUTChIZJXpHvuH7uiuy+oKuBIlM1xEViCgmVjvxdPy8ORGHMVepLQq8+jl8uPn6F/a2yv2w0zj
	qEGGsSi7IglN1hCXn84VTCPAbo7jdM8+MrHG22glOSS/BtagO8xxm75+BJRo44iNhcSvTai9yTF
	9P/WgJQApq+kqEgXqR5WIDwfGmvJ9bYWLmRRhcZ+/fWNLomGKi5iGj5LvL1hQ/0/LAd+PgBEKIK
	7LOQNAb4d/ke6Hf7h/tVcPenxWqXEXc4Jv7Pzww8ta2Zl5fZROq3mLY+IFzCFxj/LpVtvYPr7wO
	UjJaEoX/erqPEhboAdZ5AiCW8eOBOIW2piiTZ3KUmMnaKF3M/gwQb6ve9tBuFvMrEf+B8iiB2BM
	L3zJqO3uzOoXHePHGio6V/BjR2yVQQIjavMnL6GXFnCeSbs/FGs2LSsHD+e2uNZfs5Ga58N9WQ6
	1NG+WQfHzvJ8rNYLlFEESxMs2fhbcnUM+pLUgWXOXEYAo10EW2LWUEa7VxsR0BApnD3Upr9Mt/K
	qQiVmbxdG7Rvbg67rzZv06aq5uax9lBOtF+OalHpuLQXLkgValFdSyXMftjdHk30D2BKSHIQwK/
	gg6k8ePKI59lM10tmDFPKSGN0qTMzcg==
X-Received: by 2002:a17:907:3e02:b0:c21:6f8c:2335 with SMTP id a640c23a62f3a-c246a6b1745mr1270213666b.16.1787385833434;
        Sat, 22 Aug 2026 01:03:53 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm11114235a12.6.2026.08.22.01.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:03:53 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 22 Aug 2026 10:02:37 +0200
Subject: [PATCH 10/14] iio: temperature: tmp117: make headers conform to
 IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kernel-header-removal-v1-10-ee31b124be11@gmail.com>
References: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
In-Reply-To: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787385823; l=942;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=OxiqvW6PRLQsOVphmE5v5j3F9oU3VHEQDJ4OMIfY9pk=;
 b=Csw4e40xxmBzCO6WP3RAce2rTBD1Hvqz/Rchyzou7yRtEdpBZdGCg6JyHX4cmglldwCKNbtbw
 +JxHPzixy8eBd5gWzPbEl1sHgoJKk+LA1uU9DkNvjMkbDYMMhm98Hub
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header and add the missing
<linux/dev_printk.h> header to enforce IWYU.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <linux/dev_printk.h>: for dev_err(), dev_info(), etc.
Removed:
- <linux/kernel.h>: catch-all header no longer needed
---
 drivers/iio/temperature/tmp117.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index fed8af2d81eb..2caab0624a23 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -12,9 +12,9 @@
 #include <linux/array_size.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
-#include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/property.h>

-- 
2.55.0

