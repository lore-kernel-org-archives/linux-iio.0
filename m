Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912FC37DE91;
	Mon,  4 May 2026 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777887435; cv=none; b=jpUX8rXCLfmmin8V39oDpalG5vGvhtdJsHOgOnYugsjN/Nqo6t7dKargJVBp+2oMHxTtMiegWhuGpOOyVxz0X75tNIpXAmNt95rVmZccot9shh1pONiOQpJkf5bqu7R52ZLgiWozwdwMVbec9vROm7KoUbTvDIyR6qZtn6/JnWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777887435; c=relaxed/simple;
	bh=JJjdKsJQxpVG5tygyR/5h/ot3CyhFC1wE4QELmvydP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8Sa+1ayqXG6py8nXkWZ7wpTsGeejLvPI3UZDRMNaQx5KQE3orae2G8sY88/ZdydFEzw5SgLpGFJeVKhrFOi/YBGEvTRVbMy6dDjhJT1uQIdIf/HdGllzYDqb1Q5NWxB5cF4fzPWoNpoYanAl9H5TsVrjcTUYzlIqf7kw5VPxIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDuVZNhw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDuVZNhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23EBC2BCB8;
	Mon,  4 May 2026 09:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777887435;
	bh=JJjdKsJQxpVG5tygyR/5h/ot3CyhFC1wE4QELmvydP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lDuVZNhwUMfRx2QGA5GHYewl7MiVwEOy6km6rFOTtY/kAlU6xP1De0VbBQ4R83SCZ
	 Mg8mkK470h10zfMBmOnZTWyhCfb1zOuAtYwdHWnBq5srsaweay5z5S8b+mUlSe6Svw
	 MTvaH00KRNt/jWFtZxrdFJmqqV3u9vmzzL67LGYd2rdy7nSO2oGtvTLv/anmRPjF0T
	 59fdIYqYQuNCf6BOzCkLHY8NivwVmmRjiSC9TUYbAA+OEya+v17dqapSh1DgZs7vsa
	 c/eH59QXj7DK0t1NbaleMZwXlnhFYC6aZc0n0nVup37YvyO5mk3kQpKVfGiesAkD6H
	 Hf+KcT9Hpodiw==
From: William Breathitt Gray <wbg@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linusw@kernel.org,
	brgl@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor.dooley@microchip.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] counter: add GPIO-based quadrature encoder driver
Date: Mon,  4 May 2026 18:36:45 +0900
Message-ID: <20260504093648.530308-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501200749.20029-1-wafgo01@gmail.com>
References: <20260501200749.20029-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2769; i=wbg@kernel.org; h=from:subject; bh=JJjdKsJQxpVG5tygyR/5h/ot3CyhFC1wE4QELmvydP8=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJk/MmZ7VbPvn5ly/DHjCTOd6f+//F/z6tbDJ3vbs/wdF 94Ra2O06ihlYRDjYpAVU2TpNT9798ElVY0fL+Zvg5nDygQyhIGLUwAmUprIyLCI/eB+bxsBZpHE 5It7X56xNj68/xOvyo9C7nWnXNPzhcwYGd6/iIrMEI/dy6SYdGmdfLle8lsF6ZVPdjV6vMxxmbX uHDsA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Fri, May 01, 2026 at 10:07:46PM +0200, Wadim Mueller wrote:
> This series adds a new counter subsystem driver that implements
> quadrature encoder position tracking using plain GPIO pins with
> edge-triggered interrupts.
> 
> The driver is intended for low to medium speed rotary encoders where
> hardware counter peripherals (eQEP, FTM, etc.) are unavailable or
> already in use. It targets the same use-cases as interrupt-cnt.c but
> provides full quadrature decoding instead of simple pulse counting.
> 
> Features:
>   - X1, X2, X4 quadrature decoding and pulse-direction mode
>   - Optional index signal for zero-reset
>   - Configurable ceiling (position clamping)
>   - Standard counter subsystem sysfs + chrdev interface
>   - Enable/disable via sysfs with IRQ gating
> 
> Tested on TI AM64x (Cortex-A53) with a motor-driven rotary encoder
> at up to 2 kHz quadrature edge rate.

Hello Wadim,

This is certainly a neat idea! :-) Several times I have wished for a
convenient way to just plug in a quadrature encoder to the GPIO lines of
my system and immediately start reading position data. However, I want
to be sure this makes sense as a Counter subsystem driver before I
proceed with a full review.

If I understand correctly from my brief overview, the core approach in
the gpio-quadrature-encoder module is to take two GPIO lines (A and B),
setup interrupt service routines for them, compare their GPIO values on
each interrupt, and respectively update a persistent count based on the
quadrature relationship.

From that description, I don't immediately see a need for this to occur
in kernelspace. Couldn't the same design be accomplished effectively in
userspace via the libgpiod API[^1]? I believe that library allows you
to watch for GPIO edge events and request GPIO line values. (I'm CCing
the GPIO subsystem maintainers in case I'm missing something obvious
here.)

Although the Counter subsystem does provide an established user
interface for counter devices, I'm not sure that alone justifies a
kernel driver when the same can be achieved by an equivalent userspace
application. If you can argue for why this should exist in the kernel,
I'll feel more comfortable with accepting the Counter subsystem as the
right home for the gpio-quadrature-encoder module.

> Changes in v3:
>   - Pick up Acked-by: Conor Dooley on the DT binding patch.
>   - No code changes.

As an aside, you don't need to resend the patchset if there are no code
changes, I'll make sure to pick up the tags in the mail threads when the
patches are accepted. This helps reduce the amount the messages we need
to parse on the mailing list.

Thanks,

William Breathitt Gray

[^1] https://libgpiod.readthedocs.io/
