Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BAD3AF66D
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879198; cv=none; b=K7igDweRYP76V2jKH365ggD3cd5hPJF+smm1n3EPfUsWXuIx/JgC+FZqnpiQhBAyKgHvz/7BbJPesnoi36mb9JfAKx1ROaFyEoIiasRi+uKN6ru0JT4GH3Zh9iKYQVje8XoSd1CrxlaHla+uHvgGpFqC1XbFHIT6uvP3btHIPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879198; c=relaxed/simple;
	bh=q+SoAChfHihj2C1OY6mAEkJV8Ndl18NofL/2g0AVns8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5CJFEhX1+DMIDVg/v06+XybQz2QskXC3fxAamUqLBDrGX2PbHLGj5Wb3L6axFD0oex0AdW/VdSHTL2OSCFUsjaCgbHaVt0lm1aQxNafIcvHi6VZ9XNK0ladtUP1/kRYZwxOpWzv4XTUe/+QkTB44waglfZNKwLn1nOwHT7M2TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRV0nOdf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRV0nOdf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A441F01568
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 07:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784879190;
	bh=q+SoAChfHihj2C1OY6mAEkJV8Ndl18NofL/2g0AVns8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=TRV0nOdfcybaTzF2XN+uSDKG/q0YmUw+TY/hMce1fU9c9WVx8GLRSern/xD9hiNl8
	 s43vmxoCYlnzJQSanNSWTLCXmZBcvulJqItHzF+Bjw7gKySb+nj9RU4yH0Xf4utZkh
	 fqHWMvULRIntJwY2CszZB9x+3t/Z8FLuFBiXUUFbYyEddsdGTxexvPpDD6oQ//2V78
	 wZ4pm2kO4BgCYwWeID0w9C7N2rgGrfIYcICojGvOa+KGNdEMuLpgUuRqfPVLHkjRuM
	 zO4HiCMoTCI2YnyYgXD0UgQc7HkoMg6zhe3zRRBMYjzTuttKfz0amGC/OHtkSclSxR
	 VB8IWN63Xq+ZA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c95395230so1120151fa.2
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 00:46:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpq7K/NZmUN/hiKAEBv/lsaoC/VKYOZm1TcVmG6J917OPlDcSRWiOHHrKucSIvF48OngYOxZvg7+4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4XoYEwyRWO8+84hMBgvaKZDjTiGy6kdDgUtGAYVRQYaz6TDf
	sAp1/ptgmaIqZUjpnZN22ohnReyr/vmyX4MXLaS9Oo9roe/olzv6wAKFEu/6WohfWbqO2VSqsF3
	FWInas7yHpYEG/gx1DqBmmYYdoELRch+cvDtZ8dar0A==
X-Received: by 2002:a05:6512:1518:20b0:5b1:5351:712 with SMTP id
 2adb3069b0e04-5b2b2e59542mr980925e87.28.1784879188912; Fri, 24 Jul 2026
 00:46:28 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:46:27 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:46:27 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260723175632.44812-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723175632.44812-1-farbere@amazon.com>
Date: Fri, 24 Jul 2026 00:46:27 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfmFwx4U4D_FXMUyf-jVh7r8nWvyxJE2yi1LEkUh9ik8g@mail.gmail.com>
X-Gm-Features: AUfX_mxVD-CwkTGspLVy2DW1kerTLycxmmZGgKBMf7USBKBu13VE2iFPbK51l48
Message-ID: <CAMRc=MfmFwx4U4D_FXMUyf-jVh7r8nWvyxJE2yi1LEkUh9ik8g@mail.gmail.com>
Subject: Re: [PATCH 10/12] gpio: eic-sprd: use devm_atomic_notifier_chain_register()
To: Eliav Farber <farbere@amazon.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org, 
	orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	dmitry.torokhov@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	W_Armin@gmx.de, ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, 
	jason@os.amperecomputing.com, pedro.pbg@usp.br, paulmck@kernel.org, 
	frederic@kernel.org, kees@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jul 2026 19:56:30 +0200, Eliav Farber <farbere@amazon.com> said:
> Replace the atomic_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_atomic_notifier_chain_register(), removing the
> sprd_eic_unregister_notifier() callback.
>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
