Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114B53F5BE5
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841323; cv=none; b=nmM+JOdSaPZ1xPeicMDJwUuMJGPTXPXaSkxA0YiIHHN/Yuzcyv9zGF25jOzYlcwGfrEXO63lCWEIYy6QFJ9+szFwuk0OceIRMW4o5qZFqeoQ1m5At+5uTEmqjpN1WMYQzrmvNng79fLxexGnOPUo0tNPCTfMY3iJqrPWckHFyL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841323; c=relaxed/simple;
	bh=nJq2cv5euqqfwimN8ok0U6uAc6u6DOLHM5flS9vO3tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tah8MLH6gDiWxzCXE5grIkdONQOhdKgfMGPI3U6W1pS7eXsS/bqBQMwzHp/Rs/FzgPhWI6HAamfcdbvZttHUQJNJitlYkA/j6mXROs6k+MzMGlENwXakJxWZMLBy14OepQgyaPh+znfbOsr2uTdN7b5UHyLyU9cLmQ6vAsmmKvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsiWjZVe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsiWjZVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5B21F01562
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784841321;
	bh=nJq2cv5euqqfwimN8ok0U6uAc6u6DOLHM5flS9vO3tM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CsiWjZVe1J5xZin3m48CGVOEV70Op+rkftUYOyxSpPDrEoRTRBiDwZGGD8PiKLIzf
	 j3JUIGXS8r69gEZX4UOq3VtVy0FwHn+qfAnx2YRbp2d5MtqNhiLcevjnBHK53tn68I
	 dD764logiWCrSzOoe0KzRJmtkGkYttmO9NK4UXY4AKKVe6N5U9CZtlI3lMhSEhNbEv
	 34J4y5W4MEVu5siCOcpHQ32+i+fzgYLBl0HFHABKdf2NS1y1WRlmSvGaM4AUnA1U9j
	 PuiBiJ7fm1dHUhEI+c57lvNRNaYgqH4DvgceoqJY9toLpS7szLIkwDA6c3rlcg+XOB
	 QWaVzQ8v8Amuw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b021916bd3so1109682e87.3
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 14:15:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrxKF55UmjCDvF57tvn97AoMTKNLYh0XSwtq0RmEIQfixTxPhoHDmyDaFye/87ABsUgrNR1W9wP7mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrfPvM2ppS7ZK2GE4Az8pICo+T0D2DEsQkFC83iRwPawDXfUtq
	yAGzj4Fn/vrddrjGkFS6+OVzepi6HHLwQ8N21wKOo/gJSdxk0o3AbryYFsk5upEL+M9g41Fpfnl
	z2EVI4dHCw7gZ53bRUgfQm4LVg3Tv1z0=
X-Received: by 2002:ac2:4825:0:b0:5b2:a5e9:3aad with SMTP id
 2adb3069b0e04-5b2b2f6a7f3mr656499e87.33.1784841320430; Thu, 23 Jul 2026
 14:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723034237.2501507-1-eleanor.lin@realtek.com> <20260723034237.2501507-8-eleanor.lin@realtek.com>
In-Reply-To: <20260723034237.2501507-8-eleanor.lin@realtek.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 23 Jul 2026 23:15:08 +0200
X-Gmail-Original-Message-ID: <CAD++jL=z_xtC6s_jfqTnEMb=_WDP_PYwPBpdaQPKXm6datMReg@mail.gmail.com>
X-Gm-Features: AUfX_mxRc6OYHNbFa0gJI-Rga5n_XLBKqKNj27EL-d0DYJZIKVFaV68hRY8xl40
Message-ID: <CAD++jL=z_xtC6s_jfqTnEMb=_WDP_PYwPBpdaQPKXm6datMReg@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] gpio: regmap: Add set_config callback
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: andriy.shevchenko@intel.com, mwalle@kernel.org, brgl@kernel.org, 
	tychang@realtek.com, wbg@kernel.org, mathieu.dubois-briand@bootlin.com, 
	nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org, 
	andy@kernel.org, u.kleine-koenig@baylibre.com, dakr@kernel.org, 
	bhelgaas@google.com, o-takashi@sakamocchi.jp, dlechner@baylibre.com, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux@analog.com, 
	linux-iio@vger.kernel.org, cy.huang@realtek.com, james.tai@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 5:43=E2=80=AFAM Yu-Chun Lin <eleanor.lin@realtek.co=
m> wrote:

> Add a new set_config callback to allow drivers to implement
> hardware-specific configuration such as debounce settings, or other
> platform-specific GPIO properties.
>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

With Michael's suggested changes:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
