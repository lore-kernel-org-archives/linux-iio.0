Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195491;
	b=cKT2HsJDbI5rDJcuCHBHXfrc6KUW58LvzsQcx5/7KehePP0rdBbxC7gh4Qiuny9UWZ2U
	 n27lGbcGnYNAxq+4hkAdmuPA3GarxMU2c/qz9JIkE/kt4EvT0OzdYtDluWhb8GPVd+TrH
	 VdekKwdmoLCEI8HVqztGf/o0Gx3c/idwPmbvBORl/vezAqbysmiH5mzJIBJR/d7g8OI0h
	 9BiENZ8tSgjJHeVvryu/VyjuypMxo+InHfCOg7przCgTCPWJ9og0uawWuO+o9KySOazoA
	 HoytUWOoAMwws+VofJ5xfT9SEEW4Fya2xn/agozJY6etJ5fTl3awBJbm4iaKylG11eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195491;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4Y/rSr894qLRl2goj1baT6Zs2+/CgiEisoOorlNt+S4=;
	b=R9ZqM/3/+AA2nQBDGYecP7DLllgWoKdU3Sf/CZ3MIHb19UFKyjvmhXu4V/F3W/gtL7qK
	 pX6NV0/uB4UDLXHD3zJm4RlKMdXUcJMUxtY41fv6vWHEDCth8lqDoyOj3HuJy9HSFYwOO
	 yyzCoSkG7T7jLHWUV/vgSeBfhh/8fNNonOaq5LfhywAgQ22KbeWmitfHoxh+Uir2wrl3C
	 lqPEnj83g3j1CuCqpyHaLViZ5PRcXPNqi7uT2vR7CxuugNlqdDp0yypn4904Wk3rgPdM+
	 tXRQPwa+cvvzLoGVU0xI/oRzMa+m8617UVXtjBYe/HR4E43/9/qa8+kh7aJcCoiQkfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LhnyHoqC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA083606A321;
	Wed, 28 Oct 2026 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LhnyHoqC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29F51F01828;
	Wed, 28 Oct 2026 13:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793195490;
	bh=4Y/rSr894qLRl2goj1baT6Zs2+/CgiEisoOorlNt+S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LhnyHoqCJuE9rE85usJCDB2h/oQDstnXf3hY6egJQRU3jUjwqVgpFTHL/lVw5jpdM
	 WRT3XfE3/xqUB1VZjrEnk77Oh0a8byY71hpQ0D+5YJBG7izBPn1EgqB1VglrScq7MZ
	 6UjbB1Z/Eekl1XxfKFbASJuwO+YAZvmFwkNc4XqL7BZUDjM77zF4zxeXaE9Jv11SfI
	 P1Fie5Pqx+RVYy+l0PqpZn0zrmksrcUooQT82lE3gRDddLqnjJJPl0SEDYZo/JVdFC
	 hUE+9IUxinOhU5erVPVBcJex328FUcPIoP0YMPR7/z1q1wUiLKE74pYRjz7vWMzmFC
	 Lb2KHu7MxNQzw==
Date: Wed, 28 Oct 2026 14:51:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] iio: update email for Joshua Crofts
Message-ID: <20261028-independent-cougar-of-hail-d2b21f@quoll>
References: <20261027124602.1533-1-crofts@kernel.org>
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
In-Reply-To: <20261027124602.1533-1-crofts@kernel.org>

On Tue, Oct 27, 2026 at 12:46:02PM +0000, Joshua Crofts wrote:
> I'd like to use my kernel.org email going forward.
> 
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
> ---
>  .mailmap                                                      | 1 +
>  .../devicetree/bindings/iio/dac/microchip,mcp47a1.yaml        | 2 +-

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

