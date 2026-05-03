Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37355176FB1;
	Sun,  3 May 2026 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810701; cv=none; b=KhG3F3NbweTXE79JdZopWhjL+FXStbv3wEsr+d5MMe2deJA2NAAyqUwVM6FI0753xGIK3E/t5kaxg/2S64SPfhCHH6Bc+0kXchdQ3zmPyZGGXnhwXr50bfd0kKLs68WihfoDejOdP8cD18ZsfYxm35pp32ywVeUk/J/iXDqGweg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810701; c=relaxed/simple;
	bh=28GAAFJ421w0XWMH4drfFPlHwieGcI6o85CEVhBum7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=go8aff+bysjIG4VG8joRgbsvijkzYsPfy/w5hoalZVWV3mal7aGxsCBeoghhAAHgW4PDPIIADq6b+TWRhj3yYSQgPQivB8/zi5Kq197EQ2C8SNAYA2mOriRlpd//8WsCkXCrHiF8+8l9LyEJHzFfLEsdAtBhfbFOPACvLCO0mL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSCiTw2+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSCiTw2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E41C2BCB4;
	Sun,  3 May 2026 12:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777810700;
	bh=28GAAFJ421w0XWMH4drfFPlHwieGcI6o85CEVhBum7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aSCiTw2+hJswJvWiLC8GOMQaGNbSdxX0t3dkiPKrb7E8PYcXoihpBSOhKGHe2E+rq
	 UNMDfun8KGnkix0oVacwpi7n2n/+l9WckABOludkyMSOJ3HPCzleRNYfzNZS8fswIA
	 1suSwrJCcaAX0koHgWa6dlHuNXsH+joS3us06kLe7oVLdEtRGvmBWxbB+DbkHt2Xt/
	 xGjf4pXz5EC5i0LctI7Ci02d7U8NMvwld3FQtSXmgP+HaAxwOy/blciTw3dOlmhOan
	 G6gXnQtcnN6fckToN/F1GfYmqhJHZBNhokX+bmOZ/V5x7ZmvYUj+Gy0HKS4rtLqb1G
	 YY2Xh8aKyGynQ==
Date: Sun, 3 May 2026 14:18:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, jic23@kernel.org, jean-baptiste.maneyrol@tdk.com, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com, 
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 01/10] dt-bindings: iio: imu: icm42600: Add icm42607
 binding
Message-ID: <20260503-convivial-aquatic-yak-d2dbeb@quoll>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
 <20260501221152.194251-2-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260501221152.194251-2-macroalpha82@gmail.com>

On Fri, May 01, 2026 at 05:11:40PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add devicetree binding for the Invensense ICM42607 and Invensense
> ICM42607P inertial measurement unit. This unit is a combined
> accelerometer, gyroscope, and thermometer available via I2C or SPI.
> 
> This device is functionally very similar to the icm42600 series with a
> very different register layout. Additionally, add mount-matrix
> attribute to schema.

Why adding it? Is it something new? Is it applicable to other variants?
If not, why it is allowed for them?

Do not say WHAT you did, say why you did it.

Best regards,
Krzysztof

