Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420976;
	b=ie1O0SBtvNhRh8DAw/zuHy3uM1SXugZusdFrnnPhxXORP2CXU8UETWGvJNvKR0MFxLVU
	 ZD4cqDEUjeZ0+V8u301heotMm0Yyxi+lLnAX30A2InYic6H/yst4YDQDTPzLCirIsnZdM
	 8nnt/gV2ZlgnsYEtCsup6y2aIv/JlySU73gj/jNT0L53k/8mTkfKg/axTGqrm5lN9DzoC
	 vMSV7EMOMgIkcEYcj1rB2tI4tugbaEUWXmytaX43HrZG8wZd1yVe4c8RPCxl6pEaNduyB
	 wyX9b/IxMeVVx4I0EX4uA1fr3WulXXraML4kxEiD+p9TG+h7K5ughZp3FUVzoFIVL+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420976;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MrIf/jjqPJWBF8I0O/v/o7wGWbgE4gV9gMxEsZiWqLw=;
	b=ogdAN4JA5JnUpbZY8Euyf4iirGcUCB49lLLx4knkARs3rjihXJLht/oxxiv6zPi9xcFv
	 YKgU6iVlg46faFXTZ3PLi3iWdaVDX+bDoFDhNYCsqLmQmsJTb4b0he+fBdSJcSqREXmMA
	 /zRGUExgf3yh424D6y3rOAPuKYqYIHTVzUfu9q3wfVVi0ZOd+G9bcwlik3pDdn+QmAmm8
	 FVaJ6+tEi8c10GDg2BgkJUIMLgyjYEa6dQNjxLoUbVUGID+AQBZOE38+u055kGjkrgvE9
	 7aSS5iex3XDUspKA5B7yW5vtSG4j9N6omg4wzgVOOEDZ/yNTXJNuHolS0YWdE6oZ5Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcZEF1Jt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CEC606C22B;
	Mon, 23 Nov 2026 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZcZEF1Jt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3341F000C6;
	Mon, 23 Nov 2026 08:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420975;
	bh=MrIf/jjqPJWBF8I0O/v/o7wGWbgE4gV9gMxEsZiWqLw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZcZEF1JtJ4DyIkiy6gEVbuy1Ruskmegc0nn/hJ1NEu1VXCnCAkVGsKaRad9+uv+2g
	 zpUx6IEuLYj0Cq4GGANjtZ3g14eIkjWLPBHN5vrUJP9PDTwy7fbXGD5yhMQux8Odpm
	 f113DnESpWMZczFYAPfc3FFlVE0t4597RQ1dukxV7QXCDZPlWEG6ctBgJuUuOe7Pcc
	 /y9Kk1jXHUqiSSaewoXJ1R9c/1BQVXvGy6CDical9fRSU0P2ZryTuGpVrAdp7rhqDi
	 y/hoVZ4CPGzJt1vL35U5Id6yL/06wWY9bnHLJW3aiVxzmkrN9N4bee1pxTiyxM7/kz
	 2WFtm8LGaHgxQ==
Message-ID: <1ed3be2f-2256-4e44-95ea-10dabae6ebe2@kernel.org>
Date: Mon, 23 Nov 2026 09:02:54 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v5 5/8] iio: adc: at91_adc: use local struct device
 pointer in probe
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>, jic23@kernel.org,
 linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, giorgitchankvetadze1997@gmail.com,
 amin.gattout@gmail.com, antoniu.miclaus@analog.com,
 gregkh@linuxfoundation.org, mripard@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
 <20261123070101.53868-6-abdelnasserhussein11@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261123070101.53868-6-abdelnasserhussein11@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23-Nov-26 8:00, Abdelnasser Hussein wrote:
> Introduce a local struct device pointer in at91_adc_probe() and use it
> in place of &pdev->dev and &idev->dev throughout the function.
> 
> Also switch devm_iio_device_alloc() to use sizeof(*st) instead of
> spelling out the full private structure type.
> 
> This is a preparatory cleanup to reduce the diff noise of the upcoming
> conversion to device-managed resources.
> 
> As a result, messages previously logged against the IIO device are now
> printed using the platform device being probed.
> 
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts

