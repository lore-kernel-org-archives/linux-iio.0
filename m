Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729097;
	b=geRJ6N07CGTnVLnPoZwHAraTB9Gkl5aOBWumGvFAks5YnuSN3PjHfu55BQxIZLG6TZAO
	 HZeyIry/vq+OlpzsGUxxstHeA50qS7uD1E7P1Uj1/01DGqF/zRSriIBI2h1Xh41ifUie5
	 yudsLcvcQoCjYosQtD4o1hed2BoehgaohIdexm/KuJwKzwMMedxoni/2tjse/jc/3RQ1F
	 glA6mqVUxVh901+9LwpavxtK/rqwNlZyycRbff+kZhDnUhaG/f/pnyrtKHOkC2AaECkcD
	 D/YxnIp9NlaJYBnbVGLVJF6/JeAmzfot+gCwMTJj41L5CXGMVZm58raeFeRGbyKm84Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=F1pncYdCQPYqKl02KctTzcxHlBl0h69nvP+CZBv6X9M=;
	b=TC+/yTAnXvIrmRZ+W3Bb6MN14PiyUcBxaT5zTNyL1/ADaLbcYRRGRVTmzd8hNTAStL9x
	 xsRvVYfmDEEsd0Ft0SyWuKKH9uW33YfTToMqQl+3nJgSEqG7tbV//EnXjOH5q/MIz7fJX
	 tjfryrfB5KT9yR7C0VJq2X5EwYcJZwV2r5DU71r3RWH3BbnJGVBcreTuf3+7TYmzvb1jW
	 6Q2XdgTBnq0YlD7Pqjz9PtweJIA+2EUHA3jf76VqN0uqQpXals8z31vF9Mbugt6Gd7EWG
	 znDsDmrcwswMx0IOUqdTAUnYMMiDemvQxFEfNld/P1kLwzsf0sesEDttiCgEzWq8daA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LCd+6YUJ;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85257606A323
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 21:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85257606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LCd+6YUJ
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8c70c2ab5a2so2925009b3a.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 13:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729097; x=1796333897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F1pncYdCQPYqKl02KctTzcxHlBl0h69nvP+CZBv6X9M=;
        b=LCd+6YUJ62QRUVvAFAIUT7r7G3Uk9Ecc4qbUzB7gZSXWlXa6KVDFoP3jLX23Iuvf4q
         nxjKHwzsH4R+f5REozi+DNgz0a/Sz6O295rSeH3Ya66cqa+lYqdiPDeQN4q6+sHfXMGH
         p0n3i3vrATHWlxgF8MNGVfZS0/juyYTy6QDYRJzhfta8h8crAE+4R3Eyn6CDlQK1sYdY
         ldi2Er1CzC7ldyDez+UnckmxPQd39OsArBzCklf0UiSvdNEbFZXqSRqM3otmc9jO0WGX
         xvKjo4jiFoNnJT875sKyFkixiD9E+bgsncGWLpccjllwjuBRgP9m71MwSWthGtZjMJRO
         zZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729097; x=1796333897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F1pncYdCQPYqKl02KctTzcxHlBl0h69nvP+CZBv6X9M=;
        b=ZdyOrdrwG7KNuOKCnt67XQ7i0SgIBBj7ti7ZUaDZVavbZUVx5qBiOtvOyAL9LEczh7
         SLjUUaWivNZMMeNbilcBprFLsyxJhlR35avCJNhYNyNlvqnU9ACbcth//s4KUBv/TRtC
         6BsA+AswcJui09bW+4zLMZzo6/rCHQ96UdvkjAB7sF3VCxfBNKmoDe1umbD6QTVT5zoW
         RCXBO5t1uoRUlU0Of6nH77JqZOJmekdyrWVcU3EXBBSwyWMVxpEgEGjAIO6v2+0I1E20
         HAOuZ6HUtNAXU6/CtyUPXNSAlt4Ga/CBdu80ItCA9VcUgCrMBsqo0Shdqf5hFk09qonO
         +qZg==
X-Forwarded-Encrypted: i=1; AL+hErHDlWXxBL28b5YrJYiyXEoirxa+4vFe6Va5kB5Kpyv3g8ZZYIc4HehRQjB5q5QFhrhQWeXe6wswrCc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8svtWVT2O/DU5QHaOlantWST8haOVjKMVF9GMlvoky4WNkBvWk
	2h9hYOhjARUaf9Ov0QNVxJ3ehQuzIGFzqhYOo71SacFKLCdpgYrbDpRm
X-Gm-Gg: AZFdTZfpqSoPoCCp0V4b36whPRS3a9MEnGC3UwCzKnUvQ4SCBClLhtU6Ap0iL9/8P89
	7VClOheyrlM+HEXMykEyDPWD7mTrkcFBJnu/fUQE3e71eq1vr1QJaYsjsByMaEOJMsyX5z8208l
	QL3683iW66blOF7x0bCFiUQo1RpOjdUEmmXO3M0WDxLY0yTUtoc3YRiU9r67xpN2MYbQYAgPKEg
	Bo3OVpHwzexWRWcSgoOWmYB78tTF74aKjav2YWeSu441YPHlHlUIMO14039fCJtFbOeFZ0GH264
	wJHANdXTbk7GjHY+rkzQ6Z8CnVwBCbE/NWPENGGzUTEwxAXopUcN0dcq9JjBh3x2TxwBC9/XJj/
	P+ckZaEhg9bGfa02QRWyIr0rKA91L2eNPKmV7aOGSKTp6RdpBTVnUZVC4xdLMmWC6A+85EnNJZD
	pKWQ3hSLO5i5jg8UhoAxQ8wRXbTPGFu0pL15BrubkTW9sX31W5MGjAdCb4Q4YvcDwMlwwsJntk/
	mXDqNMmjMIcpRS1+8Wvl+6eBJ8v2ElKZOqHO/eBX9otiee8ZzndSrsBwQDKaKsDJGr3yT4zln7h
	ohJnjSWpeM8Xz+u/abkOz0qiDqWK2/b2C7DLNh7Nvw6aQqlrW7bglsRyDY2a11jb/Jn2RfIqBhS
	K4Orx+Eij/G/JlHwG9f+Wg7P3Ue3/rPyggm8ZcH8TSp8MsU645aEOAQCtRnis8a5eDBSUMMPVnw
	hhzTi0Lu2oeeRKkHQjYEe0lQ==
X-Received: by 2002:a05:6300:408a:b0:3f9:a6b6:e184 with SMTP id adf61e73a8af0-4014dd5f981mr20640395637.74.1795729096794;
        Thu, 26 Nov 2026 13:38:16 -0800 (PST)
Received: from kapoor ([149.40.62.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm11703905a12.2.2026.11.26.13.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:38:15 -0800 (PST)
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
Subject: [PATCH v2 6/6] iio: proximity: hx9023s: use plain division in get_samp_freq
Date: Fri, 27 Nov 2026 03:06:51 +0530
Message-ID: <20261126213710.1047676-7-kapoorarnav43@gmail.com>
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

hx9023s_get_samp_freq() computes the fractional part of the sampling
frequency with div_u64(), but nothing here needs 64 bits: KILO % odr
is at most 1000, so the dividend is at most 10^9 and fits in an
unsigned long on 32-bit as well. Use a plain division, and drop the
linux/math64.h include, which has no other user left after the
previous patches.

No functional change.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index c2718723db27..98b65a3e69e1 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -18,7 +18,6 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
-#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
@@ -702,7 +701,7 @@ static int hx9023s_get_samp_freq(struct hx9023s_data *data, int *val, int *val2)
 
 	odr = hx9023s_samp_freq_table[index];
 	*val = KILO / odr;
-	*val2 = div_u64((KILO % odr) * MICRO, odr);
+	*val2 = (KILO % odr) * MICRO / odr;
 
 	return IIO_VAL_INT_PLUS_MICRO;
 }
-- 
2.53.0

