Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE66B26B74A
	for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784987779; cv=none; b=KDJuK3mKUAhD98Tu2rm9gU9yA6p5GtWVurmlCGDLN3QNlFThELdgBajvitHMXtSFcgo3sX/NW/ZMwCYBqOMXGLCAscxGOHWRwlNxXumzLXMC2hIcWv1/0sxRnTRriHsnWzPZsaxCEiviol3bykOHyF8xacPSJaigmrO4ctHX/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784987779; c=relaxed/simple;
	bh=WQP2oA5rKx5FSLpDEvp8uzssDuT51alLjMmAg41jeR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQiiVNnZcn97t5y/SWLbfYeKQmDciCecgrm1e9LftDkIuE0tHZDrGG+I/AlJOleTT8hq2bL9G1yc9dA4c61RJazOQtT18FSVoWs4o3jEIEpqn61WWldpXsReTMPndSrQdpMVP5rWyttKIVszMjEsXng1f8rJ4Bdpd33rGQPN7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZ/E5TVF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZ/E5TVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886701F0155D
	for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 13:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784987777;
	bh=WQP2oA5rKx5FSLpDEvp8uzssDuT51alLjMmAg41jeR0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XZ/E5TVF82rL5DqGg0YVX+dOeybuzusBNvTTS+Blticr6jLIna96xK5B2matAKVaJ
	 ubx+lX3maeLVDgAG8rmSOYZiP5QIFW1ohzkEMpZGCkUzfpVYYj0kaZYDWZDYzf1yeD
	 9stBJu/bKYvbKbXJSpmbOJoBYQO5nWPNxdpiopTgTLOqT+/ZJYHOpniWK4EKo/cF99
	 JhJ9frVmhbGwNJEn8+agDT62DOOK6oc/tXdwN4fpIKpViYY3fX9NTLm9zQoRjSyfKz
	 Nd0Hl2iWeYdCbH27TgVxbO71If6I3ZS7jwuVypNYmWo5iptgKmr6KjHEL1oEJGe1ta
	 QRHM+af/IYi7Q==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b015532f7bso1301812e87.0
        for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 06:56:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqalkeH7LqXwM2ngi24b94uQTIzXRb3C+7uOcfbqX0z4TsbW/HAEcCRvusvsMQHrPQowa2DHz8pUQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0zsXKMFAcj1sVdGscuyPxK+31Qn8kYpu3dxyxpq6tjk9vYj7i
	xKKaafZkCBHXLllEfV/oCrpj66jHDOjzR+29wI6vO/ZwMQ9McLDpaZfpPR3g8faryoHHYN5kHc7
	aKVbmUzCm7XOtLfsLSx5rVU404KHo3yw=
X-Received: by 2002:a05:6512:3f14:b0:5b0:1eb2:53de with SMTP id
 2adb3069b0e04-5b2c1b5d430mr520664e87.44.1784987776164; Sat, 25 Jul 2026
 06:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723034237.2501507-1-eleanor.lin@realtek.com> <20260723034237.2501507-10-eleanor.lin@realtek.com>
In-Reply-To: <20260723034237.2501507-10-eleanor.lin@realtek.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 25 Jul 2026 15:56:03 +0200
X-Gmail-Original-Message-ID: <CAD++jLkfrd_X3V-JwqBd3D+kL_d2qQY4X0YQqdVvpndueZiu3g@mail.gmail.com>
X-Gm-Features: AUfX_myM6hIu4S0umra6E791UEBVNICJ0Fr1LuQ4pJ1qU8fF8MvlDATABrc8HPY
Message-ID: <CAD++jLkfrd_X3V-JwqBd3D+kL_d2qQY4X0YQqdVvpndueZiu3g@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] gpio: realtek: Add driver for Realtek DHC RTD1625 SoC
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

> From: Tzuyi Chang <tychang@realtek.com>
>
> Add support for the GPIO controller found on Realtek DHC RTD1625 SoCs.
>
> Unlike the existing Realtek GPIO driver (drivers/gpio/gpio-rtd.c),
> which manages pins via shared bank registers, the RTD1625 introduces
> a per-pin register architecture. Each GPIO line now has its own
> dedicated 32-bit control register to manage configuration independently,
> including direction, output value, input value, interrupt enable, and
> debounce. Therefore, this distinct hardware design requires a separate
> driver.
>
> The RTD1625 GPIO controller has a hardware quirk where both 'assert'
> and 'de-assert' interrupts are fired simultaneously on any edge toggle.
> The driver works around this quirk to correctly handle edge interrupts.
>
> Interrupt support is optional for this device, matching the dt-bindings.
> If the interrupts property is not provided, the driver simply skips IRQ
> initialization and operates purely as a basic GPIO controller.
>
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
> Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

I see Mathieu have some more comments, with those fixed
I think this looks good!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
