Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF9389E05
	for <linux-iio@vger.kernel.org>; Wed, 24 Jun 2026 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284263; cv=none; b=VXMU2/VO/X55Ba3Dyk5OK7v/CSgN2e/rp6XtT4Q3xav8SJlsrB0j2uvHarHegVLo9F/rReE+A41aZRYf0euHvkS5K3LeNwXIi8zSLdUB58kedok5gLRrJ/1SP92SLHIB+NrvH5iTd7RaCOVATWcJzzKi1DkGu2i8dj97bbYNasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284263; c=relaxed/simple;
	bh=NrrTgZRgI35r5ZRVUdvtx3FHrG0OFBCgNEx1O3kiQRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMvmT7XqaCWIfX9p39t6PUl1c+NlOK+oJi8S/Xxd6TAEFD9euXGlPVjmDg4WZr0nZSL6kwJwSPB8WyIjK1a5ucqFg1FSbBgfhuzMqgq1KpNcl5HSyUkxEHvVpdJ8ZYCBXo/MQBxWNOEIRfPm77rdZGqurIX45PnYZ92fVcTzE+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4S3CZiO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4S3CZiO"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso6631855e9.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 23:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782284260; x=1782889060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BvvjgBluqmaKlAHDB8z4gwwT8tYijARX0RxqO14m8A=;
        b=q4S3CZiO9mptLEBewaxL/yBZA288G91Y/rPXmZvvzwtoinEpwtjfPKDcoNBhE3CoIs
         rVTT1Xh17xrsvt5+y0hrmeShX+1dQrsXSsHeKgFdog/g7PIJED/kwqmrjMaw2BjRxGN+
         7i0IX1IM0V6l8eCxrj+qqr5Uqxc0Om7D0iO43gRFLrE8JWQdkuMP+brfqQ4sM62hDhEz
         9j0RaGUIZd2iat7mMXdA/TJt3g7W0AE3+D7zJKbSvCuNV7vkVSaGYMMWUzd4I3vks8u5
         tjQt+pB3/scrp08Vheki9yZmQFXHZ64aJowGwI0Xo4zYchg6NT3XfDE46VebNAvN6rCJ
         Yi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782284260; x=1782889060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+BvvjgBluqmaKlAHDB8z4gwwT8tYijARX0RxqO14m8A=;
        b=NQM2HdvrdsdraaTsacwjC0NsDbahn18XEKsMzGqYesbU/1YuFsSpBdZgpFirGkxj8n
         8zx+wDRhujAVzznx18g+UDNz9DrN0RYNhf9eVuieomgNEkLgFv4NoVnERDAl7PQ/DSUt
         hm+E6AuehMHsSIbp5kYYoVjMtXU+EEln8QuJ8JKCb9dHBqSub11nkOan6qnrs5crirHd
         3YXWnltmRATieSzKyBAB77cwABh/QNlQReh82PnoAUnwqTz4RqCEHNi8376nwNBEprzJ
         SJStPMcYP1jtAXDW89SjZKY+oDaEQ/rKPZXFVkRo3S6Orab0O0dLuVHj8fEuEwd4331i
         /VWQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vVlo4T1LzlU5D9yeydiNasK+FFjRVHzmWAWfnXhDT7KrLNQx8zCU2tUxqgPqtwb5DAIy3Q0Y48Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFN+k4PUwdpF7fagElpb8w9EWyK9V/hpxKSOoN8rznRrNMmJGj
	mZXNuChZSySeD2YlHbFES22y/dDeBg6DIRrXQuHPHFLJpdvl0DcCa2ej
X-Gm-Gg: AfdE7clqBZrAktNrNYuN6EU4f95nWV+nwf9m4qOfaAxS4VuMlYzgzGNyFjyaQ2nwkn7
	2vZj5ZIDv0/MtfnVvIIYIQB5OzxfbWMaqa1sZ880ePbEUJB5LlRTxvCH5v4VdwnogSzAE/Mf93J
	n4lH9XBPopxhA8OioARVZ51sgAIviRxoRupK+evbIPA8z1gE/ivQcQSye0EyUDC7a1s/G9Z/Jle
	5HM9MA8oDVz4u4rmjVd4pU1LoLNiGHWNFR0EAbopNsz9KZIJPAvo1uIMKRAXooGyERu++3j6EJt
	VwI8KnMkdyRHOQFruichxjhUB/y4XuvP3JUBwKYjdZgW6OHXpHjumouFUREEeBP/7m6N70Kr/8t
	0SY/VuFGlHp63K4uj8BmbI1QrMdu0pvRp6r2K5lzvCtfnl5giCjJnY5hj85o4/1KLbEJOIPRk1c
	Dk4hiAzvp/EiKX7QKPpzT4xbLM4p8/C6S2l8Dv/fwqXw726hn22FVYmTK9cq/IRjJkqYpKxUrZc
	kQCJ+z4Pi13Pq+TGXxm7grLmNG4Q5YTzXz0VegrUOx5uAXLRxMlRdINqB9Fmj/nO+xDf7DIHZK1
	t5vQSU9h/nxK+EwxFTWp758aolfYYezqrwUsc1bhveb89UR/g0xwVZw=
X-Received: by 2002:a05:600c:4686:b0:490:50c5:8153 with SMTP id 5b1f17b1804b1-4926084ab47mr26057075e9.2.1782284260228;
        Tue, 23 Jun 2026 23:57:40 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49260e14d0asm22746845e9.0.2026.06.23.23.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 23:57:40 -0700 (PDT)
Date: Wed, 24 Jun 2026 08:57:39 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads124s08: Return reset failures
Message-ID: <20260624085739.00005fdb@gmail.com>
In-Reply-To: <20260624055325.32388-1-pengpeng@iscas.ac.cn>
References: <20260624055325.32388-1-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 13:53:25 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> devm_gpiod_get_optional() returns NULL when the optional GPIO is absent,
> but returns an ERR_PTR when the provider lookup fails.  Probe currently
> logs the ERR_PTR case and keeps the error pointer in reset_gpio.
> 
> Later ads124s_reset() treats any non-NULL reset_gpio as valid and passes
> it to gpiod_set_value_cansleep().  Return the lookup error instead of
> retaining the ERR_PTR.
> 
> Also return ads124s_reset() failures so probe does not register the IIO
> device after either the GPIO reset path or the software reset command
> failed.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---

Hmm, perhaps it's trivial, but not sure if these changes should be separated
into two patches. If so, feel free to carry over my tag.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
