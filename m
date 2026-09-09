Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE854B1CF
	for <linux-iio@vger.kernel.org>; Wed,  9 Sep 2026 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970875; cv=none; b=FXBGQb0k+JSWlM+RG+7w4u5B19I+sZ4Vg457iRxviOeRPjsROlZ1KLxVGqXriKhrCzLF+aQm8XZt7gmAZORi982A/ekv+N6MrbIo40ArCWXhjQxLJufnJQpDyxykU6fdQMcVS9uxEmysNdXftcjycF0z3nVp0AUcHpJ4vpRPxSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970875; c=relaxed/simple;
	bh=S0UWoaX2vzA5f4S5nnP29NGTAhTrLsvfkLzTwM37uq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmDGx2txzlR1YMuPvS+h7fKXx20TVZVkMbjxhSbO4lFXj7RcQRNIfI+C5fL3whKBgxpfFBm1t6/pgr5ycS6M+IJf07gHS1sEUfmW4Dz6HJjTVtG3ePOm81k6xXmOPfAL5PGTAiedD9XmGXRd+B23CM5Tpq7lL6KjzwHF1oAm3oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm3+4TZG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm3+4TZG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49954b88fffso44614385e9.0
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 09:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788970872; x=1789575672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shGFvWN8Lz0mV1DV5AN0zM10G20yvkKxhMse0B/zkow=;
        b=lm3+4TZGURTgQLXnTBEbOyLynt17ur0mmNve1aA9N2S+hbkpHicxyy170rTroI3aFC
         WYT+Ky0xLzUGwJ2BpQFNhfOG8e3HxT1ieiVqXFMz6R5TjJAG7tKgklMnxi2xvCONZOxx
         75O8r6/G0Uv6df58TgqFTAcpEh44dg34+wp30V5jRcbUf5Bxohe1iqCUjfaD6iKmqoWZ
         O2hGKt6Dm/6yke1OHZLvDHIDPWvqHAqJCs4ReZ4Bks5ShWLBtLhyQFpBRwiSMrhVs7KP
         NPwweocBigMjlHwQjtaSIaL17RQ0ND4o/FXGD0XOpFr1mMEdKuirzku9ZrARxbn+h9Ou
         PTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788970872; x=1789575672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=shGFvWN8Lz0mV1DV5AN0zM10G20yvkKxhMse0B/zkow=;
        b=W9zsJ1akxtCxx20cErJXzk5uzq9P8oTewK4P+P+ic5VnDNC1F7oDJq0n8G5fvV4uXH
         4vwmfydyrNa7gOhPOztBpUThqX9fkegei7nWM1dN5UBckktvji6t2yjQBNDR4/Dg9sul
         8Cq4rGdWo1bR3/jrttVI59U6Nwtw0lW04k2TJoPZK09JZz1sz03RI2PQnGB2fOGyF+/p
         srpGXTFzxlfxm5UOqNesmJMmjmynzEgDbZR0CGChgEc5k9vU/pZyLPKwtT0ZVdyc2H+6
         YVgXnBQhTIeK2yulWBbgdtEypJpQOtY/iXvnQEPk6KW+iKxu9B2GPImbBtj80D/YZXgU
         SSBQ==
X-Forwarded-Encrypted: i=1; AKwUvBydU28Vlv+AYnEEofGqm2TWdqKFg/QxJQo2/zpZA5G3QcEFKTNTaXvGji5YANq6ERPzUbIuC++1TMU=@vger.kernel.org
X-Gm-Message-State: AFuF++nVbKhDAwyK9Zm9c8Tg1VA4yjzxiWh9QKdwfzzy5IVlrIjabpqX
	UhEmeFiJcsN316mSjZ2k29CZEMQAZR1q0mVV9FiFNa6Lkc4j5IyQ7dbF
X-Gm-Gg: AYBFou1jHoknW7WRZHHXgjHF5sKwjUXokGBBHNGE+UDgiYMSLemKB/s5D7QuToqKuqW
	lsdBm5/B1ysjkNDfObc5I0z0tsF0eziEn2ARaILwB3wHyvKIvPMj7vTNIBa1qiMckq47foqEaZT
	LVGfBA7rq53CwTIyLqF/Dye+9a0hHWuDPvL3Mvdk2ygfhbW+bkmMt9hOozvenb72ejTF11P8VWF
	fWYSUrPWPXbrtKcPNQW+f8hhb8Y3RdoOtKDykjWzHoeNpnwRE7mh7AwB5N1t8M28xHahoMHcKZa
	suW8aHfYf/5wKCEzyogP+l7HDRQfUiebl+G6jH1nES530h7D0pAObReeZ1eeX0nruXSAWlHiLuO
	SfxNZY2x8BTmS+quZ74cDV+Z5IYkjQN1Rtftlypj0rWqYdQG2s/JKhub6Zz6/ThObAf5PgMD2Hk
	PKIRnqGajxlwIsinf52OstG3pDWWmdu2bVTPVUzVSEtmkNKY0ZI5CE5j2qTD1s7IgvG6v3sQAvp
	ShVoiV0RYb3bGjWKKg09/ELSFW5Gy5Z8I/jW2D3blPSsVRrmk+HgAuVCzPIOcWhUM02ap5FN6N2
	2Yum4XHzDnC2YDZ1QwUf
X-Received: by 2002:a05:600c:3550:b0:49d:7fc:5dc5 with SMTP id 5b1f17b1804b1-49d07fc61bdmr241345435e9.1.1788970871624;
        Wed, 09 Sep 2026 09:21:11 -0700 (PDT)
Received: from kdev ([81.56.8.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bc5fsm1893145e9.3.2026.09.09.09.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 09:21:11 -0700 (PDT)
From: Fabio Cesari <fabio.cesari@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: isl29028: fix runtime PM reference leak on error paths
Date: Wed,  9 Sep 2026 18:21:07 +0200
Message-ID: <20260909162107.306528-1-fabio.cesari@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907092924.00000e80@gmail.com>
References: <20260906131203.125407-1-fabio.cesari@gmail.com> <20260906184358.398f3f1d@jic23-huawei> <20260906221517.201877-1-fabio.cesari@gmail.com> <20260907030751.3da628d4@jic23-huawei> <20260907092924.00000e80@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan, Joshua,

On Mon, 7 Sep 2026 09:29:24 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 7 Sep 2026 03:07:51 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > Why the if enabled variant?  I think that only makes sense in places that can
> > be hit prior to runtime pm being up and running. Maybe that's true here.

It isn't true here: isl29028_probe() calls pm_runtime_enable() before
iio_device_register(), so neither callback can run before runtime PM is
up.

> The regular PM_RUNTIME_ACQUIRE_AUTOSUSPEND() is adequate.

Agreed, and it was on me to check.
v3 will use PM_RUNTIME_ACQUIRE_AUTOSUSPEND() in both functions.

Thanks,

Fabio
