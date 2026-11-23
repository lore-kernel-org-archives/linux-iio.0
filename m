Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452794;
	b=nCdNvFRgRmeZqT9oLuM4xy7Ws5uZCA1+TjpwQKqhn2m7NAC9ay5wJdMhvMhgrSPSICZl
	 2mUwf0ZA0p6YeoJY7CeGCCEUs2pudGBFU+n+K5Xqhaq9LEWRGv51ixSSFJ/OhimhbnDAE
	 9XjrZxPA6GkD91+31WdIw4R2dPtNIgFND2RuptVAC/uwRyozsAN/NVKFO82v0qYL8qEc4
	 4fERfmBL+Loo8w7OUo+MhZUs4En2D64ZElJkuWbZYFe3lisPS0wK3/PkBusZE4jV7ItNn
	 KwhfVU0LWORNlZ9P1dQlP6uMnsRL2m7ec6SDxeCrW8yB52j/96MIL9ywh54pKurfBZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TUxLuuQ5BDvgDBvVo0cr4CFNouXQkFS9YLCQcvchztE=;
	b=BH/BellCAA4DNfpZ+SJqPuiBSyooCnwcz4bpk+IXigPRxw1zLRS6QHA/r8IzVoT93ePW
	 TyspAFzwC2xCVzZRU0lIZQAIsIE2hz7ieyerS9WO9c4xMTWpfl9vBEnSSa3BhZ4jkQpS9
	 NxFjpRmxZ/Cv5bS162HXVyFIyPFL0AGG7aSquoz55WG6ywnMYw/sdW9qeN9SW2cBzTYOW
	 5Ykbxm8z6CYAEUr8bsthT29wjS6RaCdMDm8/hd/QBZBshHvuIx8Qdxr5v9/4H8nrT10ob
	 Ox50bDA/gZxzxz6S8mniVf/DBnFHHsoKtjJ+a0vWULvrbb0aehTlMWHWnOCFE/nu6VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YAo5ihZ4;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE122606A31F
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 16:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE122606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YAo5ihZ4
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-385c497bf94so2530971eec.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 08:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452793; x=1796057593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TUxLuuQ5BDvgDBvVo0cr4CFNouXQkFS9YLCQcvchztE=;
        b=YAo5ihZ48I1v+Pdk7t4OH1oJhmBDkUx52bBmNd+J1+eFDYPHZLCWW67QOyk//vP8m/
         IzDkpNJqfx2I9Co6wktYpobWMcTAmMA3/JCsgtWmG4kgwWRKTV/E8RJIDvBkBvEE+Qem
         psAsriBU8ztXG4oW6msy9cckQdJ8TVOaHzVpNCr4SIgf+EUhNIa/17k5L5TJMUIrwZTs
         xuIUHhNFsB5tjdx9MWQHHYLnenV+NxGFbLAFgP2L9xFZbnn8N/w0QXCrJgpYXAp6uWbT
         38hQE56ZzaA8zwnrV/XtVO1Pc2ezSZnZ7KRUH51zwRs/F1rczSESvVPmPYYhRtW94Kae
         ejlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452793; x=1796057593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TUxLuuQ5BDvgDBvVo0cr4CFNouXQkFS9YLCQcvchztE=;
        b=oV8WXad7VJLtthmnDDE53lKsuGsGP9Cai5qPg0jcIV7xrkkPeVG/lVeOhc40Ztwwe+
         bkjQ8FIchCkfr8kricvX2GuyjcG0RJ2wCNcBheNBS5oEkqvmDClmlrKy1WUNoL84j5hk
         7gX7AGLsVDymp0hwLAFqmjj1vr8qjq2eZCkyga3yAlDKI25jSoGMcx+Y2UceiO8Tjwdf
         Glzg09B5JIXFM2gnwPNM3rNSFNcyUGEZafm0GZzh+R4yQbhNYEYt+8/MgWEp+7re5w9l
         A70ZVwD0k8ljHOg55m/fO5KdizMZp6BISWx+ybY8sk7l1aWt5hzM/2L5sYo5cNOVYC+k
         ZtXA==
X-Forwarded-Encrypted: i=1; AL+hErFwQ42G0uB3eQUEtQrdjEXjemgRV/xLUHwARUfrPdcH9DKdA0fb8sUHrf0TW9cbZSctU6RoZ7pM4M0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AVR2G187P+FRWwFUsd1kquSrdOYRnCxEEEdulL/GNdrGWaAyj
	N2tz2LUlPWH9ta29Pqm5qDBUqJ2wjdjGvU506K9r0PJs4QUIjv6Y+/x3
X-Gm-Gg: AZFdTZdJ+iV5kDY0rh0cw/zksLCBvh6t0cNYPPI2XxZHIl8dV6y6OVjCoCh4dvYs7qb
	8Nb6lec4OKbDCwFj2EuKJn+JPDHDL44mwQiWj0a9YoUZuocXpjuMGUyPtWAxNBSInk+Pr4r/Q6X
	xUZ12Kz+0OPyST2h5yS7mcQ5nKI1aiJ9NoLb2R0KbW3ZQvvdpL7LrjZqCR+sWdNOSAEQNhS0UYq
	XH11lvMSB43pORoeM9DTccd0yFHrRBAQlBtUwY3WXMc0HVLYxJ9nPGLJTRb3wjqmf+VjpUvFYCP
	z+sy3q/LNUICgVSLAho42EI1MPXDZGFpmSu99JrxZxzGYDoCJem274dMTqYVlIu6d0/cWIdMWlR
	zjPRXC2psjG2Pa+SV4eT5NRYWPQfhOWCc8/NxyoymwaM4KaKByI9N+5ukxwNsW1wfRpb6cZrnVk
	RiSXJJePmNL48kwBF+hF5nLpG0AKKyiloFUf05U54MNWQiY+LQ8PTcd1eoQe3WqPpmab0CW9M88
	mu/i5xFs4DzvIYZHb1+TumtpHu/Xf90g1iG/b3WLc3MeLl67o6a++TzbDDKSr+zuTTpUwH3lhif
	KPXSU+Tfd7gtbVm/4M3toLiHvui2Z/cBHupi2jhH8D5U541xU8x0JyyCEaQoqJylKF9f/1AIl6s
	IwgHRDUWGLNQwL60LNiLcfoGtSKxyZ8ns+Nu8LP3g2jdFj24sUyizv7BkH2S1sU0S8BDIIlWv5B
	6H7ESICvamQ1D51DUt5H8kr9ODdObH08I/XAx2IBfirg==
X-Received: by 2002:a05:7300:1899:b0:386:b6e2:9fa1 with SMTP id 5a478bee46e88-386b6e2a02fmr3281767eec.34.1795452792857;
        Mon, 23 Nov 2026 08:53:12 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm47196668eec.5.2026.11.23.08.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:53:12 -0800 (PST)
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
Subject: [PATCH 2/5] iio: proximity: hx9023s: check the sampling frequency index
Date: Mon, 23 Nov 2026 22:22:48 +0530
Message-ID: <20261123165255.239490-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123165255.239490-1-kapoorarnav43@gmail.com>
References: <20261123165255.239490-1-kapoorarnav43@gmail.com>
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
index eaf962c29256..364ad2fd6095 100644
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

