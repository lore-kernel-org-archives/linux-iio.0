Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34D7346A0E;
	Tue, 27 Jan 2026 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542687; cv=none; b=X8woeglx8qvCM2p+i/lYqz4iFG16FserFhQMg1S780/UzU2tofk3vZZRVEnIdp0+oGvSmk5ZPXtdSwe9bSv2cYHiheL06ANpaCBk/OB5GMFFU5rEMCr5IJ3kofYoM8ktZVxZljFSgRoi5XlzLRPuC6djmT0c6NQpA2OA6kuGIA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542687; c=relaxed/simple;
	bh=7JZ8eOfeyzXUJwc1ev7M4s+cnApmIeXL2LCfgmGC+6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGFUoboo+9r5cJDPV0G1pX/rRsvu7UmrcHwqYjMPBJA/KNXBZV6Mxa8NboqXffcHs65GlYwW3DzcE+fXCkbyyqnrs2t5J4dYPeqwkjq9eEVJ58LrRcnaulvMGV58N0kGC5GkpT9aooiC9U2WSa/i4wMAVWnbjoCpC35fahAnpBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FC2C116C6;
	Tue, 27 Jan 2026 19:38:03 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: bigeasy@linutronix.de
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	nuno.sa@analog.com,
	tglx@kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 20/21] iio: magnetometer: Remove IRQF_ONESHOT
Date: Tue, 27 Jan 2026 20:37:55 +0100
Message-ID: <20260127193755.3091995-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123113708.416727-21-bigeasy@linutronix.de>
References: <20260123113708.416727-21-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

	Hi Sebastian,

> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> The force-threading functionality is required on PREEMPT_RT because the
> handler is using locks with can sleep on PREEMPT_RT.
> 
> Remove IRQF_ONESHOT from irqflags.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks for your patch!

This fixes the

    WARNING: kernel/irq/manage.c:1491 at __setup_irq+0xb0/0x79c, CPU#0: swapper/0/1

I was seeing on the KZM-A9-GT board since commit aef30c8d569c0f31
("genirq: Warn about using IRQF_ONESHOT without a threaded handler") in
irqchip/irq/core.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

