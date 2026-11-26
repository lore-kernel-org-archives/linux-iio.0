Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729063;
	b=a0e3ikEdadDPcsrKoyfG2QLu8WkboELe56qD4mzr6b2TqLvfMc5VDUdiIKvawvC44uzs
	 GX0hhR9RkKnyVxqzblWDaMn1kuGKdTkTd3RXT3z88cHGpCBYqXIRXzm+bJyPsIpfAz0EF
	 wXu5BIbZZ/z8K8GGssVbgtR/vsHro+/+aQUu7fuFMBe832xfB97iWtJRnIMgS5dt9r/Ab
	 q853tNfUm/eVxRyYal1V49dWQSYiPMdBYHadGSkExe2tCC57n+sYte5iHnfxeqIJ8losa
	 C2gL1nPivdOj2Ru2SuX5Z3M1Xa2I6WC80OsCp3fmFpsnSWjgSGN2f+vYhghM2rUHvKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1nqKyPhYmsBm0UGaYPfH+vL30mlKGB4MC7xPzvkwra0=;
	b=Sf3IGpwg1inTRfSDcnDjKexgqtXrT95Do8qGUGHaIi+zCexMiQYfMNepImqMspEoUpRX
	 7b9gz9lXX1qkkILqNcRPwIxor6LYqkHPmoG8VL4bQp5KgGsd9vOoZnHM6EAWoTD4eQ2++
	 ClZDAn2jBvP4htTzKq7n8mrvkKzqX1tIT+jCeGYacqJldAiOsvsKosyMCKPIxZSsDOHOF
	 5qhmvp1PC1/cXlWsNLyYI50oWQb7XQ3HCT0dmX/knLWMqWLjiuDB2W14ut3GX+MhNEu3G
	 9/pL1wr/mfji/CyVc+2Qk+BeGkaTtUSHidx8yppUBrcncmWPRh6HAWmpGKbg1FitEhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z5FRwF3d;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE8606A321
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 21:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECCE8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z5FRwF3d
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b421e8d111so4947504a91.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 13:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729062; x=1796333862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1nqKyPhYmsBm0UGaYPfH+vL30mlKGB4MC7xPzvkwra0=;
        b=z5FRwF3dwle5SPubKZH4G8lrWhJeHFmUdtTn8YMPTX/Q1oaRHLRyMvlydU/VBTNLjJ
         MUA2hbq+49YtdHI854lVowmOVt5hAxPQohiPua3PUbNXhkjBil33Qp0Sg3t/WhrvF03z
         Lm/Gdl+c946x9bCTaSwUMn8xjPXYxUQiGycloIT7wBlAgarKAtHlm2OBvKkZjzSbjXlh
         uiX/NOVoueRb6MVqv0WjX1m12JJIKkauOGHOHltn2r6jTfghUbi8m8CqvpuArrj0LWj7
         NUPuBs2CMpdFCU4IIaaulGQaemqZLo6SyTfOl/oo0p1HtG8au/Hro2qU6egB25KnQndO
         VTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729062; x=1796333862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1nqKyPhYmsBm0UGaYPfH+vL30mlKGB4MC7xPzvkwra0=;
        b=NLLQOC8JQc/zWNfjMNefKk6deHtinklfI/fosYsL1p6PoHqCyl5qIEHCj69YOC20w4
         WmCSq039lLAhM9V5Ynox225AsL2P6oS3BZE5WzGWP1AR/lymjaRyo7zOJYPc6slhJKM1
         q16VOMReKI1Si3kaDDp62VAp+4vwB96bu7VWd60u5a463W0xKmTZFNkWG30W/krhzbii
         aNmyvmMfIWvykdWmlLAS8Bk3+KbpzcRVI9BU8nX+LPco/Wxm8CQP65RFqj7TVmdNbLC1
         4UUyY83ho4sgvjUxx4VhJmGP/4X+anEun+yW1rpB70fpeNTHGwZDcQyqzp4N2ee7hgLE
         RDIw==
X-Forwarded-Encrypted: i=1; AL+hErGf3zO5KdbQo+7/l1XTV5jflc2hNos759f5l0i41zveF3KJuTC3Y4WrCzVwrb0zff8aLVyqpzY0dps=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GzCLeF2QTw/rBPUzIhRb1R7FL7JGdxRw9gq1vSjjH5kPkiKH+
	HjrjHxd+6opGWzjea0dcKzvz6Q6BNT/VgrRHqHcv7Nq6LrYLqddq4ScR
X-Gm-Gg: AZFdTZd/NyBLLw0n2x9DqKPcki5WkBFwwO3QzOIL0GzGR88YYR1lnG7KE+/1an058aV
	jAA8jLNLv3oE4z+Aryve7OV1m0+MlOTGyTKUZKo/emLQDqjUqtRXStUEvHl06+fAWiU0ghUumnR
	+Rhl8YNR+ujnnSCDgmxNdBi9ADldjbzLPleAbf302uUHgKx7dzgTM+HM0RZnLJT1RjhV7uv4I4N
	ZCHdYG8rB17kgv1YMNSiB5WCj9BeS28xTzWXxlva5/p0NEbQa3r/s5er6U9/+b3iRq2v9FaaP3E
	JPnIHm6VIEVgv+teI1dWrkNnUf2hs8ogRqF7PGef0QZidVw56DN2kiLgusoVMo8FigxaV9SQqdL
	nt1gmnmE40A8l8F+6UyMXUGLA6/F6X42y9gc8IyV0E/BWAlzqnIS+jJP+poK5yuffJxX8jsRm9E
	2hHNLKTlsO1EF5Fb57nZeT1kiEXoyXh1rlZ5FLRvEU/TC7ovYhM+DxW8XRSo3Z3b6OfsF/JEPkU
	318qHM/t+fSOW5f30tM6yW8UHk03WzNH/Dl7RSlr2vtPx8AIcnbGgKrl0QSAksCzqAWYTrqlS1F
	qht/DHi6qU+M1W4u8PQNtYQ9FwGUy0hrNCR5GUpFLe/UIYLhroCxUpYvqM4Pu6X+Yq+RK2DIwu/
	eXSdKwSEP2AtrkQr5HaEH9pwUaiJuEf+dmDq8dgrNhfuoakDuq5aDpWCapZ5/V0c7dO9SuFLnpx
	vIBApkQeUQD7JtPmlOf7OKqg==
X-Received: by 2002:a17:90b:180e:b0:3a4:f8da:2478 with SMTP id 98e67ed59e1d1-3b41c9e4a2dmr22048568a91.29.1795729062277;
        Thu, 26 Nov 2026 13:37:42 -0800 (PST)
Received: from kapoor ([149.40.62.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm11703905a12.2.2026.11.26.13.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:37:40 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 2/6] iio: proximity: hx9023s: check the sampling frequency index
Date: Fri, 27 Nov 2026 03:06:47 +0530
Message-ID: <20261126213710.1047676-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126213710.1047676-1-kapoorarnav43@gmail.com>
References: <20261126213710.1047676-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hx9023s_get_samp_freq() uses the PRF_CFG register value as an index
into hx9023s_samp_freq_table[], which has 32 entries, without checking
it. The driver only writes valid indexes itself, but the configuration
file loaded by hx9023s_bin_load() writes arbitrary register/value pairs,
so PRF_CFG can hold any 8-bit value. Reading sampling_frequency then
reads past the end of the table and divides KILO by whatever it finds
there, which may be zero.

Return -EINVAL if the index is outside the table.

Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsing functionality")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index f5cd31a308c3..030a6265f896 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -681,6 +681,9 @@ static int hx9023s_get_samp_freq(struct hx9023s_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
+	if (index >= ARRAY_SIZE(hx9023s_samp_freq_table))
+		return -EINVAL;
+
 	odr = hx9023s_samp_freq_table[index];
 	*val = KILO / odr;
 	*val2 = div_u64((KILO % odr) * MICRO, odr);
-- 
2.53.0

