Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793548754;
	b=0H6IfI4TMjUDk6KVfIPsa4hmy6Bspy/MwmPYgQuQlyNSWdkBELvuYZQk4IAd8shxfloS
	 4Eh7iNdl3xVCoBjgAvHJ8CI89zjr4b5Sq4b7TosMb7oJECHDuga4asfI4DxATY8GzOhVm
	 RVMvjeTwv6lR3LvgoA8FVleZVxbjFYLgFVLDRLBTpeDyszERVrcBu8d9mH/LzSHxWeDHO
	 TMPokdbPDp/jM2AwSqzhDwAsJdf0NS74wLLAb5w3RQL1Zz5G5XW3+WyWZv123kYEiKkxg
	 in/c9g9oGIGCi/bb/6OHTdGmdhOWc+uU9Ha224wy5tlIkWuX+iOoF03xwwQOvjcIZAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793548754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OaBbso/nWA2Q4yJF5+SbtI8vmJ4zVrnNgMLlXI5ZDPE=;
	b=KKWBL/lsRzrXn89p7NRlelldVtkjEFt3XLan4CgdANhMRu+DJPavRCbdxh/+gStAuRzn
	 DP/iKCOjfC0knMO3oYAv0zXIZOSmNXd/G1KKdLlJQekv230JNzXS3D+4v6dYHlqdzlsyn
	 3FZoVPB7QeMrgo0j2uiFpVd6j1pqTmvVGmEhUakGN9EiCAS13G/3e/QzXab236ekLNvls
	 14PI1Gv0SRBFslujpvRnAApn3fzXA43bsB7QxLQKtNbeIDAMAMBMvacRLcFCuhRK5uC3I
	 UPgU+Ow7U9jzvnRmcQs5O4qP6HtOFzHcuR9xU78uJanrI1YiOa+D1sVfoRB+onvTULQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vyOmQU+G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABAD606A324
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 15:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ABAD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vyOmQU+G
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so3836874c88.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 07:59:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793548752; cv=none;
        d=google.com; s=arc-20260327;
        b=NS31xjp425AwVYP2P183gKCT2E5Gdb1YmnHrR8R2qQdaOxtxVgD5wxAWsfT5WQUjOD
         LhmVFRL+Qt3d8B6nWfNHiwgf6QRzK/ZF0XrxL1wN+Pgyhu8t3PGZwQ/7WXMaKWnzoD6U
         x9NhoasNBjLlXD6b8i8FBycHpUOACdxYkx1K6HztJUOAWDVTguz4FBe56SDBd62IVRbx
         ANQcSitnGcUbF5HmaIgipYWOVhQWAXiyIcqnw5VnH3c+OGWZZnZa/mEZ03p1HVqYEdqh
         q71VfZm6qQKD6PwZOkYn6WxyA7PfsxVlgUqTlDDwxJqXQk+Ud2waqJY7ewfuM3TDMRy1
         ZIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OaBbso/nWA2Q4yJF5+SbtI8vmJ4zVrnNgMLlXI5ZDPE=;
        fh=Jo1L5iQce2VZ4hLncvgnRrdappWal7T6bGbm9n4L/QY=;
        b=jNPCtmOCPuKo8/Flmu2bpxSjCrYfrTb4zSHdCn1ZVShHCsZ/gCVimZYsRc2wEv7lKO
         Jrj/L0qj0kF24TqFudIqPHoJQvN27upwkDt2Wk5WB6T6c2cbB30JcSOr4wHa+fV03kSz
         JbmWqqq5wAqsqqQilpbV4H86aMK6xQ58Btl3z5HeY8XQGBXKRvT2Q7LgfKnhhLT4f2Me
         tsJCrDng2eqfhsm39iZmzX9PwaAHdTQcCQ9JUFsjBzxHszobiC/aHb2Es7U6syiO2AJx
         9yGPY0UkfZDy3snPJb1zi33m5Sn8JTOdGXxMEMD1HgWvosklh9aBx4SgL1BGaI6JlKwP
         LHtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793548752; x=1794153552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OaBbso/nWA2Q4yJF5+SbtI8vmJ4zVrnNgMLlXI5ZDPE=;
        b=vyOmQU+GIUzXlWzuISIAqmcM+65J78pwMqPSy/SmvKYrqsO5olf638kBeiXOM3v7fD
         7Gjz2ZgbU+Y14eCQ/WSShxwfOn/HC5FFJPn+gZia6EiAo7w+pYIMU2t2Ia0UWj+TUBPg
         PJDZOD7lvjlbUhpVweHCokLOA6EG5D8SVEorKg9Age6da+KPUy0x3ZqNQOIZ3sdcYOsI
         lf0khruygB9gKpxiaUoEzlksGd02/37GJ7qNZFPu2SNZAil98x/HUwjVANp1Xlcy+UWg
         056SSxMwD8fwFs3wlSDLNpmICXNxGhgJxtkxBA08Ee/r62MC2T6Qxlcy6FnEvqnVfVsh
         DI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793548752; x=1794153552;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OaBbso/nWA2Q4yJF5+SbtI8vmJ4zVrnNgMLlXI5ZDPE=;
        b=IIZKDk7a/BB+wK38w40JugEyFlBuIOe84k1WFuMl7LkhKudCfv1EqC8J7l+QhNkHvU
         SnemHnvYBti53h92QagPMBNHJs1SCcwbfJiKxB8c44g2GggCNhvpX7XwLCn5RxpBGFnU
         OW5Ukr5QJPJRGOrD1ZokJO55P4JW5kj2JuqkUtg7cjh+PH5CePvOfx+Gw58a0xmNIPJI
         hkBLOqnXaHPya8hqgxgBI6XcND+I/UoCSn2spCC9JPPUEk0Jggzd3nHxxmA31p1biCSq
         g46KuZA7vjxydoo/Gz3PtnHthyRF0pLjZiWkWmpOPoYdyDLCsRkVawAs04aVhSJ6A5XI
         arWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbIHVgshBlB8Uf4/tsPxm8iNJsmZDJxSv2I31CzHx3eCtn5SkPI6d/UrwrTySNjQgAEjWUA6+IySU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+b3xApH2ifBAKTVjaSnWA1gYTV3blJB9XkfeIuxGRhHjH3J3RR
	Zu7gUroXz3WRIQ97nNOyPTIJ5O1nWn/K+6LhCLUSdpYhancVAoesvYtY/ye9wbM0bKxI3GXyyB1
	uEhGoN40o/iEMRhuQEMXFy0AdaJoC3d4=
X-Gm-Gg: AYBFou0bcaffDNOHDEaRa2cerhFqxkX4hQILfGip1gXZszZ7nj/2pMpBVjlH9nrf6sN
	62eP/G8ppId/TYzmo5ghchuGCGb3sNt6rLMr87diZkFrVWvcsKYC3FAVczDMLKNxQZerOC/fUrj
	pXLs67EUZJCvHsCfR5M5o/MCD0dP7ok9pS/HboW1LoZ2VAWYAApc0JeQfTxSkVhqZAAmDFIZM6u
	Jr5/8kb8p3QOGe9mFWrdNgmurVbObyZERARQGicDQ2QRJE0ffM3QUc0jrcTo/oOXgYl9NiZAtaM
	ni7o7SPpSmVDxRO4dD9sCVUzTlsXZ2un3jzVCF9TO+H1MoA2IS5wjC5w3DJsSiVuha+9JAiSkn8
	el4qH+1bdjKcE6//0SwpHciW/SLzlEPCAIac3A1beOdmoT3BXW8FUXK8f+OXf17QBOo0wnoA=
X-Received: by 2002:a05:7301:6198:b0:36a:1e9e:ae61 with SMTP id
 5a478bee46e88-36a42602aa1mr11000618eec.38.1793548752284; Sun, 01 Nov 2026
 07:59:12 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101-upstream-iio-cm3217-v1-0-5e1724cae7b7@tsv-stahl-riesa.de>
 <20261101-upstream-iio-cm3217-v1-2-5e1724cae7b7@tsv-stahl-riesa.de>
In-Reply-To: <20261101-upstream-iio-cm3217-v1-2-5e1724cae7b7@tsv-stahl-riesa.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 1 Nov 2026 17:59:01 +0200
X-Gm-Features: AclHuK8C4vxEYccTnlJFTZvavpWf-GCXw0Ej68N8q_v5q9HytmNW0NUmwJ3LSVo
Message-ID: <CAPVz0n2YSjPsmhYHnm9UfNtU5gg-pWcxe0Rybpf12jrXUKn1aw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: light: Add Capella CM3217 ambient light sensor driver
To: admin@tsv-stahl-riesa.de
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 1 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:46=
 Patrick Fischer via B4 Relay
<devnull+admin.tsv-stahl-riesa.de@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>
> The CM3217 has no registers and no ID. Writing a byte to address 0x10
> or 0x11 sets command byte 1 or 2, reading a byte from 0x10 or 0x11
> returns the high or low byte of the 16-bit light count.
>
> Command byte 1 holds the shutdown bit and the IT_T field (1/2 T, 1 T,
> 2 T or 4 T), command byte 2 the FD_IT field (800 ms down to 66 ms). The
> count scales linearly with both. The driver exposes FD_IT as the
> integration time and IT_T through the scale, so the scale list offers
> four ranges for each integration time.
>
> The datasheet is not public. The bit fields, the reserved bits that are
> written as 1 and the startup setting of 2 T and 100 ms come from NVIDIA's
> downstream drivers for the Tegra Note 7 (drivers/staging/iio/light/
> cm3217.c in the 3.4 and 3.10 kernels). For the resolution, Capella
> gives a range of 0.01875 to 119156 lux. The driver takes 0.01875 lux
> per count at 4 T and 800 ms. This matches both the upper end (65535
> counts at 1/2 T and 66 ms) and the 0.3 lux per count that the NVIDIA
> 3.4 driver uses at 2 T and 100 ms.
>
> The sensor has no data-ready flag, and a new setting only takes effect
> when the conversion in progress ends. A conversion takes IT_T times
> FD_IT, up to 3.2 s. Leaving shutdown starts a new one at once, so the
> driver passes through shutdown on every change and waits one conversion
> period plus a margin before it reads the count. The timing was measured
> on a Tegra Note 7.
>
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/iio/light/Kconfig  |  10 ++
>  drivers/iio/light/Makefile |   1 +
>  drivers/iio/light/cm3217.c | 383 +++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 394 insertions(+)
>

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegratab P1988
