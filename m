Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566835;
	b=q4fg1NmHUssAw7UGXOwkMpKUBj8ZZa3wZyN1NON57S7vreSl1Q57WcIEHT8Jovk0qIzz
	 JZBwJwnxuwygV1lBqE7AtQ3r2/4P3ML19fb+1hpUJREzaP01Vzb3e7+kBdyLiYZ1LzGYD
	 lv/h20C27mU58dT0XCdlwTEk+AZcai0iw1WjVp509JD3YPVTl6utwnJ51zqMF/qrHNJYz
	 WCM8EK82RKYHvG8s/ZOsu0LTMl/2g4fMfS4VkUwwSYIShZmVzf8hWEkJ6f7nX25StnUHJ
	 RH+d1b8joxG3cMct1hEpscND9xrcTShSq3VZkZFqziMY+pns2NBjIaIgyg12+fSEhlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566835;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=29ur7TbnSLjIE3Dz9Z7p/coMA4YgLT7MD1zA5tUu7p4=;
	b=SZOEdd1HH0BwAZpKv3ORAfEOzIQHNXZoAE6H7IRkpRbRXHPV82oSYxqeSpGEGty27tjf
	 skLeXnm3sxIbHbCcVY2Z7jrXi7QfBd4nXXEh+JNHV55e7giBLrrGmrNa4D66GMK6ddDv0
	 iiQhAYnhj/fP3N8ls/AvotGh9tidJBeB3Ko3sAQD+Uz4rvH7uDbDEiF06DNWGi5uOzkjq
	 oJ6WDYF3S6Og94Mzq82ZlH5zTrcq8CECKoCcE1oT4+hT+DKlrZLIRrvCQmJYDr+zuK11V
	 sOHCHKxppVAnelWC+ZP6qKKkKZ/Dm5nhRj5IR1F4lW2I/96SjDRvZz6Lv7w21S28daw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E50E1TEE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B189606A32D;
	Fri, 13 Nov 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E50E1TEE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC0E1F000C5;
	Fri, 13 Nov 2026 10:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794566834;
	bh=29ur7TbnSLjIE3Dz9Z7p/coMA4YgLT7MD1zA5tUu7p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E50E1TEEXvlnEIzPJSQ4phdYiD8T0Yp1PB2Kj0Q5yw2+nmaC0SO8nEfna8PjJuaXK
	 wTFEIp0iUqZi7yshxjWuovZZhNygQvH+TboAgE9Wk3VP52324nDN5UdPxv0s9kioCD
	 uSlaSppBryeOB7aa1ITzAvrfsavR8XjZPhdHtBwlQ8WAXQtMw2X6OHRgLmBYGTppvH
	 K1ijh8b4nkJ5P0UQrwotFtqL010RgORIJeF7WM0PFvViTqGLJlJYuA/dWd34UI4C/I
	 yksVHO+TOK1qLzvIZ2hRiCp2VVZ/zjgmI8Tl85VZMKFPjN+FgfyHTbvnxxcui3/Y1y
	 6fP9kb0hfW/oA==
Date: Fri, 13 Nov 2026 11:47:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: lltc,ltc2497: Make vref-supply
 optional for LTC2305/LTC2309
Message-ID: <20261113-bonobo-of-algebraic-flowers-af7dd8@quoll>
References: <20261110-ltc2497-vref-optional-v1-1-35c9657f3c0f@gmail.com>
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
In-Reply-To: <20261110-ltc2497-vref-optional-v1-1-35c9657f3c0f@gmail.com>

On Tue, Nov 10, 2026 at 04:42:59PM +0800, Kyle Hsieh wrote:
> The LTC2305 and LTC2309 have an internal 4.096V reference, so their REF
> pin does not need to be driven by an external supply. The LTC2497 and
> LTC2499 have no internal reference and require one.
> 
> Only require vref-supply for the LTC2497 and LTC2499, so boards using
> the internal reference can be described without a dummy regulator.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---

You need to address also Sashiko feedback.

Best regards,
Krzysztof

