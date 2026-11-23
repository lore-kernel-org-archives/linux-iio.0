Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421044;
	b=jrP7qkm47AgKJORLHkQWOEA4Vm7ZfIAKCAkTym4Eu2uWTVKR8DkjIZY4dQ3TW9tCRI5e
	 WFvnjJipwaPSBJ1kw8BGsCR01gKwi7eMfYJ4vy0YMmRFJxoQEPuQc1eKn2Y32eqZMDorI
	 pM7SAk7S3TJ7vkhQVpE9XFVPIti8Eo0CMPZ7u2jpmYBWN15/qkA5plgWPNB0GD4D4p8NO
	 wNtyVyod7NiNGSSQqtnHiMR2VoDV0oZUSxs/0HPVVdz2N6L5eUqVepto4u4ET71nQ30D5
	 vKDgj8asGBEXyGvG/a/JuYXmZc8NLMOeOnnnOfsfggnA8JbWO43DXVyk7DDRrsus3HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421044;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=leRR6eNzADhVnKcUAKiblsCMLIUNRjwjArIIU12nGiE=;
	b=a9y9vR4FU7gFIb/P6l7VlDt8hpGaLGIKUn+yPXQ4F/LgxfKRNMcufc/1My06dEwMTAtc
	 8kpUG943PmpxvE66TCBANkkJeSeTwF8c/+LaMk6h+J+BkiMjhq6o4B3IOKeVzZu1o2sK5
	 GMZMDFzN6aPq2CDhz4NA+91BSl9HARkjhGokpjoT6G1VRJSnaMT4DA5wCRymoxQAqB690
	 fwExVUSPrQx8UjQaZQdyoQ30z+1E0jXkmfACPCfsL4zy6eT2YEOR/sce2lb8RqKefkhGB
	 rTPVWtc7sTG8n+12eQn/imxfZ7B2rxqW4BtUtBvtS1D3Ney0vfR9zac6ui65dLkGmIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQZg+5F6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10337606E61E;
	Mon, 23 Nov 2026 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQZg+5F6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF5E1F000CF;
	Mon, 23 Nov 2026 08:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795421043;
	bh=leRR6eNzADhVnKcUAKiblsCMLIUNRjwjArIIU12nGiE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kQZg+5F6Arowc8IX/pv/bvNDLZ+/tso26+mHlXpttbrrxleQO3nGx4ltqpDIoVWqZ
	 OUi0TWLIZWFTW6lF2U+hmLX+cgUT/26AqFoPh1oicwi0S8y/aoxo033JQDfN4vpRAi
	 I0hMpX8OuVWTX6XqVnhQ9lGqrWMCky1KchX2y41+U6ZXmpe2PYF5xzL23Uc3W9vX5R
	 qW1u+0Jt2/e1zo+zGSp8HU/2ThsWrDO/O8A4pzsyatU1bbEiWqiO5NJcT0tH39gP8U
	 1bhAz16hlUVQgxltp09in9gcdk5SvW12+lbVe/IKRiABRuJrSlN8Pwn958EuRHkQez
	 /xNw+XGYmOZsA==
Message-ID: <d854fae0-eb46-456d-a7d9-8a0691db40b1@kernel.org>
Date: Mon, 23 Nov 2026 09:04:02 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v5 7/8] iio: adc: at91_adc: use HZ_PER_KHZ instead of raw
 1000
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>, jic23@kernel.org,
 linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, giorgitchankvetadze1997@gmail.com,
 amin.gattout@gmail.com, antoniu.miclaus@analog.com,
 gregkh@linuxfoundation.org, mripard@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
 <20261123070101.53868-8-abdelnasserhussein11@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261123070101.53868-8-abdelnasserhussein11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23-Nov-26 8:01, Abdelnasser Hussein wrote:
> Use the HZ_PER_KHZ constant from <linux/units.h> when converting the ADC
> clock rate to kilohertz instead of open-coding the divisor.
> 
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts

