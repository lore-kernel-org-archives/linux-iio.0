Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4564ADD8E;
	Thu, 28 May 2026 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980130; cv=none; b=ZGQuV3Ki2tPvepEPWgHValI2GEyQUzz//PeZeDFfzwkFqqw0r033dcJTE0Rq7GFbYHaPDC2ceBp95iAooJy2Ce5f/vDMuxUSz6p4Q85vHJWHuX9AhzGFx9yylpvDisA2oUJ3MmXQfy0qHyMBiPS295fhWkLWqQNe/Hgs7WM2hqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980130; c=relaxed/simple;
	bh=ANR78EMmIwPF3IKjKoGidM86rWXaZZJRzlqcS08xYU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ll4n/Bv97H+XcpznzlZ7TK47ZxcSs+GFNpjicxNHqJ8yqlwhisudAdeqbJV73TR340EQhDZpAM3T8DLhA6KJ+500Ctu02VozDwIFnSQHUu0QuP2tuUjMuaU8Ss2h/wQApR5vRcrdYGZ8/wIKKQpTzpBw4vi54Lnz3vEGdfvhliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZiTAqL5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZiTAqL5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A4F1F000E9;
	Thu, 28 May 2026 14:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779980068;
	bh=PDEl4kKPc6iIqexxaYFEcgJVGHLTcyA6Gc83lceYzh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FZiTAqL55iNX2zlVq96qXv++ZhTH/cMMAlVouWHSt60HcngXMDVTplKN/6Zdf4XW6
	 3RrCDhttq7DrsxzajbV2n7lRI1DgUjIne1EsgRx7fIERVKHk3z68G01nPIYqny9gYl
	 uXyNy3Xdk+O0GmQM2Ve45girjhplwDtuA/dgY0Y/bJ7ZVAqKRF/sSiTQ9t/Dfii1rv
	 G1LKVu3Xb6XCjQ5jvAk6sGKvRpwmDiQo4e5QarP5uOJft2h60GPkY0pQ5Q5ivPs/yp
	 Kma1FTJJIND11XzU6sc6o7LajDjGiZExDDrTNq8/szb9BwxOc9IThbQchufOEqgdot
	 JB0a99ICbsnXQ==
Date: Thu, 28 May 2026 15:54:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: leds: Document TI LM3533 LED
 controller
Message-ID: <20260528155416.26cc42ad@jic23-huawei>
In-Reply-To: <20260528135123.103745-2-clamor95@gmail.com>
References: <20260528135123.103745-1-clamor95@gmail.com>
	<20260528135123.103745-2-clamor95@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 16:51:18 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Document the LM3533 - a complete power source for backlight, keypad and
> indicator LEDs in smartphone handsets. The high-voltage inductive boost
> converter provides the power for two series LED strings display backlight
> and keypad functions.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---


The light sensor binding looks fine to me. I didn't check the rest.

Reviewed-by: Jonathan Cameron <jic23@kernel.org> #for light sensor

