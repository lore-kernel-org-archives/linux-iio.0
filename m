Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170513;
	b=jmyzDAJHFsg54lBiP+QftwXCL6XRiOZXuyXDNk9VPO8/2SPbTjMvtxnEULewO91HMGio
	 EClB+iz/CVwYAUNKvoQLGxeNJnT5GnA7IQoQ2vb6OwCMbXjhphpzmh8tLjCAWZ8zkQM61
	 LSz6GlA5aAowv1axrID3j2t4gHSC7g3ZGGJyC2d8/boGmcEyHkhRyJHzsIvW95MtUfKkW
	 D5f9SIN+S7nMv0RZ+n9uFLA/JMMEQ8EA3Vk7Yq5pHHEERM8/MYLVpRb5dwOI6Dlxzm83W
	 gCqy1YnqEQwHWH1DDYcE6spo9tbBm04UsRXLM2njyKzBtQUxem1ucEUE0WxIBEsoTMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=+JJ9mA9xVaU1nW23PRrzTwcqP90WUl/SIHCdKPh6v0M=;
	b=frlsoNwKr2fTbZmsgPzgh4uhhCWG4vd9TmuqfWXxpq1djs/0Hokaa5Jy9eIRlRSiVBiK
	 z+LlB/fJTALMnoO60OTKlg8nVlefHWinolSaBW6ixdF4tFp0mImw1ryTdc+nvvGyCvBFP
	 c/rrVeq9kef44mRzylT2ZeOrQRI1f8JcUNiijESS0waeIRTyXzniOgRVtaG+qHM5pR5Pc
	 jEloFjZ8CfGBfPb/TNQQ2r9bh+jmOWRKp465rgiVHt8iS9xhAuTZ3h3/QNSCLo1q1gJtT
	 G2gvaOXFHcNsD6vFKQUyKZDO7n+WKJcjPgBufIauB2ywm+bIwoTTi/iNmwfzMO19yFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vSjwIw9V;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B289B60A2610
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 10:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B289B60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vSjwIw9V
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-99e1babd683so349495241.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 02:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795170511; x=1795775311; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+JJ9mA9xVaU1nW23PRrzTwcqP90WUl/SIHCdKPh6v0M=;
        b=vSjwIw9VKynhJ94nR+qB0TnpjpOM/K2BPW7P4MLU4RHgwvNy/wcyCI0aC0f+jO//GP
         R7w0Za2/lVFF7Zt+pmqOMEyVQkR4OE8MEUzDXKfUlhddcb8GrT76KV2EiMhocAYldese
         lU6GU64NAtMAAZlqT/TxjPNICGorvAXjlJSwG1+TmPyx7l/R0vnvnOdN8tAf+4jcRgAL
         uz5sXk072zSOxKsGtYNtrbUEY9MbAtoP0EpElar4Mh8UipvsOP+WBpH0DK8Y8oW7g3zY
         swngZ1/DgUM/QYFN4ec9hmoGyWR2nJbKRB1gMXmYb05kmOApRMTXCUwJm2yjGJqiYQZp
         SgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170511; x=1795775311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+JJ9mA9xVaU1nW23PRrzTwcqP90WUl/SIHCdKPh6v0M=;
        b=Jirh4ahzoX4IQ+a+a/QyprfPGvxUNyP0foAcH/OW3SeDT24zeDAZizMtTkCUwBY527
         ly/I7yLmoBSEM1/FS9Ms3SwzAMuYS3QA+81u71ooy4FsfPKzBrWGr9VnwyIWag6p41Jb
         A0aDj+lLaYpOdOyA4HPMZkRDfgrInK0M1wWRpZTzJSWXW38hhLAya1EzwZq+oZmful/g
         YTAVZPJPBs3VoEA72QmHv0viSNc4c+VDa7WA60Bntuk17ZhOfu8AyulFJyVY5OPxj2Do
         MACj2l4SJvd1JXWbwZCQ6c+IORdAkr4RL8HHvQm4nJGnqplxs69jKTrL/qPlCqd/W8h7
         /+tg==
X-Gm-Message-State: APuU4Z97MQAlOkFhxnvXPS3PlEu5meprt+Mr+/2kIQNivZfDFfi0ADoX
	BIGUJqfaf6HcNXMuR9MjH0Hc9CGmUJS9/8wUKS4pQjzNzw2DcQ8egwAE
X-Gm-Gg: AZFdTZc2m1sXvzSL3n0jHiSA0/EcbrnEhKx4af31qAMO9O2LPl9rDf2zrjx2x23bTHg
	KmFBxh9eF1ZZbQU259QfrawfZ9W3C41+wqTUgWdvfkzsx0gfwqDQxVUePZb2G+5bdL2F5t6RqGK
	Ux9P0C1RXbMkl6uAcJB+2zDb6bFwxO8rFD09kElbN00Wx6nDv7FohfFZAKC78AB0fL95Oua5FLI
	JTkvhjeI6ppHeAsY2OXirZSuXdcPYp9noNeK0ffcFI7fpEfVnmYfJ2J45N0BIyPYZr1/lUcz95M
	6Whu/0AQJi2A9P7P8nk8m9Y51CfyQ1pj0wpHMzdirdk+/NYzo4JYZ7Za3kJGBChRht3hSV5NEaE
	BSGfyZpF1XAp49Gavycvtzz2x//a52lc3TyhqfhgJSSZv5XQ7DhKlMmJDrs94zy1yJ0itHXOSgr
	IngPaH4Zk3zl6C+Eh1yFAXIT5/Wlz9uGPYkfR3aFNWeSOo5sbeJG5vP3CWVtMwHrZzi6bYwkR0k
	S5LAqQRGPZdPWAkTNmFDnYV/Y1/3Po0LYFWgzirhw7amybQxvV3Qzr99cNi0f9n8weH13/YJIzm
	yBr29862Mf6lCZGK3g==
X-Received: by 2002:a67:e115:0:b0:7cc:115:ddf4 with SMTP id ada2fe7eead31-7d73961ffdfmr805311137.25.1795170511618;
        Fri, 20 Nov 2026 02:28:31 -0800 (PST)
Received: from [192.168.0.9] ([2a09:bac5:565c:aa::11:204])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6e08a02asm2481753241.11.2026.11.20.02.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:28:31 -0800 (PST)
From: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Date: Fri, 20 Nov 2026 04:28:26 -0600
Subject: [PATCH v2 1/2] iio: pressure: abp060mg: Fix max pressure value for
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
Message-Id: <20261120-b4-abp060mg-fixes-v2-1-89a274d68a9a@gmail.com>
References: <20261120-b4-abp060mg-fixes-v2-0-89a274d68a9a@gmail.com>
In-Reply-To: <20261120-b4-abp060mg-fixes-v2-0-89a274d68a9a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Marcin Malagowski <mrc@bourne.st>
Cc: linux-iio@vger.kernel.org, 
 =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795170508; l=1590;
 i=aleszlucero@gmail.com; s=20261104; h=from:subject:message-id;
 bh=HummygsZEDzkRnFB58d/m3Bwfs42IfQEgoQpqWgwNv8=;
 b=GkUumlUlK7VJH7X2u7zlzErqx4LNM1OIwgrYzKrPTs18RMFADPWPe0PPkVJgajYYyRh432iar
 Q1xqeFe3cpsCXT8YGsL1YVs4JZoMMaxrNewvtQh0jwX36NfRRqwumKr
X-Developer-Key: i=aleszlucero@gmail.com; a=ed25519;
 pk=zRzEBMID7l1FXqr2CjfnlIn++3m3N05FuNYb5zPA3cw=

According to the Honeywell ABP Series datasheet (Document 32305128,
Issue 2, Figure 3 "Nomenclature and Order Guide" and Table 7 "Pressure
Range Specifications"), the 001PG gage variant has a pressure range of
0 psi to 1 psi (1 psi = 6894.76 Pa, rounded to 6895 Pa).

Fix the transposed digits (6985 -> 6895) in the ABP001PG configuration
entry so its scale is calculated properly.

Fixes: 9ecca12edde4 ("iio: pressure: Add driver for Honeywell ABP family")
Signed-off-by: Oscar Alejandro Sánchez Lucero <aleszlucero@gmail.com>
---
Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/ko-kr/products/sensors/pressure-sensors/board-mount-pressure-sensors/basic-abp-series/documents/sps-siot-basic-board-mount-pressure-abp-series-datasheet-32305128-ciid-155789.pdf
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

