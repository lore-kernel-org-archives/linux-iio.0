Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FA3AD51A
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784879178; cv=none; b=SB+nOWRgiVRP636aA+Aolweoi7fTUAx7YSRcbHbg72Bt4LvDZtxS16KQcoYoTH9+noIG4p5tcv31coF/zCfHuPurf0n0TX1M6sJYttG/9/WpWetIQz391J8uaUwKkVI08E+Arm4a6WX/DQetio0mBA6/kPV8Njcc3mSzIEcz5uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784879178; c=relaxed/simple;
	bh=j6/fHiKSlowXTIF7ftKZpJh31EB2s4w6tFTulHJrrLY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8vC57kYW/Pr+RfO/keK6gfHHEKJShHoECEJp2xlhbVPvgCbGRyNqrkQzjxPXyhuaz4K7+Ih9hBvdCzCRX1QPAkH8NzXE/BpN+ypJ5FwsSuWd5T4XYLr+viBc9Z+CWQdA5/3qhvXbmKFO82O0zOAi2zQ6BsJyjgQ25dnDX0s3fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9gC0Ih3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9gC0Ih3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ED21F0155B
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 07:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784879177;
	bh=5WZbUGleVOSpBn4ZbRf07IEslchh3FUMGtTBiKonZI4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=F9gC0Ih3uso9K+BAgneoM8/i0E2gNCbRw2vhrBcx0+p73hOAQ5c5RVwapUtWxz1IX
	 zhwtkluKWNgk8mAFjcWtY6Ig3at1MVIf5/LAAu11kYO+8O1McBxgs1R/abRlypiJq7
	 e+f8WjUMoCbjLIuhh5k+tyMtOBAPF3etShNz9uVpZ/vH44m+TksFwls/BQnKtLhTn3
	 +axbIP+Q5S95nnR+movpEvYr+mBDh/g17LVQlx5ySTDcfkqmxHEvo2S5r33JCge/cU
	 c3uuwuHyB/8ounaWJwmAbKOxcDf40r/kdU7Bpq5nLbt1CWGaX6WcMKrdPXXphcfkLI
	 pUM4MErClGQ9w==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39c9452244aso1220111fa.3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 00:46:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro6bphcU2KYvMi3FCxVf1a9p6YtpAgILiMmRonTkcOQ2LjTAw/yIUgft65AMYdlp/JcCpskRwoeDRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTDIyZ8q8vTbtS0p76x046650aJCqNsF8LAjK4qnRi5vTszR+G
	JSlnjizVsTD0gmbMqgTYV8rMcl5zB8sFrI23V8UlGv0dK5c8q3dQIPZq348Guj6apeLVgu6KiRG
	pYjyBE0/G7zMBjkJ9CEJGbi9RIIN1vE/TwKzTxtpVGw==
X-Received: by 2002:a05:651c:2cb:b0:39c:9241:af75 with SMTP id
 38308e7fff4ca-39f07c8c174mr9612131fa.5.1784879176135; Fri, 24 Jul 2026
 00:46:16 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:46:15 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:46:14 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260723175325.37397-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723175325.37397-1-farbere@amazon.com>
Date: Fri, 24 Jul 2026 00:46:14 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mfw0OXWF_1yU=5mBuXJscDv2H+JP1n4YicDUeMLwfjibg@mail.gmail.com>
X-Gm-Features: AUfX_myaS5o5pZ_K1kZfydIbb_RAyDJwRVdT4TDBui6jxs8IutTlBmRloNm5ZKw
Message-ID: <CAMRc=Mfw0OXWF_1yU=5mBuXJscDv2H+JP1n4YicDUeMLwfjibg@mail.gmail.com>
Subject: Re: [PATCH 00/12] notifier: add device-managed registration APIs and
 convert drivers
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

On Thu, 23 Jul 2026 19:53:13 +0200, Eliav Farber <farbere@amazon.com> said:
> Many drivers repeat the same boilerplate when registering notifiers with
> device lifetime:
>
>   1. Register the notifier with *_notifier_chain_register()
>   2. Check for error
>   3. Register a devm action to unregister on teardown
>   4. Implement a per-driver static unregister callback
>
> This series adds devm_atomic_notifier_chain_register(),
> devm_blocking_notifier_chain_register(), and
> devm_raw_notifier_chain_register() that automatically unregister the
> notifier when the device is unbound, then converts 11 drivers to use
> them.
>
> Each conversion eliminates a per-driver unregister callback and the
> associated devm_add_action_or_reset() call, reducing code by ~15 lines
> per driver.
>
> The implementation follows the established devres pattern used by other
> device-managed kernel APIs.
>
> Checkpatch reports 6 CHECKs (0 errors, 0 warnings) on patch 1:
> - "extern prototypes should be avoided in .h files"
> - "Alignment should match open parenthesis"
>
> Both are intentional to match the existing coding style in notifier.h,
> where all declarations use 'extern' and tab-indented continuation lines.
>

What is the merging strategy? Acks and all patches go through driver core?

Bartosz
