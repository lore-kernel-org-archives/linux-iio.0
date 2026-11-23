Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454950;
	b=AW6dapulCQ1AYT0fjcFOE3IhsfjEu2W2SHTxwNmPbV/LytuCkjeFybvFrRjFgszCedqQ
	 F6Ga0Q4bcKCveHsDIEPu83uCyAyXoCcKllEf1oQLCTip44R5tHRnPA7VHtRB8gF+yVO5f
	 EOAB2beIh2oIcSXiBsak97nikh8jWJWRRk/TntTTaWbug6w3x9jUYAhOWUT/N8MMzzciC
	 aP47xdZwoF8k4X5inRjSGmyAcK65ufHIq0elcM6X4HueUlPI2NhA0S5fdVNspdzzsSb3p
	 /xNtgA8EvTdtj6CkpuSpiUDTB6SGWqwTn7BrdGKg4mAFUrimt0PDbTX7Y00dIsLRA+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Q533qC5yHnPMw2MvdiCjXU74WULol03pGw7lt5AbWok=;
	b=2HAtSsKtIZPsdkJs0HTJbEyTGuZpzbP6mcLrVxmD8XN4sj2yxz5SNicOvqmFuyGj8Sv7
	 DjmDAvjXspBqBQDOPkf5sHatgDClpBylsY1+o7zbteialk8hpk36gB3k8gpmaExIWBBD2
	 sxRM1ubtGd+Guv2NYwgQPO6C71XCxb+D/XLOOdd5gSNGiCos5l+BZ0Y6lUbhHaPPhDY/E
	 NuHZBFXcZOY0BpB+L63MjD97cTKZy9hz2VjcXpQ7ZaHru8nWMDgv+ZWpFCPfFY09fHlmV
	 QUM8MXNnbucqVLXNZDRarm5rQ4kFJcV6CRHmtQCqmD+TxKXa+rmJKnaQoyHreNaJg9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jUKX6QGg;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50194606A31E
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 17:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50194606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jUKX6QGg
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso1792300a12.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 09:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795454949; x=1796059749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q533qC5yHnPMw2MvdiCjXU74WULol03pGw7lt5AbWok=;
        b=jUKX6QGgXGnne3N+/ACsSaxSUBaZeH/sPWhDAbfR1nxNCsW7iZwExRGVaIy4IwVux2
         tuCY+bLAqSf63jUT+wo8nvDawRwCMWwEDaVATXA7ELQwm71eZWd3VNavdF6GuapVBxgP
         ZRJ9J7i26bbdrdos2LYfgzF7uF74SSg2s3dHpx0tduMsmfFFVhkScJsTG+iuXMNNPuUn
         lSwJ+nC/jfNvIsIzRWBcDwWSkcIuiSIm77IH4ip2NYTiYECSmT2SE8Zs//41PsbqKzil
         gV/kqRzGgF6Y3SF1WG07YBwz4GosFktaEpiYnOxVrqS9eePBY9V6JtOrnVhXmQdvlmaX
         tmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795454949; x=1796059749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q533qC5yHnPMw2MvdiCjXU74WULol03pGw7lt5AbWok=;
        b=vAq7XC3yUTK8QRHM65JhMJ3CSrJbWGj+7Z6OgdZtjCpEa4mcej8Z/k1y1XOIM3s9ZE
         avtv+RUui0oCD8IuqUCBYzFKYDYWzBVBpH1B8kJduWPCNAy/5UCf3lcyGy7nvpCW80RS
         96lROBjzcpa9D+6Zs3NU3DTsykBFxLeKMdX2MGWP2UP1J2Ytgg7h6BSIkysQmfizWYru
         7aMJcmp1Sd1MiIeM3Pa2pEuifaeFeRJFPea3iudAqRBTD8yHjW7vHzlmOrtXLKduiNXI
         fonO2frK+CWtO0r/aSeST88Oe+XXxo29diwKCXF7B3oIK7mDJocrHr6lt9bdlfHBSCHV
         lNLg==
X-Forwarded-Encrypted: i=1; AL+hErFqj31ggfT7JfaPGRGGtL23oXPiprIlbSsGn12ZPgvrxhyZLBqGZpNstoZk+zFVhL0yiCrVXlhrp+4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+AMytHrLcnkUoDhZ7L2V/BAUNzFs7pbcDXfET668dkQ0rWZrH8
	Vo9km/YZQ5w4tpW6/PrbPy1DZtC6/4ni/G+/G0snWcGYn5fDN/YDeSUo
X-Gm-Gg: AZFdTZcWbWv4GxJq/3cqIAEkUd9SaQa43urzbym4IQbs9BeqOWJNTBa3iF5SVp+yk89
	iD9vqF67dD/9h88XlbD7SU7NecSdSj5Dtfr9IebUQU9FlNkRuhKu+YgCVBZL6QoUb3cDbzp6dXW
	2vPIF2k4ulXgbLYbzULIPWSurrDjOG8x3xW9pbscgnagODi1E8gYFfxRNV1lFNaGGPlKe5JWqv3
	YE4Qw4Gc0MOekHroRNEShVO3orDPQZQ+1zihHZjkpI+bo0ax1eyGoem5wadPkDXEPv4k9880zS0
	tlpDqbHqgY1s/UiTiVz7oKpfxtSD6P0ZAQ7VdH5tURlsz8V/H02ogchd/puvX3DKcj9wjDvaeqN
	GZoXcYe+zW7Fhu+iPsJZkxiaTlUHgy/L/Tu8uv29RObFTBTXiVmDgSfZhxMtUiyKwJ80eZ+7UEl
	3OhF0UelOaW1+xMbKVNrnSDVgu4WEhNTNwAyxjWCEXfwt1BLRV6J1h7osPYqOPWoZHtcc+XtelR
	M8xD4SBUFY46ZhL/GzhMctFea79I7Sav73bDjT6ZNTIn5eXghcWB2kh54qLiAXyHOcySKKplzSp
	t+BxZYr3lqLmGUHNXw5x/VGZ89mFqIhe
X-Received: by 2002:a17:90b:288e:b0:3b3:ab75:c94f with SMTP id 98e67ed59e1d1-3b41c92a098mr10454308a91.31.1795454949484;
        Mon, 23 Nov 2026 09:29:09 -0800 (PST)
Received: from omarchy ([122.186.156.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfebdbasm5552489a12.13.2026.11.23.09.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:29:09 -0800 (PST)
From: Vaibhav Chahar <vaibhav.chahar26@gmail.com>
To: jic23@kernel.org,
	marius.cristea@microchip.com
Cc: crofts@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vaibhav Chahar <vaibhav.chahar26@gmail.com>
Subject: [PATCH v2 0/2] iio: adc: Use cleanup.h guards for mutex locking
Date: Mon, 23 Nov 2026 22:58:34 +0530
Message-ID: <20261123172836.130440-1-vaibhav.chahar26@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123070802.14487-1-vaibhav.chahar26@gmail.com>
References: <20261123070802.14487-1-vaibhav.chahar26@gmail.com>
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

Modernize mutex locking in the mcp3564 and palmas_gpadc ADC drivers by
replacing manual mutex_lock() and mutex_unlock() calls with cleanup.h
guard(mutex) and scoped_guard() helpers.

Changes in v2:
- Patch 1 (mcp3564): Wrap switch cases containing guard() in braces,
  add blank lines around guard() calls, and clean up the commit message.
- Patch 2 (palmas_gpadc): New patch converting palmas_gpadc calls to 
  guard(mutex).

Vaibhav Chahar (2):
  iio: adc: mcp3564: Use guard() and scoped_guard() to manage mutex
  iio: adc: palmas_gpadc: Use guard(mutex) to manage locks

 drivers/iio/adc/mcp3564.c      | 63 +++++++++++++++++++---------------
 drivers/iio/adc/palmas_gpadc.c | 46 +++++++++----------------
 2 files changed, 53 insertions(+), 56 deletions(-)

-- 
2.56.0

