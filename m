Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158706;
	b=F5D5g1HhOmHO2SOrLt0WRFZ/InqxTnD3/+F6hw43vZNGpf1rjs3EbqviEqKh3Ox3bTm+
	 uTO1o2F4PzrwEcqITTOrz06JiZe5IOpD410AcjWqJt8lql09JB8it5dhp06RYZOXk/DuC
	 zR5E3HtS4A7gPv0DSsRsDZvAFO5UzTUZzt0xEo+qTTL8Gmx+Pd3El6ePkkUsCKOWwKwIk
	 dyG5L+KJ2scdUItP1zVJEoxOC73ScoLaOQ0itefvNp/J0mQBstMk96Eky0+ar+RZnvcJF
	 5G/4MwhxpELl+Yh4csGGo3F3x4H7fgoU6AHzxmqeYvjBjTIlLsA87/54OX5p3B9X40w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=ltIGsSmri0nvtppydJ1lrSOYh7wuovs9r8XwUzdiCbo=;
	b=M0wHzXQ/dz4KtVE9fEZts+Gh64kf5thVjnj+ruUXtEr1YQZeDsWk7UmWUUOhqABniGpd
	 IC3+BbFwhDivfHm1qbJ5w9wnknEkHaPHcpVL3aQILRdHNZmtvgoQ3PHTIkCjChQKH3fKF
	 IA8bRdc5onMO3oO+TrL6qzPohodNUlW7OCWAVHMjc1CGTaKZvqPCEIrr9BZ1rc0O1uDBE
	 oF7WmREcrtt/qVPI6tHEX6KLbzOg7wNOt4o4gJN/NTB++6nKDfunNu+y0Lq4/b63dxd3I
	 5iBlNPYUS62M5+5gRBSTUQg/53lfxyhu7ZnsG/ZUFkNUBGQbRk7nxnl0OR70d85kNOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="yrv/R6Io";
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D2606A325
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 07:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D0D2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yrv/R6Io
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so425834e0c.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 23:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795158705; x=1795763505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ltIGsSmri0nvtppydJ1lrSOYh7wuovs9r8XwUzdiCbo=;
        b=yrv/R6IoY0PDdRJ1bme4asqGM20XLErFxx2pgGxPsfFvvojIAvAhE0fYwji0jPHQkG
         xwxdBaJSbtjWd9AXKWIRTTGi2QImcCRg23V/otZvXNVSD90eDulr9jb2rXoYYmN9sBEt
         nrrVehLfvCHaMNfjWeUUdtotFhKV6Be3YprSiZU9o+3+knrHGinptmR628JRgQGemlqI
         DysBP6CAqsThGkoz2T5HmzixmSf7wWTHyAMylBvnd4KUwNvzTL8MKarnciWPe1U/hnba
         WsiE8MFzvrcEl9I3ZUJ+jAIoV2RY7zxCpWglTu4odEb6+Qp8F1wdNyXTXEXEFeMzzrqb
         Dokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795158705; x=1795763505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ltIGsSmri0nvtppydJ1lrSOYh7wuovs9r8XwUzdiCbo=;
        b=VRY0eK8lVi5yCzBJYdDHnhQ859Lzya+bolNJpBYrHpNb23rQz1HhdV0Wt45Mob2hJ+
         X0wv3VFNDn+I8u76A1oFvsHRMTEyC1XywTviZJ3UCb/crgz/HtARK8OQfDdH+WhinxKH
         I+WpBqoHlrJoNKh+5XHp6h60Bb9ce8J5azEeECueFF4hZMtTzwNVQYzhcZlRfdurzvMi
         7go2CVZp76hLke0qKHb2kpzrevYq29I3imcZTWWfTyIK4IQ19hegLYqb6IZ9SToMO4zm
         A1DKQl0O4Damr6FYNWeLStWn3CyanCouLoa2NlXJJnOIf7zUvVmgkIdRKE4Uiv+/CtvK
         N5hQ==
X-Gm-Message-State: APuU4Z914F0toZ//EKeT8lNl5xmucCXLwHf9ENPTVPA0L/VPW3A7RP6l
	wqGcpAL8tIKADXmLS7Ole5+uvjT2OU+xxAeBz12dXidHdLDjDRNqYvIz
X-Gm-Gg: AZFdTZc9/2QUsVv5V+5wGJphhZ06hqRcFcfK+dgV3cYbwaqvOSrh+7dpaVxxlEviLAa
	4eprxPZWIWKLtExGOTMRsbP4koBWoB+Ps30ggLgiKYIF6LUuhy7amoGUdDpFTYQKhH6y0VBgTHV
	j7p2shKrGEa8XUkjMYuwu4+GgYYI/2NsU1rhE6xWogoJ8TDeb0r2nL3pcVBr3/toalnmu6in75h
	sWrY640ExV/gC+43g2tGWMY80UMbhxZKvfL0ZLKtss4u4eU11H2gUcFJVoP6IKHTX1y4Oj7r0En
	sfuQXFcZoNqc5I/XQ53GGMa8EtKo6AE8mt9cjiegv2Q39XIf/VcP5pO3/Hu0PjOCuxXx0wOYhHo
	VX+W2SWk+6qxDuqXsToUpFAUeL0UVG/mkjmbtx/7m4+GpNzIvVKCV9GlrrWjmoqMuVNVfX3q5v5
	koWML6rUKJr13hJrEXtRXGGY2KEpeYjIO3fGsqaTK7qVf4d1mi+hwnBpTAJX19Gvvhvv4HwyYvn
	Pvia+DY/zMucc1IxH1iTgwBYfgJ3FoAgk3H0NPy6IuZApmjH+0FdVjt5Tq4wz8C5BJggOi3hBPq
	3V3RmU6+Z3pwlu5KQA==
X-Received: by 2002:a05:6122:3b88:b0:5ea:e197:93d9 with SMTP id 71dfb90a1353d-5ee8af6eee8mr1261837e0c.19.1795158705113;
        Thu, 19 Nov 2026 23:11:45 -0800 (PST)
Received: from [192.168.0.9] ([2a09:bac5:565c:aa::11:204])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b653081sm1773611e0c.16.2026.11.19.23.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:11:44 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Date: Fri, 20 Nov 2026 01:11:37 -0600
Subject: [PATCH 1/3] iio: pressure: abp060mg: Fix max pressure value for
 abp001pg
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261120-b4-abp060mg-fixes-v1-1-2baf026cde47@gmail.com>
References: <20261120-b4-abp060mg-fixes-v1-0-2baf026cde47@gmail.com>
In-Reply-To: <20261120-b4-abp060mg-fixes-v1-0-2baf026cde47@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Marcin Malagowski <mrc@bourne.st>
Cc: linux-iio@vger.kernel.org, 
 =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795158700; l=1160;
 i=aleszlucero@gmail.com; s=20261104; h=from:subject:message-id;
 bh=+vn+y5SeWBnvbb91tEwCUDWjowuytkIJmiprFseqWPs=;
 b=kqmuqrdGjS22mftN923P5NzLdcwh6xJNJYs+9iFadQljDs5+7FebYcEffvy4/U2bKdTrOAvWa
 nqNm7q0mA63A3eOFaeSIr+61QoiEYhR39XS6qsSxnNlcKNvWDo3fz2B
X-Developer-Key: i=aleszlucero@gmail.com; a=ed25519;
 pk=zRzEBMID7l1FXqr2CjfnlIn++3m3N05FuNYb5zPA3cw=

1 psi is approximately 6895 Pa, as stated in the comment and used in
the differential variant ABP001PD. Fix the transposed digits
(6985 -> 6895) in the ABP001PG configuration entry so its scale is
calculated properly.

Fixes: 9ecca12edde4 ("iio: pressure: Add driver for Honeywell ABP family")
Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
 drivers/iio/pressure/abp060mg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/abp060mg.c b/drivers/iio/pressure/abp060mg.c
index fd48bed35088..9a9dc2bfdd40 100644
--- a/drivers/iio/pressure/abp060mg.c
+++ b/drivers/iio/pressure/abp060mg.c
@@ -60,7 +60,7 @@ static const struct abp_config abp_config[] = {
 	[ABP250KD] = { .min = -250000, .max =   250000 },
 	[ABP400KD] = { .min = -400000, .max =   400000 },
 	/* psi variants (1 psi ~ 6895 Pa) */
-	[ABP001PG] = { .min =       0, .max =     6985 },
+	[ABP001PG] = { .min =       0, .max =     6895 },
 	[ABP005PG] = { .min =       0, .max =    34474 },
 	[ABP015PG] = { .min =       0, .max =   103421 },
 	[ABP030PG] = { .min =       0, .max =   206843 },

-- 
2.56.1

