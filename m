Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616480;
	b=XxqNHlIttzUw0D305dAc2SX8ocXt0L6FPCMugP8comiM0HFq0iKD8diZSsej7F4yfVfs
	 m/kJKZ8Jbz1Nxyh+xiH6aEzrw5U9m1iLiXS9IZNI7eyK6S9vjlFqnZ7jNFSy/NzEYlwNP
	 7c8MFVm1ur9v0GaMY8QekpMDJs4fS86CesB7iXn63mE4gx1WZjKdqYK50bd+cFQkLpHPE
	 uzs6b1Qm/PPDjdDctjwBv8ZA4UeNeYdIapEWvtC9auTDs3qlsNxTV1ERcwNsHFvw8ecc8
	 raEE52cQwMZZAjoMsw9PApW1/sK3TkAGBjY4WXgErVXAJ4wYpF9oRvozTbMEmMHtfFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616480;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LhjOPfinJzTYMIUcY4x4/TLtdZAWqxGUlmkuQXgGtNw=;
	b=Z7uyRKwUlf2fxwmXf/ryozy9LlVyt+NEesRYYhFgV1z0W54vnogzUAonzMcEArtOrjyN
	 +nTbThsz+Gl4t4aeDPkraNNN79PmNSitwyCJBBgliecG57Nl5jB5wm9Cj9rjoxq6M4eMz
	 puFsxFPdGPcoVS21dmVz9bG3oc+Wex/JGKyYI5sWO77FKpUr4FbFbEHGutWYfWPVwmLgT
	 TvMJv3r/DkVxA5LBufajkQQKQJ4yE/lKsocQ8+Jumae6418iR76xphJraPDDQhuT+oVWE
	 ARHe+EBiqWP34nNC2YEj+6v4md82T5jjL2GPmsyCYDu8tRJvWcstIjK+nbSffWvUTsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXn0hMu+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1961C606A32F;
	Mon,  2 Nov 2026 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXn0hMu+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275381F00919;
	Mon,  2 Nov 2026 10:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793616480;
	bh=LhjOPfinJzTYMIUcY4x4/TLtdZAWqxGUlmkuQXgGtNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eXn0hMu+5P/sfxvTvNEoLm2YxOJ+dKdLMcDlGJB0O3i9p+/OZAOY8+o1OzqTZMuSk
	 1fMDVIZzPNxM/7br7oR+9KB8vL1x56C+7zWEu9Op8kiO5ouwZaHTmSIKNjbLHbg2L2
	 xSFs04h2dsCAjYFgLnrJPJztFUOGjPPWCsdgsZxWrv+xhLhBOBwy88CVo1RUzxMLwP
	 g4yyiVs06CzXPdaHKwgGHG23VExu3WOLympLBCi2Au/wqCeJZBz5VHevaJ5OpiQEOZ
	 C8GH4pDbQ4NGkfqfpyaw84VmfH1BW0VymW+zcPuUh1BYgQFwytX4effGXBisS5XMtl
	 WtDlJJsgnh1aw==
Date: Mon, 2 Nov 2026 11:47:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/3] iio: proximity: Add Benewake TF-Luna LiDAR driver
Message-ID: <20261102-massive-busy-woodlouse-8d0bbb@quoll>
References: <20261031-tf-luna-v2-0-ce403579bb8a@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261031-tf-luna-v2-0-ce403579bb8a@gmail.com>

On Sat, Oct 31, 2026 at 12:23:27AM +0530, Vidhu Sarwal wrote:
> This series adds support for the Benewake TF-Luna, a single point ToF
>  LiDAR distance sensor with a range of 0.2 m to 8 m. The
> sensor uses either UART or I2C, selected by a strap pin at power-up.
> This series covers the I2C interface only.
> 
> Patch 1 adds the vendor prefix, patch 2 adds the binding and patch 3 adds the
> driver, which reports distance using an IIO_DISTANCE channel.
> 
> The driver keeps the sensor in trigger mode and starts a measurement
> per read. The manual warns that reads in continuous mode can race with
> the sensor updating its result registers unless they are synchronised
> to the data ready output, which the driver does not use yet.
> 
> Two issues I faced with the hardware that the manual does not mention:
> - The sensor silently drops a register write that arrives right after
>   another one, so probe reads the mode back after setting it.
> - The boot time is not documented. I was able to measure 350ms after a
>   reboot before the registers read back correctly, so probe waits
>   500 ms after enabling the supply, keeping some buffer.
> 
> Later on I plan to add buffered caputure using data ready interrupt and 
> runtime PM in a follow up series. 
> 
> This was tested on hardware using Raspberry Pi 4 and with firmware v3.6.0
> built out of tree on the 6.18 RPi kernel both via new_device as well as a 
> DT Overlay.
> 
> ---
> Changes in v2:
> - dt-bindings: describe the UART interface as well per Krzysztof

What changed exactly? b4 diff fails, the patchset cannot be applied on
any known upstream revision I tried.

Best regards,
Krzysztof

