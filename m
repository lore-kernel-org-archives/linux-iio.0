Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793063756;
	b=4WfjL8SLySOiou0lc+GSScw1Rk7xCVcv436rmpQCe4Pdo+E9Louwy5eWVoXAeB95FhWJ
	 fVC6gXmen0J75JTgReSOTlgkZ0zmNg2BB1BZdRGy0rm+olTozVs8llfEHnY+t5NtxyqFF
	 xi5a1G8m4B8LluQrHiwqsepKDikpxZLMMUt5P9RcfcUkMb8E7/somWgyo3CdVltTDaozx
	 bj/MNC+Sl8eXpd9NGFNORXIRgQDTGbgeAc8QlSasgpqbfDkbzqS5PgZ8iGoIEPxej4zQy
	 byTV3ZIXL7TTBUwdPLAyWGzJD9k3srQZXfsXf4yUFZonv4lVexSZ5drIl2Hti8EcP/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793063756;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qkIrICFESu5+p9IdHsK2lcfxMULnjI90Aj6TvpKsBdg=;
	b=bJERFPF1Wc83UNJyvGjE8Zh7WF8y/VZxG+Wx2HwG0EEDZbOSXjIsaUQ/1RrjctNjrY/3
	 3EGk+4cgVZV2fMR/COWLC/YtFhcaRMRLnmK6JqEHsm0KngAdK1sLTHsUxapuZBdiu5qJr
	 9Avawxb3tVQNsDFZH74U0sJij1tbL8HN9LSkdb+CQzoEjBBUMzPDfGCg8FGqbuGYvmAZF
	 r+VQkYcwtkuxRjRlnJCK4ann6mYh6SgElel6xUtKpklmvJB2YdOM0oVfu4XTiiJMFDqpc
	 V9l84aGIuOtXnMm3GEzX5BKP98on4KlsMQRtwHDrDW9LazNRG3wREjafzCpCGCpgrdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5LSgVLb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489F0606A31A;
	Tue, 27 Oct 2026 01:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5LSgVLb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C4A1F01825;
	Tue, 27 Oct 2026 01:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793063756;
	bh=qkIrICFESu5+p9IdHsK2lcfxMULnjI90Aj6TvpKsBdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z5LSgVLbx+/HJNW1MXc2vjiTu+QzPIvMP999KzcgwrmSOf6ehZ+iAwB+lzk3VHjFt
	 X7ZZJuGEb+WXwhWXt+X6Gphv31gC1eL7HN91YC3O0CsE0jsq+fOUfkzcOAj9u+Eo/s
	 ELCCrrWJb/fg39G61hPaGLdvmAdrwP5KUXPTZUG5uL3ThnA1LxQl6FdTeuZ/x7XspK
	 z6/8LO/n19heSr827Q6zI4d4g9K5vcO7UhjqTK7Ol/14t9Uthbbtgdn+zP0OhxItcM
	 F6ALXdAxiJyLPeIwh9DZyP0hNRiS5nB5X7s+DRfYBSN5MjXQ1BkwyC0TH4+cqV4bN6
	 47nL3wJ4J+0lw==
Date: Tue, 27 Oct 2026 01:15:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>, "H . Nikolaus
 Schaller" <hns@goldelico.com>, Joshua Crofts <joshua.crofts1@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: adc: Add the Ingenic X1600 ADC
Message-ID: <20261027011547.191101b7@jic23-hlaptop>
In-Reply-To: <20261026083631.48406-1-olivier@mgcrea.io>
References: <20261026083631.48406-1-olivier@mgcrea.io>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 09:36:29 +0100
Olivier Louvignes <olivier@mgcrea.io> wrote:

> A driver for the SAR ADC of the Ingenic X1600: four auxiliary channels,
> 12 bits, one interrupt per channel. Tested on a HiBy R1, whose keys are on
> channel 0 behind adc-keys.
> 
> By their programming manuals, the X1830 (3 channels, 10 bits) and the
> X2000 (5 channels, 10 bits, one more data register) have the same
> register layout, two results to a data register. As Jonathan said on v2,
> the X1600 name stays, and supporting them now is welcome but not
> required: I have neither to test on, so this version is X1600-only, and
> a chip_info with the channel count and the resolution can add them
> later. Nikolaus, if Letux has either at hand, adding them on top with a
> test would be welcome.

Nothing to add from me for this version but perhaps wait a few days to
see if this suggestion gets more feedback.

Jonathan
