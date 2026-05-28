Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED13AC0F6;
	Thu, 28 May 2026 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959865; cv=none; b=Gz/GDSaE8QqDIEgFWc2rDCDFEday76UoBR3eFvgMcVvALARARBgdUvrqB+ggASf855yzBGPK3Zey/8sd9TBfRvBRTCNVz/IA1uFt1qaProMI6ucsOU+Z1Wqmmv7DVLA6hND7FwuhV8I7FULlpJ0SOJfsHY4AWGM/2m/FxjaABl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959865; c=relaxed/simple;
	bh=hc3TIONYbVbZ5aQ4GmAverbO2NgNiR2NPrPpO5S9LWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlqckJl02NKL57EjZncmJaGyNg7JnwvvkSks/9GLLc1+TD8u3g2VhmwToGlauqUqgRVGYhFQoOmtbnpKdotTV3dKInc5WTS/2iXDmODFffxXA2nj7IIIwzJyipCPUzvN1eQ5Eo6BO96vekSzRYJpLf+2aK6Okhn5cO1Vbpq2ZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G39SLCoO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G39SLCoO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22481F000E9;
	Thu, 28 May 2026 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779959862;
	bh=qgotZdYlH2qKqrRa2TbL0w5hWHoJ5dB0jsdcBzEktJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G39SLCoO708ZpB7BZ0deCrXa0MoEvYNiaXQGa7URhHwKCprWVZGwC8gHG/xhxwV+S
	 fM6bgUNlI/xT7JtVeLvYyZcP+d3pH8uThHDzTDIBct0PzYLg0eHw9uaWcPl6q4l4L3
	 vASYVAF4nh7pBGdJA1j/FBVAPwvYRCRTljf5yFXE7hHj7nlXqcCr4OamD1aJIQ+IB1
	 txOZBM40UukQ5ZTOxmZAKC0PhXRbfxEkVezY41g8U4sfuZOHZ0I1lLwNllFCxPyZPH
	 nxYX0ZJNG9rqP+Cm/6ulJbof8M+Lh4dICsUDuaruYZbyqGJyBuSS3jAAHCSA8xL9Qi
	 1KvkJBfehCHdQ==
Date: Thu, 28 May 2026 10:17:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty
 <pbolisetty@axiado.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Subject: [PATCH 0/3] iio: adc: Add Axiado SARADC
 driver
Message-ID: <20260528101732.034f57ab@jic23-huawei>
In-Reply-To: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
References: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 01:10:22 -0700
Petar Stepanovic <pstepanovic@axiado.com> wrote:

> This series adds support for the SAR ADC controller found on Axiado
> AX3000 and AX3005 SoCs.
> 
> The controller is a 10-bit ADC. AX3000 has sixteen input channels and
> AX3005 has eight input channels. The driver uses SoC match data to
> select the number of available channels for each compatible.
> 
> The driver supports single-shot voltage reads through the IIO subsystem
> and uses the reference voltage regulator for scale calculation.
> 
> Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
Hi Petar

Welcome to the IIO subsystem.

I guess you already noticed, but something went wrong with your
patch title.

If this is an issue with a company email system or similar, consider
using the b4 tool and the web gateway that works with as it avoids
any corruption of threads or similar.

Thanks,

Jonathan

> ---
> Petar Stepanovic (3):
>       dt-bindings: iio: adc: add Axiado AX3000/AX3005 SARADC
>       iio: adc: add Axiado SARADC driver
>       MAINTAINERS: add Axiado SARADC driver entry
> 
>  .../bindings/iio/adc/axiado,ax3000-saradc.yaml     |  58 ++++++
>  MAINTAINERS                                        |   8 +
>  drivers/iio/adc/Kconfig                            |  11 ++
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/axiado_saradc.c                    | 218 +++++++++++++++++++++
>  5 files changed, 296 insertions(+)
> ---
> base-commit: 51f0c0b8545b23963afd5d43a8f56ee05bfa54da
> change-id: 20260508-axiado-ax3000-ax3005-saradc-151aed5d25da
> 
> Best regards,

