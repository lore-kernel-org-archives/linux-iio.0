Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795227271;
	b=S+SLwp4sA2VABfcLDPEui3HEheKZxKAtM5UW7CdUwYDlN9XTRrVDv9haO72U9AnhClKR
	 NZ8KMH86YAmg7txelYm1wi2mdyXNwsc5fx1ETMhzZzuvygYP5JW3eTy9G+yrGlzNPxRLS
	 rZKr9PNM/d4yojGnO0z90juJEusm96wVT25sCJLeDXMU6OESSXG3Nr2Dtlf4dRMXQeJv9
	 gBryU+Vtv7HZW887dn3uNnr5gu7Vyj3NOKVuaa7I7x2ICO1M22N3qfxM2A5nnIz0e2RRA
	 ddlg7sV+2PQVcHUXuh2QRK9x47Nl5nadyLZU8JvCom84S4AX61/QxVT2Cy2f28QFkiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795227271;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=diMFiH0iF2NK4uRHNjga5KulLfwIy8jG7CUwz9y2dvM=;
	b=hNXQm46YhWaqoJkpgqwDjAUotTrbnqlq0keIHuNSaYV2DB+BZoFiur5vWhdQWPHSnIy1
	 lF4U9R1BJwgqfsdniIbfcs2ub9Xvl8iEbCxoXoO6hkr7+R0upEQx8GAoYS1wLLRHFbnZE
	 goVoJRbv6Be8tWoe6egB0WOeEEY7YKeB7t0Q4ALPeaXFRzW+0WDAMJDlpPwpvaqp9xZe3
	 2fBVNE41l95hRxvUndjC/H4HpoGqfTu7zopwYw1wI9aq0DsCmcsnzkI3as4rOv9cpBh64
	 uZVRPk2OGzdoPLR1ZCHtXn/n92Ym5Dv3XQdlgRmXSOjiUnNv99wZGlGqocfFaNR0cBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SnBpVxSX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D031606A68F;
	Sat, 21 Nov 2026 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SnBpVxSX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FAA1F000CF;
	Sat, 21 Nov 2026 02:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795227270;
	bh=diMFiH0iF2NK4uRHNjga5KulLfwIy8jG7CUwz9y2dvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SnBpVxSXKAlysYKm/BvtY5D/DFb1d/Bb/HUjw/FTUSXQoglv7xpBz6fuvzBaUuDGt
	 zu3v4LmwsJG2IW9qp0sKNgaQjNV2hMo2UrldVAArfyv51n5Qm0CwEKLjXM98UEYlsS
	 LbtgZuWkIZtKPnqrViblB52IGp55A5FDta8GE1JtuOyv23U9+7IwelUZ3UhTLZvVM5
	 KhmwWBrMdOZ9v0LX21ym7vqCToYye2DWzmWKQOl9/POuWiRMSEmVmwlBdPg5BFfn1J
	 sn1A4U8M1JbCsP7vBddlAztrgwmoH8rVnauyC2eJ0sXj8sRQ5YHzLzKHOwwVIVg7uT
	 hVJFH6UZXlLPA==
Date: Sat, 21 Nov 2026 02:14:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: ILYAS NHASSE via B4 Relay <devnull+ilyas.nhasse.skf.com@kernel.org>
Cc: ilyas.nhasse@skf.com, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad_sigma_delta: support devices without
 RDY interrupt
Message-ID: <20261121021423.6d432a98@jic23-hlaptop>
In-Reply-To: <20261120-ad7124-no-irq-v1-2-7826c5c3fd25@skf.com>
References: <20261120-ad7124-no-irq-v1-0-7826c5c3fd25@skf.com>
	<20261120-ad7124-no-irq-v1-2-7826c5c3fd25@skf.com>
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

On Fri, 20 Nov 2026 12:26:48 +0100
ILYAS NHASSE via B4 Relay <devnull+ilyas.nhasse.skf.com@kernel.org> wrote:

> From: ILYAS NHASSE <ilyas.nhasse@skf.com>
> 
> The end of a conversion or of a calibration is detected with the DOUT/RDY
> interrupt, so a device whose DOUT/RDY pin is only wired to the SPI MISO
> line can't be used, although its status register reports the same event
> in its RDY bit.
> 
> For devices with registers but without interrupt, wait for RDY in

without the interrupt wired

> ad_sigma_delta_single_conversion() and ad_sd_calibrate() by polling the
> status register, with the same timeouts as the interrupt-driven waits.
> As with the interrupt, the bus stays locked and CS asserted during the
> wait, and ad_sigma_delta_clear_pending_event() has drained any older
> result beforehand, so the RDY bit seen by the poll belongs to the
> operation just started. A timeout is reported as -ETIMEDOUT.
> 
> The RDY interrupt is the only trigger source of the triggered buffer, so
> devm_ad_sd_setup_buffer_and_trigger() sets nothing up for these devices
> and they only support direct mode. Registerless devices still require
> the interrupt.
> 
> Each poll is a SPI transfer, so poll every 20 ms: this delays the
> detection of the end of a conversion by at most one period, a fifth of
> a conversion at the AD7124 default output data rate of 10 SPS, while
> keeping the bus traffic, and the CPU time of PIO SPI transfers, low.
> 
> Nothing changes for devices with an interrupt.

This is rather wordy.  Perhaps try rewriting to cut that down
to text more likely to be read.
> 
> Signed-off-by: ILYAS NHASSE <ilyas.nhasse@skf.com>
In general seems fine to me.

Jonathan
