Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC044D955D
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580095; cv=none; b=jZNAdzC/gQjuW+hvR2Qr5zd6YsGsbLux+PuUteqk/MzV5v+WQ4FdhzaH0Y/Y7D4Ne/TGiO1Uvv5kxSM0MYdWNB5UqQKcz3CtTxGSx02Yh9CfGlxWHmK9lji4VnKV7fwPyu6/7iT1ALvUe/lmXVPmgpNmFH3XRaG/KHO1QcCWWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580095; c=relaxed/simple;
	bh=Kmxozl0qKuXng/ZzxSp/PLsFMCZDIjd8TEUgFJcMZgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5Kkjt9fkvEmnEjXhLXx2HapXBCxSEe3/1nFgYu5lUBl/V8gGlHuePgiqwTsxyKtWAZoJReKd3QOHDNYAr2yd85ZC/bqfM0OXGR/uCEWgf72L67sLy3ZBtX8w7A/3V3TOpYB9KDyEvN0lt8gakXRIEmmCrH7jMETH4JHPCRmAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWZgoE8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWZgoE8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28F61F00899
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580080;
	bh=Kmxozl0qKuXng/ZzxSp/PLsFMCZDIjd8TEUgFJcMZgw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NWZgoE8MnS+5zuawTwxJ9hFmjkFzg+dKExWJBLVgU73GBRvSNqkjrCvUsNa4v1duI
	 hlXJxjzVzaUK9SPBV+DG6FgKP/cgE3vjmfPYxH34h6AtJS6Bf0TvqYLIt6QUvLda4m
	 NivcLpxIUMX0lW/FH8BU6DgH2RQ4HmqVAyyfCCGdLYNiPGiLWqxQX5WSfAAThgCIlo
	 XQt5YyNin3EV3w8NN+WjRPRYViud3QBy6BBoj1YDg9K0+mSF4+i4ASEv6MbrrHFWTK
	 LTdlSHdKozFMgTYhriZAsmcV4iorwqN++sS3w/kykIa6H0TyNQ4+YeWUBEOcAqLmWF
	 YffotFTkMxoBA==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f17450so1102041e87.0
        for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 10:34:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxmL6AfCfseouSDctWYpc9LYisfYFM7CHMa/mjsrFq8BYOP2XqsX9DqcZsvHyG/G85W/DDKfFzW9jE=@vger.kernel.org
X-Gm-Message-State: AFuF++nDO04M9A0AB7FVPGYGey1/7B2E814j9aBMMCT2HrPGoZSHXxQt
	r5hOtkyTMhVgzifGUSxIAl0pizVdw0DErW9c+QW0TWXpcVHfhZrUzadZukXwmewU4/LwIcFGZ+Q
	HIRpVYGEVqOaI2PRwhAyk9t7cE5BaVYA=
X-Received: by 2002:a05:6512:238a:b0:5b3:420:884d with SMTP id
 2adb3069b0e04-5b8b6615dd6mr1009628e87.18.1789580079608; Wed, 16 Sep 2026
 10:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916162949.2083791-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916162949.2083791-1-vulab@iscas.ac.cn>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 19:34:25 +0200
X-Gmail-Original-Message-ID: <CAD++jLk9Pc9UM8ovJRFGe5fzjr2ci=yTQmp+RXTsugW+qiPsEQ@mail.gmail.com>
X-Gm-Features: AcwNN1WrGklsU7RbsJ6ysUI41c2hLLzkBaXx_VRIeVKzN0WXlEhxnMgj-5D6nCU
Message-ID: <CAD++jLk9Pc9UM8ovJRFGe5fzjr2ci=yTQmp+RXTsugW+qiPsEQ@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: mpu3050: Fix runtime PM leak in mpu3050_drdy_trigger_set_state()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 6:30=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:

> The enable path of the trigger state callback called
> pm_runtime_get_sync() and returned early on every following register
> access failure without releasing the runtime PM reference, leaving
> the device powered permanently. Use pm_runtime_resume_and_get() to
> propagate resume errors without bumping the usage count, and release
> the reference on all error paths before returning.
>
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Cc: stable@vger.kernel.org

No stable material.

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
