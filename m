Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BE3390229
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969245; cv=none; b=Orr48vrjmt0CAM2Qq+qJsa6OAmaes7Y+g1PMCV8SdE2zw+I/VPTxboZQcI7ZMcfQawbwRaFb604UIINafBfvns97JDNK1hqYF/Ye16NBg31xiQqlPR7UGUujcFain3BFON2vN+wwCwJtpYzlc7O3meNH6EK7nA6qZL5AR/8du/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969245; c=relaxed/simple;
	bh=kAeJX9Uec/6XKxjU9aI3iiCC/zao+WP5C5A6QEo6DTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUqAfAjs1h5h8nczpTRbqnkTX6NtOeM0TWGWiPjz7Ic/vPinkzseNet9PbHP7fEU/ewahp3UrZdpWGQOf4RJS+rdndjFU1u6QYPqCmkdRO17QnZjGwNQfVFjw5EvBb0zscaVAtQUlOrAAWM02odsQMjPATeekm5mZmm1GGeJ/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqgTPBRO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqgTPBRO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCE41F000E9
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 12:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786969244;
	bh=kAeJX9Uec/6XKxjU9aI3iiCC/zao+WP5C5A6QEo6DTA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CqgTPBROnGBq2qHj7ShFsuoZZpiFp/2y/P4AfKMQixTzthp4kctcB0ycYyUvi417s
	 x6pjxGxxBwkIli5cBOd/+2plLX1VOCqh3B1WRxedUFPCxnHOJNy7bwP4rJFtBePWLw
	 VbnrJFCk9IrhF2v9djpf6pfx0Z73uDa3B/JyEsMzGaZFbU6OGKmFCyBFB37C+RKIIO
	 4eIX9xcjE+kgRAAOI9iA5NT4KqjnASZXYJ1dLZ5SlG05/OsEdglo4SePyAgqzCgViO
	 CgjzjjCFylUSL40hRwsyLNUn1RlXFflxNCrBZR6MJY0uVEDTmy+gTQRlx65gHhTOIH
	 YfDjkeBxuVJkA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so2819457e87.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 05:20:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Roww1M7V2CgtRrbcvdTk8GXjt9ZEy+B+qrY7vwoeE4ShYmM7r7aHdmwD0prFRp1kMFKCad4fxkxASk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXeohMYl4zPjKHW3u82csiIgbEA9C599Mia+ebezMY6oDRphOI
	9/mKVdadR/vXl4PFOqHPTQJ5A55VMdr8ooahGF/KJ3CdKBCWJ6gVd0cXB210fTy0sje5N2WK5b/
	h2D66oiqzhDKyDgXkObZEAe8oJnYAtKs=
X-Received: by 2002:a05:6512:3985:b0:5b2:a55f:2ce1 with SMTP id
 2adb3069b0e04-5b45918bfbcmr2928871e87.37.1786968767385; Mon, 17 Aug 2026
 05:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816060648.4030-1-farbere@amazon.com> <20260816060648.4030-12-farbere@amazon.com>
In-Reply-To: <20260816060648.4030-12-farbere@amazon.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:12:34 +0200
X-Gmail-Original-Message-ID: <CAD++jL=AXgHSR7TGFeAQv=7yu9VhSznQy99MKDTgM2rJjv5HNw@mail.gmail.com>
X-Gm-Features: AcwNN1UtCvrDpVC9uuvoUfBmhVJEvfMufMk34D8Z0GoJ1ENEbtfx026qmqKhJwc
Message-ID: <CAD++jL=AXgHSR7TGFeAQv=7yu9VhSznQy99MKDTgM2rJjv5HNw@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] gpio: eic-sprd: use devm_atomic_notifier_chain_register()
To: Eliav Farber <farbere@amazon.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, brgl@kernel.org, orsonzhai@gmail.com, 
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	dmitry.torokhov@gmail.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	W_Armin@gmx.de, ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br, 
	paulmck@kernel.org, frederic@kernel.org, kees@kernel.org, 
	saket.dumbre@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	acpica-devel@lists.linux.dev, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 8:09=E2=80=AFAM Eliav Farber <farbere@amazon.com> w=
rote:

> Replace the atomic_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_atomic_notifier_chain_register(), removing the
> sprd_eic_unregister_notifier() callback.
>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
