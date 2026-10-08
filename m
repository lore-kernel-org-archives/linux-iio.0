Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D6A46AA9A
	for <linux-iio@vger.kernel.org>; Thu,  8 Oct 2026 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453490; cv=none; b=M69Om+qY7zTcAmvVMHP8UaKRqUymieVjk6g0ka+DDa5oXRRGWKRGd92DKRFLNOhNF8O3v8MjcYZB5P34iknGaXwjWh2UldaxWXMiizbLlkeIAabS1Xbl7jidsrR7tDVtExbps1hM1ueQA2k3t1bQ/VHD90R0bpaFrk6/547KFGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453490; c=relaxed/simple;
	bh=fSYAbmxRE0jt0zIcP3TT8UrYA5bThEJGN0EtBC7a0/w=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTMdOUqhp7GpAh5jCGhoOYvi91YBOSz4TNyzJfF59GcB6+Lf4QyncQFdroRgMSZDnKgmRFXVnMtHvP42xZvciT9/gIpzL5H/vi5Z3oEc/eicfMS+e4FgruWHol/rTegZrpZSPneYjVmJg/a1PSBjwpQgJiwEd/C5rNf1v9Ixdqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nbt5+sqf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nbt5+sqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD98C1F00899
	for <linux-iio@vger.kernel.org>; Thu,  8 Oct 2026 09:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791453488;
	bh=woGmnLr98yOau6GfG9F6xdFnQ1Yiq7IDU0jF2dLszMg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Nbt5+sqfdtI2VC7ZyW69Qpe5kpgmx6euvKRKdHD70zr60XMgNELN/CZ67Q2ZHwE/J
	 aPVCOPQnQMF0im2pas28jCrcLyZ7r6olGBybdKP2hYJaZeBkoiyqhWCG9Co+s15G/y
	 1enEyiQ6y3em/gw2hj+IFOaCzMVC202FSwzCbfV1tPOPkyYTvBnXiaEJXDWS2+AQxU
	 +vWq+LSp7Hoksek5sDqXCBmukIKWP5MzciV5yPaw5iRe3nuDW+2g81KqXXDk+8tkXd
	 pv0NBkuOtylFPZf8rp3NUoIkvU7RJgGu4o3AEguYNYgom2Nd0ZaZIjM9HXofptF5uq
	 aDLpKKYrs7SVA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bb7ae22913so2040597e87.3
        for <linux-iio@vger.kernel.org>; Thu, 08 Oct 2026 02:58:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw+7fVhtj0dw91/oVNQL+P54WngASRHD5vO5coHX4xrMt5AoooD9pymrj199sxbf4n1kpQG8xAVWVA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzHCCqIecv/FYIpfy9DmFjMxODL5DgRuX+U/3n0EHASZ/VXnu3
	wGOz8b/HbvfbsEhu7vq06ebzUZTRLTv8ZwCpBVk6eS0//iM/o5rxSHSCanadImN5F7BV5R5vF3/
	JDvx0n8q+KSjsdw1KviFy6JojOWEH/oyqye/ZX6DRtA==
X-Received: by 2002:a05:6512:250e:b0:5b6:4ae:8c02 with SMTP id
 2adb3069b0e04-5bcd06d5e57mr1709984e87.29.1791453487283; Thu, 08 Oct 2026
 02:58:07 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 09:58:05 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 8 Oct 2026 09:58:05 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261008031154.3440632-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008031154.3440632-1-shengchao.guo@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 09:58:05 +0000
X-Gmail-Original-Message-ID: <CAMRc=MeoCXH6zX0016vMLZG7c6HEsB=bce_0Em+rn1bvXUcUYw@mail.gmail.com>
X-Gm-Features: AclHuK_zKpnJSr3iyRJyZ6vM4zwkoU-8MwT2Ot-sr2HmngtyH51wLaGs2TtLHi4
Message-ID: <CAMRc=MeoCXH6zX0016vMLZG7c6HEsB=bce_0Em+rn1bvXUcUYw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: Allocate unique ADC_TM aux
 device IDs
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Dan Carpenter <error27@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Dhruvin Rajpura <dhruvin.rajpura@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Oct 2026 05:11:54 +0200, Shawn Guo
<shengchao.guo@oss.qualcomm.com> said:
> adc5_gen3_add_aux_tm_device() never sets the auxiliary device id, so
> every ADC5 Gen3 instance with at least one qcom,adc-tm channel tries
> to register the same device name. With ADC_TM channels on more than
> one PMIC, the second instance to probe fails:
>
>   sysfs: cannot create duplicate filename '/bus/auxiliary/devices/qcom_spmi_adc5_gen3.adc5_tm_gen3.0'
>   ...
>   auxiliary qcom_spmi_adc5_gen3.adc5_tm_gen3.0: adding auxiliary device failed!: -17
>   qcom-spmi-adc5-gen3 c400000.spmi:pmic@8:adc@7200: error -EEXIST: Failed to add auxiliary TM device
>
> The ADC probe then fails as a whole, so that PMIC loses both its IIO
> channels and its thermal zones. This shows up on Nord, which has
> thermistor channels on two PMAU0102 PMICs.
>
> Allocate the id from a driver-wide IDA and release it from the
> auxiliary device release callback. The ADC_TM driver matches on the
> device name only, so the instance number does not affect binding.
>
> Assisted-by: LLM
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
