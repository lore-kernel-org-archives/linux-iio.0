Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7745337A85B
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786137626; cv=none; b=BU5jLVeJZ17AwkndWvp7xtydSrn3JU97y4hBfMnhtnYBK1AX4kBlamCTj9zICfur3mlvvQekZ5nctbS+1T8/Lqp3B+Gp/nIbnKkBXnZE3e409+9Kveo6QwW9N/r4ITjCIkOCsVs0Tv7B8XbJB0jnQWYhijsuS3w3mZpLDEo52LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786137626; c=relaxed/simple;
	bh=Y1YR/rDS4UV8ZC6YGY/M20j60KZGDeruvSj1PJBUU04=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rIKHk4u2aJmRZBN7mrLPBbo2I16NcC42HSKGA0fOR2n+kxQs13D004K0SpLTI5eQsAT+04S7HjyyIyFGGX6RLaKQk1XZ0uAUnfRxsoVHtH08ZZfbr6gqIZSt4dzAXdWpbq79NRr60OjY/VZ4BiLiGnloMAk2SEtlx1p9xB2ujvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=n5ID3vdJ; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="n5ID3vdJ"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4af7283bf83so38b6e.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 14:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786137624; x=1786742424; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d5hGw9MGpZ/5bo7zCtdzHu94M+1LPqoJVQ0/LVYI14U=;
        b=n5ID3vdJjuDiW9DYkblAHpqWBLBe+y6grgKpvuU0xKqUfo5P4FxZut/inHsS2brV4b
         gj/RSKXWSpr1XiXCgeSZnpH9A/7dd+Osz/M2aaqp3zB+mchhw0DYDGxNQ/tx6ZWnR7/t
         CCHH6qUsk+xcl68LghlNEV8f8S9lixtlh5RBBxZqgzJBTxFlaNUdK+4Ak5ITkogyGMuS
         3/ODsM/+tLd00+UEn1jQ8P+rW1Pls7mrNcoUiVf6YaRamMva5txzkkejKTdKB3nEguO6
         9Ajdoe1utByiYDHercuRQ76SxfIojg6bpFU7A1RAIufJd1p9t1pHQEfMNAZi510GBsyT
         vO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786137624; x=1786742424;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d5hGw9MGpZ/5bo7zCtdzHu94M+1LPqoJVQ0/LVYI14U=;
        b=QRgGQeM2SyXMqa9oiRrrKsnhE0g6xet8Fbbvb/YYPTvdzR8wIt6FSjK0R5eVQX9sQf
         ta2jn8FBjq30sZD7n7np663ARCozbY9LHbJkCoVa/MaoD6J3JeHpjy2Rpf8YqTFjGUnZ
         JaykQCqraYOh3ez9+ut/qMhDlgvpHaSytGOmb0Wpn8ZF8YYvk/tMwZgBR40l6cArJWCL
         65vDwlwgNEHbCKp91gNIGuM86xY4KlgM7jTaTB0avvSII6u/WHit0oJCO/BcC0BV2v6r
         xAxxW2SzcplHG/DqwtgFnvLFfMC0b3Hp+iBq5CFVxHC8SlOirGf7AWXm9mrBx3dZJ1SZ
         nTlA==
X-Forwarded-Encrypted: i=1; AHgh+RocOcQY6UxLDR7tmt+7ptuVMOO399G7L9yH7j0baGkJ3Iein4Lhw+wFhQdzzuzU03ct5DDWVy9zIqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbRUYQn+wD/4kNPtRlyx5IeK8t0M9wPudK1AfY3PDU+9clxr9G
	dVt7bEx/S5bMsTcCbjTvo4GUjj/gwa2sI3VyL4ho3dohchb+zg3/k/9mToSpd0hC4YA=
X-Gm-Gg: AR+sD135wutuFWSK2DmlzJPE39uFOA9NRewIjXFOcSlvD1lR4eGPBr0duaI5Xzoreag
	xSh8ymo+HJJZ53BZVpzpj0u5dciBZQStKpRsJqUuFJJOJCQBRSmgL6OKx5NkwDyPoD6PcsIv4P2
	IZI0jOAL3v1r0AtTBfx8IMKJvzCgkOmGpGHu3RVQvi6yXnYK9EGsZR6w3zovPBe+I3OMM02f1eT
	QQ5iBRMwKHO912B8ruZV1ylM95cxdKAaIyBdoxIhbjAUHGCEnkgrTPkqZjS4ioWW24Lh1gcjIO/
	1nJ7gT4G0DII0nGUcE7fz0v6DPdx3YWDQ2/UQ39/52k/UyG8hFYmyCxcFxyL1ZJpgsfUvNb2PWH
	EEJrC7WDL7/W3588CQl7+ZYQ/IQ9J9Dg5muqJLa3hfuyYxYMjroC8Utj7fE1dZJ9FrynCtccPP9
	o0KZVm2VVl9UCCitkIY3qqpYN+6NvstWxQBkpEk6HVawgEN0DedLXppHL+8/rDor5a
X-Received: by 2002:a05:6808:1529:b0:4a3:d333:2258 with SMTP id 5614622812f47-4b1ab9ddf66mr2107042b6e.14.1786137624341;
        Fri, 07 Aug 2026 14:20:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1af0bafa1sm508068b6e.7.2026.08.07.14.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 14:20:23 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Subject: [PATCH v3 0/3] iio: adc: ti-ads112c14: continuous mode support
Date: Fri, 07 Aug 2026 16:19:45 -0500
Message-Id: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-0-76e0d30e6c6b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WPzU7DQAyEXyXaMya7m7RJe+I9EIf9cVojkoX1J
 qKq8u64KQfECU7WyONvxlfFmAlZHauryrgQU5pENA+VCmc3nRAoilZW273ubAtECVwMUEgGG2O
 DaSGkqdA0p5lhTBEhRrPrdbdr9/qgBPWecaDPLeb55a559q8Yyo397cj4MUt+uduUd4wCHkcqx
 0ruuc44JtnWUqGWKYkndaOdiUvKl+2HxWzH/6u7GNBwQK9959pBW/3k3eWNfMZHKbBlLPYHtzF
 /5FrhojdNdE2P/RB+cdd1/QIR8UdQgQEAAA==
X-Change-ID: 20260724-iio-adc-ti-ads112c14-continuous-mode-dd1580754609
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2173; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Y1YR/rDS4UV8ZC6YGY/M20j60KZGDeruvSj1PJBUU04=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGLLKvL/2qqTu5eDm2RPSELrhVfxbj/nHtJ1NtrNFhD7MZ
 /w/9ZVbJ6MxCwMjF4OsmCLLG4mb85L4mq/NuZExA2YQKxPIFAYuTgGYiM1XDoa+vsy20u4obdNN
 0f0CMaev1csZsm6UijzvElCnXiG758ejF1UhJ7NFpgg/nSUfFRkmPFNW4ZsAa8nW/EjPmZsmV9e
 Zc7903s4ttEGtOpI//6LDa69lN5OObS/kN/3kumfaJ5tvC+YYdPW38H9fIqfYsCDL8Nrj+SESvr
 0vPfZv6SnNnxogHM2yj0dYYIXPTrfEMMWqqC2GwW9/78oSMhIy0+jmZe63iZ+yVGSJeeF6Qc663
 WdPb3y2mt972ed5+sain3qYTHa41M0vE6xcrnXpkcW/ezt2LX4z40poebVC7zuND5+53jUFyYUW
 uSSwy//Zxj+lwVejiXft9KXGJ3ac+Z+ucKY0pCJh1z5JAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

The TI ADS112C14 ADC has a continuous mode where it can trigger
conversions using its own clock and signals that data is ready using
the /DRDY line. This allows capturing data at higher rates since it
avoids the settling time between conversions. But it is limited to only
being able to sample one channel at a time.

Users will be able to select between continuous and single-shot mode
for buffered reads by selecting the trigger. If the "own" trigger from
the /DRDY interrupt is selected, continuous mode will be used. Or if
some other (software) trigger is selected, single-shot mode will be used
as was already implemented before this series.

Supporting open-drain /DRDY is deferred for future work. In simple cases
we have just done a `drive-open-drain` DT property for this, but on this
chip there is more than one pin (GPIO, FAULT interrupt) that could also
need to be open-drain and not all at the same time.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
Changes in v3:
- Leave DRDY interrupt always enabled.
- Link to v2: https://patch.msgid.link/20260731-iio-adc-ti-ads112c14-continuous-mode-v2-0-eb13da38e8fc@baylibre.com

Changes in v2:
- Split out irq and poll code paths into separate functions.
- Split refactoring into separate patch.
- Use iio_validate_scan_mask_onehot().
- Just return immediately on error in buffer_predisable().
- Don't set default trigger.
- Code style improvements.
- Fixed null pointer dereference bug when no trigger.
- Link to v1: https://patch.msgid.link/20260724-iio-adc-ti-ads112c14-continuous-mode-v1-0-9eb0b7a4f020@baylibre.com

---
David Lechner (TI) (3):
      iio: adc: ti-ads112c14: add DRDY interrupt support
      iio: adc: ti-ads112c14: create data read helper functions
      iio: adc: ti-ads112c14: add continuous mode support

 drivers/iio/adc/ti-ads112c14.c | 277 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 248 insertions(+), 29 deletions(-)
---
base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
change-id: 20260724-iio-adc-ti-ads112c14-continuous-mode-dd1580754609

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

