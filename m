Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E9715B998
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777217206; cv=pass; b=ZhK8MThQU9rnXz8w9lRECBuyYP8DtiDmt8D3Bpe3hiVwyNZSsFQrtPsYRrSA7/eLsZN5plMZCzyoTowLw6gTnMi4vL+x9Pm3HoS3QswCIuxCYnjiK4+mypo+nac5hUG5oRl4MXQ8LblN8nd1NBAjpdAu/6otJEXv5VZngJE2/f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777217206; c=relaxed/simple;
	bh=oPUu0Cm27qIygZI4ma0gwbXy+SSkhZVphR3VJlTtVS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khDVXyn4Osi0TfuRmfYPsAQnVEz4rLTzEpuWqy6tLUBCun1bEuy7lA3XlCAmujIsJKPeLW/7QoLZvAj2EvwBnnEenEgWV4N71vmcghStBmEVn0ShvlhxhI4QODuWPXbP8lPhjroY+Q8eWFcab8JlJqc/u8seWcp/KHU92kyQ5FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvlAmCtJ; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvlAmCtJ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ab232cc803so44816495ad.3
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 08:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777217204; cv=none;
        d=google.com; s=arc-20240605;
        b=UWz2VgJ2yimBKU0j3s2XdTYBtdMoQ0aAUh/G10ZzuxHNEz+Ji0Q1+aHUsLOKJ37ZBd
         vphev3VNV/cAkRaUMKIJkzIqelAtM9a0ns3JQcdhweV7CjNUkoe/jRK6dFaXC7/KL2uL
         8ElIbEhF6r2sL/qActTQlcUkiyH2Rc6dDWq63K1kJbpwE15i3+15fiXYNf/j/xHxW8VR
         t6ONkYzTLsn73aJIGNUMD6WaMLyRm38hbhYc+LFLSFegBqAZKR1Fsyzc0yJ47EPamXFa
         lpr7tC37UmiEA0TiHNM7+8yObF+8qoATBRDfBHUCnfwys0VHFAoMFBqcMnxajYrn2ojs
         UmLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oPUu0Cm27qIygZI4ma0gwbXy+SSkhZVphR3VJlTtVS8=;
        fh=X1k07asCggKIQMT9m/Yx09YtVInTu02up5S7njXI8fs=;
        b=PAmySRgjbp6fVwr28QtSYHEJD7BmfPYqKxYcYebLLRAImzkvpNDQ3YF0PF1iqQkjRY
         deVGNc0uwVaC6qCPQiITZxohUwVqRx9E0RB6jCDyn88F7tNCnqwe3uUTCf50zY0IlNyy
         gKM2pEYQXzZ+BdN0OCF4MLuDYki0UrqJ33aoA58AUum8gOUFshL2d4HRk3y88Tf/yUi9
         stL3bHEsfSccUERMvFGDArYzB6bWq7sND5ytqvJ7+V9fPfFslnGl004eKYCPCQQdYwep
         VqYBk9keLNZA7XXaRlYPhhQItK7/gosNee6ZvWcOuyV/UYOm60rPD8MxA0KrDPcLMKrM
         hOkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777217204; x=1777822004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPUu0Cm27qIygZI4ma0gwbXy+SSkhZVphR3VJlTtVS8=;
        b=LvlAmCtJw/0IRcC+qCFvY61q0KaHR731eWBI5tkfPsxUioPs4nylswFfDi7z6Kjlke
         lhBdSyNJlGc4dA5ieIWxUX443GyEwZONizDU7xnF1bG/AYDmfw3nm/XqfiecRSlbNoe/
         VY7Q2wGgknkP5XCicD3StpzMMXsNwYNv7V9hGr2AJ17cffLS0HemDSnaOzAke2puTNnm
         SQjtcAK5hRij0uC6B5j2E1UD3zXzhPt94PzmOrcQkW7C2LiitjAxhqTlDlYMmrR7saDp
         dxwxa+bz7w+h0QZiN5/0eAlHzqvQK4k4A2WyG3Thq1HJe7WgG26EblxwKaV+3dvxm1d4
         2nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777217204; x=1777822004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oPUu0Cm27qIygZI4ma0gwbXy+SSkhZVphR3VJlTtVS8=;
        b=KmYA2iyvo3qpOjGGUcWS7YaSUqc3kbwg25AISNvLo0A9Fm0mdGUbYGya6Ncff/huK2
         zKCzkrDZnotgJVYAbLKLs+oaI/4qRbI5sIIpY3Sh8UUSD7Zb9V84s7UMMYrRvCivpnOZ
         MV11Ac0p95iIfqXR7ozArLn9ZMH6yCZZZKkZTDJQjJai+mnXXSGs7Z3b0yOpRxVvgdWq
         L7anXKuD5T5Jobaz6kfLtHmFcp6HTfruK5tsiQz5bUBAnEk1MwxJPEzW45kYEeohLeQ6
         Jrx0mn26wWqF1JX+KdjZJG4AGYrWvKN1zCOD7EF1DGrQUtU4YQew4KeZVxzAyPMRfszb
         qmuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/RvybDueCpLejpRMvkFtyrlhPmmMl6FLapd2jsa3jTffUXbAJvb827WCMKKk+Gi8ljUtsKxCGknr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf4VARTmJd92Kd7BBePcW6tc7HK7LKKKNctjR43M+/xgSE7oxy
	weE4zZZ27sDTv7yaAA65nDMJuTZeh8MA4yqbF5GqWzLeqLsjqGxUP6ToeGvTso+OANQu3b1E0fh
	872e93CbadYDOlVTEr6wl/Uf5C7VZDOM=
X-Gm-Gg: AeBDiese0KFJj+FMwo0mvU9fA8JpY/WMUySCeY4NDPQ6yVpVXeCHaoCvZMFZztkTUwt
	YHVj6BvIfDqdIF7xpVSFr844v5KRqZjW482Bf1jxjkurrKXAIb8EqU5i+p8sJ4gQii7zS8GszQR
	UUY/gfJT6s3fa6oE0Hh17vOTke5Dl1p65pDOPWP5Jk1Sryw4BkUXcUBLqDUXmcAx1f9kCNEPbt3
	fSHG9BGqisbHdrUwds7suef2D9Kddf+Sr6tyadnwTXn7/ngCVCCMKcKpiPghyC8HOY0NaXfX+8s
	VL+6ocC2U7o2cTWztPXq5yl0IFtK9oQHizsJTY6o0S3oMEcSwb56wP+agJVnC7gixThtgIkueab
	zxRICMBuCE8UIxC0dq7r4St8kA71PlxI=
X-Received: by 2002:a17:902:ce09:b0:2b4:5d87:a1fd with SMTP id
 d9443c01a7336-2b5f9fd21c5mr414476575ad.27.1777217203962; Sun, 26 Apr 2026
 08:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426-meson_saradc-v1-1-6e96b2982c43@gmail.com>
 <CAKxU2N9_Nmk_apUZLSCGssXpwxYOz9k99ggRcUM3EPGUzaVi7w@mail.gmail.com> <20260426114118.7ad8b130@jic23-huawei>
In-Reply-To: <20260426114118.7ad8b130@jic23-huawei>
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 26 Apr 2026 23:26:33 +0800
X-Gm-Features: AQROBzAaYDomYsrasutwOHUKLQNNevm2fkTAMklUdCnv3oJkdjE1Eum5JhBFxZA
Message-ID: <CAN4SLj1_45OG+1AdzCfNiV7T3VX9tpQTcX8krsTDruhtYLzEGw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson-saradc: fix calibration buffer leak on error
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-iio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 6:41=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> That is the minimal fix, so we should probably do that first
> even if we then circle back to consider if __free() magic is worth using =
here.
>
> J

Hi Jonathan,
You prefer a minimal fix here?

Best regards,
Felix
