Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AAC1FF7C7;
	Mon,  3 Aug 2026 06:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737082; cv=none; b=W81XLMwJzBiSRTGLf/7P029dZ6yN+WJx2ElGJqKOCJUdZu8oMQP0xDlCi/70cZGMMbAgqK0qCEI8IvNqNcli7fiz8+pejjoxVSR7L8CWv9ZVkLXirk8yDv571PffZHt0BsheonUf4Bh1ZYcGsm+xx2tdLpq14hFxvYTwvSGaYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737082; c=relaxed/simple;
	bh=KXIFbSQYjM2J8LFuuiXyFRy7trYM50KDgrF39da7DwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U6BWHS5vrFdLItyWmqzcAMG09fQXIiWYOxF3fJVcBATG3zKZr5oU6s5HMS3pDn6e15QbSl30Rqd8ynrbSxCHVfLNiRHNK7iaSkDU3NSuxdixKJUN0lO7m9wVfOpZeY9JxPU6S/38fKK4ANzec/mb9Gv6QBC/RvjPvstDZA2UEFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLlNaK0y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLlNaK0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5338C1F000E9;
	Mon,  3 Aug 2026 06:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785737081;
	bh=x3/ru7zpA2JSvkJSqvHSPa5Yj+x3WuUgsz/z/nJltAU=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=XLlNaK0y8ickvHFCLf6HfktO2C50XANCgHclddLaeig45WMrCwe79cCZvGFeek+ZJ
	 1EgrcceDB2YYW8+m7kf8yQ81gLgkQ5MEMXs23ax/H53wrgj6GT+cZmSVxI1rqQBWvh
	 z9Z0XQMv3UeJZSkJa7FHGw7pcykX3jgE4ODt0BMTF8T2IJh9UOOWHA1iIAXBVv1dds
	 UL5V5gd33LmG9B45JlA3rEuMvD0gLeiFghVM0UBW+Wpf19jKMCJjJmm7ViqYqOuive
	 ycsd8VVTHOy1IC6RtSMr50GIs0neMSv9NL080ASgjKO+ks5EuArqrFvGm/FmUzjkPX
	 k109VKN79CVqw==
Message-ID: <f7837407-3d5b-4dcc-8118-b2912dbae652@kernel.org>
Date: Mon, 3 Aug 2026 09:04:34 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/16] iio: adc: at91-sama5d2_adc: remove unnecessary
 casts in of_device_id
To: Varshini Rajendran <varshini.rajendran@microchip.com>, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, srini@kernel.org,
 marcelo.schmitt@analog.com, radu.sabau@analog.com,
 Jonathan.Santos@analog.com, jorge.marques@analog.com,
 joshua.crofts1@gmail.com, jishnu.prakash@oss.qualcomm.com,
 antoniu.miclaus@analog.com, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260727122633.117435-1-varshini.rajendran@microchip.com>
 <20260727122633.117435-6-varshini.rajendran@microchip.com>
From: Eugen Hristev <ehristev@kernel.org>
Content-Language: en-US
In-Reply-To: <20260727122633.117435-6-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/26 15:26, Varshini Rajendran wrote:
> The .data field in struct of_device_id is 'const void *', so explicit
> casts are unnecessary when assigning addresses of const structs.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Reviewed-by: Eugen Hristev <ehristev@kernel.org>
