Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794829474;
	b=q5qFz91zblZIkgBXiBr4bTNfVmUtuI2Q76P/LBiMdreO4pkuGto/DZ4SkST7PK7LA0Qz
	 Dp/JRBQebadr8CDq8KN/3uhq8vKg/ko7EjygbpaQ5sdBgi6CbXZK+yvqU7EfkYl/oYQ0q
	 xRbJmK+WdQQ7yQhI8jszf6UwiLVmRD4soAwIZLmsvc8+2d/USpMuj+DrTlkpRxoOnzpDf
	 sibznnA8n9hmBgT9lGtFDkZYJUB6at1mrh4e3XVVxgNFoe9HwxapCQRw/vPMXAJJwa9ZR
	 9yfE+sjdvsfzshNGadnMgMWe5uzV6TVz4S13mifg0+C8cKbYYosVc38a3xtQfA9hAgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794829474;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KGZgtFOwBdvEiMXgivra/57xr6FQxzyBu11AFSKiqZI=;
	b=IHH3GH1QtcIaVnvC+zuzjhSATZYc7xLu1gJPuns6sPeNq6GS/RJVioax2a5W6Df3lc6k
	 vqPKVN+kVhkj5+iGh8RjnZMkN/RtAqF0SLydFBrdnrGlExyTpGWVBbgb9VWHUU34oUQT6
	 q+c9/1T31dJfzWnHOrFkUUaCb8JjZ5MK6EwSdyUsYccHc+GQ+JMqOQGFXMYoIM24qI5Is
	 sZ5fr6qfOn509DepnrvqbOTKboNZE7HqqG2uHBKmZtJ5voEZ+6JQuBQjihpQXgZn/Lodp
	 RmOVwUhLsumn2mYR6BWZVNOj7Ug5k6pEjcX5qMdhe3oBZgnMbvzjbnI1VZE9w/OYG5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kI/I4yLU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45950606A31C;
	Mon, 16 Nov 2026 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kI/I4yLU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1091F000C5;
	Mon, 16 Nov 2026 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794829473;
	bh=KGZgtFOwBdvEiMXgivra/57xr6FQxzyBu11AFSKiqZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kI/I4yLUJ5GCvzaY57Do2Fvb9RBpacmrFuqNMgeEl13BTw/V8dLH4plt3WCUP1HfO
	 5v2ZzBByd8Dg7f6L6/RU0anBjJGUVqOkbf91QqoMkhShDurPVqDzhCLzE1Dr2RuYDY
	 jZ4BPYVW2zrgoTAzLTW0GP+knu7wka6lg2jNjXlimvOgoeh4pPkiZukegE9IC/LtV2
	 IQTVVu3slHaO1xzEjkNXEx8BqE/tDgdElr135t7pvkapuChzuubfryYXixD8YwsJ4c
	 NlOBbeVbdVqgeUhiGIJuYchrqaljR/39Hjx8rVtPo5+K1zOYu4sHUl1fTEvULQ/0o5
	 UhPBqyj+y0qbw==
Date: Mon, 16 Nov 2026 12:44:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Patrick Fischer <admin@tsv-stahl-riesa.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>, 
	Svyatoslav Ryhel <clamor95@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: Add Capella CM3217
Message-ID: <20261116-classy-fossa-of-grandeur-ccbc25@quoll>
References: <20261113-upstream-iio-cm3217-v3-0-c4d5b2485dff@tsv-stahl-riesa.de>
 <20261113-upstream-iio-cm3217-v3-1-c4d5b2485dff@tsv-stahl-riesa.de>
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
In-Reply-To: <20261113-upstream-iio-cm3217-v3-1-c4d5b2485dff@tsv-stahl-riesa.de>

On Fri, Nov 13, 2026 at 08:58:59PM +0100, Patrick Fischer wrote:
> The Capella CM3217 is an ambient light sensor with an I2C interface but
> without registers and without an interrupt line. It always answers on
> the two fixed addresses 0x10 and 0x11, which are both listed in reg.
> 
> The sensor is used in the NVIDIA Tegra Note 7 and the NVIDIA Shield
> Tablet.
> 
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  .../bindings/iio/light/capella,cm3217.yaml         | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

